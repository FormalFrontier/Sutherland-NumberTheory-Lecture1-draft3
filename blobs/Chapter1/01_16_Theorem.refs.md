# References for Chapter1/01_16_Theorem

## Mathlib
- Coverage: `partial`
- Declarations: `IsDiscreteValuationRing.TFAE`, `ValuationRing`, `IsIntegrallyClosed`, `IsRegularLocalRing`, `ringKrullDim`
- Notes: Mathlib already proves a substantial TFAE for DVRs, but the lecture's exact seven-bullet list is not verbatim identical and still needs statement-level bridging.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Chapter 23: Discrete valuations, Worldwide Center of Mathematics, 2013. <https://web.mit.edu/18.705/www/13Ed.pdf>
- M. F. Atiyah and I. G. Macdonald, *Introduction to Commutative Algebra*, Chapter 9: Discrete valuation rings and Dedekind domains, Addison-Wesley, 1969. <https://search.worldcat.org/title/Introduction-to-commutative-algebra/oclc/7491>

## Formalization notes
- Internal prerequisites: `Chapter1/01_15a_Discussion`
- Start from `IsDiscreteValuationRing.TFAE` and translate the lecture's bullet list into the nearest Mathlib predicates before proving any missing implications.
- This item is a likely Stage 3 missing-claim or bridge-heavy theorem, not a straight exact import.
