# References for Chapter1/01_11_Definition

## Mathlib
- Coverage: `exact`
- Declarations: `ValuationRing`
- Notes: Mathlib's `ValuationRing` predicate is exactly the textbook definition.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #8: Complete fields and valuation rings (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes8.pdf>
- The Stacks Project, Section 10.50: Valuation rings. <https://stacks.math.columbia.edu/tag/00I8>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Chapter 23: Discrete valuations, Worldwide Center of Mathematics, 2013. <https://web.mit.edu/18.705/www/13Ed.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_10a_Discussion`
- Formalize this as a direct wrapper around `ValuationRing`; avoid introducing a separate bespoke predicate unless later statements force it.
