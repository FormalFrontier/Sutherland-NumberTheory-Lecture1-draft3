## Queue snapshot

At `2026-04-21T10:49:42Z`, `progress/status.json` shows:

- `sorry_free=14`
- `claims_audited=18`
- `definition_verified=6`
- `scaffolded=11`
- `structured=7`
- `non_formalizable=3`

The issue body for `#375` is already stale on one important point: the near frontier is not `definition_verified=4`; it is `definition_verified=6`, namely the `01_05`, `01_08`, and `01_09` theorem/proof pairs.

## Main sequencing risks

1. The audit queue is now concentrated in exactly three adjacent pairs: `01_05`, `01_08`, and `01_09`. Opening new Stage `3.4` proof issues before clearing those Stage `3.3` audits would violate the current gate and create planner churn.
2. Several early Chapter 1 items are already `claims_audited` and their Lean files contain no literal `sorry`, but their statuses were never promoted. The most obvious early cleanup targets are `01_02_Definition`, `01_03_Example`, `01_04_Proof`, and `01_06_Definition`; `#378` is already handling the first two.
3. The `01_09` pair is not the clean next hard-feature target yet. `01_09_Proof.lean` already has no `sorry`, but `01_09_Theorem.lean` still has two, so the pair is mixed and still audit-gated.
4. A naive "grep for `sorry`" heuristic is no longer reliable as a planning proxy. Many files are zero-sorry while still honestly parked at `scaffolded`, `definition_verified`, or `claims_audited` because the required review/audit/promotion work has not been logged yet.

## Recommended planner split

### Lane A: finish Stage `3.3` first

Treat the six `definition_verified` items as the immediate priority queue:

1. `#377` for `01_05_Corollary` / `01_05_Proof`
2. `#376` for `01_08_Theorem` / `01_08_Proof`
3. Create the matching Stage `3.3` audit issue for `01_09_Theorem` / `01_09_Proof`

This clears the gate contiguously and prevents planners from mixing audit work with proof work on the same local block.

### Lane B: explicit stale-status cleanup

After `#378` lands, planners should create small atomic promotion issues for already-audited zero-sorry files rather than letting them sit indefinitely as `claims_audited`.

Suggested order:

1. `01_04_Proof`
2. `01_06_Definition`
3. then the next earliest audited zero-sorry items (`01_11`-`01_13` cluster if still unchanged)

These should be framed as verification-plus-status-cleanup tasks, not as large proof features.

### Lane C: defer the next hard proof issue until the frontier is compressed

Do not make `01_09` the next hard-feature issue yet. After Lane A is cleared, the better hard-feature candidate is the smallest audited item that still has real theorem-level proof debt. Based on current file state, `01_05` is the better next proof lane than `01_09`: it is earlier in the text, adjacent to the current audit queue, and avoids jumping ahead to the product-formula pair while the nearer corollary/proof block is still unfinished.

## Practical planner guidance

- Prefer one more planner pass only after `#376`, `#377`, and the `01_09` audit issue are either claimed or converted into PRs.
- Keep cleanup issues atomic. Avoid a single "promote all stale statuses" batch issue.
- When choosing the next feature after the audit wave, use current file contents, not only statuses: `01_08` is already zero-sorry, `01_09` is mixed, and `01_05` still carries the clearest honest proof debt in the immediate early-Chapter frontier.
