## Scope

Summary follow-up to issue `#642`, covering the merged-PR window since summarize issue `#642` closed at `2026-04-21T22:40:44Z`. The issue body was opened against a `45`-PR window with `Chapter1/01_15a_Discussion` still in flight; during this turn, already-green PR `#752` was merged, so the live window on `master` is now `46` merged PRs and the Chapter 1 Stage `3.6` polish wave is fully landed.

## Post-`#642` merge wave

The `46` merged PRs since `#642` break into three clear tranches:

- `7` Stage `3.7` / tracker maintenance PRs at the front of the window: `#644`, `#645`, `#646`, `#647`, `#649`, `#651`, `#653`
- `5` template and policy corrections that reset the Stage `3.6` bookkeeping onto the updated project rules: `#654`, `#657`, `#659`, `#660`, `#730`
- `34` Chapter 1 Stage `3.6` polish/formalization PRs that advanced the remaining non-proof Lean files from `dependency_trimmed` to `polished`: `#731` through `#764`, plus the final `#752` repair landing for `Chapter1/01_15a_Discussion`

That last tranche is the dominant story. The wave polished the Chapter 1 introduction, definition, theorem, discussion, example, proposition, corollary, and remark wrappers in rapid sequence:

- early tranche: `01_00_Introduction` through `01_13a_Discussion` via `#731`-`#747`
- middle tranche: `01_14_Example` through `01_23_Corollary` via `#748`-`#758`
- closing tranche: `01_24_Example` through `01_29_Example` via `#759`-`#764`
- final straggler: `#752`, which closed out `01_15a_Discussion` after the temporary conflict noted in repair issue `#765`

## Live project state

On a fresh `origin/master` worktree after `#752`, `scripts/ff-status` now reports:

- `59` total tracked items
- `0` non-terminal items
- `0` unrecognised statuses
- phase totals: `45 polished`, `7 non_formalizable`, `7 structured`

The queue snapshot is correspondingly empty:

- issue `#695` is closed at `2026-04-22T08:06:57Z`
- repair issue `#765` is already closed
- there are no open PRs
- there are no open `feature`, `review`, `replan`, or `human-oversight` issues
- the only open `agent-plan` issue is this summarize issue `#766`

So the issue body's "near-terminal" read is now slightly stale: the project is not merely near-terminal on Chapter 1 Stage `3.6`; that lane is presently exhausted on `master`, and there is no additional planner-created work left unblocked once `#752` landed.

## Recommendation

The next planner cycle should not hold a minimal execution queue waiting for the `#695` / `#765` repair path anymore, because that repair path has already landed. Instead:

1. Close out `#766` and let the dispatcher sit effectively idle until a planner creates a genuinely new tranche.
2. Treat the next planner action as a fresh frontier-selection pass over a now-terminal `progress/status.json`, rather than as continuation of the old Stage `3.6` wave.
3. Do not trigger another summarize pass immediately; a new summarize issue is only likely to be useful after a planner opens and partially executes the next stage, creating another nontrivial merge wave worth synthesizing.
