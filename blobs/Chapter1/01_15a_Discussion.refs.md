# References for Chapter1/01_15a_Discussion

## Mathlib
- Coverage: `partial`
- Declarations: `IsNoetherianRing`, `IsPrincipalIdealRing`, `IsLocalRing`, `ringKrullDim`, `IsRegularLocalRing`, `IsIntegrallyClosed`
- Notes: Mathlib has predicates for the standard structural properties in the DVR survey, but not the lecture's "maximal subring of the fraction field" language as one packaged declaration.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #8: Complete fields and valuation rings (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes8.pdf>
- The Stacks Project, Section 10.50: Valuation rings. <https://stacks.math.columbia.edu/tag/00I8>
- Allen Altman and Steven Kleiman, *A Term of Commutative Algebra*, Chapter 23: Discrete valuations, Worldwide Center of Mathematics, 2013. <https://web.mit.edu/18.705/www/13Ed.pdf>
- M. F. Atiyah and I. G. Macdonald, *Introduction to Commutative Algebra*, Chapter 9: Discrete valuation rings and Dedekind domains, Addison-Wesley, 1969. <https://search.worldcat.org/title/Introduction-to-commutative-algebra/oclc/7491>

## Formalization notes
- Internal prerequisites: `Chapter1/01_10_Definition`, `Chapter1/01_12_Definition`, `Chapter1/01_13_Definition`
- This blob is mainly a checklist for later theorem statements; use the bundled predicates directly when splitting the prose into formalizable claims.
- The "maximal" characterization is the least packaged part and may require the most local infrastructure.
