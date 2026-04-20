# References for Chapter1/01_29_Example

## Mathlib
- Coverage: `partial`
- Declarations: `minpoly.isIntegrallyClosed_eq_field_fractions'`, `Rat.cast_def`
- Notes: Mathlib has the general minimal-polynomial criterion for non-integrality, but not this concrete `(1 + sqrt 7) / 2` computation as a ready-made example.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_24_Example`, `Chapter1/01_28_Proposition`
- Stage 3 should reuse Proposition 1.28 and then add the explicit coefficient computation showing the minimal polynomial is not in `Z[X]`.
