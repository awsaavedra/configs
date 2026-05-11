---
name: software-engineering
description: Software engineering principles cluster. Currently: /design — clean code rules for naming, functions, classes, and refactoring. /architecture — seam-first design for replaceable dependencies.
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

---

## Architecture

Build explicit boundaries into your architecture so any dependency can be replaced without touching the code that uses it. A **seam** is any place where behavior can be swapped without editing the caller.

### Rules
- **Depend on interfaces, not implementations.** `EmailSender`, `BillingGateway`, `UserStore` — never SendGrid, Stripe, or Postgres directly.
- **No infrastructure imports at the logic layer.** If your domain model imports an ORM, a framework, or an HTTP client, you've lost a seam.
- **Inject everything that touches the outside world.** HTTP clients, clocks, file systems, random sources — all injected, all replaceable.
- **Treat every hard dependency as a logged decision.** Ask: *what would it cost to replace this?* If the answer is "a lot," add a seam.

### Why
Seams make components independently testable, vendors swappable, and modules extractable into services when the time comes. A seam-first codebase survives vendor death, infrastructure pivots, and scale changes. Without seams, dependencies become load-bearing walls.
