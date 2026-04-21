## Scope

Summary follow-up to issue `#512`, covering the merged-PR window since summarize issue `#492` (`2026-04-21T15:43:04Z`) and the live planner-facing frontier after that wave finished playing out.

## Post-`#492` merge wave

Since `#492`, `39` PRs have merged through `#576`. The issue body captured only the early half of the wave; the actual merged run extended well beyond `Chapter1/01_21_Corollary` and ended up clearing the visible Chapter 1 Stage `3.5` tail.

The wave breaks down into four parts:

1. Stage `3.5` dependency trimming in book order from `Chapter1/01_08_Proof` through `Chapter1/01_17_Definition`:
   - `#496`, `#497`, `#500`, `#501`, `#505`, `#507`, `#510`, `#511`, `#514`, `#515`, `#518`, `#519`, `#522`, `#523`, `#526`
2. Queue-shaping checkpoints that should be noted but not re-expanded here:
   - `#506` already recorded the meditate checkpoint during this same wave
   - `#546` added a later queue-shaping meditation once the frontier had moved farther down Chapter 1
3. Middle and late Stage `3.5` trimming from `Chapter1/01_18_Proof` through `Chapter1/01_29_Example`:
   - `#533`, `#534`, `#538`, `#540`, `#542`, `#545`, `#549`, `#556`, `#559`, `#560`, `#562`, `#565`, `#566`, `#572`, `#573`, `#571`
4. PR repair and stale-branch cleanup needed to keep that wave landing:
   - `#531` repaired the conflicted `01_18_Proposition` branch path
   - `#537` cleaned up the stale conflicted PR around `01_18`
   - `#552` repaired the conflicted `01_23_Corollary` PR
   - `#574` repaired PR `#571` so `01_28_Proposition` could merge cleanly
   - `#576` opened Stage `3.6` by polishing `Chapter1/01_05_Proof`

## Live project state

Current `progress/status.json` counts:

- `44` `dependency_trimmed`
- `1` `proof_polished`
- `7` `structured`
- `7` `non_formalizable`

Relative to summarize issue `#492`, the status mix has fully flipped:

- Then: `34` `sorry_free`, `11` `dependency_trimmed`, `7` `structured`, `7` `non_formalizable`
- Now: `0` `sorry_free`, `44` `dependency_trimmed`, `1` `proof_polished`, `7` `structured`, `7` `non_formalizable`

That means the entire `34`-item `sorry_free` tranche visible at `#492` has now advanced out of `sorry_free`: `33` items are currently recorded as `dependency_trimmed`, and `1` (`Chapter1/01_05_Proof`) has already moved one step farther to `proof_polished`.

The dependency-trimmed run now extends through the end of the visible Chapter 1 mathematical sequence:

- Early wave endpoint captured by the issue body: `Chapter1/01_21_Corollary`
- Actual current endpoint on `master`: `Chapter1/01_29_Example`

## Recommendation

Do not create more Chapter 1 Stage `3.5` dependency-trimming issues in the old visible tranche; that queue is exhausted through `Chapter1/01_29_Example`.

The next planner cycle should:

1. Treat this as a queue-shaping moment, not as a request for more of the same `01_21`-era Stage `3.5` tickets.
2. Recompute the next genuine Stage `3.5` frontier from current `progress/status.json` and book order, because the issue snapshot is stale by nearly an entire page of Chapter 1.
3. In parallel, allow the already-open Stage `3.6` proof-polish work (`#577` for `01_18_Proof`, `#578` for `01_20_Proof`) to proceed, since those are now the clearest unclaimed executable items.
