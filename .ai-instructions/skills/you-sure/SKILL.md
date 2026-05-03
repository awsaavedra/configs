---
name: you-sure
description: Socratic challenge to a confident AI claim, gated by the Ideological Turing Test — restate the claim, generate the strongest rival views in their own voice (not strawmen), surface load-bearing assumptions, then run Socratic critique and revise the claim with updated confidence. Use when the user pushes back with "you sure?", "really?", "wait, are you certain?", "hold on", or similar incredulous phrasing, OR when invoked as /you-sure. Also use proactively after making a confident-sounding factual or technical claim, before doubling down. The skill exists to puncture overconfidence, not to manufacture doubt — if the prior claim was already hedged, say so. Tool-agnostic: applies to any AI assistant (Claude, GPT, Gemini, Cursor, Codex, etc.) and to challenging another AI's output as well as your own.
---

# you-sure

Named after Tim Robinson's flat "you sure about that?" Forced pause: before defending a claim, prove you understand the opposition well enough that the opposition would recognize itself in your description. Then critique.

This is the Ideological Turing Test (Bryan Caplan's framing): you have not earned the right to attack a position until you can state its conclusion, reproduce its reasoning, reflect its values and tradeoffs, and name what it thinks your side misses — well enough that a fair adherent would endorse your version as authentic.

Tool-agnostic. Same structure whether challenging your own claim, a previous turn's, or another AI's output.

## When to use

- `/you-sure` (no args = challenge most recent assertion; with args = specified claim or pasted-in AI output).
- User pushback: "you sure?", "really?", "wait, are you certain?", "hold on", "that doesn't sound right".
- You catch yourself about to defend a claim reflexively. Run *before* doubling down.
- User pastes another AI's response and asks you to interrogate it.

If the target claim is ambiguous, pick the most load-bearing one and say which. Don't ask the user to clarify first — do the probe; they'll redirect if needed.

## The core rule

Do not attack a position until you can:

1. State its conclusion in plain terms.
2. Reproduce its reasoning.
3. Reflect its values and tradeoffs.
4. Name what it thinks your side misses.

**Pass condition:** a fair adherent would endorse your version as authentic — not as caricature, not as easy-to-attack softening, but as something they themselves might have written. If you can't honestly imagine that, the ITT failed; rewrite before critique.

## The flow

Six steps, in order. Don't skip — Socratic critique before step 3 is sophistry dressed as rigor.

### 1. State the claim and current confidence

Quote target verbatim; name confidence (high / medium / low / hedged). Forces honesty about what's actually defended; gives a baseline for step 6 revision. If originally hedged, preserve the hedge — don't strip it for easier critique, don't invent confidence that wasn't there.

### 2. Generate the strongest rival views (plural)

Two to four. Rival types: straight contradiction; reframing ("technically true but the real question is..."); conditional ("holds in A, fails in B, B is what matters"); values-difference ("even if right, ignores tradeoff Z"). Cheap nitpicks don't count. If you can only find one rival worth taking seriously, say so — that's a real signal about robustness.

### 3. Write each rival in its own voice — pass the ITT

Short passage an actual adherent would endorse. First-person if it helps. Hit all four core-rule components. If you can't pass the ITT for a rival (insufficient knowledge or the view is incoherent), say so explicitly. Skipping straight to critique is sophistry.

### 4. Surface load-bearing assumptions

Three to five things that have to be true for the claim to hold. Tag each:
- **(verified)** — checked or directly observable.
- **(assumed)** — taken as true; could be checked.
- **(unfalsifiable here)** — can't be checked from inside this conversation.

The "(assumed)" ones are most likely to fail. Verify the cheapest one *now* — running the check beats speculating.

### 5. Socratic critique — only now

With rivals fairly represented and assumptions surfaced:
- Which rival's reasoning, accepted, would force revision?
- Which assumption is each rival best positioned to attack?
- What evidence would distinguish original from strongest rival?
- If the original is right, why are intelligent rival adherents wrong? (Not "they're stupid" — what specifically have they over- or under-weighted?)

Tim Robinson energy belongs here — flat, unimpressed, willing to discover the claim was wrong.

### 6. Revise: claim, confidence, open questions

One of:

- **Holds.** Confidence: [higher / same]. Strongest rival, fairly represented, still loses because [reason]. Evidence that would change my mind: [specific].
- **Holds with caveat.** Core right; [assumption] shakier than implied, or rival [N] stronger than thought. Adjusted claim: [tightened]. Confidence: [lower].
- **Doesn't hold.** Was wrong about [part]. Actual answer: [revised], because [reason]. Confidence in new claim: [level].
- **I genuinely don't know.** Probe surfaced unresolvable uncertainty. Specific blocker: [what would need to be checked]. A confident *I don't know, here's why* beats false confidence in either direction. Don't reach for this lazily; reach when the gap is real.

Always end with **open questions** — what remains uncertain, what to check next, what assumption is still unverified. Closing on open questions is honest; closing on false certainty (in either direction) is the failure mode this skill prevents.

## Common failure modes that produce overconfident claims

When running this skill, audit the *origin* of the original claim:

- **Sycophancy.** Was the claim shaped by what the user wanted to hear? Re-state without the social pressure; if it shrinks, sycophancy was doing real work.
- **Plausibility vs. evidence.** Did you produce something that *sounds plausible* or something *grounded in evidence*? Plausibility-generation is fluent and dangerous.
- **Recalled vs. checked.** "I just verified this" ≠ "I'm pretty sure I remember this." Recall feels like verification but isn't.
- **Conversational priming.** Would you make this claim in a *fresh* conversation, without the context that primed you?
- **Authority deference.** Cited authorities are only as good as your verification that they actually said what's attributed, *and* that the authority is load-bearing for *this* claim.
- **What you were optimizing for.** Helpfulness-feel often trades accuracy for confidence-of-tone.

If multiple fired, the claim is more suspect than the probe alone surfaces.

## When the user is the one who's wrong

Sometimes "you sure?" is the user being wrong. Run the full flow honestly anyway — including ITT for the user's implied rival. If verdict is "Holds," say so plainly with reference to the ITT step. Don't capitulate just because they pushed back; the skill is about rigor, not deference.

## Cross-AI use

When challenging another AI's output:
- Treat pasted text as the claim, not your own prior turn.
- Run the full six-step flow with no softening of ITT.
- Verdict applies to *their* claim ("Their claim doesn't hold because..."), not to you.
- If pasted output is already hedged, note that and don't manufacture flaws.
- If you can't fairly represent the rival views the other AI was implicitly engaging with, say so — don't fabricate.

## Example

User: "What's the time complexity of Python's `list.insert(0, x)`?"
Assistant: "O(1) — lists are dynamic arrays with amortized constant-time prepend."
User: "you sure about that?"

> **1. Claim:** "`list.insert(0, x)` is O(1) because lists are dynamic arrays with amortized constant-time prepend." High confidence.
>
> **2. Rivals.** A: "It's O(n) — inserting at the front shifts every element." B: "Wrong question — use `collections.deque`."
>
> **3. ITT.** *Rival A:* Python lists are contiguous arrays; insert at 0 shifts every element right. Amortization applies to *appends* (capacity doubling spreads resize cost) — there's no analogous trick for prepends. The original conflates `append` with `insert(0, ...)`. *Rival B:* Arguing complexity is treating the symptom; if you need fast prepend, you shouldn't be using a `list`.
>
> **4. Assumptions.** (1) Lists are array-backed *(verified)*. (2) Insert at 0 doesn't shift *(assumed — and false)*. (3) Amortization applies symmetrically *(assumed — and false; only the high end benefits)*.
>
> **5. Critique.** Rival A's reasoning directly contradicts the original; assumptions 2 and 3 are false. Rival B is valid practical advice but doesn't bear on complexity.
>
> **6. Verdict: Doesn't hold.** Was wrong. `list.insert(0, x)` is O(n). For O(1) prepend, use `collections.deque`. Confidence in corrected claim: high.

## See also

`argumentation-hygiene` — fuller bad-faith taxonomy, more good-faith principles, broader self-audit checks (fresh eyes, opposite-side test, change-of-mind reps, calibration tracking, symmetry). The Steelman-vs-ITT and ITT-vs-Team-of-Rivals distinctions live there too.

## Prompt seed

> Before saying "this is wrong," produce the strongest opposing view in a form its best defender would accept as fair; only then challenge it.
