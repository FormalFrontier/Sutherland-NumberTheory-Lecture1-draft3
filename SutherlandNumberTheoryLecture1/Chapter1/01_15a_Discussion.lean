import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_13a_Discussion»

/-!
# Discussion 1.15a: standard properties and characterizations of DVRs

The lecture pauses to list the standard package enjoyed by any discrete
valuation ring and notes that several combinations of these properties can be
used as alternative characterizations of DVRs.

This scaffold records those consequences directly with Mathlib's bundled
predicates:

- `IsNoetherianRing`
- `IsPrincipalIdealRing`
- `IsLocalRing`
- `ringKrullDim`
- `IsRegularLocalRing`
- `IsIntegrallyClosed`

The lecture's "maximal subring of the fraction field" language is less packaged
in Mathlib, so it is retained here as an explicit theorem statement about
`Subalgebra A (FractionRing A)`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

open IsLocalRing

section Discussion_01_15a_Properties

variable (A : Type*) [CommRing A] [IsDomain A] [IsDiscreteValuationRing A]

/-- A DVR is noetherian. -/
theorem dvr_isNoetherianRing : IsNoetherianRing A := by
  infer_instance

/-- A DVR is a principal ideal domain. -/
theorem dvr_isPrincipalIdealRing : IsPrincipalIdealRing A := by
  infer_instance

/-- A DVR is local. -/
theorem dvr_isLocalRing : IsLocalRing A := by
  infer_instance

/-- A DVR has Krull dimension one. -/
theorem dvr_ringKrullDim_eq_one : ringKrullDim A = 1 := by
  exact IsPrincipalIdealRing.ringKrullDim_eq_one A (IsDiscreteValuationRing.not_isField A)

/-- A DVR is a regular local ring. -/
theorem dvr_isRegularLocalRing : IsRegularLocalRing A := by
  infer_instance

/-- The cotangent-space formulation of regularity specializes to dimension one for DVRs. -/
theorem dvr_finrank_cotangentSpace_eq_one :
    Module.finrank (ResidueField A) (CotangentSpace A) = 1 := by
  simpa using IsLocalRing.finrank_CotangentSpace_eq_one (R := A)

/-- A DVR is integrally closed in its fraction field. -/
theorem dvr_isIntegrallyClosed : IsIntegrallyClosed A := by
  infer_instance

/-- The lecture's "maximal" language says that a DVR admits no proper
intermediate `A`-subalgebra inside its fraction field. -/
theorem dvr_fractionRing_maximal_subalgebra
    (S : Subalgebra A (FractionRing A)) (hS : S ≠ ⊤) :
    S = ⊥ := by
  let K := FractionRing A
  let V : ValuationSubring K := dvrValuationSubring A K
  let hV_le_S : V.toSubring ≤ S.toSubring := by
    intro x hx
    rw [dvrValuationSubring_toSubring_eq_image (A := A) (K := K)] at hx
    rcases hx with ⟨a, -, rfl⟩
    exact S.algebraMap_mem a
  let W : ValuationSubring K := ValuationSubring.ofLE V S.toSubring hV_le_S
  have hW_ne_top : W ≠ ⊤ := by
    intro hW
    apply hS
    have hSTop : S.toSubring = ⊤ := by
      change W.toSubring = ⊤
      simpa using congrArg ValuationSubring.toSubring hW
    exact Subalgebra.toSubring_injective hSTop
  have hdimV : ringKrullDim V = 1 := by
    rw [← dvr_ringKrullDim_eq_one (A := A)]
    exact (ringKrullDim_eq_of_ringEquiv (equivDvrValuationSubring A K)).symm
  letI : Ring.KrullDimLE 1 V := (Ring.krullDimLE_iff.mpr hdimV.le)
  have hVW : V = W :=
    ValuationSubring.eq_of_le_of_ne_top (A := V) (B := W) hV_le_S hW_ne_top
  have hSubring : S.toSubring = V.toSubring := by
    simpa [W] using congrArg ValuationSubring.toSubring hVW.symm
  ext x
  constructor
  · intro hx
    change x ∈ Set.range (algebraMap A K)
    have hx' : x ∈ V.toSubring := by
      have hxS : x ∈ S.toSubring := hx
      rwa [hSubring] at hxS
    change x ∈ (dvrValuationSubring A K).toSubring at hx'
    rw [dvrValuationSubring_toSubring_eq_image (A := A) (K := K)] at hx'
    rcases hx' with ⟨a, -, rfl⟩
    exact ⟨a, rfl⟩
  · intro hx
    exact (show (⊥ : Subalgebra A K) ≤ S from bot_le) hx

end Discussion_01_15a_Properties

section Discussion_01_15a_Characterizations

variable (A : Type*) [CommRing A] [IsDomain A] [IsNoetherianRing A] [IsLocalRing A]

/-- One standard alternative definition: in the noetherian local domain setting,
being integrally closed with a unique nonzero prime ideal is equivalent to being
a DVR. -/
theorem isDiscreteValuationRing_iff_integrallyClosed_and_existsUnique_nonzero_prime
    (hA : ¬ IsField A) :
    IsDiscreteValuationRing A ↔
      IsIntegrallyClosed A ∧ ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime := by
  exact (IsDiscreteValuationRing.TFAE A hA).out 0 3

/-- The regular-local characterization can be expressed through the cotangent
space having dimension one over the residue field. -/
theorem isDiscreteValuationRing_iff_finrank_cotangentSpace_eq_one :
    IsDiscreteValuationRing A ↔ Module.finrank (ResidueField A) (CotangentSpace A) = 1 := by
  exact (IsLocalRing.finrank_CotangentSpace_eq_one_iff (R := A)).symm

/-- A regular local domain of Krull dimension one is a DVR. -/
theorem isDiscreteValuationRing_of_isRegularLocalRing_of_ringKrullDim_eq_one
    [IsRegularLocalRing A] (hA : ringKrullDim A = 1) :
    IsDiscreteValuationRing A := by
  have hreg :
      Module.finrank (ResidueField A) (CotangentSpace A) = ringKrullDim A := by
    exact (IsRegularLocalRing.iff_finrank_cotangentSpace (R := A)).mp inferInstance
  have hfin_cast :
      (Module.finrank (ResidueField A) (CotangentSpace A) : ℕ∞) = 1 := by
    simpa [hA] using hreg
  have hfin : Module.finrank (ResidueField A) (CotangentSpace A) = 1 := by
    exact_mod_cast hfin_cast
  exact (IsLocalRing.finrank_CotangentSpace_eq_one_iff (R := A)).mp hfin

end Discussion_01_15a_Characterizations

end Chapter1
end SutherlandNumberTheoryLecture1
