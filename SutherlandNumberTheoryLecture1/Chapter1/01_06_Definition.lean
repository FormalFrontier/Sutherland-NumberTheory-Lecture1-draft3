import Mathlib

/-!
# Definition 1.6: Equivalent absolute values

The lecture defines two absolute values `|.|` and `|.|'` on the same field to be
equivalent when there is a positive real exponent `α` such that `|x|' = |x|^α`
for every `x`. Mathlib's core notion is `AbsoluteValue.IsEquiv`, and
`AbsoluteValue.isEquiv_iff_exists_rpow_eq` gives exactly the bridge to the
lecture's exponentiation phrasing.
-/

recall AbsoluteValue.IsEquiv {R : Type u_1} [Semiring R] {S : Type u_2} [Semiring S]
  [PartialOrder S] (v w : AbsoluteValue R S) : Prop

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_06

variable {k : Type*} [Field k]

/-- Definition 1.6 written in the lecture's `|x|' = |x|^α` form. -/
theorem isEquiv_iff_exists_forall_rpow_eq (v w : AbsoluteValue k ℝ) :
    v.IsEquiv w ↔ ∃ α : ℝ, 0 < α ∧ ∀ x : k, w x = v x ^ α := by
  constructor
  · intro h
    rcases AbsoluteValue.isEquiv_iff_exists_rpow_eq.mp h with ⟨α, hα, hpow⟩
    refine ⟨α, hα, ?_⟩
    intro x
    exact (congrFun hpow x).symm
  · rintro ⟨α, hα, hpow⟩
    refine AbsoluteValue.isEquiv_iff_exists_rpow_eq.mpr ?_
    refine ⟨α, hα, funext ?_⟩
    intro x
    exact (hpow x).symm

end Definition_01_06

end Chapter1
end SutherlandNumberTheoryLecture1
