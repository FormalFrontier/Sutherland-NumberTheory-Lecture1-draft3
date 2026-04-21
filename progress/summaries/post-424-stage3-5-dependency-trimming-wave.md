## Scope

Summary follow-up to issue `#478`, covering the merge wave after summarize issue `#424` and the live Chapter 1 Stage `3.5` frontier visible now.

## Post-`#424` merge wave

The wave after `#424` did two things in sequence:

1. Queue shaping and stage-boundary cleanup:
   - `#457` ran the mandatory Stage `3` status check after the Chapter 1 merge wave.
   - `#459` and `#460` promoted the `01_21`-`01_23`, `01_25_Proof`, and `01_28_Proof` cluster to `sorry_free`.
   - `#462` closed obsolete PR `#458`.
   - `#465` recorded the post-`#423` queue-collapse meditation.
   - `#466` normalized `Chapter1/01_29a_Bibliography` to terminal `non_formalizable`.
2. Start of Stage `3.5` dependency trimming in book order:
   - `#470` trimmed `Chapter1/01_02_Definition`
   - `#471` trimmed `Chapter1/01_03_Example`
   - `#474` trimmed `Chapter1/01_00_Introduction`
   - `#475` trimmed `Chapter1/01_04_Lemma`

That wave converted the earlier "queue collapse" meditation into an active Stage `3.5` execution lane: the project stopped treating Chapter 1 as a Stage `3.4` proving frontier and started trimming real direct dependencies item by item.

## Live project state

Current `progress/status.json` counts:

- `34` `sorry_free`
- `11` `dependency_trimmed`
- `7` `non_formalizable`
- `7` `structured`

The early Chapter 1 dependency-trimming tranche has now advanced beyond the original four PRs. The items through `Chapter1/01_08_Theorem` currently stand as:

- `dependency_trimmed`: `01_00_Introduction`, `01_02_Definition`, `01_03_Example`, `01_04_Lemma`, `01_04_Proof`, `01_05_Corollary`, `01_05_Proof`, `01_06_Definition`, `01_06a_Discussion`, `01_07_Definition`, `01_08_Theorem`
- still `sorry_free`: `01_08_Proof`, `01_09_Theorem`, `01_09_Proof`

Queue health at summary time:

- `2` unclaimed work items: `#490` (`01_09_Theorem`) and `#491` (`01_08_Proof`)
- `1` claimed work item: this summarize issue `#478`
- `0` open PRs
- `0` PRs needing attention

## Active frontier

The active frontier is still Chapter 1 Stage `3.5` dependency trimming. The current queue shows the next immediate passes on the Ostrowski/product-formula block:

1. `#491` trim dependencies for `Chapter1/01_08_Proof`
2. `#490` trim dependencies for `Chapter1/01_09_Theorem`

After those land, the next obvious follow-on is the still-`sorry_free` `Chapter1/01_09_Proof`, unless a fresh status/queue check surfaces a better dependency-trimming target elsewhere in book order.
