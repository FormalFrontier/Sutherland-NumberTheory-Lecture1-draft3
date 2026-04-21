# References for Chapter1/01_27_Remark

## Mathlib
- Coverage: `partial`
- Declarations: `NumberField.RingOfIntegers`
- Notes: Mathlib bundles the ring of integers itself, but not the full order/maximal-order discussion as a single ready-made API surface.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Andrew V. Sutherland, 18.783 Elliptic Curves, Lecture #12 (MIT, Fall 2025). <https://math.mit.edu/classes/18.783/2025/LectureNotes12.pdf>
- Jean-Pierre Serre, *Local Fields*, Springer, 1979. <https://link.springer.com/book/10.1007/978-1-4757-5673-9>

## Formalization notes
- Internal prerequisites: `Chapter1/01_26_Definition`
- Expect later work on orders and maximal orders to need local glue lemmas beyond `NumberField.RingOfIntegers`.
