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
- Since meditate issue `#237` closed on `2026-04-21T05:41:04Z`, `18` PRs have merged through `#275`. Since summarize issue `#238` closed on `2026-04-21T05:46:56Z`, `16` PRs have merged through `#275`.
- The late Chapter 1 tail is no longer the only active frontier. Recent merges added:
  - Stage `3.1` scaffolds for `01_10a_Discussion`, `01_11a_Discussion`, and `01_13a_Discussion`,
  - Stage `3.2` review for `01_24_Example`, `01_25_Proposition`, `01_26_Definition`, `01_27_Remark`, `01_28_Proposition`, and `01_29_Example`,
  - Stage `3.3` audits for `01_06`-`01_07`, `01_10`-`01_12`, and `01_25`-`01_27`.
- The live frontier is now split across two lanes:
  - middle valuation/DVR queue replenishment: `01_10a_Discussion` still needs Stage `3.2`, while `01_14` through `01_16a` remain unscheduled at `references_attached`,
  - late-tail audit completion: `01_24_Example`, `01_28_Proposition`, and `01_29_Example` remain `definition_verified` and still need Stage `3.3`.
- Current Chapter 1 status counts from `progress/status.json`:
  - `16` `claims_audited`,
  - `7` `definition_verified`,
  - `21` `scaffolded`,
  - `7` `references_attached`,
  - `1` `non_formalizable`.

## In-Flight Work

- No PRs are currently open, and there are no broken PRs.
- The only claimed issue is meditate issue `#270`.
- The only unclaimed work item is review issue `#276` for Stage `3.2` coverage on `Chapter1/01_10a_Discussion`.

## Queue Health And Risks

- Queue metrics at `2026-04-21T06:57:29Z`: `16` merged PRs since summarize issue `#238` closed, `18` merged PRs since meditate issue `#237` closed, `1` unclaimed `agent-plan` issue (`#276`), `1` claimed issue (`#270`), `0` open PRs, and `0` broken PRs.
- This is better stocked than the previous summary, but only barely. The queue has one immediate review task and then a large unscheduled middle tranche.
- The main planning risk is no longer starvation of the late tail. It is imbalance: if planners keep feeding only Stage `3.3` audit work, the newly reopened middle valuation/DVR tranche (`01_14`-`01_16a`) will remain the largest untouched dependency block.

## Recommended Planner Sequence

1. Prioritize review issue `#276` immediately so `Chapter1/01_10a_Discussion` joins the reviewed valuation/DVR vocabulary instead of leaving a scaffolded bottleneck in the middle tranche.
2. After `#276`, restock Stage `3.1` for the middle valuation/DVR sequence before expanding more tail work:
   - `Chapter1/01_14_Example` and `Chapter1/01_15_Example` next,
   - then `Chapter1/01_15a_Discussion`,
   - then `Chapter1/01_16_Theorem`, `Chapter1/01_16_Proof`, and `Chapter1/01_16a_Discussion`.
3. Keep exactly one late-tail Stage `3.3` lane open in parallel, starting with the remaining reviewed items `Chapter1/01_24_Example`, `Chapter1/01_28_Proposition`, and `Chapter1/01_29_Example`, but do not let those audits become the sole planner focus now that `01_11a` and `01_13a` are scaffolded.
4. Defer proof-heavy scaffold reviews (`01_20`-`01_23`, `01_25_Proof`, `01_28_Proof`) until the `01_14`-`01_16a` tranche is at least scaffolded. That restores the ordering described in `PLANNING.md` and avoids jumping ahead to later proofs while an earlier vocabulary/examples block is still missing.
5. Dispatcher posture: run at most `2` workers immediately, rising to `3` only after planners queue one middle-batch Stage `3.1` issue plus one late-tail Stage `3.3` audit alongside `#276`. More than `3` workers would create overlap because the middle tranche is still partly serial.
