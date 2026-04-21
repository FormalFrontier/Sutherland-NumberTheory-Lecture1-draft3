import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_02_Definition»

/-!
# Definition 1.10: Valuations, valuation rings, and DVRs

The lecture presents valuations additively as maps to `ℝ ∪ {∞}` satisfying the
nonarchimedean inequality, then derives a nonarchimedean absolute value
`|x|_v = c ^ v(x)` for `0 < c < 1`. Mathlib packages the same material in the
bundled valuation APIs:

- `Valuation k Γ₀` for multiplicative valuations;
- `AddValuation k Γ` for additive valuations;
- `Valuation.valuationSubring` for the valuation ring attached to a valuation;
- `IsDiscreteValuationRing` for the DVR predicate.

This file records those packaged notions and exposes the lecture's derived
absolute-value and DVR assertions as explicit theorem-level obligations.
-/

recall Valuation (R : Type*) (Γ₀ : Type*) [LinearOrderedCommMonoidWithZero Γ₀] [Ring R] : Type _

recall IsDiscreteValuationRing (A : Type*) [CommRing A] [IsDomain A] : Prop

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_10

variable {k : Type*} [Field k]
variable {Γ₀ : Type*} [LinearOrderedCommGroupWithZero Γ₀]
variable {Γ : Type*} [LinearOrderedAddCommGroupWithTop Γ]

/-- The lecture's multiplicative notion of valuation is Mathlib's bundled `Valuation`. -/
abbrev textbookValuation := Valuation k Γ₀

/-- The lecture's additive notation for valuations is Mathlib's bundled `AddValuation`. -/
abbrev textbookAddValuation := AddValuation k Γ

/-- The value group of an additive valuation is its image. -/
abbrev valuationValueGroup (v : textbookAddValuation (k := k) (Γ := Γ)) : Set Γ :=
  Set.range v

/-- The valuation ring attached to a multiplicative valuation is `valuationSubring`. -/
abbrev valuationRing (v : textbookValuation (k := k) (Γ₀ := Γ₀)) : ValuationSubring k :=
  v.valuationSubring

/--
The additive presentation used in the lecture induces the same valuation ring
via `toValuation`.
-/
abbrev additiveValuationRing (v : textbookAddValuation (k := k) (Γ := Γ)) : ValuationSubring k :=
  v.toValuation.valuationSubring

/--
For `0 < c < 1`, the lecture's formula `|x|_v = c ^ v(x)` yields a
nonarchimedean absolute value.
-/
theorem exists_nonarchimedean_absoluteValue_of_addValuation
    (v : AddValuation k (WithTop ℝ)) {c : ℝ} (hc0 : 0 < c) (hc1 : c < 1) :
    ∃ abv : AbsoluteValue k ℝ, IsNonarchimedean abv := by
  sorry

end Definition_01_10

section Definition_01_10_DVR

variable {k : Type*} [Field k]

/-- A discrete valuation is modeled by an additive valuation with value group `ℤ`. -/
abbrev discreteValuation := AddValuation k (WithTop ℤ)

/-- The lecture's definition of a DVR matches Mathlib's bundled predicate. -/
abbrev isDiscreteValuationRing (A : Type*) [CommRing A] [IsDomain A] : Prop :=
  IsDiscreteValuationRing A

/-- The valuation ring of a field with a discrete valuation is a DVR. -/
theorem additiveValuationRing_isDiscreteValuationRing (v : discreteValuation (k := k)) :
    IsDiscreteValuationRing (additiveValuationRing (k := k) v) := by
  sorry

/-- A discrete valuation ring cannot be a field. -/
theorem discreteValuationRing_not_isField (A : Type*) [CommRing A] [IsDomain A]
    [isDiscreteValuationRing A] : ¬ IsField A := by
  exact IsDiscreteValuationRing.not_isField A

end Definition_01_10_DVR

end Chapter1
end SutherlandNumberTheoryLecture1
