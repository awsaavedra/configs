---
name: data-analysis
description: Hygiene for drawing conclusions from numbers — provenance + sanity checks before any statistic, plot before summarizing, named denominators + base rates, distribution over mean, outliers investigated not silently dropped, confounder / selection-bias / Simpson's-paradox checks before causal stories, signal-vs-noise guards (regression to the mean, multiple comparisons, practical vs statistical significance). Triggers: /data-analysis · "analyze this data" · "what do these numbers say" · "is this metric real" · "does this trend hold" · "did the experiment work".
when_to_use: Drawing a conclusion from numbers — metrics, benchmarks, experiment results, survey data — or auditing a conclusion someone else drew. `research` covers what the literature says; this covers what the data says. Not topic investigation (research), not root-causing a failure (debug, whose evidence rules bind here too), not producing the benchmark itself — budgets, workload, environment (performance; its results are read under these rules).
---

# Data Analysis

A statistic is a claim plus a method, and the method is where analyses die. Every rule here exists because the number can be right while the conclusion is wrong.

## Before any statistic
- **Provenance** — who collected it, how, over what period, and what never entered the dataset. Data filtered on the way in (dropped rows, failed pings, churned users) biases everything downstream.
- **Sanity** — units consistent · orders of magnitude plausible · totals reconcile · duplicates and nulls counted · the time range actually covers the claim. A number that fails the smell test isn't analyzed; it's investigated.
- **Plot before summarizing** — identical summary statistics hide wildly different data (Anscombe). Look at the shape first; the statistic comes second.

## Denominators & base rates
- **Every rate names its denominator.** "Errors doubled" means nothing without traffic; a percentage without its base is an anecdote in a suit.
- **Base rates first** — a 99%-accurate detector on a 1-in-10,000 condition is mostly false positives. Condition on the prior before trusting the hit.
- Counts and rates answer different questions; switching between them mid-argument is how numbers lie.

## Distributions
- **Never the mean alone** — report center *and* spread *and* shape. Skew and fat tails make the mean a lie (mean latency with a P99 tail; mean wealth vs median).
- Percentiles for anything user-facing (P50 / P95 / P99); the tail is where the pain lives.
- A change in the mean with no change in the median is a tail story — find which tail.

## Outliers
- **Investigate before excluding** — an outlier is either a pipeline error (fix the pipeline, not the point) or the most informative datum you have (fat-tail domains are *made* of outliers).
- Exclusion is a recorded decision: which points, why, and both results (with / without). Silent deletion is fabrication by omission.

## Causal hygiene
- **Correlation earns no causal verb** — "drives", "causes", "improves" require a mechanism plus ruled-out alternatives, not a scatterplot.
- **Enumerate confounders before accepting the story** — what third thing moves both? Time is the classic (everything trends together).
- **Selection & survivorship** — who's missing from the sample? Analyzing only what survived the filter (returning users, passing builds, live companies) studies the filter, not the population.
- **Simpson's paradox** — check whether the key subgroups reverse the aggregate before shipping the aggregate; a mix-shift can manufacture or hide any trend.

## Signal vs noise
- **Small samples are volatile** — the most extreme groups are usually the smallest. Rank nothing by raw rate without a size floor.
- **Regression to the mean** explains most improvement-after-intervention on a metric selected for being bad; demand a control or a holdout before crediting the fix.
- **Multiple comparisons** — slice enough cuts and something is "significant" by chance. Name the hypothesis before looking; slices found after the fact are hypotheses for the *next* dataset, not conclusions from this one.
- **Practical vs statistical significance** — with enough n, trivia is significant; with real stakes, effect size and cost decide, not p.

## Output
```
## Analysis: <question>
Data: <source · period · known exclusions>
Sanity: PASS | <issue — resolved how>
Finding: <effect + size + spread, denominators named>
Causal status: descriptive | correlated | causal (mechanism + alternatives ruled out)
Caveats: <outlier decisions · subgroup checks · what this data cannot answer>
```

## Gates
- Provenance and exclusions stated; sanity checks run before any statistic.
- Data plotted (or distribution characterized) before summarizing.
- Every rate's denominator named; base rate considered.
- Outlier handling recorded with both results.
- No causal verb without confounders enumerated and subgroups checked.
- Hypotheses named before slicing; post-hoc slices labeled as such.
