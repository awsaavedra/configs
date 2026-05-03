---
name: double-crux
description: Symmetric productive disagreement — when you and the user (or two views the user is weighing) genuinely disagree and neither side is auditing the other. Each side names a crux: a specific belief such that, if it flipped, the position would flip. The conversation then locates whether the disagreement is a shared crux (operationally resolvable by checking a fact), a crux-mismatch (each side cares about different evidence), values-level (different weighting of consequences), framing-level (different mental models), or empty (no operational disagreement). Use when invoked as /double-crux, when the user says "we disagree," "we're stuck," "let's find the actual disagreement," "I'm torn between these two views," or when AI and user are in genuine disagreement that neither audit-self nor challenge-user resolves. Distinct from you-sure (asymmetric self-audit), steelyman (asymmetric user-challenge), and devil's advocate (performed opposition). Tool-agnostic.
---

# double-crux

The technique for productive disagreement: each side identifies a *crux* — a specific belief such that, if it flipped, their stated position would flip — and the conversation locates whether the cruxes match.

Origin: rationalist practice (CFAR, Sarah Constantin). The central insight is that most disagreements are debated at the wrong level — people argue about the surface conclusion when the actual disagreement is one or two levels deeper, about which evidence is decisive, which values to weight, or which mental model to use.

This skill is *symmetric* — neither side is auditing the other (`you-sure`) or challenging the other (`steelyman`). Both have positions; both are willing to update; the goal is to find where the real disagreement actually lives.

## When to use

- `/double-crux` invocation, with a disagreement specified.
- "We disagree about X" / "we're stuck" / "let's find the actual disagreement."
- User is torn between two views and wants to locate the real difference.
- AI and user are in genuine disagreement that neither side auditing the other resolves.

**When not to use:**
- Trivial preferences ("I like X more than Y") — no operational disagreement to resolve.
- Performed disagreement — when one side is arguing for sport rather than belief.
- The disagreement isn't load-bearing for any decision either party will make. (See `argumentation-hygiene`'s "this isn't worth arguing about" principle.)

## The mindset

- **Both sides have to be willing to update.** If either side has decided in advance not to be moved, this isn't double-crux; it's debate. Either move to a different mode or name the asymmetry.
- **Cruxes have to be real.** A crux that the speaker wouldn't actually update on if the test came back the wrong way is fake. Pass condition: would you genuinely revise your stated position if the crux flipped? If you'd just rationalize a new reason to hold the same position, the crux was performance.
- **The disagreement is often deeper than the surface.** When cruxes don't match, the real disagreement isn't the surface claim — it's about which evidence matters. That's progress, even if it doesn't resolve.

## The flow

Six steps. After step 3 the path branches based on classification.

### 1. Both sides state position with confidence

Each side: "My current position is X, with confidence [high/medium/low]." No softening the position; no inflating the confidence. Bet-grade.

### 2. Each side names their crux

"I believe X. If [Y] were true, I would believe not-X."

Y has to be:
- Specific enough to be checkable (not "if I had different priors").
- Genuinely load-bearing (you'd actually update, not rationalize).
- Distinct from "I'd update if I were just convinced you're right" — that's not a crux, it's submission.

Both sides do this in parallel, ideally without seeing the other's first.

### 3. Compare cruxes — classify

Hold both cruxes side by side. Classify the disagreement:

- **Shared crux:** both cruxes refer to the same fact or evidence. → Operationally resolvable; check the fact.
- **Crux-mismatch:** each side cares about different evidence. → Real disagreement is about which evidence is decisive.
- **Values-level:** cruxes are about different weighting of consequences. → Not resolvable by fact-checking; resolvable only by negotiating values or scoping the decision.
- **Framing-level:** cruxes are downstream of different mental models. → Resolution requires comparing the models themselves.
- **Empty:** neither side can name a crux that bears on a decision either party will make. → "Disagreement" is rhetorical; name and exit.

### 4. If shared crux: check the fact

Just check it. If the evidence comes back, both sides update per their stated cruxes. If either side fails to update at this point, the crux was fake — flag it.

### 5. If crux-mismatch / values / framing: surface the real disagreement

"We were arguing about X, but the real disagreement is about [which evidence is decisive / which values to weight / which model to use]. That's a different conversation."

This often dissolves the heat. The original argument was a proxy for the deeper one; naming the deeper one lets both sides actually engage with it (or agree to disagree at that level).

### 6. If empty: exit

"We don't actually disagree about anything that bears on a decision either of us will make." Honest exits beat continued performance.

## The hard part: real cruxes

Common fake-crux failure modes:

- **Un-falsifiable cruxes.** "I'd change my mind if I were just convinced." Not a crux — no evidence test specified.
- **Motte-and-bailey cruxes.** Stating a strong-but-narrow crux ("I'd update if you proved P") while actually defending a broader position. When the narrow crux flips, the position should flip; if it doesn't, the stated crux wasn't real.
- **Cruxes that aren't actually load-bearing.** The speaker stated a crux but their actual position is held for other reasons. Test: imagine the crux flipped; does the stated position genuinely flip, or do you reach for another reason to hold it?

Pass condition for a real crux: you would visibly, publicly revise your stated position if the crux flipped — not just hedge or qualify.

## Distinction from related skills

- **ITT (Ideological Turing Test):** faithful representation of the *opposing* view. Double-crux is about locating where you disagree given that both sides understand each other.
- **Steelmanning:** strongest version of an opposing argument. Useful within double-crux when constructing what the other side's crux might actually be.
- **Devil's advocate:** performed opposition. Double-crux requires both sides genuinely hold their positions; performed cruxes don't generate real updates.

## Example

User: "I think we should rewrite the auth service. The current code is unmaintainable."
AI: "I think we should leave it alone for now. It works and a rewrite is high-risk."

> **1. Positions and confidence.**
> User: rewrite auth service, confidence high.
> AI: leave it alone for now, confidence medium.
>
> **2. Cruxes.**
> User: "If I learned that the existing code can be incrementally improved without major rewrite, *and* the team has the bandwidth to do that incremental work, I'd update toward leaving it alone."
> AI: "If I learned that the existing auth service has hidden critical bugs that incremental work can't address, *or* that key team members are about to leave taking the context with them, I'd update toward rewriting now."
>
> **3. Classify: crux-mismatch.** The user's crux is about the *cost of incremental improvement*; the AI's crux is about *hidden risks of staying*. Different evidence cared about.
>
> **4. Surface the real disagreement.** The disagreement isn't really about whether to rewrite — it's about whether the existing code has hidden risks that incremental work won't address. If yes, rewrite makes sense. If no, incremental wins.
>
> **5. Resolution.** Both sides agree: spend a week auditing the existing code for hidden critical bugs and team-context risks before deciding. The audit is the operational test that resolves the surface disagreement.

## See also

- `argumentation-hygiene` — for the cruxes principle, motte-and-bailey detection, and self-audit checks. Double-crux requires the cruxes principle as its central move.
- `you-sure` — when one side suspects their own position is overconfident before entering double-crux.
- `steelyman` — when one side wants adversarial review of their position before entering double-crux.

## Prompt seed

> Each side names what evidence would flip their position. Compare. If cruxes match, check the fact. If they don't, the real disagreement is one level down — about which evidence is decisive — and that's the conversation worth having.
