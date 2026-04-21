import SutherlandNumberTheoryLecture1.Chapter1.«01_10_Definition»

/-!
# Discussion 1.10a: basic structure of valuation rings

This discussion blob spells out the basic algebraic interface of the valuation
ring attached to a real-valued additive valuation `v`. The lecture phrases the
results in terms of the sign of `v(x)`, so the declarations below keep that
additive language visible while reusing Mathlib's bundled `ValuationSubring`
API for the actual ring-theoretic facts.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Discussion_01_10a

variable {k : Type*} [Field k]

/-- Every valuation ring is an integral domain. -/
theorem valuationSubring_isDomain (v : RealValuation k) :
    IsDomain (valuationSubring v) := by
  infer_instance

/-- The ambient field is the fraction field of its valuation ring. -/
theorem valuationSubring_isFractionRing (v : RealValuation k) :
    IsFractionRing (valuationSubring v) k := by
  infer_instance

/-- Every nonzero field element, or its inverse, lies in the valuation ring. -/
theorem mem_or_inv_mem_valuationSubring (v : RealValuation k) (x : kˣ) :
    ((x : k) ∈ valuationSubring v) ∨ (((↑x : k)⁻¹) ∈ valuationSubring v) := by
  simpa using (valuationSubring v).mem_or_inv_mem (x : k)

/-- For an element of the valuation ring, being a unit is equivalent to vanishing valuation. -/
theorem isUnit_iff_valuation_eq_zero (v : RealValuation k) (x : valuationSubring v) :
    IsUnit x ↔ v (x : k) = 0 := by
  have hval : v (x : k) = 0 ↔ (valuationSubring v).valuation x = 1 := by
    simpa [valuationSubring] using
      ((Valuation.isEquiv_valuation_valuationSubring (asValuation v)).eq_one_iff_eq_one
        (x := (x : k)))
  rw [hval]
  exact (valuationSubring v).valuation_eq_one_iff x

/-- The lecture's description of the unit group as the valuation-zero locus. -/
theorem unitGroup_eq_zeroValuation_set (v : RealValuation k) :
    {x : valuationSubring v | IsUnit x} = {x : valuationSubring v | v (x : k) = 0} := by
  ext x
  exact isUnit_iff_valuation_eq_zero (v := v) x

/-- Positive valuation picks out the maximal ideal, hence the nonunits of the ring. -/
theorem mem_maximalIdeal_iff_valuation_pos (v : RealValuation k) (x : valuationSubring v) :
    x ∈ IsLocalRing.maximalIdeal (valuationSubring v) ↔ 0 < v (x : k) := by
  constructor
  · intro hx
    have h_not_unit : ¬ IsUnit x := by
      simpa using hx
    have hx_nonneg : 0 ≤ v (x : k) := (mem_valuationSubring_iff (v := v) _).1 x.2
    exact lt_of_le_of_ne hx_nonneg fun hzero => h_not_unit ((isUnit_iff_valuation_eq_zero
      (v := v) x).2 hzero.symm)
  · intro hx
    have h_not_unit : ¬ IsUnit x := by
      intro h_unit
      exact (ne_of_gt hx) ((isUnit_iff_valuation_eq_zero (v := v) x).1 h_unit)
    simpa using h_not_unit

/-- An element of strictly positive valuation lies in the valuation ring. -/
theorem mem_valuationSubring_of_pos (v : RealValuation k) {x : k} (hx : 0 < v x) :
    x ∈ valuationSubring v := by
  exact (mem_valuationSubring_iff (v := v) x).2 hx.le

/-- An element of strictly negative valuation does not lie in the valuation ring. -/
theorem not_mem_valuationSubring_of_neg (v : RealValuation k) {x : k} (hx : v x < 0) :
    x ∉ valuationSubring v := by
  intro hxmem
  exact not_le_of_gt hx ((mem_valuationSubring_iff (v := v) x).1 hxmem)

/-- Strictly positive valuation means the corresponding ring element is a nonunit. -/
theorem not_isUnit_of_pos (v : RealValuation k) {x : k} (hx : 0 < v x) :
    ¬IsUnit (⟨x, mem_valuationSubring_of_pos (v := v) hx⟩ : valuationSubring v) := by
  rw [isUnit_iff_valuation_eq_zero]
  exact ne_of_gt hx

/-- If `v(x) < 0`, then `x⁻¹` lies in the maximal ideal of the valuation ring. -/
theorem inv_mem_maximalIdeal_of_neg (v : RealValuation k) {x : k} (hx : v x < 0) :
    (⟨x⁻¹, by
      rcases (valuationSubring v).mem_or_inv_mem x with hxmem | hxinv
      · exact False.elim <| not_mem_valuationSubring_of_neg (v := v) hx hxmem
      · exact hxinv
    ⟩ : valuationSubring v) ∈ IsLocalRing.maximalIdeal (valuationSubring v) := by
  rw [mem_maximalIdeal_iff_valuation_pos]
  rw [v.map_inv]
  simpa using (Or.inl hx : v x < 0 ∨ x = 0)

/-- The lecture's sign trichotomy for nonzero field elements, organized as usable cases. -/
theorem valuation_sign_partition (v : RealValuation k) {x : k} (_hx : x ≠ 0) :
    (v x = 0 ∧ x ∈ valuationSubring v) ∨
      (0 < v x ∧ x ∈ valuationSubring v) ∨
      (v x < 0 ∧ x ∉ valuationSubring v ∧ x⁻¹ ∈ valuationSubring v) := by
  rcases lt_trichotomy (v x) 0 with hlt | hEq | hgt
  · exact Or.inr <| Or.inr
      ⟨hlt, not_mem_valuationSubring_of_neg (v := v) hlt,
        ((valuationSubring v).mem_or_inv_mem x).resolve_left
          (not_mem_valuationSubring_of_neg (v := v) hlt)⟩
  · exact Or.inl ⟨hEq, (mem_valuationSubring_iff (v := v) x).2 (by simpa [hEq])⟩
  · exact Or.inr <| Or.inl ⟨hgt, mem_valuationSubring_of_pos (v := v) hgt⟩

end Discussion_01_10a

end Chapter1
end SutherlandNumberTheoryLecture1
