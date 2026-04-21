# References for Chapter1/01_19_Definition

## Mathlib
- Coverage: `exact`
- Declarations: `integralClosure`, `IsIntegrallyClosed`
- Notes: Mathlib has both the bundled integral closure and the predicate for being integrally closed in the fraction field.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- The Stacks Project, Section 10.36: Finite and integral ring extensions. <https://stacks.math.columbia.edu/tag/00GH>

## Formalization notes
- Internal prerequisites: `Chapter1/01_17_Definition`, `Chapter1/01_18_Proposition`
- Prefer `integralClosure` for the constructed object and `IsIntegrallyClosed` for the property; this definition should not require any new bridge lemmas.
