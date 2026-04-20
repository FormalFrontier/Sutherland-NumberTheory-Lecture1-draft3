# References for Chapter1/01_15_Example

## Mathlib
- Coverage: `partial`
- Declarations: `LaurentSeries`, `PowerSeries`, `PowerSeries.order`, `PowerSeries.residueFieldOfPowerSeries`
- Notes: Laurent series, power series, and order-of-vanishing infrastructure already exist, but the lecture's valuation on `k((t))` and the expansion-at-`alpha` variant are not bundled as the same ready-made example.

## External sources
- Andrew V. Sutherland, 18.785 Number Theory I, Lecture #1: Absolute values and discrete valuations (MIT, Fall 2021). <https://math.mit.edu/classes/18.785/2021fa/LectureNotes1.pdf>

## Formalization notes
- Internal prerequisites: `Chapter1/01_10_Definition`
- Build this example on top of `PowerSeries.order` and the Laurent-series API rather than defining a fresh valuation object from scratch.
- The order-at-`alpha` sentence likely becomes a later follow-up lemma after the `t`-adic case is in place.
