# References for Chapter1/01_23_Proof

## Mathlib
- Coverage: `exact`
- Declarations: `isInteger_of_is_root_of_monic`, `UniqueFactorizationMonoid.instIsIntegrallyClosed`
- Notes: The textbook's "same proof as Proposition 1.22" is already subsumed by Mathlib's UFD-level infrastructure.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_23_Corollary`, `Chapter1/01_22_Proof`
- Reuse the proposition-level instance unless the project later wants the rational-root proof generalized to arbitrary UFDs.
