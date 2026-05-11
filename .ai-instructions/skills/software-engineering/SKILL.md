---
name: software-engineering
description: Software engineering principles cluster. /design — clean code rules for naming, functions, classes, refactoring. /architecture — seam-first design for replaceable dependencies.
when_to_use: Writing, reviewing, or refactoring code. Apply design automatically; invoke explicitly for a focused audit.
---

# Software Engineering

## Design

Apply clean code principles automatically when writing or reviewing code.

### Rules
- **Names:** Exact. Verbs→functions, nouns→classes. No abbreviations, no magic numbers.
- **Functions:** One thing. ≤3 args (else object). No side effects. No flag args. ≤20 lines.
- **Comments:** Explain *why*, never *what*. No commented-out code. Block needs explaining → extract to named function.
- **Classes:** SRP. DIP. Prefer composition over inheritance.
- **DRY:** One authoritative home per piece of knowledge.
- **KISS/YAGNI:** Simplest solution that works. Don't build for imaginary futures.
- **Fail fast:** Validate at boundary; surface errors early.
- **Smells:** long methods · large classes · duplicates · feature envy · primitive obsession · type-switch chains · dead code
- **Boy Scout Rule:** Leave every file cleaner than found.
- **Refactor continuously.**

---

## Architecture

Build seams — places where behavior can be swapped without editing the caller — so any dependency is replaceable.

### Rules
- **Depend on interfaces, not implementations.** `EmailSender`, `BillingGateway`, `UserStore` — never SendGrid, Stripe, Postgres directly.
- **No infrastructure imports at logic layer.** Domain model imports ORM/framework/HTTP client → seam lost.
- **Inject everything touching the outside world.** HTTP clients, clocks, file systems, random sources — all injected.
- **Treat every hard dependency as a logged decision.** Ask: *what would it cost to replace this?* High cost → add a seam.
- **Seams pay off:** independent testability · vendor swappability · service extraction. Without them, dependencies become load-bearing walls.
