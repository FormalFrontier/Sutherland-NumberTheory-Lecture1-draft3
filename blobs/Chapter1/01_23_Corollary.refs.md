# References for Chapter1/01_23_Corollary

## Mathlib
- Coverage: `exact`
- Declarations: `UniqueFactorizationMonoid.instIsIntegrallyClosed`
- Notes: Mathlib already packages the general result that UFDs are integrally closed, and PIDs inherit it through the usual instance chain.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_22_Proposition`
- The PID clause should be a short corollary from the UFD instance rather than a separate proof branch.
