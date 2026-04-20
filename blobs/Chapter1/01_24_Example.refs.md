# References for Chapter1/01_24_Example

## Mathlib
- Coverage: `partial`
- Declarations: `IsIntegral`, `Zsqrtd`
- Notes: Mathlib has the ambient integrality predicate and quadratic-integer type `Zsqrtd`, but not this exact non-integrally-closed `Z[sqrt 5]` example in the lecture's presentation.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_23_Corollary`, `Chapter1/01_17_Definition`
- Expect Stage 3 to need a small amount of custom arithmetic showing `(1 + sqrt 5) / 2` is integral but not contained in the chosen order.
