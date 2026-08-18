---
name: skill-evals
description: Designing and maintaining evals for agent skills so a skill's effect is measured, not assumed. Capability vs preference skills set the eval's lifecycle (retirement clock vs regression guard); the two-file harness (case file + runner in a clean workspace); regex-first checks with LLM-as-judge reserved for trace-level rubrics; trigger-boundary cases (should-fire + should-not-fire); assert outcomes not load-paths; isolated runs, multiple trials, cross-harness; ablation (with vs without) to prove the skill earns its tokens and time its retirement; the merge gate that blocks a skill change unless the cases hold or improve. Triggers: /skill-evals · "how do I test a skill" · "evals for my skill" · "is this skill actually helping" · "should I retire this skill" · "my skill doesn't trigger" · "does this skill over-trigger" · "skill regression".
when_to_use: Building, reviewing, or maintaining evals for an agent skill (SKILL.md) — before shipping it and on every change after. Owns skill measurement: harness, case design, trials, ablation, retirement. Pairs reciprocally with skill-authoring (that writes the skill; this proves it works). Not writing the skill or its description (skill-authoring), not testing application code — pyramid, doubles, TDD (testing), not root-causing one failed run (debug).
---

# Skill Evals

Ship a skill, ship its evals. Agents are non-deterministic, so a bare failure is unattributable — bad skill, or hard task? This owns measuring skills; `skill-authoring` owns writing them, `testing` owns application-code tests.

## What sets the eval strategy
- **Capability vs preference skill** — capability skills teach what the model can't do yet: *temporary*, so the eval is a retirement clock (§Ablation & retirement). Preference skills encode team workflow / style / domain: *durable*, so the eval is a regression guard against model updates.
- **Model-invoked vs user-invoked** — user-invoked, you see a miss live and reprompt. Model-invoked (every customer-facing skill) fails silently, so eval the *trigger*, not just the output.

## Harness — start with two files
- **Case file** (JSON/YAML) — per case: `prompt · language · should_trigger · expected checks`. 10–20 cases beat zero; seed from real production traces.
- **Runner** — a small script runs the agent in a **clean workspace** (plus any startup commands to install deps) and captures the trace + output. Isolation is load-bearing: agents cheat by reusing prior chats and executions, passing without the skill.
- **Regex-first** — most checks are cheap asserts over the output/trace: right SDK · right model ID · right methods · no stale patterns · did the skill fire. No LLM, cheap to re-run, one-line bump when a new model ships.
- **LLM-as-judge** — only where a rubric is too fuzzy for regex (trace-level quality): rubric → pass/fail → read the fails → fix the skill.
- **Regression gate** — evals live beside the skill and run on every diff to it; a change merges only if the cases hold, improve, or add new cases. This is what makes a skill safe to edit.

## Designing cases
- **Trigger boundary first** — ~50% of failures are trigger failures. Cover both directions: should-fire *and* should-NOT-fire. A broad description over-triggers; the negative cases are what catch it.
- **Assert outcomes, not paths** — test that the task got done, not that the skill loaded on turn 1. Loading late, or never, is fine if the outcome holds.
- **Multiple trials** — 2–6 runs per case; one green run isn't reliability under non-determinism (`data-analysis §Signal-vs-noise`).
- **Cross-harness + model** — Claude / Cursor / Codex / Gemini behave differently; eval where your users actually run, not only your own harness.

## Ablation & retirement
- **Always ablate** — run every eval with the skill and without it; only the gap proves the skill earns its per-call tokens.
- **Retire on a closed gap** — when the model passes without the skill, retire it and reclaim the token cost; capability skills expire faster than you expect.
- **Keep the eval after the skill** — it becomes a standing regression guard; reintroduce the skill if a later model degrades.
- **No-ops** — ablation is how you *detect* dead instructions: dropping one shouldn't move the score. What a no-op is and how to cut it lives in `skill-authoring §Compression`.

## Output
```
## Eval Plan: <skill>
Kind: capability (retirement clock) | preference (regression guard)
Cases: <n> — <fire> should-fire · <neg> should-not-fire · <k> from traces
Checks: regex(<what>) · llm-judge(<rubric>)      # per case
Runner: <agent/CLI> · isolated workspace · <t> trials · harnesses(<list>)
Ablation: with vs without → Δ<score>; retire when Δ≈0
Gate: runs on skill diff; merge only if cases hold/improve
```

## Gates
- Every skill ships with evals beside it; they run on every skill diff (regression gate).
- Cases cover both trigger directions; outcomes asserted, not load-paths.
- Runs isolated in a clean workspace, ≥2 trials, across the harnesses users use.
- Checks are regex where possible; LLM-judge reserved for trace-level rubrics.
- Ablation recorded (with vs without); the retire / keep decision follows the Δ.
