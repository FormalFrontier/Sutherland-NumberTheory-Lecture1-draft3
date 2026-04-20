# References for Chapter1/01_12_Definition

## Mathlib
- Coverage: `exact`
- Declarations: `IsLocalRing`, `IsLocalRing.maximalIdeal`
- Notes: The local-ring definition and its distinguished maximal ideal match Mathlib directly.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- The Stacks Project, Section 10.18: Local rings. <https://stacks.math.columbia.edu/tag/07BH>

## Formalization notes
- Internal prerequisites: `Chapter1/01_11a_Discussion`
- This should scaffold directly against `IsLocalRing`; keep the maximal ideal bundled through `IsLocalRing.maximalIdeal`.
