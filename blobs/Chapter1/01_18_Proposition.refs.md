# References for Chapter1/01_18_Proposition

## Mathlib
- Coverage: `exact`
- Declarations: `IsIntegral.add`, `IsIntegral.mul`
- Notes: Mathlib already proves exactly the closure under addition and multiplication stated in the proposition.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- The Stacks Project, Section 10.36: Finite and integral ring extensions. <https://stacks.math.columbia.edu/tag/00GH>

## Formalization notes
- Internal prerequisites: `Chapter1/01_17_Definition`
- This proposition should cite `IsIntegral.add` and `IsIntegral.mul` directly; there is no reason to reproduce the textbook's algebraic-closure proof in Lean.
