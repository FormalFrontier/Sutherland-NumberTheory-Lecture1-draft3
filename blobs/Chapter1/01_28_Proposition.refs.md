# References for Chapter1/01_28_Proposition

## Mathlib
- Coverage: `exact`
- Declarations: `minpoly.isIntegrallyClosed_eq_field_fractions'`, `minpoly.isIntegrallyClosed_dvd`
- Notes: Mathlib already proves the integrally-closed minimal-polynomial criterion that matches the proposition.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_17_Definition`, `Chapter1/01_19_Definition`
- Use the minimal-polynomial API instead of recreating the conjugate/Vieta argument by hand.
