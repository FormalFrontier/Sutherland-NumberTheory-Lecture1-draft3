import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_24_Example»
import SutherlandNumberTheoryLecture1.Chapter1.«01_28_Proposition»

/-!
# Example 1.29: `(1 + √7) / 2` is not integral over `ℤ`

Example 1.24 used the golden ratio `(1 + √5) / 2` as an integral element in the
fraction field of `ℤ[√5]`. The lecture now contrasts this with
`α = (1 + √7) / 2`: its minimal polynomial over `ℚ` is `X^2 - X - 3 / 2`,
whose constant coefficient is not an integer, so Proposition 1.28 implies that
`α` is not integral over `ℤ`.

As in Example 1.24, we model the relevant quadratic order with Mathlib's
quadratic integer ring `ℤ√7`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Example_01_29

open Polynomial Zsqrtd

local notation "ZSqrtSeven" => ℤ√7

private theorem seven_not_int_square (n : ℤ) : (7 : ℤ) ≠ n * n := by
  intro h
  have hn_lower : -3 ≤ n := by
    nlinarith
  have hn_upper : n ≤ 3 := by
    nlinarith
  interval_cases n <;> norm_num at h

local instance : IsDomain ZSqrtSeven := by
  exact Function.Injective.isDomain
    (Zsqrtd.toReal (d := 7) (by positivity))
    (Zsqrtd.toReal_injective (d := 7) (by positivity) seven_not_int_square)

/-- Example 1.29 explicitly recalls the earlier positive example
`(1 + √5) / 2` from Example 1.24. -/
theorem goldenRatio_reference_isIntegral :
    IsIntegral ℤ goldenRatioInFractionRing :=
  goldenRatio_isIntegral_over_int

/-- The lecture's new witness `α = (1 + √7) / 2`, viewed in the fraction field
of `ℤ[√7]`. -/
noncomputable def sqrtSevenWitness : FractionRing ZSqrtSeven :=
  (algebraMap ZSqrtSeven (FractionRing ZSqrtSeven) ((1 : ZSqrtSeven) + sqrtd)) *
    (2 : FractionRing ZSqrtSeven)⁻¹

/-- The polynomial appearing in Example 1.29. -/
noncomputable def sqrtSevenWitnessPolynomial : ℚ[X] :=
  X ^ 2 - X - C (3 / 2 : ℚ)

/-- The lecture's coefficient computation is visible directly in Lean. -/
theorem sqrtSevenWitnessPolynomial_coeff_zero :
    sqrtSevenWitnessPolynomial.coeff 0 = -(3 / 2 : ℚ) := by
  simp [sqrtSevenWitnessPolynomial]

/-- The linear coefficient of the lecture's polynomial is `-1`. -/
theorem sqrtSevenWitnessPolynomial_coeff_one :
    sqrtSevenWitnessPolynomial.coeff 1 = (-1 : ℚ) := by
  simp [sqrtSevenWitnessPolynomial]

/-- The quadratic coefficient of the lecture's polynomial is `1`. -/
theorem sqrtSevenWitnessPolynomial_coeff_two :
    sqrtSevenWitnessPolynomial.coeff 2 = (1 : ℚ) := by
  sorry

/-- The witness satisfies the lecture's polynomial. The proof is the explicit
`((1 + √7) / 2)^2 - (1 + √7) / 2 - 3/2 = 0` computation inside the fraction
field of `ℤ[√7]`. -/
theorem sqrtSevenWitness_aeval_eq_zero :
    aeval sqrtSevenWitness sqrtSevenWitnessPolynomial = 0 := by
  sorry

/-- The minimal polynomial of `α = (1 + √7) / 2` over `ℚ` is the lecture's
`X^2 - X - 3/2`. -/
theorem minpoly_sqrtSevenWitness :
    minpoly ℚ sqrtSevenWitness = sqrtSevenWitnessPolynomial := by
  sorry

/-- The lecture's polynomial does not come from an integer polynomial, because
its constant coefficient is `-3/2`. -/
theorem sqrtSevenWitnessPolynomial_not_in_integer_subring :
    ¬ ∃ f : ℤ[X], f.map (algebraMap ℤ ℚ) = sqrtSevenWitnessPolynomial := by
  sorry

/-- Example 1.29: `(1 + √7) / 2` is not integral over `ℤ`.

This is the textbook application of Proposition 1.28: if the witness were
integral, then its minimal polynomial over `ℚ` would be the image of a monic
polynomial in `ℤ[X]`, contradicting the explicit coefficient calculation above.
-/
theorem sqrtSevenWitness_not_isIntegral :
    ¬ IsIntegral ℤ sqrtSevenWitness := by
  /-
  Intended Stage 3.2 proof: apply Proposition 1.28 with `A = ℤ`, `K = ℚ`, and
  `L = FractionRing (ℤ√7)`. If `sqrtSevenWitness` were integral over `ℤ`, then
  `minpoly ℚ sqrtSevenWitness` would be the image of some monic polynomial in
  `ℤ[X]`; `minpoly_sqrtSevenWitness` identifies that minimal polynomial with
  `sqrtSevenWitnessPolynomial`, contradicting
  `sqrtSevenWitnessPolynomial_not_in_integer_subring`.
  -/
  sorry

end Example_01_29

end Chapter1
end SutherlandNumberTheoryLecture1
