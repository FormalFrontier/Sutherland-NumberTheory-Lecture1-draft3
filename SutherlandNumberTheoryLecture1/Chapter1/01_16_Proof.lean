import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_16_Theorem»

/-!
# Proof of Theorem 1.16

The lecture sends the proof to the standard commutative algebra references.
For the formalization scaffold we make the proof structure explicit: most of the
equivalences are direct consequences of `IsDiscreteValuationRing.TFAE` together
with the bridge lemmas already recorded in Discussion 1.15a. The remaining
"maximal subring" formulation is kept as a theorem-level placeholder.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_16

variable (A : Type*) [CommRing A] [IsDomain A]

/-- A DVR is a noetherian valuation ring and cannot be a field. -/
theorem isDvr_iff_isNoetherianValuationRingNotField :
    IsDvr A ↔ IsNoetherianValuationRingNotField A := by
  constructor
  · intro hA
    change IsDiscreteValuationRing A at hA
    letI := hA
    exact ⟨inferInstance, inferInstance, IsDiscreteValuationRing.not_isField A⟩
  · rintro ⟨_hNoetherian, hValuation, hNotField⟩
    letI : IsNoetherianRing A := _hNoetherian
    letI : ValuationRing A := hValuation
    exact ((IsDiscreteValuationRing.TFAE A hNotField).out 1 0).mp
      (show ValuationRing A from inferInstance)

/-- A DVR is equivalently a local PID that is not a field. -/
theorem isDvr_iff_isLocalPidNotField :
    IsDvr A ↔ IsLocalPidNotField A := by
  constructor
  · intro hA
    change IsDiscreteValuationRing A at hA
    letI := hA
    exact ⟨inferInstance, inferInstance, IsDiscreteValuationRing.not_isField A⟩
  · rintro ⟨hLocal, _hPid, hNotField⟩
    letI : IsLocalRing A := hLocal
    letI : IsNoetherianRing A := inferInstance
    letI : IsPrincipalIdealRing A := _hPid
    have hPrincipal : (IsLocalRing.maximalIdeal A).IsPrincipal := by
      infer_instance
    exact ((IsDiscreteValuationRing.TFAE A hNotField).out 4 0).mp
      (show (IsLocalRing.maximalIdeal A).IsPrincipal from hPrincipal)

/-- A DVR satisfies the lecture's integrally closed one-dimensional local criterion. -/
theorem isDvr_implies_isIntegrallyClosedNoetherianLocalDimOne
    (hA : IsDvr A) :
    IsIntegrallyClosedNoetherianLocalDimOne A := by
  change IsDiscreteValuationRing A at hA
  letI := hA
  exact ⟨inferInstance, inferInstance, dvr_isIntegrallyClosed (A := A),
    dvr_ringKrullDim_eq_one (A := A)⟩

/-- A regular local one-dimensional noetherian domain is a DVR. -/
theorem isDvr_of_isRegularNoetherianLocalDimOne
    (hA : IsRegularNoetherianLocalDimOne A) :
    IsDvr A := by
  rcases hA with ⟨_hNoetherian, hLocal, hRegular, hDim⟩
  letI := hLocal
  letI := hRegular
  exact isDiscreteValuationRing_of_isRegularLocalRing_of_ringKrullDim_eq_one
    (A := A) hDim

/-- Any DVR has the regular local one-dimensional package listed in the theorem. -/
theorem isDvr_implies_isRegularNoetherianLocalDimOne
    (hA : IsDvr A) :
    IsRegularNoetherianLocalDimOne A := by
  change IsDiscreteValuationRing A at hA
  letI := hA
  exact ⟨inferInstance, inferInstance, inferInstance, dvr_ringKrullDim_eq_one (A := A)⟩

/-- A noetherian local domain with nonzero principal maximal ideal is a DVR. -/
theorem isDvr_of_hasPrincipalNonzeroMaximalIdeal
    (hA : HasPrincipalNonzeroMaximalIdeal A) :
    IsDvr A := by
  rcases hA with ⟨_hNoetherian, hLocal, hMaximalNe, hPrincipal⟩
  letI : IsNoetherianRing A := _hNoetherian
  letI : IsLocalRing A := hLocal
  have hNotField : ¬ IsField A :=
    IsLocalRing.isField_iff_maximalIdeal_eq.not.mpr hMaximalNe
  exact ((IsDiscreteValuationRing.TFAE A hNotField).out 4 0).mp
    (show (IsLocalRing.maximalIdeal A).IsPrincipal from hPrincipal)

