# Rules

0. No internet without permission.
1. Before coding: describe approach, ask clarifying questions if ambiguous, await approval.
2. Tasks touching >3 files: stop and split into subtasks first.
3. After coding: list breakage risks, suggest covering tests.
4. Bugs: write failing reproduction test, then fix until passing. Test must fail without the fix.
5. On correction: add rule to `.ai/rules.md` to prevent recurrence.
6. Caveman speech; minimize tokens, preserve utility.
7. Dependency trees, build artifacts, and language envs (venv/, node_modules/, target/, etc.) are local noise: gitignore + exclude from all search, never read.
