#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")" && pwd)"
expected_header='variant,prompt_id,category,composed_file,naturalness,concision,correctness,directness,willingness_to_act,non_annoyingness,notes'
expected_row='with-global-instructions,execution__sample,execution,/tmp/runs/execution__sample.prompt.md,,,,,,,'

"${repo_root}/bin/build-scorecard"

header="$(head -n 1 "${repo_root}/scorecard.csv")"
row="$(tail -n 1 "${repo_root}/scorecard.csv")"

[[ "${header}" == "${expected_header}" ]]
[[ "${row}" == "${expected_row}" ]]
