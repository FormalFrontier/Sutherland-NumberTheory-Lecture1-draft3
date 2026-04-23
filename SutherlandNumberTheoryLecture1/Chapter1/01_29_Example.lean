import Mathlib.Algebra.Polynomial.SpecificDegree
import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed
import Mathlib.NumberTheory.Zsqrtd.ToReal
import Mathlib.Tactic
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

local instance : IsScalarTower ℤ ℚ (FractionRing ZSqrtSeven) :=
  ⟨fun z q a => by
    cases z <;> simp [Rat.smul_def] <;> ring⟩

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
  simp [sqrtSevenWitnessPolynomial, coeff_X_pow, Polynomial.coeff_X]

/-- The witness satisfies the lecture's polynomial. The proof is the explicit
`((1 + √7) / 2)^2 - (1 + √7) / 2 - 3/2 = 0` computation inside the fraction
field of `ℤ[√7]`. -/
theorem sqrtSevenWitness_aeval_eq_zero :
    aeval sqrtSevenWitness sqrtSevenWitnessPolynomial = 0 := by
  have htwo_ne_zero : (2 : FractionRing ZSqrtSeven) ≠ 0 := by
    norm_num
  have hs2 : (algebraMap ZSqrtSeven (FractionRing ZSqrtSeven) sqrtd) ^ 2 =
      (7 : FractionRing ZSqrtSeven) := by
    calc
      (algebraMap ZSqrtSeven (FractionRing ZSqrtSeven) sqrtd) ^ 2 =
          algebraMap ZSqrtSeven (FractionRing ZSqrtSeven) (sqrtd * sqrtd) := by
            rw [pow_two, ← map_mul]
      _ = algebraMap ZSqrtSeven (FractionRing ZSqrtSeven) ((7 : ℤ) : ZSqrtSeven) := by
            rw [dmuld]
      _ = (7 : FractionRing ZSqrtSeven) := by
            simpa using map_intCast (algebraMap ZSqrtSeven (FractionRing ZSqrtSeven)) (7 : ℤ)
  simp [sqrtSevenWitnessPolynomial, sqrtSevenWitness]
  field_simp [htwo_ne_zero]
  ring_nf
  rw [hs2]
  norm_num

/-- The minimal polynomial of `α = (1 + √7) / 2` over `ℚ` is the lecture's
`X^2 - X - 3/2`. -/
theorem minpoly_sqrtSevenWitness :
    minpoly ℚ sqrtSevenWitness = sqrtSevenWitnessPolynomial := by
  have hdeg : sqrtSevenWitnessPolynomial.natDegree = 2 := by
    have hdegree : sqrtSevenWitnessPolynomial.degree = 2 := by
      rw [sqrtSevenWitnessPolynomial]
      simpa [sub_eq_add_neg, add_assoc, add_left_comm, add_comm, mul_comm, mul_left_comm,
        mul_assoc] using
        (degree_quadratic (R := ℚ) (a := (1 : ℚ)) (b := (-1 : ℚ))
          (c := (-(3 / 2 : ℚ))) one_ne_zero)
    exact natDegree_eq_of_degree_eq_some hdegree
  have hmonic : sqrtSevenWitnessPolynomial.Monic := by
    apply monic_of_natDegree_le_of_coeff_eq_one 2
    · rw [hdeg]
    · simpa using sqrtSevenWitnessPolynomial_coeff_two
  have hirr : Irreducible sqrtSevenWitnessPolynomial := by
    apply Polynomial.irreducible_of_degree_le_three_of_not_isRoot
    · rw [hdeg]
      norm_num
    · intro r hr
      have hsq : IsSquare (7 : ℚ) := by
        have hr' : r ^ 2 - r - (3 / 2 : ℚ) = 0 := by
          simpa [Polynomial.IsRoot, sqrtSevenWitnessPolynomial] using hr
        refine ⟨2 * r - 1, ?_⟩
        nlinarith
      have hnat : IsSquare (7 : ℕ) := (Rat.isSquare_natCast_iff).mp hsq
      norm_num at hnat
  exact (minpoly.eq_of_irreducible_of_monic hirr sqrtSevenWitness_aeval_eq_zero hmonic).symm

/-- The lecture's polynomial does not come from an integer polynomial, because
its constant coefficient is `-3/2`. -/
theorem sqrtSevenWitnessPolynomial_not_in_integer_subring :
    ¬ ∃ f : ℤ[X], f.map (algebraMap ℤ ℚ) = sqrtSevenWitnessPolynomial := by
  rintro ⟨f, hf⟩
  have hcoeff := congrArg (fun p : ℚ[X] => p.coeff 0) hf
  norm_num [sqrtSevenWitnessPolynomial] at hcoeff
  have hnot : ∀ z : ℤ, ¬ (z : ℚ) = -(3 / 2 : ℚ) := by
    intro z hz
    have hden : (-(3 / 2 : ℚ)).den = 1 := by
      rw [← hz]
      simp
    norm_num at hden
  exact hnot (f.coeff 0) hcoeff

/-- Example 1.29: `(1 + √7) / 2` is not integral over `ℤ`.

This is the textbook application of Proposition 1.28: if the witness were
integral, then its minimal polynomial over `ℚ` would be the image of a monic
polynomial in `ℤ[X]`, contradicting the explicit coefficient calculation above.
-/
theorem sqrtSevenWitness_not_isIntegral :
    ¬ IsIntegral ℤ sqrtSevenWitness := by
  intro hIntegral
  let towerA :
      @IsScalarTower ℤ ℚ (FractionRing ZSqrtSeven) Algebra.toSMul Algebra.toSMul Algebra.toSMul :=
    IsScalarTower.of_algebraMap_eq (R := ℤ) (S := ℚ) (A := FractionRing ZSqrtSeven) fun z => by
      norm_num
  have hmin :
      minpoly ℚ sqrtSevenWitness =
        (minpoly ℤ sqrtSevenWitness).map (algebraMap ℤ ℚ) := by
    simpa using
      (@minpoly.isIntegrallyClosed_eq_field_fractions' ℤ (FractionRing ZSqrtSeven)
        _ _ _ _ ℚ _ _ _ _ _ _ towerA sqrtSevenWitness hIntegral)
  exact sqrtSevenWitnessPolynomial_not_in_integer_subring
    ⟨minpoly ℤ sqrtSevenWitness, hmin.symm.trans minpoly_sqrtSevenWitness⟩

end Example_01_29

end Chapter1
end SutherlandNumberTheoryLecture1
