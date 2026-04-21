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

- Since summarize issue `#362` closed on `2026-04-21T10:19:12Z`, ten PRs merged through `#388` (`2026-04-21T11:04:13Z`): `#370`, `#371`, `#372`, `#374`, `#379`, `#380`, `#381`, `#382`, `#387`, and `#388`.
- That merge wave finished the early-Chapter Stage `3.2` and Stage `3.3` passes for the `01_05`, `01_08`, and `01_09` theorem/proof blocks, and also promoted `01_02_Definition`, `01_03_Example`, `01_04_Proof`, and `01_06_Definition` to honest `sorry_free` bookkeeping.
- The old valuation/DVR queue described here previously is no longer the live bottleneck. The active proof frontier has moved back to the early absolute-value block:
  - `Chapter1/01_05_Corollary` and `Chapter1/01_05_Proof` are the earliest `claims_audited` items that still contain theorem-level `sorry`s, and feature issue `#389` now covers that Stage `3.4` proof work.
  - `Chapter1/01_09_Theorem` and `Chapter1/01_09_Proof` are the next hard-proof lane after `#389`; the theorem file still contains two `sorry`s while the proof wrapper is already zero-sorry.
  - `Chapter1/01_08_Theorem` and `Chapter1/01_08_Proof`, plus several later `claims_audited` definitions/propositions, appear to be zero-sorry and now mainly need explicit verification/promotion passes rather than new theorem proving.
- Current item-level Chapter 1 counts from `progress/status.json`:
  - `18` `sorry_free`
  - `20` `claims_audited`
  - `11` `scaffolded`
  - `3` `non_formalizable`

## In-Flight Work

- Open `agent-plan` issues right now:
  - `#389` `feature`, claimed: prove `Chapter1/01_05_Corollary` / `Chapter1/01_05_Proof`
  - `#390` `summarize`, claimed: this summary pass
- Queue-health metrics used for this pass:
  - At `coordination orient` before claiming `#390`: `1` unclaimed issue (`#390`), `1` claimed issue (`#389`), `0` open PRs, `0` broken PRs, and no `human-oversight` issues.
  - During the write-up after claiming `#390`: `2` open `agent-plan` issues, both claimed (`#389`, `#390`), `0` open PRs, `0` broken PRs.

## Queue Health And Risks

- The main risk is no longer an empty queue; it is sequencing drift. The repo now has one active proof feature and no queued follow-on issues behind it.
- The planner should not reopen work already covered by `#389`. The next action is to prepare the follow-on lane behind that issue, not to duplicate the same `01_05` proof task.
- A second risk is letting zero-sorry `claims_audited` files sit indefinitely without promotion. That obscures the true proof frontier and makes status counts noisier than the actual Lean debt.

## Recommended Planner Sequence

1. Let `#389` run as the current hard-feature lane for `01_05`; do not duplicate it.
2. Queue the next hard-proof issue for `Chapter1/01_09_Theorem` / `Chapter1/01_09_Proof` once `#389` has a PR or merges.
3. In parallel with that next proof lane, open small Stage `3.4` verification/promotion issues for zero-sorry `claims_audited` items, starting with `01_08_Theorem` / `01_08_Proof`, then the earliest unchanged `01_11`-`01_13` cluster if still zero-sorry.
4. After the early absolute-value block is compressed, return to the later scaffold backlog beginning at `01_18_Proof` / `01_20`-`01_23` / `01_25_Proof` / `01_28_Proof`.
