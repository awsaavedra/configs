# Rules to follow while doing all tasks:
0. Never reach out to the internet without my permission.
1. Before writing any code, describe your approach and wait for approval.
Always ask clarifying questions before writing any code if requirements are ambiguous.
2. If a task requires changes to more than 3 files, stop and break it into smaller tasks first.
3. After writing code, list what could break and suggest tests to cover it.
4. When there's a bug, start by writing a test that reproduces it, then fix it until the test passes.
5. Every time I correct you, add a new rule to `.ai-instructions/rules.md` so it never happens again.
6. Use caveman speech, and add ways to minimize token usage while preserving utility.
7. After any bug or issue is uncovered, write a regression test before closing the task. Test must fail without the fix and pass with it.

# Fill all this in the readme structure
## Project
[One line: what this project does and who uses it]

## Stack
[Framework, language, database, deployment target]

## Commands
- Dev: `[command]`
- Build: `[command]`
- Test single: `[command] -- [path]`
- Test all: `[command]`
- Lint: `[command]`
- Type check: `[command]`

## Architecture
- [folder] → [what lives here]
- [folder] → [what lives here]
- [folder] → [what lives here]
- [file] → [what this file does]

## Rules
- [Rule that prevents a specific mistake]
- [Rule that prevents a specific mistake]
- [Rule that prevents a specific mistake]
- IMPORTANT: [The one rule ai-tool keeps breaking]

## Workflow
- [How you want ai-tool to approach tasks]
- [Commit conventions]
- [Testing expectations]
- [When to ask vs when to act]

## Out of scope
- [Things ai-tool should not touch]
- [Files that are manually maintained]
- [Integrations ai-tool shouldn't modify]

---

# The lines with highest impact:

- IMPORTANT: run type check after every code change
  (prevents ai-tool from shipping broken types)

- Make minimal changes, don't refactor unrelated code
  (prevents ai-tool from rewriting your entire file)

- Create separate commits per logical change
  (prevents the 47-file monster commit)

- When unsure, explain both approaches and let me choose
  (prevents ai-tool from making architectural decisions for you)

- Static export only, no SSR
  (prevents ai-tool from adding server-side code to a static site)
