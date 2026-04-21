import SutherlandNumberTheoryLecture1.Chapter1.«01_28_Proposition»

/-!
# Proof of Proposition 1.28

The lecture proves the forward implication by factoring the minimal polynomial
over an algebraic closure and then observing that its coefficients are integral
over the base ring. Mathlib already packages that argument in the
integrally-closed `minpoly` API, so this file records the textbook proof as a
small collection of explicit theorem-level wrappers around those lemmas, while
keeping the proof blob's assumptions slightly lighter than the proposition file.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_28

open Polynomial

variable {A K L : Type*}
variable [CommRing A] [IsDomain A] [Field K] [Field L]
variable [Algebra A K] [Algebra A L] [Algebra K L] [IsScalarTower A K L]
variable [IsIntegrallyClosed A]

/-- Any monic lift of the fraction-field minimal polynomial forces the base-ring
minimal polynomial to divide it. This is the packaged replacement for the
textbook's factor-by-factor argument in an algebraic closure. -/
theorem minpoly_dvd_of_monic_lifted_root [Module.IsTorsionFree A L]
    {α : L} {g : A[X]} (hg : g.Monic) (hroot : aeval α (g.map (algebraMap A K)) = 0) :
    minpoly A α ∣ g := by
  exact minpoly.isIntegrallyClosed_dvd ⟨g, hg, by
    rw [Polynomial.aeval_map_algebraMap K α g] at hroot
    exact hroot⟩ <| by
      rw [Polynomial.aeval_map_algebraMap K α g] at hroot
      exact hroot

/-- If `α` is integral over `A`, then every coefficient of its minimal
polynomial over the fraction field `K` already comes from `A`. This packages the
lecture's final "integral closure intersect the fraction field" step. -/
theorem minpoly_coeff_lifts_to_base [IsFractionRing A K] {α : L} (hα : IsIntegral A α) (n : ℕ) :
    ∃ a : A, algebraMap A K a = (minpoly K α).coeff n := by
  have hcoeff_integral : IsIntegral A ((minpoly K α).coeff n) := by
    rw [minpoly.isIntegrallyClosed_eq_field_fractions' K hα, coeff_map]
    simpa using
      (isIntegral_algebraMap : IsIntegral A (algebraMap A K ((minpoly A α).coeff n)))
  exact IsIntegrallyClosed.isIntegral_iff.mp hcoeff_integral

/-- The proof blob for Proposition 1.28, restated as an explicit Lean theorem. -/
theorem proof_isIntegral_iff_exists_map_eq_minpoly [IsFractionRing A K] {α : L} :
    IsIntegral A α ↔ ∃ f : A[X], f.Monic ∧ f.map (algebraMap A K) = minpoly K α := by
  constructor
  · intro hα
    exact ⟨minpoly A α, minpoly.monic hα,
      (minpoly.isIntegrallyClosed_eq_field_fractions' K hα).symm⟩
  · rintro ⟨f, hf_monic, hf_eq⟩
    have hrootK : aeval α (f.map (algebraMap A K)) = 0 := by
      rw [hf_eq]
      exact minpoly.aeval K α
    refine ⟨f, hf_monic, ?_⟩
    rw [Polynomial.aeval_map_algebraMap K α f] at hrootK
    exact hrootK

end Proof_01_28

end Chapter1
end SutherlandNumberTheoryLecture1
