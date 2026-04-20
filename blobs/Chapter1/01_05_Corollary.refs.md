# References for Chapter1/01_05_Corollary

## Mathlib
- Coverage: `partial`
- Declarations: `AbsoluteValue.isEquiv_trivial_iff_eq_trivial`, `FiniteField.card`, `FiniteField.pow_card`
- Notes: Mathlib has the finite-field Frobenius ingredients and the trivial-absolute-value test, but not this corollary as a packaged result.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Jean-Pierre Serre, *Local Fields*, Springer, 1979. <https://link.springer.com/book/10.1007/978-1-4757-5673-9>

## Formalization notes
- Internal prerequisites: `Chapter1/01_04_Lemma`
- The positive-characteristic half should reduce to Lemma 1.4 plus the Frobenius identity.
- The finite-field half likely needs a short local lemma turning `x^q = x` into triviality of the absolute value.
