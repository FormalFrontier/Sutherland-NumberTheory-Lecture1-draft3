# References for Chapter1/01_07_Definition

## Mathlib
- Coverage: `partial`
- Declarations: `padicValRat`, `padicNorm`, `padicNorm.nonarchimedean`, `padicNorm.triangle_ineq`, `Rat.AbsoluteValue.padic`
- Notes: Mathlib already packages the p-adic valuation and norm on `Q`; the only mismatch is the lecture's explicit `v_p(0) = infinity` convention.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Jean-Pierre Serre, *Local Fields*, Springer, 1979. <https://link.springer.com/book/10.1007/978-1-4757-5673-9>

## Formalization notes
- Internal prerequisites: `Chapter1/01_06a_Discussion`
- Favor `Rat.AbsoluteValue.padic` and `padicValRat` directly; only add a local wrapper if the lecture's notation with `infinity` is needed explicitly.
