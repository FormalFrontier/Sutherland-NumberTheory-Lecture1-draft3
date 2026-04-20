# References for Chapter1/01_25_Proposition

## Mathlib
- Coverage: `partial`
- Declarations: `Valuation.Integers.isIntegrallyClosed`, `ValuationRing.iff_isInteger_or_isInteger`
- Notes: The valuation API can recover the proposition, but the lecture's exact statement is not packaged under one single declaration name.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>
- Jean-Pierre Serre, *Local Fields*, Springer, 1979. <https://link.springer.com/book/10.1007/978-1-4757-5673-9>

## Formalization notes
- Internal prerequisites: `Chapter1/01_11_Definition`, `Chapter1/01_19_Definition`
- Stage 3 will likely need a short bridge lemma from the book's definition of valuation ring to Mathlib's bundled valuation-ring API.
