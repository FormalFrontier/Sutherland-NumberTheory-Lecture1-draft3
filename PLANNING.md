# Stage 2.5 Formalization Planning Report

This report covers the currently extracted Chapter 1 slice through `Chapter1/01_29a_Bibliography` (logical pages `1` through `7`). It is based on `items.json`, `dependencies/internal.json`, `dependencies/external.json`, `research/mathlib-coverage.json`, `research/external-sources.json`, and the current execution frontier recorded in `progress/status.json`.

## Suggested Formalization Order

1. Start Phase `3.1` on the opening batch items that already have Stage `2.6` merged.
   The only slice items currently at `references_attached` are `Chapter1/01_00_Introduction` through `Chapter1/01_09a_Discussion`, so these are the only items immediately eligible for scaffolding without waiting on PR `#88` or issue `#90`.

2. Build the absolute-value kernel first.
   Formalize `Chapter1/01_02_Definition`, `Chapter1/01_03_Example`, `Chapter1/01_06_Definition`, and `Chapter1/01_07_Definition` before any proof-heavy opening-batch claims. These introduce the bundled objects used by `Chapter1/01_04_Lemma`, `Chapter1/01_05_Corollary`, `Chapter1/01_08_Theorem`, and `Chapter1/01_09_Theorem`.

3. Discharge the low-friction theorem/proof pairs that already match Mathlib.
   After the kernel is scaffolded, `Chapter1/01_08_Theorem` and `Chapter1/01_08_Proof` should be early proof targets because `Rat.AbsoluteValue.equiv_real_or_padic` already matches the lecture. This gives a quick end-to-end win in the opening batch while harder local infrastructure is still missing elsewhere.

4. Treat `Chapter1/01_04_Lemma`, `Chapter1/01_05_Corollary`, and `Chapter1/01_09_Theorem` as the opening-batch hard tail.
   `Chapter1/01_04_Lemma` and `Chapter1/01_05_Corollary` need small local glue around `AbsoluteValue`, while `Chapter1/01_09_Theorem` will need genuinely new local infrastructure. These should not block scaffolding or easy proof progress on other items.

5. Once the middle-batch references land, formalize the valuation/DVR vocabulary before the examples and TFAE.
   The recommended order is `Chapter1/01_10_Definition`, `Chapter1/01_11_Definition`, `Chapter1/01_12_Definition`, `Chapter1/01_13_Definition`, then the surrounding discussion blobs `Chapter1/01_10a_Discussion`, `Chapter1/01_11a_Discussion`, `Chapter1/01_13a_Discussion` after the Stage `3.1` claim audit decides which claims are formalizable. Only after that should work move to `Chapter1/01_14_Example`, `Chapter1/01_15_Example`, and `Chapter1/01_16_Theorem`.

6. Treat the integrality block as the main parallelizable tranche once tail references land.
   `Chapter1/01_17_Definition` through `Chapter1/01_23_Proof` are unusually favorable because Mathlib already contains exact statements for integrality, integral closure, transitivity, and integrally closed domains. This block should be formalized before the tail examples `Chapter1/01_24_Example` and `Chapter1/01_29_Example`, and before the valuation-ring bridge in `Chapter1/01_25_Proposition`.

7. Leave order language and explicit quadratic examples until after the integrality kernel is stable.
   `Chapter1/01_24_Example`, `Chapter1/01_25_Proposition`, `Chapter1/01_27_Remark`, `Chapter1/01_28_Proposition`, and `Chapter1/01_29_Example` all depend on the integrality infrastructure but still need item-specific bridging or calculations. They are better handled after the generic integrality API is already in place.

8. During Stage `3.1`, assess discussion and metadata blobs aggressively instead of assuming they are formalizable.
   The likely early `non_formalizable` candidates are `Chapter1/01_01a_Discussion`, `Chapter1/01_06a_Discussion`, `Chapter1/01_09a_Discussion`, `Chapter1/01_16a_Discussion`, and `Chapter1/01_29a_Bibliography`, but that decision should only be made after the required claim-by-claim audit in the roadmap.

## Dependency Gaps

1. `Chapter1/01_04_Lemma` and `Chapter1/01_05_Corollary` need local absolute-value lemmas.
   Mathlib has `AbsoluteValue.apply_nat_le_self`, Frobenius on finite fields, and equivalence-to-triviality checks, but not the lecture's exact nonarchimedean characterization or the stated positive-characteristic corollary. These are small but real local lemmas that sit between the exact definitions and the later classification results.

