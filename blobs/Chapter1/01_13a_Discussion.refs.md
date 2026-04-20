# References for Chapter1/01_13a_Discussion

## Mathlib
- Coverage: `partial`
- Declarations: `ValuationSubring.valuation`, `Valuation.isEquiv_valuation_valuationSubring`, `ValuationSubring.valuationSubring_valuation`, `ValuationSubring.integer_valuation`
- Notes: Mathlib has both directions of the valuation-subring correspondence, but not the lecture's exact reconstruction of a DVR valuation from powers of the maximal ideal.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- The Stacks Project, Section 10.50: Valuation rings. <https://stacks.math.columbia.edu/tag/00I8>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Chapter 23: Discrete valuations, Worldwide Center of Mathematics, 2013. <https://web.mit.edu/18.705/www/13Ed.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_10_Definition`, `Chapter1/01_12_Definition`
- Use the valuation-subring equivalence API as the main bridge; the powers-of-maximal-ideal construction will likely need local scaffolding if formalized literally.
- The uniqueness claim should be phrased via equivalence/recovery lemmas already in Mathlib where possible.
