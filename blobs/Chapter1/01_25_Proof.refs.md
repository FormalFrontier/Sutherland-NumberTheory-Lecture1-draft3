# References for Chapter1/01_25_Proof

## Mathlib
- Coverage: `partial`
- Declarations: `Valuation.Integers.isIntegrallyClosed`, `ValuationRing.iff_isInteger_or_isInteger`
- Notes: The proof strategy matches the standard valuation dichotomy encoded in Mathlib, but the lecture's direct contradiction proof is not already packaged verbatim.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>
- Jean-Pierre Serre, *Local Fields*, Springer, 1979. <https://link.springer.com/book/10.1007/978-1-4757-5673-9>

## Formalization notes
- Internal prerequisites: `Chapter1/01_25_Proposition`, `Chapter1/01_11_Definition`, `Chapter1/01_17_Definition`
- Prefer importing the valuation-ring characterization and deriving integrally closedness from the bundled theorem rather than replaying the hand computation.