2. `Chapter1/01_09_Theorem` and `Chapter1/01_09_Proof` are a real library gap.
   No packaged product formula on `Q` was found. Expect local development around prime support of a rational, conversion between `padicValRat` and multiplicative norms, and a finite product argument over all contributing places.

3. `Chapter1/01_10_Definition` through `Chapter1/01_16_Proof` need statement-bridging from textbook valuations to Mathlib's bundled APIs.
   Mathlib has `Valuation`, `ValuationSubring`, `ValuationRing`, and `IsDiscreteValuationRing.TFAE`, but the lecture mixes additive valuations into `R ∪ {∞}`, valuation rings defined inside a fraction field, explicit uniformizer language, and a seven-way DVR characterization that is close to but not identical with Mathlib's statements. This is more of a packaging gap than an absence of theory.

4. `Chapter1/01_14_Example` and `Chapter1/01_15_Example` need concrete specialization lemmas.
   The general localization and Laurent-series infrastructure exists, but the examples require explicit identifications such as `Z_(p)`, its residue field, and the lecture's chosen valuation on `k((t))`.

5. `Chapter1/01_24_Example` and `Chapter1/01_29_Example` need explicit algebraic-number computations.
   Mathlib has the generic integrality and minimal-polynomial machinery, but not these specific witnesses in the lecture's presentation. Expect some manual quadratic-field algebra around `(1 + sqrt(5)) / 2` and `(1 + sqrt(7)) / 2`.

6. `Chapter1/01_25_Proposition` is likely to need a local bridge theorem rather than new theory.
   The result should be recoverable from `Valuation.Integers.isIntegrallyClosed` and the valuation-ring characterization already in Mathlib, but the lecture's statement is not exposed under one theorem name. A short wrapper theorem will probably be needed before later valuation-ring work feels natural.

7. `Chapter1/01_27_Remark` depends on order/maximal-order language that is only partially packaged in the current search results.
   `NumberField.RingOfIntegers` exists, but the remark about orders as lattices and `O_K` as the maximal order is not represented as one ready-made API surface in the current repository inputs.

8. The Stage `3.1` discussion-blob audit is itself a prerequisite for clean issue creation.
   Several discussion blobs probably reduce to `non_formalizable`, but some middle-batch discussion blobs (`Chapter1/01_10a_Discussion`, `Chapter1/01_11a_Discussion`, `Chapter1/01_13a_Discussion`, `Chapter1/01_15a_Discussion`, `Chapter1/01_24a_Discussion`) contain mathematical claims that may need their own Lean files.

## Hardest Items

1. Hardest single item: `Chapter1/01_09_Theorem` with `Chapter1/01_09_Proof`.
   This is the clearest genuine Mathlib gap in the current slice. It needs new local infrastructure, not just statement alignment.

2. Hardest cluster: `Chapter1/01_10_Definition` through `Chapter1/01_16_Proof`.
   The underlying theory exists, but the lecture's valuation/DVR presentation cuts across several bundled Mathlib abstractions. This cluster is likely to dominate Phase `3` time because it mixes definitions, examples, discussion claims, and a near-match TFAE theorem.

3. Hardest example pair: `Chapter1/01_24_Example` and `Chapter1/01_29_Example`.
   These are not deep theorems, but they require explicit field-element calculations that are more brittle than the surrounding abstract integrality lemmas.

4. Hardest remark-level item: `Chapter1/01_27_Remark`.
   If the Stage `3.1` audit decides it is formalizable, it will likely require importing order language not already surfaced in the current Mathlib-coverage report.

5. Easiest high-value tranche: `Chapter1/01_17_Definition` through `Chapter1/01_23_Proof`.
   This is not the hardest part of the slice; it is the part most likely to produce fast Phase `3` wins because the statements already align closely with Mathlib.

## Immediate Execution Recommendation

1. Queue Stage `3.1` setup for the opening batch as soon as this report merges.
   Those items already have Stage `2.6` merged, so Phase `3` does not need to wait for the rest of the slice.

2. Finish slice-wide reference attachment in parallel, not serially before all scaffolding.
   PR `#88` and issue `#90` should continue, but they should not delay opening-batch scaffolding or discussion-blob assessment.

3. When the planner creates Stage `3.1` work, split it into three streams.
   Use an opening-batch stream (`01_02` to `01_09`), a valuation/DVR stream (`01_10` to `01_16`), and an integrality stream (`01_17` to `01_29`) so that the easy exact-Mathlib items are not blocked behind the product-formula and valuation-bridging work.
