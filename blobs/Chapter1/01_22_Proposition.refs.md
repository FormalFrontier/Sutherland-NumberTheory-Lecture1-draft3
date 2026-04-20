# References for Chapter1/01_22_Proposition

## Mathlib
- Coverage: `exact`
- Declarations: `UniqueFactorizationMonoid.instIsIntegrallyClosed`
- Notes: Since `Z` is already a UFD in Mathlib, its integrally-closed property is available by instance.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_19_Definition`
- Stage 3 can prove the proposition by typeclass inference instead of replaying the rational-root argument.
