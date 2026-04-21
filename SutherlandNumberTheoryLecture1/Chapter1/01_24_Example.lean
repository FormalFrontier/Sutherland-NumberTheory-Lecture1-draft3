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

open Polynomial Zsqrtd

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
  have hs2 : (algebraMap ZSqrtFive (FractionRing ZSqrtFive) sqrtd) ^ 2 =
      (5 : FractionRing ZSqrtFive) := by
    calc
      (algebraMap ZSqrtFive (FractionRing ZSqrtFive) sqrtd) ^ 2 =
          algebraMap ZSqrtFive (FractionRing ZSqrtFive) (sqrtd * sqrtd) := by
            rw [pow_two, ← map_mul]
      _ = algebraMap ZSqrtFive (FractionRing ZSqrtFive) ((5 : ℤ) : ZSqrtFive) := by
            rw [dmuld]
      _ = (5 : FractionRing ZSqrtFive) := by
            simpa using
              map_intCast (algebraMap ZSqrtFive (FractionRing ZSqrtFive)) (5 : ℤ)
  simp [goldenRatioInFractionRing]
  ring_nf
  rw [hs2]
  ring

/-- The element `φ = (1 + √5) / 2` is integral over `ℤ` because it satisfies
`X^2 - X - 1 = 0`.

The remaining work here is the explicit polynomial calculation in the fraction
field of `ℤ[√5]`.
-/
theorem goldenRatio_isIntegral_over_int :
    IsIntegral ℤ (goldenRatioInFractionRing) := by
  refine ⟨X ^ 2 - X - 1, ?_, ?_⟩
  · have hdeg : degree ((X : ℤ[X]) + 1) < 2 := by
      simpa using (show degree ((X : ℤ[X]) + C (1 : ℤ)) < (2 : WithBot ℕ) by
        rw [degree_X_add_C]
        decide)
    simpa [sub_eq_add_neg, add_assoc, add_left_comm, add_comm] using
      (monic_X_pow_sub (n := 2) (p := X + 1) hdeg)
  · simp [goldenRatio_sq_sub_self_sub_one_eq_zero]

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
  rintro ⟨⟨a, b⟩, hz⟩
  have htwo_ne_zero : (2 : FractionRing ZSqrtFive) ≠ 0 := by
    norm_num
  have hmap_two :
      algebraMap ZSqrtFive (FractionRing ZSqrtFive) (2 : ZSqrtFive) =
        (2 : FractionRing ZSqrtFive) := by
    simpa using map_natCast (algebraMap ZSqrtFive (FractionRing ZSqrtFive)) 2
  have hdouble :
      algebraMap ZSqrtFive (FractionRing ZSqrtFive) ((⟨a, b⟩ : ZSqrtFive) * (2 : ZSqrtFive)) =
        algebraMap ZSqrtFive (FractionRing ZSqrtFive) ((1 : ZSqrtFive) + sqrtd) := by
    calc
      algebraMap ZSqrtFive (FractionRing ZSqrtFive) ((⟨a, b⟩ : ZSqrtFive) * (2 : ZSqrtFive)) =
          algebraMap ZSqrtFive (FractionRing ZSqrtFive) (⟨a, b⟩ : ZSqrtFive) *
            (2 : FractionRing ZSqrtFive) := by
              rw [map_mul, hmap_two]
      _ = goldenRatioInFractionRing * (2 : FractionRing ZSqrtFive) := by rw [hz]
      _ = algebraMap ZSqrtFive (FractionRing ZSqrtFive) ((1 : ZSqrtFive) + sqrtd) := by
            simp [goldenRatioInFractionRing, mul_comm, htwo_ne_zero]
  have hdouble' : ((⟨a, b⟩ : ZSqrtFive) * (2 : ZSqrtFive)) = ((1 : ZSqrtFive) + sqrtd) :=
    (IsFractionRing.injective ZSqrtFive (FractionRing ZSqrtFive)) hdouble
  have hre : a * 2 = 1 := by
    simpa using congrArg Zsqrtd.re hdouble'
  have him : b * 2 = 1 := by
    simpa using congrArg Zsqrtd.im hdouble'
  have hone : Even (1 : ℤ) := by
    refine ⟨a, ?_⟩
    linarith [hre]
  norm_num at hone

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
