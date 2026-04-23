import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
/-!
# Proposition 1.28: minimal polynomials and integrality over an integrally closed domain

The lecture proves that if `A` is an integrally closed domain with fraction field
`K`, and `L / K` is a finite extension, then an element `α : L` is integral over
`A` exactly when its minimal polynomial over `K` has coefficients in `A`.

Mathlib already packages the two key ingredients for this criterion:

- `minpoly.isIntegrallyClosed_eq_field_fractions'` identifies the minimal
  polynomial over the fraction field with the base-ring minimal polynomial when
  the element is integral over an integrally closed domain.
- `minpoly.isIntegrallyClosed_dvd` shows that the base-ring minimal polynomial
  divides any base-ring polynomial having the integral element as a root.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proposition_01_28

open Polynomial

variable {A K L : Type*}
variable [CommRing A] [IsDomain A] [Field K] [Field L]
variable [Algebra A K]
variable [Algebra A L] [Algebra K L] [IsScalarTower A K L]
variable [IsIntegrallyClosed A]

/-- Any lifted base-ring polynomial vanishing at an integral element is divisible by the
base-ring minimal polynomial. This is the packaged divisibility step used in the lecture's proof.
-/
theorem minpoly_dvd_of_fractionRing_aeval_eq_zero [Module.IsTorsionFree A L]
    {α : L} (hα : IsIntegral A α) {f : A[X]}
    (hf : aeval α (f.map (algebraMap A K)) = 0) :
    minpoly A α ∣ f := by
  have hf' : aeval α f = 0 := by
    simpa [Polynomial.aeval_map_algebraMap K α f] using hf
  exact minpoly.isIntegrallyClosed_dvd hα hf'

/-- Proposition 1.28: over an integrally closed domain, integrality is equivalent to the
minimal polynomial over the fraction field coming from a base-ring polynomial.
-/
theorem integral_iff_minpoly_over_base [IsFractionRing A K] [FiniteDimensional K L] {α : L} :
    IsIntegral A α ↔ ∃ f : A[X], minpoly K α = f.map (algebraMap A K) := by
  constructor
  · intro hα
    refine ⟨minpoly A α, ?_⟩
    exact minpoly.isIntegrallyClosed_eq_field_fractions' K hα
  · rintro ⟨f, hf_eq⟩
    have hαK : IsIntegral K α := Algebra.IsIntegral.isIntegral (R := K) α
    have hf_monic : f.Monic := by
      apply Polynomial.monic_of_injective (f := algebraMap A K) (IsFractionRing.injective A K)
      simpa [hf_eq] using minpoly.monic hαK
    have hf_rootK : aeval α (f.map (algebraMap A K)) = 0 := by
      rw [← hf_eq]
      exact minpoly.aeval K α
    have hf_rootA : aeval α f = 0 := by
      simpa [Polynomial.aeval_map_algebraMap K α f] using hf_rootK
    refine ⟨f, hf_monic, ?_⟩
    exact hf_rootA

end Proposition_01_28

end Chapter1
end SutherlandNumberTheoryLecture1
