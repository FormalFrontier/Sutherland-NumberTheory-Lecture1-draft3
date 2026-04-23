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

/-- A nonnegative real fixed by a power `> 1` is `0` or `1`. -/
theorem eq_zero_or_one_of_nonneg_of_pow_eq_self {x : ℝ} {n : ℕ} (hx : 0 ≤ x)
    (hn : 1 < n) (hpow : x ^ n = x) : x = 0 ∨ x = 1 := by
  by_cases hx0 : x = 0
  · exact Or.inl hx0
  · right
    rcases n with _ | _ | m
    · omega
    · omega
    · have hmul : x ^ (m + 1) * x = 1 * x := by
        simpa [pow_succ, mul_assoc] using hpow
      have hpow' : x ^ (m + 1) = 1 := mul_right_cancel₀ hx0 hmul
      exact (pow_eq_one_iff_of_nonneg hx (Nat.succ_ne_zero m)).1 hpow'

/-- In positive characteristic, Frobenius fixes every natural-number scalar. -/
theorem natCast_absoluteValue_pow_char (abv : AbsoluteValue k ℝ) {p : ℕ}
    [Fact p.Prime] [CharP k p] (n : ℕ) :
    abv n ^ p = abv n := by
  have hpow : (n : k) ^ p = (n : k) := by
    change frobenius k p (n : k) = (n : k)
    exact map_natCast (frobenius k p) n
  simpa only [map_pow] using congrArg abv hpow

/-- In a field of positive characteristic, every absolute value is nonarchimedean. -/
theorem absoluteValue_isNonarchimedean_of_pos_char (abv : AbsoluteValue k ℝ) {p : ℕ}
    [Fact p.Prime] [CharP k p] :
    IsNonarchimedean abv := by
  refine (isNonarchimedean_iff_natCast_pos_le_one abv).2 ?_
  intro n hn
  have hpow : abv n ^ p = abv n := natCast_absoluteValue_pow_char abv (p := p) n
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain hzero | hone :=
    eq_zero_or_one_of_nonneg_of_pow_eq_self (x := abv n) (abv.nonneg n) hp hpow
  · simp [hzero]
  · simp [hone]

end Corollary_01_05_PositiveCharacteristic

section Corollary_01_05_FiniteField

variable {k : Type*} [Field k] [Finite k]

/-- Any absolute value on a finite field takes value `1` on nonzero elements. -/
theorem absoluteValue_eq_one_of_ne_zero (abv : AbsoluteValue k ℝ) {x : k} (hx : x ≠ 0) :
    abv x = 1 := by
  letI := Fintype.ofFinite k
  have hpow : abv x ^ (Fintype.card k - 1) = 1 := by
    simpa only [map_pow, map_one] using congrArg abv (FiniteField.pow_card_sub_one_eq_one x hx)
  exact (pow_eq_one_iff_of_nonneg (abv.nonneg x) (Nat.sub_ne_zero_of_lt Fintype.one_lt_card)).1 hpow

/-- The only absolute value on a finite field is the trivial one. -/
theorem absoluteValue_eq_trivial_of_finite [DecidableEq k] (abv : AbsoluteValue k ℝ) :
    abv = AbsoluteValue.trivial := by
  ext x
  by_cases hx : x = 0
  · simp [hx]
  · simp [absoluteValue_eq_one_of_ne_zero abv hx, AbsoluteValue.trivial_apply, hx]

end Corollary_01_05_FiniteField

end Chapter1
end SutherlandNumberTheoryLecture1
