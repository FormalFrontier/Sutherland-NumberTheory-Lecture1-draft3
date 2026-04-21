import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_02_Definition»

/-!
# Definition 1.6: Equivalent absolute values

The lecture defines two absolute values on the same field to be equivalent when
one is a positive real power of the other. Mathlib packages the core notion as
`AbsoluteValue.IsEquiv`, stated in order-theoretic form, and proves that for
real-valued absolute values this is equivalent to the lecture's exponentiation
criterion. This file records both viewpoints explicitly.
-/

recall AbsoluteValue.IsEquiv {R : Type u_1} [Semiring R] {S : Type u_2} [Semiring S]
  [PartialOrder S] (v w : AbsoluteValue R S) : Prop

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_06

variable {k : Type*} [Field k]

/-- The lecture's definition is exactly Mathlib's `AbsoluteValue.IsEquiv`. -/
theorem isEquiv_iff_exists_rpow_eq_pointwise (abv abv' : AbsoluteValue k ℝ) :
    abv.IsEquiv abv' ↔ ∃ α : ℝ, 0 < α ∧ ∀ x : k, abv x ^ α = abv' x := by
  rw [AbsoluteValue.isEquiv_iff_exists_rpow_eq]
  constructor
  · rintro ⟨α, hα, hpow⟩
    exact ⟨α, hα, fun x => by simpa using congrFun hpow x⟩
  · rintro ⟨α, hα, hpow⟩
    exact ⟨α, hα, funext hpow⟩

/-- This is the lecture's `|x|' = |x|^α` phrasing written verbatim. -/
theorem isEquiv_iff_exists_rpow_eq_textbook (abv abv' : AbsoluteValue k ℝ) :
    abv.IsEquiv abv' ↔ ∃ α : ℝ, 0 < α ∧ ∀ x : k, abv' x = abv x ^ α := by
  rw [isEquiv_iff_exists_rpow_eq_pointwise]
  constructor
  · rintro ⟨α, hα, hpow⟩
    exact ⟨α, hα, fun x => (hpow x).symm⟩
  · rintro ⟨α, hα, hpow⟩
    exact ⟨α, hα, fun x => (hpow x).symm⟩

end Definition_01_06

end Chapter1
end SutherlandNumberTheoryLecture1
