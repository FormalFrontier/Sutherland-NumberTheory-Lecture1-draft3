# Project Progress

## Completed Stages

- Stage `1.1` page extraction is complete.
- Stage `1.2` Lean/Mathlib bootstrap is complete.
- Stage `1.3` frontmatter detection and `pdf/pages/` mapping are complete.
- Stage `1.4` transcription is complete for logical pages `1` through `7`.
- Stage `1.5` validation is complete for logical pages `1` through `7`.
- Stage `1.6` structure analysis is complete for logical pages `1` through `7`, producing `items.json` with `52` Chapter 1 items.
- Stage `1.7` blob extraction is complete for `Chapter1/01_00_Introduction` through `Chapter1/01_29a_Bibliography`; `blobs/Chapter1/` contains all `52` extracted blob files from the opening lecture segment.
- Stage `2.1` internal dependency mapping is merged across the full extracted Chapter 1 slice.
- Stage `2.2` external dependency mapping is merged across the full extracted Chapter 1 slice.
- Stage `2.3` Mathlib-coverage research is merged across the full extracted Chapter 1 slice.
- Stage `2.4` external-source research is merged across the full extracted Chapter 1 slice.
- Stage `2.5` formalization planning is complete in [PLANNING.md](/home/kim/Sutherland-NumberTheory-Lecture1-draft3/worktrees/2cbe86e1/PLANNING.md).
- Stage `2.6` reference attachment is complete for all `52` extracted Chapter 1 blobs.

## Current Frontier

- Since summarize issue `#390` closed on `2026-04-21T11:16:29Z`, `30` PRs have merged through `#451` (`2026-04-21T13:42:20Z`): first the `#392`-`#419` integrality/order wave, then the `#420`-`#451` scaffold-review and missing-claims-audit sweep.
- Stage `3.4` moved first. The repo promoted `01_05_Corollary`/`01_05_Proof`, `01_08_Theorem`/`01_08_Proof`, `01_09_Theorem`/`01_09_Proof`, `01_11_Definition`, `01_12_Definition`, `01_13_Definition`/discussion, `01_17_Definition`, `01_18_Proposition`, `01_19_Definition`, `01_25_Proposition`, `01_26_Definition`, `01_27_Remark`, and `01_28_Proposition` to `sorry_free`.
- The frontier then shifted into Stage `3.2` and Stage `3.3` cleanup across the mid-Chapter integrality block:
  - `01_18_Proof` cleared Stage `3.2`, cleared Stage `3.3`, and then finalized as `sorry_free`.
  - `01_20_Proposition` finalized as `sorry_free`, while `01_20_Proof` cleared Stage `3.2` and Stage `3.3`.
  - `01_21_Corollary`/`01_21_Proof`, `01_22_Proposition`/`01_22_Proof`, and `01_23_Corollary`/`01_23_Proof` all cleared Stage `3.2` and Stage `3.3`.
  - `01_25_Proof` and `01_28_Proof` also cleared Stage `3.2` and Stage `3.3`.
- There are no active theorem-level `sorry`s left under `SutherlandNumberTheoryLecture1`; the only remaining `sorry` token in that tree is explanatory prose in `01_10_Definition.lean`.
- Current item-level Chapter 1 counts from `progress/status.json`:
  - `37` `sorry_free`
  - `12` `claims_audited`
  - `7` `structured`
  - `3` `non_formalizable`

## In-Flight Work

- Open `agent-plan` issues right now:
  - `#424` `summarize`, claimed: this summary pass
- Queue-health metrics used for this pass:
  - Immediately before claiming `#424`: `1` unclaimed issue (`#424`), `1` claimed issue (`#450`), `0` open PRs, `0` broken PRs, and no `human-oversight` issues.
  - During the write-up after `#451` merged and `#424` was claimed: `1` open `agent-plan` issue (`#424`), `0` open PRs, `0` broken PRs.

## Queue Health And Risks

- The main risk is status lag, not proof debt. Several `claims_audited` items in the `01_20`-`01_28` lane are already zero-sorry Lean files and mainly need Stage `3.4` promotion.
- With no unclaimed work and no open PRs, planner latency is now the main way the queue can stall.
- The remaining `structured` items are outside the already-clean integrality/order cluster, so the next planner cycle should avoid reopening `01_20`-`01_28` audit work that is already complete.

## Recommended Planner Sequence

1. Open a Stage `3.4` promotion issue for `Chapter1/01_20_Proof`, the earliest zero-sorry item still parked at `claims_audited`.
2. Follow with a small batch-promotion issue for the zero-sorry `01_21`-`01_23` cluster: `01_21_Corollary`, `01_21_Proof`, `01_22_Proposition`, `01_22_Proof`, `01_23_Corollary`, and `01_23_Proof`.
3. Then promote the later zero-sorry proof wrappers `01_25_Proof` and `01_28_Proof`, plus any terminal metadata cleanup such as `01_29a_Bibliography` if the planner wants the status file to reflect that it is already audit-complete and non-mathematical.
4. Once that bookkeeping pass lands, re-open the next real formalization lane from the remaining `structured` items rather than generating more audit work inside the already-clean `01_18`-`01_28` block.
