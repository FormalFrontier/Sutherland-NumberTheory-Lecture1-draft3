import SutherlandNumberTheoryLecture1.Chapter1.«01_10_Definition»
import SutherlandNumberTheoryLecture1.Chapter1.«01_13_Definition»

/-!
# Discussion 1.13a: recovering the valuation from a DVR

The lecture explains how a discrete valuation ring determines the valuation on
its fraction field: start with the adic valuation of the maximal ideal on the
ring itself, then extend it to the fraction field. Mathlib already provides
that extension for any DVR through the `HeightOneSpectrum` valuation attached to
the unique maximal ideal.

The lecture uses additive notation with the valuation ring written as
`{x : k | v x ≥ 0}`. Mathlib packages the same object multiplicatively, so the
corresponding condition becomes `v x ≤ 1`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Discussion_01_13a

open IsDedekindDomain
open IsDedekindDomain.HeightOneSpectrum
open IsDiscreteValuationRing

variable (A K : Type*) [CommRing A] [IsDomain A] [IsDiscreteValuationRing A] [Field K]
  [Algebra A K] [IsFractionRing A K]

/-- The valuation on the DVR itself coming from powers of its maximal ideal. -/
noncomputable abbrev maximalIdealIntValuation : Valuation A (WithZero (Multiplicative ℤ)) :=
  (IsDiscreteValuationRing.maximalIdeal A).intValuation

/-- The induced valuation on the fraction field of the DVR. -/
noncomputable abbrev dvrValuation : Valuation K (WithZero (Multiplicative ℤ)) :=
  (IsDiscreteValuationRing.maximalIdeal A).valuation K

/-- The valuation subring cut out by the reconstructed fraction-field valuation. -/
noncomputable abbrev dvrValuationSubring : ValuationSubring K :=
  (dvrValuation A K).valuationSubring

/-- Powers of the maximal ideal are measured by the adic valuation on the DVR. -/
theorem maximalIdealIntValuation_le_pow_iff_mem (a : A) (n : ℕ) :
    maximalIdealIntValuation A a ≤ WithZero.exp (-(n : ℤ)) ↔
      a ∈ IsLocalRing.maximalIdeal A ^ n := by
  simpa [maximalIdealIntValuation] using
    (IsDedekindDomain.HeightOneSpectrum.intValuation_le_pow_iff_mem
      (v := IsDiscreteValuationRing.maximalIdeal A) (r := a) (n := n))

/-- In the lecture's multiplicative normalization, the valuation ring is the `v(x) ≤ 1` locus. -/
theorem mem_dvrValuationSubring_iff (x : K) :
    x ∈ dvrValuationSubring A K ↔ dvrValuation A K x ≤ 1 := by
  simp [dvrValuationSubring]

/-- The reconstructed valuation ring is exactly the nonnegative part of the valuation. -/
theorem dvrValuationSubring_eq_setOf_nonnegative :
    (dvrValuationSubring A K : Set K) = {x : K | dvrValuation A K x ≤ 1} := by
  ext x
  simp [dvrValuationSubring]

/-- The fraction-field valuation recovers the original DVR inside its field of fractions. -/
theorem dvrValuationSubring_toSubring_eq_image :
    (dvrValuationSubring A K).toSubring = Subring.map (algebraMap A K) ⊤ := by
  symm
  simpa [dvrValuationSubring, dvrValuation] using
    (IsDiscreteValuationRing.map_algebraMap_eq_valuationSubring (A := A) (K := K))

/-- The ring of valuation-integral elements is exactly the image of the DVR in its
fraction field. -/
theorem dvrValuation_integer_eq_image :
    (dvrValuation A K).integer = Subring.map (algebraMap A K) ⊤ := by
  calc
    (dvrValuation A K).integer = (dvrValuationSubring A K).toSubring := by
      rfl
    _ = Subring.map (algebraMap A K) ⊤ :=
      dvrValuationSubring_toSubring_eq_image (A := A) (K := K)

/-- The original DVR is canonically isomorphic to the reconstructed valuation subring. -/
noncomputable abbrev equivDvrValuationSubring :
    A ≃+* dvrValuationSubring A K :=
  IsDiscreteValuationRing.equivValuationSubring (A := A) (K := K)

/-- Any valuation whose valuation ring is the recovered DVR is equivalent to the
reconstructed one. -/
theorem isEquiv_dvrValuation_of_valuationSubring_eq {Γ : Type*}
    [LinearOrderedCommGroupWithZero Γ] (v : Valuation K Γ)
    (hA : v.valuationSubring = dvrValuationSubring A K) :
    v.IsEquiv (dvrValuation A K) := by
  rw [Valuation.isEquiv_iff_valuationSubring]
  simpa [dvrValuationSubring] using hA

/-- The recovered valuation admits a uniformizer in its valuation subring. -/
theorem exists_uniformizer_dvrValuation :
    ∃ π : dvrValuationSubring A K, (dvrValuation A K).IsUniformizer (π : K) := by
  simpa [dvrValuationSubring] using
    (Valuation.exists_isUniformizer_of_isCyclic_of_nontrivial (v := dvrValuation A K))

/-- For the recovered valuation, generators of the maximal ideal are exactly uniformizers. -/
theorem maximalIdeal_eq_span_iff_isUniformizer (π : dvrValuationSubring A K) :
    IsLocalRing.maximalIdeal (dvrValuationSubring A K) = Ideal.span {π} ↔
      (dvrValuation A K).IsUniformizer (π : K) := by
  constructor
  · intro hπ
    simpa [dvrValuationSubring] using
      (Valuation.isUniformizer_of_maximalIdeal_eq_span (v := dvrValuation A K) hπ)
  · intro hπ
    simpa [dvrValuationSubring] using hπ.is_generator

end Discussion_01_13a

end Chapter1
end SutherlandNumberTheoryLecture1
