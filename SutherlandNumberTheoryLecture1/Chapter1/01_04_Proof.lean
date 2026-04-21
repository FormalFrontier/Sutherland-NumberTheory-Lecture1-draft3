import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_04_Lemma»

/-!
# Proof of Lemma 1.4

The lecture defers the converse direction of Lemma 1.4 to Problem Set 1. This
module makes that deferred obligation explicit as Lean declarations on top of
`Chapter1/01_04_Lemma`, rather than leaving the proof blob as prose-only
metadata.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_04

variable {k : Type*} [Field k]

/-- Problem Set 1 supplies the converse implication in the all-natural-numbers form. -/
theorem problemSet1_isNonarchimedean_of_natCast_le_one
    (abv : AbsoluteValue k ℝ) (h_nat : ∀ n : ℕ, abv n ≤ 1) :
    IsNonarchimedean abv := by
  exact isNonarchimedean_of_natCast_le_one abv h_nat

/-- The lecture's `n ≥ 1` phrasing recovers the same conclusion. -/
theorem problemSet1_isNonarchimedean_of_natCast_pos_le_one
    (abv : AbsoluteValue k ℝ) (h_pos : ∀ n : ℕ, 0 < n → abv n ≤ 1) :
    IsNonarchimedean abv := by
  exact (isNonarchimedean_iff_natCast_pos_le_one abv).2 h_pos

end Proof_01_04

end Chapter1
end SutherlandNumberTheoryLecture1
