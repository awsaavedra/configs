---
name: performance
description: Proactive performance engineering — budgets set at design time (percentile targets, not averages), measure-first profiling (no optimization without a measurement; Amdahl caps the win), benchmark hygiene (realistic workloads, warm-up, fixed environment, distributions not single runs), complexity budgets at design time, premature-optimization guardrails (readability default, optimize only a measured hot path against a violated budget, revert what misses). Triggers: /performance · "make this faster" · "will this scale" · "optimize this" · "set a latency budget" · "benchmark this".
when_to_use: Proactive performance work — setting budgets, profiling before optimizing, benchmarking a change, deciding whether an optimization is worth its complexity. A performance *regression* (was fast, now slow) is `debug`'s lane — reproduce and root-cause first; benchmark results are read under `data-analysis` rules (distributions, variance, regression to the mean).
---

# Performance

Performance is a requirement with a budget, not a virtue to maximize. This skill owns the proactive lane — budgets, profiling, benchmarks; `debug` owns regressions after the fact.

## Budgets first
- **A target or it's vibes** — latency / throughput / memory / cost budgets per user-facing operation, set at design time. Without a budget, "fast enough" is unfalsifiable and optimization has no stopping rule.
- **Percentiles, not averages** — budget the P95 / P99; the mean hides the tail and the tail is the experience (`data-analysis` §Distributions).
- Budget the *system*, then apportion to layers — an end-to-end 200ms budget spent 190ms in one hop is an architecture finding, not a tuning task.

## Measure first
- **No optimization without a measurement.** The bottleneck is never where you think — profile before touching code; intuition about hot paths has a documented failure rate.
- **Amdahl caps the win** — speeding up a component bounds total gain by that component's share of runtime; a 10× win on 5% of the time is 4.8%. Attack the largest measured contributor first.
- **Measure in production-like conditions** — prod-shaped data, real concurrency, warm and cold cache states. A laptop profile of a toy dataset answers a different question.
- Measure → change → measure again. The second measurement is the deliverable; "should be faster" is `debug`'s "should work" wearing a different hat.

## Benchmark hygiene
- **Realistic workloads** — toy inputs lie: n is small, branches are predictable, caches never miss. Benchmark the shape of data you'll serve.
- **Warm-up before timing** — JITs, caches, connection pools; steady-state and cold-start are both real numbers, but know which one you're reporting.
- **Fixed environment** — pinned versions, quiet machine, same hardware; a benchmark that moves with the weather measures the weather.
- **Distributions, not single runs** — repeat, report spread, compare percentiles (`data-analysis` §Signal-vs-noise); a single run is an anecdote.
- **Baseline recorded before the change** — a speedup claim without a same-environment baseline is unverifiable.
- Microbenchmark traps: dead-code elimination (consume the result), measuring the harness, optimizing what the compiler already removed.

## Complexity budgets
- **Big-O is the one legitimate design-time performance concern** — algorithm and data-structure choice is cheap before implementation and expensive after; choosing the right complexity class is not premature optimization.
- **Know n** — and its growth. O(n²) on a bounded n of 50 is fine forever; O(n log n) on unbounded user data is a budget question.
- Constant-factor tuning waits for a measurement; complexity-class decisions don't.

## Guardrails
- **Readability is the default** — code is optimized for the next reader until a measurement against a violated budget says otherwise (`software-engineering` §Design KISS/YAGNI).
- **Optimize only: measured hot path + violated budget.** Both, not either — a hot path within budget is done; a slow path nobody hits is nobody's problem.
- **Every optimization records before / after** under the same benchmark; one that doesn't pay for its complexity gets reverted, not defended.
- **Caching is a liability until measured** — invalidation, staleness, and memory cost are permanent; earn a cache with a measurement, and budget its hit rate like any other target.
- Guard the budget in CI where it matters — a perf test against the budget catches the regression before `debug` meets it in prod.

## Output
```
## Performance: <operation>
Budget: <target @ percentile | none — set one first>
Measured: <profile / benchmark result + conditions>
Largest contributor: <component — share of runtime>
Action: <change> — before: <…> after: <…> | within budget — stop
```

## Gates
- Budget stated (percentile target) before any optimization.
- Profile identifies the largest contributor; no change to unmeasured code.
- Benchmark: realistic workload, warm-up, fixed environment, distribution reported, baseline recorded.
- After-measurement present; miss → revert.
- Complexity class checked against n's growth at design time.
