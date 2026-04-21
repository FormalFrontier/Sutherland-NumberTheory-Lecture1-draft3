# Project Progress

## Completed Stages

- Stage `1.1` page extraction is complete.
- Stage `1.2` Lean/Mathlib bootstrap is complete.
- Stage `1.3` frontmatter detection and `pdf/pages/` mapping are complete.
- Stage `1.4` transcription is complete for logical pages `1` through `7`.
- Stage `1.5` validation is complete for logical pages `1` through `7`.
- Stage `1.6` structure analysis is complete for logical pages `1` through `7`, producing `items.json` with `52` Chapter 1 items.
- Stage `1.7` blob extraction is complete for `Chapter1/01_00_Introduction` through `Chapter1/01_29a_Bibliography`; `blobs/Chapter1/` now contains all `52` extracted blob files from the opening lecture segment.
- Stage `2.1` internal dependency mapping is merged across the full current Chapter 1 slice.
- Stage `2.2` external dependency mapping is merged across the full current Chapter 1 slice.
- Stage `2.3` Mathlib-coverage research is merged across the full current Chapter 1 slice.
- Stage `2.4` external-source research is merged across the full current Chapter 1 slice.
- Stage `2.5` formalization planning is complete in [PLANNING.md](/home/kim/Sutherland-NumberTheory-Lecture1-draft3/worktrees/4184d558/PLANNING.md).
- Stage `2.6` reference attachment is complete for all `52` extracted Chapter 1 blobs. `progress/status.json` tracks the full slice from `Chapter1/01_00_Introduction` through `Chapter1/01_29a_Bibliography`.

## Current Frontier

- Phase `2` is complete for the current extracted slice (logical pages `1` through `7`).
- Since meditate issue `#270` closed on `2026-04-21T07:00:53Z`, `27` PRs have merged through `#337`. Since summarize issue `#297` closed on `2026-04-21T08:15:34Z`, `13` PRs have merged through `#337`.
- The Chapter 1 valuation/DVR block has advanced from scaffold/review work into active proof completion:
  - `01_06a_Discussion`, `01_07_Definition`, `01_11a_Discussion`, `01_15a_Discussion`, and the `01_16` theorem/proof pair are now `sorry_free`,
  - `01_14_Example` and `01_15_Example` have cleared Stage `3.3` and are in Stage `3.4`,
  - the remaining nearby unreconciled valuation items are now `01_10a_Discussion`, `01_13_Definition`, `01_13a_Discussion`, and `01_16a_Discussion`.
- The live frontier is split across three non-overlapping lanes:
  - active proof completion: `01_14_Example` and `01_15_Example`,
  - middle valuation follow-through: `01_10a_Discussion`, `01_13_Definition`, and `01_13a_Discussion` still need to move from `definition_verified` to `claims_audited`,
  - queue replenishment / later isolation: `01_16a_Discussion` and `01_24a_Discussion` remain at `references_attached`, while `01_24_Example` remains `definition_verified`.
- Current Chapter 1 status counts from `progress/status.json`:
  - `19` `claims_audited`,
  - `4` `definition_verified`,
  - `18` `scaffolded`,
  - `2` `references_attached`,
  - `8` `sorry_free`,
  - `1` `non_formalizable`.

## In-Flight Work

- Open PR `#338` covers Stage `3.4` proof completion for `Chapter1/01_14_Example`; its CI was still in progress when this snapshot was prepared.
- Claimed feature issue `#334` is the parallel Stage `3.4` proof lane for `Chapter1/01_15_Example`.
- Unclaimed summarize issue `#336` is the only remaining queued meta item after this meditation closes.
- There are no broken PRs and no unclaimed feature or review issues right now.

## Queue Health And Risks

- Queue metrics at `2026-04-21T09:22:08Z`: `1` unclaimed `agent-plan` issue (`#336`), `3` claimed issues (`#320`, `#334`, and the open-PR issue `#335`), `1` open PR (`#338`), `0` broken PRs, `0` unclaimed feature issues, and `0` unclaimed review issues.
- The earlier risk of starvation has been replaced by a different problem: the project now has real proof momentum, but planners have not restocked the next adjacent Chapter 1 work items behind the two active proof lanes.
- The main sequencing risk is over-concentrating on already-active proofs while leaving the `01_10a` / `01_13` / `01_13a` bridge and the `01_16a` follow-on discussion unscheduled. If that happens, worker capacity collapses again as soon as `01_14` and `01_15` merge.

## Recommended Planner Sequence

1. Let the active Stage `3.4` pair finish, but plan behind it now rather than waiting for those merges. The next adjacent valuation issue should be a Stage `3.3` audit batch for `Chapter1/01_10a_Discussion`, `Chapter1/01_13_Definition`, and `Chapter1/01_13a_Discussion`.
2. Queue a small Stage `3.1` issue for `Chapter1/01_16a_Discussion` immediately after that audit batch is opened. It is the direct textual follow-on to the completed `01_16` pair and is the most important unscheduled blob in the same local dependency cluster.
3. Keep one disjoint late-tail lane available in parallel, with `Chapter1/01_24_Example` Stage `3.3` or `Chapter1/01_24a_Discussion` Stage `3.1` as the best low-overlap option. This preserves parallelism without sending workers back into the already-busy `01_14` / `01_15` proof files.
4. Defer broader late-tail proof batches (`01_20`-`01_23`, `01_25_Proof`, `01_28_Proof`) until the valuation bridge through `01_16a` is queued. The current bottleneck is local continuity in the valuation/DVR narrative, not lack of distant theorem work.
5. Dispatcher posture: keep total worker capacity at `3` for now. That matches the actual independent work surface: one active `01_14` proof lane, one active `01_15` proof lane, and one non-overlapping meta/planning lane. Raise to `4` only after planners open both the `01_10a`/`01_13`/`01_13a` audit batch and a disjoint `01_24` or `01_24a` issue, because only then are there four genuinely separate tasks without file overlap.
