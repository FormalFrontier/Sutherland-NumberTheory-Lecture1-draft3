# References for Chapter1/01_13_Definition

## Mathlib
- Coverage: `exact`
- Declarations: `IsLocalRing.ResidueField`, `IsLocalRing.residue`
- Notes: Mathlib already packages the residue field of a local ring and the quotient map to it.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- The Stacks Project, Section 10.18: Local rings. <https://stacks.math.columbia.edu/tag/07BH>

## Formalization notes
- Internal prerequisites: `Chapter1/01_12_Definition`
- Treat this as a notation/definition wrapper around `IsLocalRing.ResidueField`; the quotient map is already available as `IsLocalRing.residue`.
