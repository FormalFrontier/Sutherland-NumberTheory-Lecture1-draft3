# References for Chapter1/01_21_Proof

## Mathlib
- Coverage: `exact`
- Declarations: `isIntegral_trans`, `IsIntegrallyClosedIn.of_isIntegralClosure`
- Notes: The proof is supported directly by transitivity of integrality together with Mathlib's theorem that the integral closure is integrally closed in the ambient ring.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Worldwide Center of Mathematics, 2013. <https://www.mi.fu-berlin.de/en/math/groups/arithmetic_geometry/teaching/exercises/Altman_-Kleiman---A-term-of-commutative-algebra-_2017_.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_21_Corollary`, `Chapter1/01_20_Proposition`, `Chapter1/01_19_Definition`
- Downstream proof work should not need the nested textbook argument once the bundled integral-closure theorem is imported.
