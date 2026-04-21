import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_23_Corollary»

/-!
# Example 1.24: `ℤ[√5]` is not integrally closed

The lecture's counterexample uses the order `ℤ[√5]` inside its fraction field.
The witness is the golden-ratio element `(1 + √5) / 2`: it is integral over `ℤ`
because it satisfies `X^2 - X - 1`, hence also integral over `ℤ[√5]`, but it
does not lie in the order itself. Therefore `ℤ[√5]` is not integrally closed.

We model `ℤ[√5]` with Mathlib's quadratic-integer ring `ℤ√5`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Example_01_24

open Zsqrtd

local notation "ZSqrtFive" => ℤ√5

private theorem five_not_int_square (n : ℤ) : (5 : ℤ) ≠ n * n := by
  intro h
  have hn_lower : -2 ≤ n := by
    nlinarith
  have hn_upper : n ≤ 2 := by
    nlinarith
  interval_cases n <;> norm_num at h

local instance : IsDomain ZSqrtFive := by
  exact Function.Injective.isDomain
    (Zsqrtd.toReal (d := 5) (by positivity))
    (Zsqrtd.toReal_injective (d := 5) (by positivity) five_not_int_square)

/-- The lecture's witness `φ = (1 + √5) / 2`, viewed in the fraction field of `ℤ[√5]`. -/
noncomputable def goldenRatioInFractionRing : FractionRing ZSqrtFive :=
  (algebraMap ZSqrtFive (FractionRing ZSqrtFive) ((1 : ZSqrtFive) + sqrtd)) *
    (2 : FractionRing ZSqrtFive)⁻¹

/-- The lecture's explicit arithmetic step for `φ = (1 + √5) / 2`. -/
theorem goldenRatio_sq_sub_self_sub_one_eq_zero :
    goldenRatioInFractionRing ^ 2 - goldenRatioInFractionRing - 1 = 0 := by
  sorry

/-- The element `φ = (1 + √5) / 2` is integral over `ℤ` because it satisfies
`X^2 - X - 1 = 0`.

The remaining work here is the explicit polynomial calculation in the fraction
field of `ℤ[√5]`.
-/
theorem goldenRatio_isIntegral_over_int :
    IsIntegral ℤ (goldenRatioInFractionRing) := by
  sorry

/-- Since `ℤ[√5]` is a `ℤ`-algebra, the same witness is integral over `ℤ[√5]`. -/
theorem goldenRatio_isIntegral :
    IsIntegral ZSqrtFive (goldenRatioInFractionRing) := by
  exact goldenRatio_isIntegral_over_int.tower_top

/-- The witness `φ = (1 + √5) / 2` does not come from an element of `ℤ[√5]`.

Concretely, equating `2φ = 1 + √5` with an image of some `a + b√5 ∈ ℤ[√5]`
forces the impossible coefficient equalities `2a = 1` and `2b = 1`.
-/
theorem goldenRatio_not_in_algebraMap_range :
    ¬ ∃ z : ZSqrtFive,
      algebraMap ZSqrtFive (FractionRing ZSqrtFive) z = goldenRatioInFractionRing := by
  sorry

/-- Example 1.24: `ℤ[√5]` is not integrally closed. -/
theorem zsqrtdFive_not_isIntegrallyClosed :
    ¬ IsIntegrallyClosed ZSqrtFive := by
  intro hclosed
  rw [isIntegrallyClosed_iff (R := ZSqrtFive) (K := FractionRing ZSqrtFive)] at hclosed
  obtain ⟨z, hz⟩ := hclosed goldenRatio_isIntegral
  exact goldenRatio_not_in_algebraMap_range ⟨z, hz⟩

/-- The lecture's first consequence: `ℤ[√5]` cannot be a UFD. -/
theorem zsqrtdFive_not_uniqueFactorizationMonoid [UniqueFactorizationMonoid ZSqrtFive] :
    False := by
  exact zsqrtdFive_not_isIntegrallyClosed (ufd_isIntegrallyClosed (R := ZSqrtFive))

/-- The lecture's second consequence: `ℤ[√5]` cannot be a PID. -/
theorem zsqrtdFive_not_isPrincipalIdealRing [IsPrincipalIdealRing ZSqrtFive] :
    False := by
  exact zsqrtdFive_not_isIntegrallyClosed (pid_isIntegrallyClosed (R := ZSqrtFive))

end Example_01_24

end Chapter1
end SutherlandNumberTheoryLecture1
