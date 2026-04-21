# References for Chapter1/01_11a_Discussion

## Mathlib
- Coverage: `partial`
- Declarations: `IsDiscreteValuationRing.exists_irreducible`, `IsDiscreteValuationRing.irreducible_iff_uniformizer`, `IsDiscreteValuationRing.not_isField`
- Notes: Uniformizer existence and the basic non-field fact are already packaged, but the full `u * pi^n` factorization and principal-ideal classification are not exposed verbatim as one theorem list.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #8: Complete fields and valuation rings (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes8.pdf>
- The Stacks Project, Section 10.50: Valuation rings. <https://stacks.math.columbia.edu/tag/00I8>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Chapter 23: Discrete valuations, Worldwide Center of Mathematics, 2013. <https://web.mit.edu/18.705/www/13Ed.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_10_Definition`, `Chapter1/01_11_Definition`
- Use the Mathlib uniformizer API first; expect additional local lemmas for the ideal-power description and total ordering of ideals.
- This blob is a likely Stage 3 source of missing-claim scaffolding around DVR structure, not just commentary.
