import SutherlandNumberTheoryLecture1.Chapter1.«01_16_Theorem»

/-!
# Proof of Theorem 1.16

This file contains the equivalence proofs for the seven DVR characterizations
introduced in `01_16_Theorem`. Keeping the proof content here removes the
untracked `01_16_Core` side-channel and keeps all Stage 3 work inside item
files recorded in `items.json`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Theorem_01_16

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

/-- The integrally closed one-dimensional local criterion is the corresponding
entry in `IsDiscreteValuationRing.TFAE`, after making the unique-nonzero-prime
package explicit from the dimension-one hypothesis. -/
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

/-- The lecture's maximal-subring criterion implies locality by forcing the
localization at a nonzero prime to coincide with `A` inside the fraction field;
the DVR conclusion then follows from the already formalized local criterion. -/
theorem isDvr_of_isMaximalNoetherianRingOfDimOne
    (hA : IsMaximalNoetherianRingOfDimOne A) :
    IsDvr A := by
  rcases hA with ⟨_hNoetherian, hDim, hMax⟩
  letI : IsNoetherianRing A := _hNoetherian
  have hNotField : ¬ IsField A := by
    intro hField
    exact zero_ne_one ((ringKrullDim_eq_zero_of_isField hField).symm.trans hDim)
  obtain ⟨P, hP0, hPPrime⟩ := Ring.not_isField_iff_exists_prime.mp hNotField
  let S : Subalgebra A (FractionRing A) :=
    Localization.subalgebra.ofField (FractionRing A) P.primeCompl P.primeCompl_le_nonZeroDivisors
  have hS_ne_top : S ≠ ⊤ := by
    intro hS_top
    let eTop : Localization.AtPrime P ≃+* FractionRing A :=
      (((IsLocalization.algEquiv P.primeCompl (Localization.AtPrime P) S).trans
          (Subalgebra.equivOfEq S ⊤ hS_top)).trans Subalgebra.topEquiv).toRingEquiv
    have hFieldLoc : IsField (Localization.AtPrime P) :=
      eTop.toMulEquiv.isField (Field.toIsField _)
    exact IsLocalization.AtPrime.not_isField (A := A) hP0 (Aₘ := Localization.AtPrime P) hFieldLoc
  have hS_bot : S = ⊥ := hMax S hS_ne_top
  let eLocal : Localization.AtPrime P ≃+* A :=
    ((((IsLocalization.algEquiv P.primeCompl (Localization.AtPrime P) S).trans
        (Subalgebra.equivOfEq S ⊥ hS_bot)).trans
          (Algebra.botEquivOfInjective (IsFractionRing.injective A (FractionRing A)))).toRingEquiv)
  letI : IsLocalRing A := eLocal.isLocalRing
  have hIntegralClosureNotTop : integralClosure A (FractionRing A) ≠ ⊤ := by
    intro hTop
    have hIntegral : Algebra.IsIntegral A (FractionRing A) :=
      (integralClosure_eq_top_iff (R := A) (A := FractionRing A)).mp hTop
    exact hNotField
      ((hIntegral.isField_iff_isField (IsFractionRing.injective A (FractionRing A))).mpr
        (Field.toIsField _))
  have hIntegralClosureBot : integralClosure A (FractionRing A) = ⊥ :=
    hMax (integralClosure A (FractionRing A)) hIntegralClosureNotTop
  have hIntegrallyClosed : IsIntegrallyClosed A := by
    rw [show IsIntegrallyClosed A ↔ IsIntegrallyClosedIn A (FractionRing A) from
      isIntegrallyClosed_iff_isIntegrallyClosedIn (R := A) (K := FractionRing A)]
    exact (IsIntegrallyClosedIn.integralClosure_eq_bot_iff
      (R := A) (A := FractionRing A) (IsFractionRing.injective A (FractionRing A))).mp
      hIntegralClosureBot
  exact isDvr_of_isIntegrallyClosedNoetherianLocalDimOne (A := A)
    ⟨inferInstance, inferInstance, hIntegrallyClosed, hDim⟩

/-- The lecture's seven characterizations of DVRs, packaged as a single TFAE statement. -/
theorem dvr_characterization_proof :
    List.TFAE
      [IsDvr A,
        IsNoetherianValuationRingNotField A,
        IsLocalPidNotField A,
        IsIntegrallyClosedNoetherianLocalDimOne A,
        IsRegularNoetherianLocalDimOne A,
        HasPrincipalNonzeroMaximalIdeal A,
        IsMaximalNoetherianRingOfDimOne A] := by
  tfae_have 1 ↔ 2 := isDvr_iff_isNoetherianValuationRingNotField (A := A)
  tfae_have 1 ↔ 3 := isDvr_iff_isLocalPidNotField (A := A)
  tfae_have 1 → 4 := isDvr_implies_isIntegrallyClosedNoetherianLocalDimOne (A := A)
  tfae_have 4 → 1 := isDvr_of_isIntegrallyClosedNoetherianLocalDimOne (A := A)
  tfae_have 1 → 5 := isDvr_implies_isRegularNoetherianLocalDimOne (A := A)
  tfae_have 5 → 1 := isDvr_of_isRegularNoetherianLocalDimOne (A := A)
  tfae_have 1 → 6 := isDvr_implies_hasPrincipalNonzeroMaximalIdeal (A := A)
  tfae_have 6 → 1 := isDvr_of_hasPrincipalNonzeroMaximalIdeal (A := A)
  tfae_have 1 → 7 := isDvr_implies_isMaximalNoetherianRingOfDimOne (A := A)
  tfae_have 7 → 1 := isDvr_of_isMaximalNoetherianRingOfDimOne (A := A)
  tfae_finish

/-- The lecture's seven characterizations of DVRs, packaged as a single TFAE statement. -/
theorem dvr_characterization_tfae :
    List.TFAE
      [IsDvr A,
        IsNoetherianValuationRingNotField A,
        IsLocalPidNotField A,
        IsIntegrallyClosedNoetherianLocalDimOne A,
        IsRegularNoetherianLocalDimOne A,
        HasPrincipalNonzeroMaximalIdeal A,
        IsMaximalNoetherianRingOfDimOne A] := by
  simpa using dvr_characterization_proof (A := A)

end Theorem_01_16

end Chapter1
end SutherlandNumberTheoryLecture1
