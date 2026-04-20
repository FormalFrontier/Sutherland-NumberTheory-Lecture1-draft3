# References for Chapter1/01_22_Proof

## Mathlib
- Coverage: `exact`
- Declarations: `isInteger_of_is_root_of_monic`, `Rat.den_eq_one_iff`, `Rat.coe_int_num_of_den_eq_one`
- Notes: Mathlib exposes the monic rational-root theorem directly, along with the denominator-one lemmas needed to conclude a rational is an integer.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Michael F. Atiyah and Ian G. Macdonald, *Introduction to Commutative Algebra*, Addison-Wesley, 1969. <https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/AtiyahMacDonald.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_22_Proposition`, `Chapter1/01_17_Definition`
- If Stage 3 wants the textbook proof rather than the abstract instance, this is the exact low-level API to use.
