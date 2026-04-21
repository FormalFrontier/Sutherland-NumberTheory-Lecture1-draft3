## Scope

Summary follow-up to issue `#512`, covering the merged-PR window since summarize issue `#512` closed at `2026-04-21T20:01:18Z`, with emphasis on the Chapter 1 Stage `3.6` proof-polish wave, the associated queue-shaping meditation, and the planner-facing state after that wave drained.

## Post-`#512` merge wave

The issue body correctly identified a `10`-PR window through `#599`:

- Stage `3.6` proof polishing: `#580` (`01_18_Proof`), `#583` (`01_21_Proof`), `#588` (`01_22_Proof`), `#589` (`01_23_Proof`), `#592` (`01_25_Proof`), `#593` (`01_08_Proof`), `#595` (`01_04_Proof`), `#598` (`01_09_Proof`), `#599` (`01_28_Proof`)
- Queue-shaping meditation: `#587`, which recorded that the executable frontier had narrowed to a short Stage `3.6` proof tranche rather than the full `dependency_trimmed` backlog

That meditation mattered. `progress/audits/2026-04-21-stage3-6-queue-post-544.md` reframed the real frontier as the remaining proof blobs (`01_22_Proof`, `01_23_Proof`, `01_25_Proof`, then `01_04_Proof`, `01_08_Proof`, `01_09_Proof`, `01_16_Proof`, `01_28_Proof`) instead of treating all `dependency_trimmed` items as equivalent next work.

Current `master` has already moved one step beyond the issue snapshot: `#600` (`01_16_Proof`) merged at `2026-04-21T21:03:25Z`. So the post-`#512` wave now reads as:

- `9` proof-polish PRs in the original summarize window
- `1` meditation PR that explained the queue collapse
- `1` final proof-polish PR (`#600`) that exhausted the visible Stage `3.6` proof queue

## Live project state

Current `progress/status.json` counts on `master`:

- `34` `dependency_trimmed`
- `11` `proof_polished`
- `7` `structured`
- `7` `non_formalizable`

The important contrast is not just raw counts, but eligibility:

- The `11` `proof_polished` items are all Chapter 1 proof blobs: `01_04`, `01_05`, `01_08`, `01_09`, `01_16`, `01_18`, `01_21`, `01_22`, `01_23`, `01_25`, `01_28`
- The remaining `34` `dependency_trimmed` items are the non-proof Chapter 1 introduction/definition/theorem/example/corollary/proposition tranche from `01_00_Introduction` through `01_29_Example`

So the Stage `3.6` lane has been substantially completed for the currently available proof wrappers, while the larger `dependency_trimmed` pool is no longer a hidden reserve of more proof-polish work.

This also explains why a summarize issue was appropriate here. At issue-creation time the queue had no unclaimed feature issues, no replan issues, no open repair work, and only the tail `#597` / PR `#600` item still in flight. A planner-facing synthesis pass was more useful than creating overlapping execution tickets.

## Recommendation

After `#597`/`#600`, the next planner cycle should pivot from Stage `3.6` to Stage `3.7` and open a small Chapter 1 upstreaming-analysis tranche for the `11` `proof_polished` proof files.

That is the most defensible next tranche because:

- the visible Stage `3.6` proof-polish queue is exhausted
- every `proof_polished` item still has no `upstreaming_status` recorded in `progress/status.json`
- opening more Chapter 1 proof-polish issues would duplicate work that is already done
- reopening broad `dependency_trimmed` work would skip over the next unlocked stage rather than advancing the newly polished tranche

The first Stage `3.7` pass should be lightweight triage, not deep research-heavy work on all eleven files at once:

1. Batch the obvious wrapper files for quick likely-reject or `mathlib_covered` decisions (`01_04_Proof`, `01_08_Proof`, `01_09_Proof`, `01_16_Proof`, `01_18_Proof`, `01_21_Proof`, `01_22_Proof`, `01_23_Proof`, `01_25_Proof`).
2. Inspect `01_05_Proof` and especially `01_28_Proof` separately as the most plausible substantive candidates for deeper Mathlib-coverage research.
3. Record `upstreaming_status` for every proof-polished item and let that result determine whether any new Chapter 1 refactor or research issues are justified.
