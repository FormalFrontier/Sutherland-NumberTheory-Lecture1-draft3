# References for Chapter1/01_14_Example

## Mathlib
- Coverage: `partial`
- Declarations: `Localization.AtPrime`, `Localization.AtPrime.map_eq_maximalIdeal`, `Ideal.bijective_algebraMap_quotient_residueField`
- Notes: Mathlib has the general localization-at-a-prime and residue-field comparison machinery, but the exact `Z_(p)` presentation and the specialization to `F_p` still need item-level glue.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- M. F. Atiyah and I. G. Macdonald, *Introduction to Commutative Algebra*, Chapter 9: Discrete valuation rings and Dedekind domains, Addison-Wesley, 1969. <https://search.worldcat.org/title/Introduction-to-commutative-algebra/oclc/7491>
- The Stacks Project, Section 10.18: Local rings. <https://stacks.math.columbia.edu/tag/07BH>

## Formalization notes
- Internal prerequisites: `Chapter1/01_07_Definition`, `Chapter1/01_10_Definition`, `Chapter1/01_13_Definition`
- Formalization should specialize general localization API to `Z` at `(p)` instead of introducing ad hoc notation first.
- Expect one short bridge lemma identifying the quotient with the finite field model used elsewhere in Mathlib.
