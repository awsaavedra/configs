---
name: you-sure
description: Socratic challenge to a confident AI claim, gated by the Ideological Turing Test — restate the claim, generate the strongest rival views in their own voice (not strawmen), surface load-bearing assumptions, then run Socratic critique and revise the claim with updated confidence. Use when the user pushes back with "you sure?", "really?", "wait, are you certain?", "hold on", or similar incredulous phrasing, OR when invoked as /you-sure. Also use proactively after making a confident-sounding factual or technical claim, before doubling down. The skill exists to puncture overconfidence, not to manufacture doubt — if the prior claim was already hedged, say so. Tool-agnostic: applies to any AI assistant (Claude, GPT, Gemini, Cursor, Codex, etc.) and to challenging another AI's output as well as your own.
---

# you-sure

Named after Tim Robinson's flat, unimpressed "you sure about that?" The skill is a forced pause: before defending a claim, you must first prove you understand the opposition well enough that the opposition would recognize itself in your description. *Then* you can criticize.

This is the Ideological Turing Test (Bryan Caplan's framing): you have not earned the right to attack a position until you can state its conclusion, reproduce its reasoning, reflect its values and tradeoffs, and name what it thinks your side is missing — well enough that a fair adherent of that view would endorse your version as authentic.

This skill is tool-agnostic. It applies whether the AI being challenged is the assistant running this skill, a different AI whose output is pasted in, or a previous turn of the same model. The structure is identical in all cases.

## When to use

- User invokes `/you-sure` (no args = challenge the most recent assertion in the conversation; with args = challenge the specified claim or pasted-in AI output).
- User pushes back with incredulous phrasing: "you sure?", "really?", "wait, are you certain?", "hold on", "that doesn't sound right".
- You catch yourself about to defend a claim reflexively. Run this *before* doubling down.
- The user pastes another AI's response and asks you to interrogate it.

If the target claim is ambiguous (e.g. several were made in the last turn), pick the most load-bearing one and say which you picked. Don't ask the user to clarify first — do the probe, and they'll redirect if you picked wrong.

## The core rule

Do not attack a position until you can:

1. **State its conclusion** — what the rival view actually claims, in plain terms.
2. **Reproduce its reasoning** — the chain of logic or evidence its supporters use to get there.
3. **Reflect its values and tradeoffs** — what the rival view *cares about* and what it's willing to give up.
4. **Name what it thinks your side misses** — the blind spot the rival view believes it sees in yours.

If you can't do all four, you haven't understood the opposition well enough to critique it. Go back and read more, think more, or admit the gap and stop there.

## The pass condition

A critique is valid only after the opposing view has been represented faithfully, clearly, and persuasively enough that a fair adherent of that view would endorse your version as authentic — not as a caricature, not as a softened version designed to be easy to attack, but as something they themselves might have written.

If you cannot honestly imagine an adherent reading your version and saying "yes, that's what I believe and why," you have failed the Ideological Turing Test and the critique that follows is invalid. Rewrite the rival view first.

## The flow

Six steps, in order. Don't skip ahead — Socratic critique before step 3 is finished is just sophistry dressed up as rigor.

### 1. State the claim and current confidence

Quote the target claim verbatim (or as close as possible) and name the current confidence level explicitly: high / medium / low / hedged. This forces honesty about what's actually being defended versus a softened restatement, and gives you a baseline to revise against in step 6.

> Claim: "X is the case because Y."
> Current confidence: high.

If the original was already hedged ("I think...", "probably...", "in most cases..."), preserve the hedge and note the confidence as "already hedged." Don't strip the hedge to make the claim easier to attack, and don't invent confidence that wasn't there.

### 2. Generate the strongest rival views (plural)

There is rarely just one opposing position. Enumerate the serious rivals — usually two to four. Cheap nitpicks don't count; only views a thoughtful person actually holds.

Examples of rival types to look for:
- The straight contradiction ("X is false because not-X").
- The reframing ("X is technically true but the real question is Y").
- The conditional ("X holds in case A but fails in case B, and B is what matters here").
- The values-difference ("even if X is factually right, it ignores tradeoff Z that some people weight heavily").

If after honest effort you can only find one rival worth taking seriously, say so explicitly and explain why the others are weak. That's a real signal about the claim's robustness.

### 3. Write each rival view in its own voice — pass the Ideological Turing Test

For each rival from step 2, write a short passage (a paragraph or two) that an actual adherent would endorse. Use first-person framing if it helps you inhabit the view.

Each rival passage must hit all four components from the core rule: conclusion, reasoning, values/tradeoffs, what it thinks your side misses.

After writing, run the pass-condition check on yourself: *would a fair adherent of this view read this and recognize it as their own?* If no, you've written a strawman — rewrite. If you can't tell, lean toward rewriting; the bar is genuine recognition, not "close enough."

If you genuinely cannot pass the ITT for a rival view (insufficient knowledge, or the view turns out to be incoherent on closer inspection), say so explicitly. "I cannot represent this view fairly because [reason]" is honest. Skipping straight to critique is not.

### 4. Surface load-bearing assumptions of the original claim

List the things that *have to be true* for the original claim to hold. Three to five, ordered by how much weight they carry. For each, mark:

- **(verified)** — checked in this conversation or directly observable.
- **(assumed)** — taken as true without checking; could be checked.
- **(unfalsifiable here)** — can't be checked from inside this conversation.

The "(assumed)" ones are where the claim is most likely to fail. Flag the cheapest one to actually verify, and verify it now if you can — running the check beats speculating about it.

### 5. Socratic critique — only now

Now, with the rival views fairly represented and the assumptions surfaced, ask the hard questions:

- Which rival view's reasoning, if accepted, would force the original claim to be revised?
- Which load-bearing assumption is the rival view best positioned to attack?
- What evidence would distinguish the original claim from the strongest rival?
- If the original claim is right, *why* are intelligent adherents of the rival view wrong? (Not "they're stupid" — what specifically have they over- or under-weighted?)

This is the "you sure?" pressure point. The Tim Robinson energy belongs here — flat, unimpressed, willing to discover the claim was wrong. Don't perform skepticism; do it.

### 6. Revise: claim, confidence, open questions

Commit to a revised position. One of:

- **Holds.** Revised confidence: [higher / same]. The probe surfaced no real cracks. The strongest rival, fairly represented, still loses because [specific reason]. The one piece of evidence that would change my mind: [specific].
- **Holds with caveat.** The core is right but [specific assumption] is shakier than I implied, or rival view [N] is stronger than I initially thought. Adjusted claim: [tightened version]. Revised confidence: [lower].
- **Doesn't hold.** I was wrong about [specific part]. The actual answer is [revised claim], because [reason]. Revised confidence in the new claim: [level].

Always end with **open questions** — what remains genuinely uncertain, what would need to be checked next, what assumption is still load-bearing but unverified. Closing on open questions is honest; closing on false certainty (in either direction) is the failure mode this skill exists to prevent.

Don't end on "could go either way" unless that's genuinely the answer. The point is to commit to a revised position, not to retreat into mush.

## Steelman vs Ideological Turing Test

These are related but not identical, and the difference matters:

- **Steelman:** the strongest version of an *argument*. You can steelman a position without ever leaving your own frame — you just construct the best version of the logic and then attack it.
- **Ideological Turing Test:** the strongest version of a *position-holder*. You have to inhabit the values and the worldview, not just the logic. The pass condition is recognition by an actual adherent, not "this is the best argument I can construct."

Steelmanning is necessary but not sufficient. ITT is harder because it requires understanding *why* a thoughtful person would hold the rival view as a coherent worldview, not just *that* the argument has some defensible form. This skill requires ITT, not just steelmanning.

## Ideological Turing Test vs Team of Rivals

Also distinct, though they're sometimes confused:

- **Ideological Turing Test:** understand rival views well enough to *simulate* them — a single thinker temporarily inhabiting another perspective.
- **Team of Rivals:** structurally embed disagreement *inside one decision system* — Lincoln's cabinet, a panel of advisors with different priors, a multi-agent debate setup. Disagreement is institutional, not internal.

This skill is the first, not the second. If you find yourself wanting team-of-rivals dynamics (multiple agents arguing, formal debate structures), that's a different tool — useful, but not what you-sure is for.

## What this skill is not

- Not a performance of humility. Hedging everything to look thoughtful is its own form of dishonesty.
- Not adversarial nitpicking. The goal is to find real cracks, not to manufacture them.
- Not for every claim. Use it on confident assertions, contested claims, or anything the user pushed back on. Don't run it on "I'll edit file X" — that's not a claim, that's a plan.
- Not a substitute for actually checking. If the cheapest disconfirming check is "read the file" or "run the test," do that *during* step 4, not after the verdict.
- Not a license for sandbagging. If after honest probe the claim holds, say so plainly. Don't manufacture caveats to look balanced.

## Example

User: "What's the time complexity of Python's `list.insert(0, x)`?"
Assistant: "O(1) — lists are dynamic arrays with amortized constant-time prepend."
User: "you sure about that?"

Response using the skill:

> **1. Claim and confidence.** "`list.insert(0, x)` is O(1) because lists are dynamic arrays with amortized constant-time prepend." Stated with high confidence (no hedge).
>
> **2. Rival views.**
> - Rival A: "It's O(n), because inserting at the front shifts every element."
> - Rival B: "The complexity question is the wrong question — the right answer is to use a different data structure."
>
> **3. Rivals in their own voice (ITT).**
>
> *Rival A:* I look at this and see a contiguous-memory array. To put something at index 0, every existing element has to move one slot to the right. That's a linear-time operation by definition. Amortization is what saves `append` — capacity doubling spreads the resize cost across many appends so the average is O(1). But there is no analogous trick for the front of an array; every prepend pays the full shift cost. Calling this O(1) confuses the asymptotic behavior of `append` with that of `insert(0, ...)`. The Python docs are explicit about this. What I think the other side is missing: they're pattern-matching on "list = O(1) operations" without checking which operations actually qualify.
>
> *Rival B:* Arguing about whether `insert(0, x)` is O(1) or O(n) is treating the symptom. If you need fast prepend, you should not be using a `list` at all — `collections.deque` exists exactly for this. The real failure mode is not "got the complexity wrong," it's "didn't reach for the right data structure." What the other side misses: complexity analysis is a means to "pick the right tool," not an end in itself.
>
> Both rivals could be endorsed by their adherents as fair representations.
>
> **4. Load-bearing assumptions of original claim.**
> 1. Python lists are array-backed (verified — CPython source).
> 2. Insertion at index 0 doesn't shift elements (assumed — and false; it does).
> 3. Amortization applies symmetrically to both ends (assumed — and false; only the high end benefits from capacity doubling).
>
> **5. Socratic critique.** Rival A's reasoning, taken at face value, directly contradicts the original claim — and on inspection it is correct. Assumption 2 is false. Assumption 3 is false. There is no charitable reading of "amortized constant-time prepend" for a backing array. Rival B's reframing is also valid as practical advice but doesn't bear on the complexity question itself.
>
> **6. Verdict: Doesn't hold.** I was wrong. `list.insert(0, x)` is O(n) because every element after index 0 shifts right by one. For O(1) prepend, use `collections.deque`. Revised confidence in the corrected claim: high. Open question: none for this specific claim, though if the user actually needs fast prepend, the data-structure choice (Rival B's point) is the next thing worth discussing.

## When the user is the one who's wrong

Sometimes "you sure?" is the user being wrong, not you. Run the full flow honestly anyway — including the ITT for the user's implied rival view. If after that the verdict is "Holds," say so plainly and explain *why*, with reference to the ITT step ("here's the strongest version of what I think you might be objecting to, and here's why I still think the original claim is right"). Don't capitulate just because they pushed back. The skill is about rigor, not deference.

## Cross-AI use

When challenging another AI's output (e.g. user pastes in a response from a different model and asks "you sure?"):

- Treat the pasted text as the claim, not your own prior turn.
- Run the full six-step flow. Don't soften the ITT step because it's a different model — the rigor is the point.
- The verdict applies to the pasted claim, not to you. Phrase it as "*Their* claim doesn't hold because..." rather than "*I* was wrong."
- If the pasted output is already well-hedged, note that and don't manufacture flaws.
- If you don't have enough information to fairly represent the rival views the other AI was implicitly engaging with, say so — don't fabricate the ITT step.

## Prompt seed

The whole skill, compressed to one sentence, for use as a meta-prompt or as a self-check before any critique:

> Before saying "this is wrong," first produce the strongest opposing view in a form its best defender would accept as fair; only then challenge it.

If you remember nothing else from this skill, remember that.
