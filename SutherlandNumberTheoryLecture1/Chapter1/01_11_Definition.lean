import Mathlib

/-!
# Definition 1.11: Valuation rings

The lecture defines a valuation ring `A` inside its fraction field `k` by the
condition that every `x : k` lies in `A` or has inverse in `A`. Mathlib packages
this exact notion as the predicate `ValuationRing A`, with the ambient
fraction-field data carried by typeclasses.
-/

recall ValuationRing (A : Type*) [CommRing A] [IsDomain A] : Prop

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_11

variable {A k : Type*} [CommRing A] [IsDomain A] [Field k] [Algebra A k] [IsFractionRing A k]

/-- Definition 1.11 is exactly Mathlib's valuation-ring predicate. -/
theorem valuationRing_iff_forall_isInteger_or_isInteger_inv :
    ValuationRing A ↔
      ∀ x : k, IsLocalization.IsInteger A x ∨ IsLocalization.IsInteger A x⁻¹ :=
  ValuationRing.iff_isInteger_or_isInteger A k

/-- Definition 1.11 in the lecture's `x ∈ A` / `x⁻¹ ∈ A` fraction-field phrasing. -/
theorem valuationRing_iff_forall_exists_eq_algebraMap_or_inv_eq_algebraMap :
    ValuationRing A ↔
      ∀ x : k, ∃ a : A, x = algebraMap A k a ∨ x⁻¹ = algebraMap A k a := by
  rw [valuationRing_iff_forall_isInteger_or_isInteger_inv (A := A) (k := k)]
  constructor
  · intro h x
    rcases h x with hx | hx
    · rcases hx with ⟨a, rfl⟩
      exact ⟨a, Or.inl rfl⟩
    · rcases hx with ⟨a, hax⟩
      exact ⟨a, Or.inr hax.symm⟩
  · intro h x
    rcases h x with ⟨a, hax | hax⟩
    · exact Or.inl ⟨a, hax.symm⟩
    · exact Or.inr ⟨a, hax.symm⟩

end Definition_01_11

end Chapter1
end SutherlandNumberTheoryLecture1
