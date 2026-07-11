---
name: communication
description: Short-form decision-seeking writing — PR descriptions, RFCs / design proposals, async status updates, asks & escalations. Rules — BLUF (the ask in the first line), audience-awareness (write to the reader's decision, not your discovery sequence), one message one ask, deadline + default-if-no-response, deltas not activity logs, make responding cheap, promote decisions out of threads. Triggers: /communication · "write the PR description" · "draft an RFC" · "status update" · "how do I ask for" · "escalate this".
when_to_use: Writing whose success condition is a decision or an unblock — PR descriptions, RFCs, status updates, asks, escalations. Not long-form prose craft (writing), not syncing docs with code (software-engineering §Documentation), not stress-testing the proposal's content (argumentation §Steelyman — run it before sending an RFC).
---

# Communication

Short-form workplace writing succeeds when the reader acts — anything that doesn't move the decision is cost. The prose analog of an API call, not an essay: `writing` owns craft for readers, this owns writing for *deciders*.

## Universal rules
- **BLUF — bottom line up front.** The ask or conclusion is the first line; context follows for whoever needs it. Readers triage from previews; a buried ask is an unanswered ask.
- **Audience first** — what does this reader already know · need to know · get to decide? Order by *their* first question, never by your discovery sequence (same rule as `writing` §Structure, compressed to paragraphs).
- **One message, one ask.** Second asks get lost; split or number them. An unstated ask gets zero responses — "FYI" that secretly wants action is the classic failure.
- **Deadline + default.** Every ask names when a response is needed and what happens without one: "if no objections by Fri, I proceed with A." The default converts silence from a blocker into a decision.
- **Make responding cheap.** Propose an answer to react to — a recommendation with options beats an open question; yes/no beats "thoughts?". The asker does the thinking, the decider decides.
- **Full context in one unit** — no "quick question" preamble, no naked links; the reader should never have to ask "what about it?". Subject line states ask + deadline.

## Types
| Type | Success condition | Shape |
|---|---|---|
| PR description | Reviewed fast, reviewed well | what + why (diff shows how) · how to review: entry point, order, what to scrutinize · risk + rollback · linked issue |
| RFC / proposal | Decision made, recorded | context → proposal → alternatives with why-nots → open questions → decision requested + deadline + default |
| Status update | Reader re-plans correctly | delta since last update · at-risk items · blockers with named asks · next steps with dates — progress against `planning`'s done-checks, never an activity log of effort expended |
| Ask / escalation | Unblocked | the ask first, sized (minutes? decision? budget?) · deadline + cost of no-decision · escalate the decision, not the blame |

- **RFC alternatives are steelmanned** (`argumentation` §Steelyman) — a why-not that misstates the alternative invites relitigating it.
- **Escalations carry evidence, not narrative** — the two-line version: blocked on X since <date>, tried A/B, need <decision> by <date> or <consequence>.

## Decisions outlive threads
- A decision made in a thread dies in the thread. Once decided: record it where it persists — ADR / `docs/` (`software-engineering` §Documentation) — and log prediction + confidence in `diagnostic` §Decision-Journal.
- The recorded decision states what was decided, why, and what was rejected — the RFC's alternatives section is the raw material; don't make readers excavate the thread.

## Gates
- Ask + deadline + default in the first two lines.
- Audience named; the message answers their first question, not yours.
- One ask per message, or asks numbered.
- Response made cheap — a recommendation to react to, not an open field.
- Decision, once made, promoted out of the thread.
