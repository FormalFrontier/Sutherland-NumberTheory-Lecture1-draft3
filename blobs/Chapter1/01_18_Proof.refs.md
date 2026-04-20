# References for Chapter1/01_18_Proof

## Mathlib
- Coverage: `exact`
- Declarations: `IsIntegral.add`, `IsIntegral.mul`, `Polynomial.isIntegral_iff_isIntegral_coeff`, `IsIntegral.of_aeval_monic_of_isIntegral_coeff`
- Notes: The library proves the result abstractly and exposes supporting polynomial-integrality lemmas that subsume the lecture's symmetric-polynomial argument.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- The Stacks Project, Section 10.36: Finite and integral ring extensions. <https://stacks.math.columbia.edu/tag/00GH>

## Formalization notes
- Internal prerequisites: `Chapter1/01_18_Proposition`
- Use the abstract closure lemmas unless Stage 3 explicitly wants the textbook proof reconstructed as an auxiliary exercise.
- The Stacks section is the best prose replacement for the textbook's algebraic-closure detour.