/-- A DVR has nonzero principal maximal ideal. -/
theorem isDvr_implies_hasPrincipalNonzeroMaximalIdeal
    (hA : IsDvr A) :
    HasPrincipalNonzeroMaximalIdeal A := by
  change IsDiscreteValuationRing A at hA
  letI := hA
  exact ⟨inferInstance, inferInstance,
    IsLocalRing.isField_iff_maximalIdeal_eq.not.mp (IsDiscreteValuationRing.not_isField A),
    inferInstance⟩

/-- A DVR has the lecture's maximal-subring formulation inside its fraction field. -/
theorem isDvr_implies_isMaximalNoetherianRingOfDimOne
    (hA : IsDvr A) :
    IsMaximalNoetherianRingOfDimOne A := by
  change IsDiscreteValuationRing A at hA
  letI := hA
  exact ⟨inferInstance, dvr_ringKrullDim_eq_one (A := A),
    dvr_fractionRing_maximal_subalgebra (A := A)⟩

/-- The integrally closed one-dimensional local criterion should be discharged by
bridging the dimension-one hypothesis to the unique-prime clause in
`IsDiscreteValuationRing.TFAE`. -/
theorem isDvr_of_isIntegrallyClosedNoetherianLocalDimOne
    (hA : IsIntegrallyClosedNoetherianLocalDimOne A) :
    IsDvr A := by
  rcases hA with ⟨_hNoetherian, hLocal, hIntegrallyClosed, hDim⟩
  letI : IsNoetherianRing A := _hNoetherian
  letI : IsLocalRing A := hLocal
  have hNotField : ¬ IsField A := by
    intro hField
    exact zero_ne_one ((ringKrullDim_eq_zero_of_isField hField).symm.trans hDim)
  have hUniquePrime : ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime := by
    refine ⟨IsLocalRing.maximalIdeal A, ?_, ?_⟩
    · refine ⟨IsLocalRing.isField_iff_maximalIdeal_eq.not.mp hNotField, inferInstance⟩
    · intro P hP
      obtain ⟨x, hxP, hx0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hP.1
      have hDimCriterion :=
        (ringKrullDim_eq_one_iff_of_isLocalRing_isDomain (R := A)).mp hDim
      have hMaxLeRad :
          IsLocalRing.maximalIdeal A ≤ Ideal.radical (Ideal.span {x}) :=
        hDimCriterion.2 x hx0
      have hRadLeP : Ideal.radical (Ideal.span {x}) ≤ P := by
        exact (Ideal.IsRadical.radical_le_iff hP.2.isRadical).mpr
          ((Ideal.span_singleton_le_iff_mem P).mpr hxP)
      letI : P.IsPrime := hP.2
      exact le_antisymm (IsLocalRing.le_maximalIdeal_of_isPrime P) (le_trans hMaxLeRad hRadLeP)
  exact ((isDiscreteValuationRing_iff_integrallyClosed_and_existsUnique_nonzero_prime
    (A := A) hNotField).mpr ⟨hIntegrallyClosed, hUniquePrime⟩)

/-- The lecture's maximal-subring reformulation remains as a theorem-level gap in
the scaffold. -/
theorem isDvr_of_isMaximalNoetherianRingOfDimOne
    (hA : IsMaximalNoetherianRingOfDimOne A) :
    IsDvr A := by
  sorry

/-- The deferred proof consists of the bridged equivalences above plus the two
remaining theorem-level gaps. -/
theorem dvr_characterization_proof :
    List.TFAE
      [IsDvr A,
        IsNoetherianValuationRingNotField A,
        IsLocalPidNotField A,
        IsIntegrallyClosedNoetherianLocalDimOne A,
        IsRegularNoetherianLocalDimOne A,
        HasPrincipalNonzeroMaximalIdeal A,
        IsMaximalNoetherianRingOfDimOne A] := by
  sorry

end Proof_01_16

end Chapter1
end SutherlandNumberTheoryLecture1
