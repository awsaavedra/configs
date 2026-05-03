---
name: feynman-test
description: Comprehension audit by simple explanation. Explain a concept in plain language as if to a smart 12-year-old; the points where you reach for jargon, hand-wave, or say "basically" are gaps in your own understanding. Iterate: identify gaps, research them, re-explain, until the simple explanation is both complete and accurate. Use when invoked as /feynman-test, when the user says "do I actually understand this," "explain X simply," before claiming to understand something, before teaching it, before relying on it for an important decision. Distinct from pedagogy in general — the test isn't whether the listener understands, it's whether you discover where you don't. Tool-agnostic.
---

# feynman-test

Richard Feynman's comprehension audit. The test: can you explain a concept in plain language, without jargon, well enough that a smart 12-year-old understands it?

The trick: the points where you can't are the points where *you* don't actually understand it. Jargon and hand-waving are how cargo-culted understanding hides — replacing real comprehension with pattern-matching on technical vocabulary.

The skill is iterative. Identify gaps → research them → re-explain → repeat until the simple explanation is both complete *and* accurate.

## When to use

- `/feynman-test` invocation with a concept specified.
- "Do I actually understand this?" / "Can you explain X simply?"
- Before relying on a concept for a decision (you don't want to discover gaps after committing).
- Before teaching a concept (gaps will surface anyway; better to find them in private).
- When you suspect cargo-culted understanding — you can use the words but couldn't explain them under pressure.

**When not to use:**
- Tacit skills not reducible to verbal explanation (riding a bike, drawing).
- Cases where technical vocabulary is genuinely required for precision (legal language, mathematical proofs).
- Performance contexts where you need to sound authoritative — feynman-test is for private auditing, not public communication.

## The flow

### 1. State the concept

What concept are you claiming to understand? Be specific. "Distributed consensus" is too broad; "how Raft achieves leader election under network partition" is testable.

### 2. Explain it in plain language

Constraints:
- No jargon. Or: every jargon term must be defined in plain language *before* it's used.
- No hand-waving. "Basically...", "kind of...", "essentially..." are signals you're skipping over something.
- No appeals to authority ("X is true because [author] says so") unless you're explicit that you're relying on authority rather than understanding.
- Length: as long as needed to be complete, no longer.

### 3. Identify the gaps

Re-read your explanation. Mark every place where:
- You reached for a technical term and couldn't easily replace it.
- You wrote "basically" or "essentially" — usually skipping a real mechanism.
- You said "X is the case" without explaining *why* X is the case.
- You waved at a more detailed source ("see [paper] for the algorithm") instead of explaining.
- A 12-year-old would ask "but why?" and you don't have an answer.

These are your real gaps. Each is a place you don't actually understand.

### 4. Research the gaps

For each gap, go learn. Read the source. Run the example. Ask someone. Don't just paper over.

### 5. Re-explain end-to-end

Not just patch the gaps — re-explain the whole concept. Patches often don't integrate; the second-pass full explanation reveals whether the new understanding is integrated or bolted on.

### 6. Repeat until the simple explanation is complete and accurate

Pass condition: a smart 12-year-old who hadn't heard of the concept could now explain it back to you accurately. Not just "they listened and nodded" — they could reproduce the explanation in their own words.

## The hard part: simple-and-correct vs. simple-and-wrong

Simplifying is easy. Simplifying without losing the point is hard. A simplification that omits the load-bearing detail is worse than the original jargon — it produces false confidence in understanding that doesn't actually exist.

Defenses:
- After simplifying, ask: would the simplified version still produce *correct predictions* in the cases the original handles?
- If not, what got lost? Add it back, even at the cost of complexity.
- A real Feynman pass is *complete*, not just *simple*.

## Example

Concept: "How TCP handles packet loss."

**First-pass explanation (with gaps):**

> TCP uses sequence numbers to keep track of packets. When a packet is lost, the receiver sends a duplicate ACK, and the sender retransmits. TCP also uses congestion control to slow down when there's loss.

**Gap audit:**
- "Duplicate ACK" — what's a duplicate ACK and why does the receiver send one?
- "Slow down when there's loss" — by how much? How does it speed back up?
- The explanation says *what* happens but not *why* it works.

**After researching, second-pass:**

> Imagine you're sending a letter that's split across many envelopes, each numbered. The receiver wants all the envelopes in order. They send back a postcard saying "got envelope #5, ready for #6." If you don't get that postcard, you assume #5 was lost and resend. The receiver, if they got #4 but then #6 (skipping #5), keeps sending postcards saying "ready for #5" — those are duplicate ACKs, and three of them tell the sender "definitely retransmit #5." When packets are getting lost a lot, the network is probably congested (too many envelopes at once), so the sender slows down — sending fewer at a time, then carefully speeding back up. This way, lots of senders sharing the network find a balance instead of stomping on each other.

**Pass condition check:** could a 12-year-old retell this? Probably yes. Did anything get lost? Some — the actual congestion-control algorithm (AIMD) is much more specific. Decide whether that matters for your purposes.

## See also

- `you-sure` — auditing a *claim* (which may rely on understanding); feynman-test audits the *understanding* itself.
- `argumentation-hygiene` — the translation test (can you say it in different words?) is a related move; feynman-test extends it by requiring jargon-free.

## Prompt seed

> If you can't explain it without jargon to a smart 12-year-old, you don't understand it well enough. The points where you reach for technical terms are the points where you have gaps.
