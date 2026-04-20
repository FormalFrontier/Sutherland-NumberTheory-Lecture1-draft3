# References for Chapter1/01_10a_Discussion

## Mathlib
- Coverage: `partial`
- Declarations: `ValuationSubring.valuation_le_one_iff`, `ValuationSubring.valuation_eq_one_iff`, `ValuationSubring.valuation_lt_one_iff`
- Notes: The unit and maximal-ideal partitions of a valuation ring are already exposed for `ValuationSubring`, but the fraction-field discussion and sign-based prose organization still need local glue.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #8: Complete fields and valuation rings (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes8.pdf>
- The Stacks Project, Section 10.50: Valuation rings. <https://stacks.math.columbia.edu/tag/00I8>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Chapter 23: Discrete valuations, Worldwide Center of Mathematics, 2013. <https://web.mit.edu/18.705/www/13Ed.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_10_Definition`
- Reuse the packaged `valuation_le_one / eq_one / lt_one` lemmas to recover membership, units, and non-units of the valuation ring.
- This discussion likely splits into several short lemmas if Stage 3 audits it as formalizable.
