import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_04_Lemma»
import SutherlandNumberTheoryLecture1.Chapter1.«01_05_Corollary»

/-!
# Proof of Corollary 1.5

The lecture proves Corollary 1.5 by combining the Frobenius identities from
positive characteristic and finite fields with the preceding nonarchimedean
criterion from Lemma 1.4. This file isolates those proof-blob steps as explicit
Lean declarations so the argument is visible in the formalization pipeline.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_05

variable {k : Type*} [Field k]

/-- A nonnegative real fixed by a positive power is forced to be `0` or `1`. -/
theorem eq_zero_or_one_of_nonneg_of_pow_eq_self {x : ℝ} {n : ℕ} (hx : 0 ≤ x) (hn : 1 < n)
    (hpow : x ^ n = x) : x = 0 ∨ x = 1 := by
  sorry

section PositiveCharacteristic

variable (abv : AbsoluteValue k ℝ)

/-- The Frobenius identity in positive characteristic forces the natural-number
values of an absolute value to lie in `{0, 1}`. -/
theorem natCast_absoluteValue_eq_zero_or_one (p : ℕ) [Fact p.Prime] [CharP k p] (n : ℕ) :
    abv n = 0 ∨ abv n = 1 := by
  have hpow : abv n ^ p = abv n := natCast_absoluteValue_pow_char abv (p := p) n
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  exact eq_zero_or_one_of_nonneg_of_pow_eq_self (x := abv n) (abv.nonneg n)
    hp hpow

/-- This is the proof-blob route from Frobenius to Lemma 1.4's criterion. -/
theorem positiveCharacteristic_nonarchimedean_proof (p : ℕ) [Fact p.Prime] [CharP k p] :
    IsNonarchimedean abv := by
  exact absoluteValue_isNonarchimedean_of_pos_char abv (p := p)

end PositiveCharacteristic

section FiniteField

variable [Finite k] (abv : AbsoluteValue k ℝ)

/-- The finite-field Frobenius identity implies that every absolute value is
`0` or `1` on each element. -/
theorem absoluteValue_eq_zero_or_one (x : k) :
    abv x = 0 ∨ abv x = 1 := by
  letI := Fintype.ofFinite k
  by_cases hx : x = 0
  · left
    simp [hx]
  · have hpow : abv x ^ Fintype.card k = abv x := by
      simpa only [map_pow] using congrArg abv (FiniteField.pow_card x)
    exact eq_zero_or_one_of_nonneg_of_pow_eq_self (x := abv x) (n := Fintype.card k) (abv.nonneg x)
      Fintype.one_lt_card hpow

/-- The proof blob concludes by identifying the finite-field absolute value with
the trivial absolute value. -/
theorem finiteField_absoluteValue_eq_trivial [DecidableEq k] :
    abv = AbsoluteValue.trivial := by
  exact absoluteValue_eq_trivial_of_finite abv

end FiniteField

end Proof_01_05

end Chapter1
end SutherlandNumberTheoryLecture1
