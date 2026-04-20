# References for Chapter1/01_20_Proof

## Mathlib
- Coverage: `exact`
- Declarations: `isIntegral_trans`
- Notes: The proof is exactly the standard tower-transitivity argument already bundled in Mathlib.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Worldwide Center of Mathematics, 2013. <https://www.mi.fu-berlin.de/en/math/groups/arithmetic_geometry/teaching/exercises/Altman_-Kleiman---A-term-of-commutative-algebra-_2017_.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_20_Proposition`
- The cited books are good prose backups, but the Lean proof should collapse to one application of `isIntegral_trans`.
