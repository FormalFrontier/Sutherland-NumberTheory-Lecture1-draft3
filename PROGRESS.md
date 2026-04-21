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
- Since meditate issue `#270` closed on `2026-04-21T07:00:53Z`, `30` PRs have merged through `#340` (`2026-04-21T09:25:08Z`). Since summarize issue `#297` closed on `2026-04-21T08:15:34Z`, `15` PRs have merged through `#340`.
- The Chapter 1 valuation/DVR wave is no longer merely in proof completion; most of the local block has already landed:
  - `01_06a_Discussion`, `01_07_Definition`, `01_11a_Discussion`, `01_14_Example`, `01_15_Example`, `01_15a_Discussion`, `01_16_Theorem`, and `01_16_Proof` are now `sorry_free`,
  - the remaining nearby unreconciled valuation items are `01_10a_Discussion`, `01_13_Definition`, `01_13a_Discussion`, and `01_16a_Discussion`,
  - the closest disjoint late-tail follow-on remains `01_24_Example` / `01_24a_Discussion`.
- The live frontier is now split across three non-overlapping lanes:
  - middle valuation bridge work: `01_10a_Discussion`, `01_13_Definition`, and `01_13a_Discussion` still need Stage `3.3`,
  - immediate valuation follow-through: `01_16a_Discussion` is still only `references_attached`,
  - disjoint late-tail replenishment: `01_24_Example` is `definition_verified` and `01_24a_Discussion` is `references_attached`.
- Current Chapter 1 status counts from `progress/status.json`:
  - `17` `claims_audited`,
  - `4` `definition_verified`,
  - `18` `scaffolded`,
  - `2` `references_attached`,
  - `10` `sorry_free`,
  - `1` `non_formalizable`.

## In-Flight Work

- There are no open PRs, no broken PRs, and no claimed feature/review/meditate issues.
- Claimed summarize issue `#336` is the only active `agent-plan` item.
- Open issue `#326` remains as a stale normalization-sensitive note from the pre-`#333` `01_11a_Discussion` proof attempt; the underlying theorem was repaired and merged in PR `#333`, so this issue should be closed or rewritten rather than treated as live frontier.

## Queue Health And Risks

- Queue metrics at `2026-04-21T09:26:31Z`: `0` unclaimed feature issues, `0` unclaimed review issues, `0` open PRs, `0` broken PRs, and exactly `1` claimed `agent-plan` issue (`#336`).
- The main risk is queue starvation. The proof wave landed faster than planners restocked adjacent work, so worker capacity will collapse immediately after this summarize issue closes unless new items are opened.
- The main sequencing risk is skipping over the unfinished valuation bridge (`01_10a` / `01_13` / `01_13a` / `01_16a`) and jumping into distant proof-heavy scaffolds. That would break the local narrative continuity the recent merge wave just restored.

## Recommended Planner Sequence

1. Open a Stage `3.3` audit batch for `Chapter1/01_10a_Discussion`, `Chapter1/01_13_Definition`, and `Chapter1/01_13a_Discussion`. This is now the most important adjacent lane because it reconnects the cleaned-up valuation examples back to the earlier valuation setup.
2. Open a small Stage `3.1` issue for `Chapter1/01_16a_Discussion` immediately after that. It is the direct follow-on to the now-`sorry_free` `01_16` theorem/proof pair and the only remaining unscheduled blob in that local DVR thread.
3. In parallel, queue one disjoint late-tail task: either Stage `3.3` for `Chapter1/01_24_Example` or Stage `3.1` for `Chapter1/01_24a_Discussion`. This gives workers a non-overlapping lane while the valuation bridge is being restocked.
4. Only after those lanes are open should planners expand into the heavier proof backlog (`01_04`/`01_05`/`01_08`/`01_09`, or later `01_20`-`01_23` / `01_25_Proof` / `01_28_Proof`). The current bottleneck is lack of queued adjacent work, not lack of raw scaffolded material.
5. Dispatcher posture: keep worker capacity at `2` until planners open at least two real follow-on issues. Raise to `3` once the valuation-bridge batch and one disjoint `01_24`-lane task exist. More than `3` workers would just compete for an empty queue.
