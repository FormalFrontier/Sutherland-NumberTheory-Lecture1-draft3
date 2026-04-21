## Queue Snapshot

At `2026-04-21T12:24:04Z`, `progress/status.json` shows:

- `sorry_free=36`
- `claims_audited=3`
- `definition_verified=2`
- `scaffolded=8`
- `structured=7`
- `non_formalizable=3`

Live queue state from `coordination orient` after claiming `#423`:

- `1` unclaimed issue: `#424` (`summarize`)
- `1` claimed issue: `#423` (`meditate`)
- `0` open PRs
- `0` broken PRs

## Main Sequencing Risks

1. The issue body's framing is already stale on the most important point: the late Chapter 1 backlog is no longer implementation-heavy. Every remaining `scaffolded` item in the active `01_21`-`01_28` span currently has a Lean file with no literal `sorry`, so the real debt is missing Stage `3.2` review and later promotion bookkeeping.
2. The near frontier is compact and contiguous: `01_20_Proposition` and `01_20_Proof` are the only `definition_verified` items, and they sit immediately before the `01_21`-`01_23` scaffold block. If planners skip over them, the status frontier becomes noisy and workers will keep re-reading the same local context.
3. `01_21`-`01_23` are adjacent but not equally independent. `01_21_Proof` explicitly uses Proposition `1.20`, and `01_23` builds on the `01_22` integrally-closed result. Queueing these out of order would create avoidable replan churn.
4. `01_25_Proof` and `01_28_Proof` look tempting as "hard proof" items because they are proof blobs, but their current Lean files already package the textbook arguments. They should be treated as late Stage `3.2` review tasks, not as fresh theorem-proving features.

## Recommended Planner Split

### Lane A: compress the immediate frontier first

Open the next two issues as Stage `3.3` missing-claims audits:

1. `Chapter1/01_20_Proposition`
2. `Chapter1/01_20_Proof`

These are the only `definition_verified` items left, and clearing them first keeps the late-integrality frontier honest before planners fan back out into the scaffold backlog.

### Lane B: run the scaffold-review wave as small atomic pairs

After the `01_20` audits are claimed or in PR, queue Stage `3.2` review issues in textbook order:

1. `Chapter1/01_21_Corollary` and `Chapter1/01_21_Proof`
2. `Chapter1/01_22_Proposition` and `Chapter1/01_22_Proof`
3. `Chapter1/01_23_Corollary` and `Chapter1/01_23_Proof`

These are review tasks, not proof-construction tasks. The files are already populated and zero-`sorry`; workers should re-read blobs against Lean, confirm no missing claim or definition defect, and promote them if the scaffolds are complete.

### Lane C: clear the tail reviews before opening new proof work

Only after Lane B is flowing, queue the two remaining late-tail scaffold reviews:

1. `Chapter1/01_25_Proof`
2. `Chapter1/01_28_Proof`

These can run independently of the `01_21`-`01_23` chain because the nearby proposition/definition support is already `sorry_free`.

## Practical Planner Guidance

- The next batch should be review-heavy, not implementation-heavy. There is no evidence in the live files that the current Chapter 1 frontier needs a new hard-proof feature issue yet.
- Keep the issues atomic. Avoid a single omnibus "review `01_21`-`01_28`" ticket; the current state supports five small non-overlapping worker tasks.
- Do not reopen `01_18` or `01_20` implementation work. The bottleneck there is status promotion (`definition_verified` to `claims_audited`), not theorem proving.
- Once the `01_20`-`01_28` review wave is mostly in PR, then a planner can decide whether another summarize/meditate pass is warranted. Right now the highest leverage is simply restocking the worker queue with these review items.
