import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_04_Lemma»

/-!
# Corollary 1.5: Absolute values in positive characteristic and on finite fields

The lecture draws two consequences from Lemma 1.4.

- In a field of positive characteristic, every natural-number scalar is fixed by
  Frobenius, so its absolute value satisfies `|n|^p = |n|`. This forces the
  bound `|n| ≤ 1` needed for the nonarchimedean criterion.
- In a finite field, every nonzero element satisfies `x^(q - 1) = 1`, so any
  absolute value must take value `1` on nonzero elements and hence coincide with
  the trivial absolute value.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Corollary_01_05_PositiveCharacteristic

variable {k : Type*} [Field k]

/-- In positive characteristic, Frobenius fixes every natural-number scalar. -/
theorem natCast_absoluteValue_pow_char (abv : AbsoluteValue k ℝ) {p : ℕ}
    [Fact p.Prime] [CharP k p] (n : ℕ) :
    abv n ^ p = abv n := by
  sorry

/-- In a field of positive characteristic, every absolute value is nonarchimedean. -/
theorem absoluteValue_isNonarchimedean_of_pos_char (abv : AbsoluteValue k ℝ) {p : ℕ}
    [Fact p.Prime] [CharP k p] :
    IsNonarchimedean abv := by
  sorry

end Corollary_01_05_PositiveCharacteristic

section Corollary_01_05_FiniteField

variable {k : Type*} [Field k] [Finite k]

/-- Any absolute value on a finite field takes value `1` on nonzero elements. -/
theorem absoluteValue_eq_one_of_ne_zero (abv : AbsoluteValue k ℝ) {x : k} (hx : x ≠ 0) :
    abv x = 1 := by
  sorry

/-- The only absolute value on a finite field is the trivial one. -/
theorem absoluteValue_eq_trivial_of_finite [DecidableEq k] (abv : AbsoluteValue k ℝ) :
    abv = AbsoluteValue.trivial := by
  sorry

end Corollary_01_05_FiniteField

end Chapter1
end SutherlandNumberTheoryLecture1
