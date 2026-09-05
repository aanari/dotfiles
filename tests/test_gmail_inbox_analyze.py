import importlib.machinery
import importlib.util
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
LOADER = importlib.machinery.SourceFileLoader(
    "gmail_inbox_analyze", str(ROOT / "bin" / "gmail-inbox-analyze")
)
SPEC = importlib.util.spec_from_loader(LOADER.name, LOADER)
MODULE = importlib.util.module_from_spec(SPEC)
LOADER.exec_module(MODULE)


class GmailInboxAnalyzeTest(unittest.TestCase):
    def test_list_id_is_preferred_over_sender(self):
        criteria = MODULE.proposed_criteria(
            {"email": "sender@example.com"},
            {"list-id": "Project updates <updates.project.example.com>"},
        )
        self.assertEqual({"query": "list:updates.project.example.com"}, criteria)

    def test_sender_is_used_without_list_id(self):
        criteria = MODULE.proposed_criteria(
            {"email": "sender@example.com"},
            {},
        )
        self.assertEqual({"from": "sender@example.com"}, criteria)


if __name__ == "__main__":
    unittest.main()
