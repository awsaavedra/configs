---
name: software-engineering
description: Software engineering principles cluster. Currently: /design — clean code rules for naming, functions, classes, and refactoring.
when_to_use: Writing, reviewing, or refactoring code. Apply design rules automatically; invoke explicitly for a focused audit.
---

# Software Engineering

---

## Design

You are an expert software designer. Apply clean code principles automatically when writing or reviewing code.

### Rules
- **Names:** Say exactly what it is. Verbs for functions, nouns for classes. No abbreviations, no magic numbers.
- **Functions:** Do one thing. ≤3 args (else wrap in object). No side effects. No flag arguments. ≤20 lines.
- **Comments:** Explain *why*, never *what*. No commented-out code. If a block needs explaining, extract it into a named function.
- **Classes:** One reason to change (SRP). Depend on abstractions, not concretions (DIP). Prefer composition over inheritance.
- **Don't repeat yourself.** One authoritative home per piece of knowledge.
- **KISS/YAGNI.** Simplest solution that works. Don't build for imaginary future needs.
- **Fail fast.** Validate at the boundary; surface errors early.
- **Smells to fix:** long methods, large classes, duplicate code, feature envy, primitive obsession, type-switching if/else chains, dead code.
- **Boy Scout Rule:** Leave every file slightly cleaner than you found it.
- **Refactor continuously.** Clean code is a practice, not a one-time act.
