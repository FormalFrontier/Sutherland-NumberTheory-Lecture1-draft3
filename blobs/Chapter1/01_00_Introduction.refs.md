# References for Chapter1/01_00_Introduction

## Mathlib
- Coverage: `partial`
- Declarations: `FiniteField.card`, `Ideal.Quotient.field`, `IsFractionRing`, `NumberField`, `RatFunc`, `FunctionField`, `FunctionField.inftyValuation`
- Notes: Mathlib already covers the core prime-field, residue-field, fraction-field, number-field, and rational-function-field infrastructure used in the introduction, but not the full global-field/completion survey as one packaged development.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #9: Local fields and Hensel's lemmas (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes9.pdf>
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #13: Global fields and the product formula (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes13.pdf>

## Formalization notes
- Internal prerequisites: none
- Reuse existing Mathlib infrastructure for examples of prime fields, number fields, and function fields.
- Expect any later formalization of the completion/local-field survey sentences to need new local glue rather than a single ready-made declaration.
