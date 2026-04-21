# References for Chapter1/01_05_Proof

## Mathlib
- Coverage: `partial`
- Declarations: `FiniteField.pow_card`
- Notes: The field-theoretic identity is available; the absolute-value argument still needs local glue.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Jean-Pierre Serre, *Local Fields*, Springer, 1979. <https://link.springer.com/book/10.1007/978-1-4757-5673-9>

## Formalization notes
- Internal prerequisites: `Chapter1/01_05_Corollary`, `Chapter1/01_04_Lemma`
- Reuse `FiniteField.pow_card`; budget for one or two helper lemmas showing that values fixed by a positive power are forced to be `0` or `1`.
