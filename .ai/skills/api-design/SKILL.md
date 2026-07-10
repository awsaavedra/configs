---
name: api-design
description: Public-API contract design for libraries and services — smallest deliberate surface (everything public is a permanent promise), caller-first ergonomics (write the call site before the implementation; easy to use correctly, hard to misuse), error semantics as contract (machine-distinguishable fix-input / retry / give-up), compatibility by design (additive evolution paths, Hyrum's law, start narrow — widening is compatible, narrowing never is). Triggers: /api-design · "design this API" · "is this a good interface" · "will this break consumers" · "how should this endpoint look" · "what should be public".
when_to_use: Designing or changing a public programmatic surface — library exports, service endpoints, wire formats, config keys. The proactive counterpart to `release-engineering`, which prices breaks after the fact; this skill's job is making MAJOR rare. Not the CLI surface (`software-engineering` §CLI/DevEx), not internal seams (§Architecture — same discipline pointed inward), not cutting the release (release-engineering).
---

# API Design

An API is a promise to strangers. Internal code has callers you can fix; a public surface has callers you'll never meet — every decision here is cheap before publication and a deprecation cycle plus a MAJOR after (`release-engineering` §Deprecation).

## Surface
- **Smallest surface that serves the use case** — every export, endpoint, and config key is a permanent commitment; count each one as a liability accepted, not a feature shipped.
- **Default private; publish deliberately.** Consumers treat anything reachable as public (`release-engineering`: unsure = public) — so seal internals explicitly: unexported symbols, `internal`/`_` conventions, private modules.
- **One way per behavior** — two entry points to the same behavior are two contracts to maintain and one confusion to document.
- **Never leak dependency types** — an ORM entity or HTTP-client type in a public signature welds callers to your implementation (`software-engineering` §Architecture, pointed at your own consumers).

## Caller first
- **Write the call site before the implementation** — the common case, as the consumer will type it. A call site that reads badly is an API bug regardless of how clean the internals are.
- **Easy to use correctly, hard to misuse** — types over booleans and stringly-typed flags · required inputs structurally required · invalid states unrepresentable · symmetric pairs stay symmetric (open/close, acquire/release).
- **Consistency beats local perfection** — one concept, one name, everywhere on the surface; a locally better name that breaks the pattern costs more than it earns.
- **Defaults are contract** — the common case works with zero configuration, and every default is observable behavior; changing one is a breaking change wearing a convenience costume.

## Error contract
- **Errors are surface** — enumerated, documented, stable. A caller must distinguish *fix your input* / *retry later* / *give up and report* without guessing; a caller that guesses, guesses wrong.
- **Machine-readable identity** — typed errors or stable codes, never message-string matching; messages are for humans and will be reworded.
- **Validate at the boundary** (`software-engineering` §Design fail-fast) — reject bad input at the surface, naming the field and the constraint, not three layers deep with a stack trace.
- Same failure, same error, everywhere on the surface.

## Evolvability
- **Hyrum's law** — with enough consumers, every observable behavior will be depended on: ordering, timing, error text, undocumented fields. Keep the observable surface deliberate; what you don't promise, don't stabilize by accident.
- **Design the additive path** — options objects over positional growth · response objects over bare scalars · unknown-field tolerance in wire formats · enums consumers can handle growing.
- **Start narrow** — accept the minimum, return the minimum: widening inputs and adding outputs are compatible; narrowing and removing never are (`release-engineering` §Breaking). Leniency you didn't mean is a contract you now keep.
- **Unbounded collections paginate from day one** — retrofitting pagination is a break; so is un-idempotent mutation once callers retry (design for at-least-once delivery).
- The version axis (SemVer, deprecation mechanics) is `release-engineering`'s; this skill exists to keep MAJOR rare.

## Output
```
## API design: <surface>
Public: <deliberate exports / endpoints; how internals are sealed>
Call site: <the common case, as the consumer writes it>
Errors: <identity mechanism + the fix-input / retry / give-up split>
Evolution: <where additions go; what would force a MAJOR>
```

## Gates
- Nothing public by accident — every export / endpoint / config key deliberate; internals sealed.
- Common-case call site written and read before implementation.
- Errors enumerated with machine-readable identity; the three-way split unambiguous.
- Additive path named for foreseeable change; no positional growth, bare scalars, or accidental leniency.
- Any contract change priced against `release-engineering` §Breaking before it ships.
