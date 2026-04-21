import SutherlandNumberTheoryLecture1.Chapter1.«01_28_Proposition»

/-!
# Proof of Proposition 1.28

The lecture proves the forward implication by factoring the minimal polynomial
over an algebraic closure and then observing that its coefficients are integral
over the base ring. Mathlib already packages that argument in the
integrally-closed `minpoly` API, so this file keeps only the proof-blob
statement whose assumptions are genuinely lighter than the proposition file.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_28

open Polynomial

variable {A K L : Type*}
variable [CommRing A] [IsDomain A] [Field K] [Field L]
variable [Algebra A K] [Algebra A L] [Algebra K L] [IsScalarTower A K L]
variable [IsIntegrallyClosed A]

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
