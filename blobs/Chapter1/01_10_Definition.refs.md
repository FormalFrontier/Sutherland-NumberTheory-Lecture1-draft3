# References for Chapter1/01_10_Definition

## Mathlib
- Coverage: `partial`
- Declarations: `Valuation`, `AddValuation`, `Valuation.valuationSubring`, `IsDiscreteValuationRing`
- Notes: Mathlib already has bundled valuations, valuation subrings, and the DVR predicate, but not the lecture's exact real-valued presentation with the derived absolute value `c^v` as one packaged definition.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #8: Complete fields and valuation rings (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes8.pdf>
- The Stacks Project, Section 10.50: Valuation rings. <https://stacks.math.columbia.edu/tag/00I8>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Chapter 23: Discrete valuations, Worldwide Center of Mathematics, 2013. <https://web.mit.edu/18.705/www/13Ed.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_02_Definition`
- Prefer scaffolding around Mathlib's bundled valuation structures, then add a local wrapper only if the lecture's `k -> R U {infinity}` presentation is required literally.
- The valuation-ring sentence should point workers toward `Valuation.valuationSubring` rather than rebuilding the ring from scratch.
