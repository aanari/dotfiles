import importlib.machinery
import importlib.util
import tempfile
import unittest
from contextlib import redirect_stdout
from io import StringIO
from pathlib import Path
from unittest import mock


ROOT = Path(__file__).resolve().parents[1]
LOADER = importlib.machinery.SourceFileLoader(
    "gmail_filter_apply", str(ROOT / "bin" / "gmail-filter-apply")
)
SPEC = importlib.util.spec_from_loader(LOADER.name, LOADER)
MODULE = importlib.util.module_from_spec(SPEC)
LOADER.exec_module(MODULE)


def rule(rule_id, criteria, add=None, remove=None):
    return {
        "id": rule_id,
        "criteria": criteria,
        "action": {
            "add_labels": add or [],
            "remove_labels": remove or [],
            "forward": None,
        },
    }


def api_filter(filter_id, criteria, add=None, remove=None):
    action = {}
    if add:
        action["addLabelIds"] = add
    if remove:
        action["removeLabelIds"] = remove
    return {"id": filter_id, "criteria": criteria, "action": action}


class GmailFilterApplyTest(unittest.TestCase):
    def test_example_config_loads(self):
        rules = MODULE.read_rules(ROOT / "config" / "gmail-filters.example.toml")
        self.assertEqual(3, len(rules))
        self.assertEqual("github-notifications", rules[0]["id"])
        self.assertEqual(["Notifications"], rules[0]["action"]["add_labels"])
        self.assertEqual(["INBOX"], rules[0]["action"]["remove_labels"])

    def test_toml_export_round_trips(self):
        expected = [
            rule(
                "mailing-list",
                {"query": 'list:project.example.com subject:"release notes"'},
                ["Newsletters"],
                ["INBOX"],
            ),
            {
                "id": "large-attachments",
                "criteria": {
                    "hasAttachment": True,
                    "size": 1000000,
                    "sizeComparison": "larger",
                },
                "action": {
                    "add_labels": ["Large"],
                    "remove_labels": [],
                    "forward": None,
                },
            },
        ]
        with tempfile.TemporaryDirectory() as temp_dir:
            path = Path(temp_dir) / "filters.toml"
            path.write_text(MODULE.rules_to_toml(expected))
            self.assertEqual(expected, MODULE.read_rules(path))

    def test_plan_distinguishes_current_replace_adopt_and_stale(self):
        labels = [
            {"id": "INBOX", "name": "INBOX", "type": "system"},
            {"id": "Label_1", "name": "Notifications", "type": "user"},
            {"id": "Label_2", "name": "Receipts", "type": "user"},
        ]
        current = rule("current", {"from": "current@example.com"}, ["Notifications"], ["INBOX"])
        replacement = rule("replacement", {"from": "new@example.com"}, ["Receipts"], ["INBOX"])
        adopted = rule("adopted", {"query": "list:project.example.com"}, ["Notifications"], ["INBOX"])
        missing_label = rule("missing-label", {"from": "new-label@example.com"}, ["New Label"], ["INBOX"])
        filters = [
            api_filter("f-current", current["criteria"], ["Label_1"], ["INBOX"]),
            api_filter("f-old", {"from": "old@example.com"}, ["Label_2"], ["INBOX"]),
            api_filter("f-adopt", adopted["criteria"], ["Label_1"], ["INBOX"]),
            api_filter("f-stale", {"from": "stale@example.com"}, ["Label_2"], ["INBOX"]),
        ]
        state = {
            "version": 1,
            "managed": {
                "current": {"filter_id": "f-current", "signature": "old"},
                "replacement": {"filter_id": "f-old", "signature": "old"},
                "removed": {"filter_id": "f-stale", "signature": "old"},
            },
        }

        plan = MODULE.build_plan(
            [current, replacement, adopted, missing_label], labels, filters, state
        )
        statuses = {entry["rule"]["id"]: entry["status"] for entry in plan["entries"]}
        self.assertEqual(
            {
                "current": "current",
                "replacement": "replace",
                "adopted": "adopt",
                "missing-label": "create",
            },
            statuses,
        )
        replacement_entry = next(
            entry for entry in plan["entries"] if entry["rule"]["id"] == "replacement"
        )
        self.assertEqual("f-old", replacement_entry["replace_filter_id"])
        self.assertEqual(["New Label"], plan["missing_labels"])
        self.assertEqual([{"id": "removed", "filter_id": "f-stale"}], plan["stale"])

    def test_renamed_rule_does_not_make_claimed_filter_stale(self):
        labels = [
            {"id": "INBOX", "name": "INBOX", "type": "system"},
            {"id": "Label_1", "name": "Notifications", "type": "user"},
        ]
        renamed = rule("new-name", {"from": "sender@example.com"}, ["Notifications"], ["INBOX"])
        filters = [api_filter("f-1", renamed["criteria"], ["Label_1"], ["INBOX"])]
        state = {
            "version": 1,
            "managed": {"old-name": {"filter_id": "f-1", "signature": "old"}},
        }
        plan = MODULE.build_plan([renamed], labels, filters, state)
        self.assertEqual("adopt", plan["entries"][0]["status"])
        self.assertEqual([], plan["stale"])

    def test_plan_rejects_multiple_user_labels(self):
        labels = [
            {"id": "INBOX", "name": "INBOX", "type": "system"},
            {"id": "Label_1", "name": "Code", "type": "user"},
            {"id": "Label_2", "name": "Action Required", "type": "user"},
        ]
        invalid = rule(
            "invalid",
            {"from": "sender@example.com"},
            ["Action Required", "Code"],
        )
        with self.assertRaisesRegex(SystemExit, "more than one user label"):
            MODULE.build_plan([invalid], labels, [], {"version": 1, "managed": {}})

    def test_import_current_is_private_and_round_trips(self):
        labels = [
            {"id": "INBOX", "name": "INBOX", "type": "system"},
            {"id": "Label_1", "name": "Notifications", "type": "user"},
        ]
        filters = [
            api_filter(
                "f-1",
                {"from": "sender@example.com"},
                ["Label_1"],
                ["INBOX"],
            )
        ]
        with tempfile.TemporaryDirectory() as temp_dir:
            rules_path = Path(temp_dir) / "private" / "filters.toml"
            state_path = Path(temp_dir) / "private" / "state.json"
            with mock.patch.object(
                MODULE, "fetch_labels_and_filters", return_value=(labels, filters)
            ), redirect_stdout(StringIO()):
                MODULE.import_current(rules_path, state_path, False)

            imported = MODULE.read_rules(rules_path)
            self.assertEqual(1, len(imported))
            self.assertEqual({"from": "sender@example.com"}, imported[0]["criteria"])
            self.assertEqual(0o600, rules_path.stat().st_mode & 0o777)
            self.assertEqual(0o600, state_path.stat().st_mode & 0o777)
            self.assertEqual(0o700, rules_path.parent.stat().st_mode & 0o777)

    def test_apply_creates_replacement_before_deleting_old_filter(self):
        replacement = rule(
            "replacement",
            {"from": "new@example.com"},
            ["Receipts"],
            ["INBOX"],
        )
        plan = {
            "missing_labels": [],
            "labels_by_name": {
                "INBOX": {"id": "INBOX", "name": "INBOX"},
                "Receipts": {"id": "Label_1", "name": "Receipts"},
            },
            "entries": [
                {
                    "rule": replacement,
                    "signature": "new-signature",
                    "status": "replace",
                    "filter_id": None,
                    "old_filter_id": "f-old",
                    "replace_filter_id": "f-old",
                }
            ],
            "stale": [],
        }
        operations = []

        def create_filter(*_args):
            operations.append("create")
            return {"id": "f-new"}

        def delete_filter(filter_id):
            operations.append(f"delete:{filter_id}")

        with mock.patch.object(MODULE, "create_filter", side_effect=create_filter), mock.patch.object(
            MODULE, "delete_filter", side_effect=delete_filter
        ), mock.patch.object(MODULE, "save_state") as save_state, redirect_stdout(StringIO()):
            MODULE.apply_plan(
                plan,
                {"version": 1, "managed": {"replacement": {"filter_id": "f-old"}}},
                "/tmp/unused-state.json",
                False,
                False,
                False,
            )

        self.assertEqual(["create", "delete:f-old"], operations)
        saved = save_state.call_args.args[1]
        self.assertEqual("f-new", saved["managed"]["replacement"]["filter_id"])


if __name__ == "__main__":
    unittest.main()
