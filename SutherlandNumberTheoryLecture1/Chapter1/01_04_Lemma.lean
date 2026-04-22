import SutherlandNumberTheoryLecture1.Chapter1.«01_02_Definition»

/-!
# Lemma 1.4: A criterion for nonarchimedean absolute values

The lecture characterizes the nonarchimedean property of an absolute value on a
field `k` by bounding the values of the natural-number sums `1 + ⋯ + 1`.
Mathlib already provides the forward implication: a nonarchimedean absolute
value satisfies `|n| ≤ 1` for every natural number `n`. This file packages that
estimate together with the converse bridge lemma to record the lecture's full
iff criterion.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Lemma_01_04

variable {k : Type*} [Field k]

/-- The easy direction of Lemma 1.4 is Mathlib's natural-number estimate. -/
theorem natCast_le_one_of_isNonarchimedean (abv : AbsoluteValue k ℝ)
    (hna : IsNonarchimedean abv) :
    ∀ n : ℕ, abv n ≤ 1 := by
  intro n
  simpa using IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean (f := abv) hna (n := n)

/-- The book phrases the natural-number bound for positive integers `n ≥ 1`. -/
theorem natCast_pos_le_one_of_isNonarchimedean (abv : AbsoluteValue k ℝ)
    (hna : IsNonarchimedean abv) :
    ∀ n : ℕ, 0 < n → abv n ≤ 1 := by
  intro n hn
  exact natCast_le_one_of_isNonarchimedean abv hna n

/-- The converse direction is the book-specific bridge deferred to the proof stage. -/
theorem isNonarchimedean_of_natCast_le_one (abv : AbsoluteValue k ℝ)
    (h_nat : ∀ n : ℕ, abv n ≤ 1) :
    IsNonarchimedean abv := by
  letI : NormedField k := abv.toNormedField
  letI : IsUltrametricDist k :=
    IsUltrametricDist.isUltrametricDist_of_forall_norm_natCast_le_one (R := k) <| by
      simpa using h_nat
  change IsNonarchimedean (‖·‖ : k → ℝ)
  simpa using (IsUltrametricDist.isNonarchimedean_norm (R := k))

/-- Lemma 1.4 in the lecture's original `n ≥ 1` form. -/
theorem isNonarchimedean_iff_natCast_pos_le_one (abv : AbsoluteValue k ℝ) :
    IsNonarchimedean abv ↔ ∀ n : ℕ, 0 < n → abv n ≤ 1 := by
  constructor
  · exact natCast_pos_le_one_of_isNonarchimedean abv
  · intro h_pos
    apply isNonarchimedean_of_natCast_le_one
    intro n
    cases n with
    | zero =>
        simpa only [Nat.cast_zero, map_zero] using (show (0 : ℝ) ≤ 1 by norm_num)
    | succ m =>
        exact h_pos (Nat.succ m) (Nat.succ_pos m)

/-- Lemma 1.4: an absolute value is nonarchimedean iff
all natural-number sums have value at most `1`. -/
theorem isNonarchimedean_iff_natCast_le_one (abv : AbsoluteValue k ℝ) :
    IsNonarchimedean abv ↔ ∀ n : ℕ, abv n ≤ 1 := by
  constructor
  · exact natCast_le_one_of_isNonarchimedean abv
  · exact isNonarchimedean_of_natCast_le_one abv

end Lemma_01_04

end Chapter1
end SutherlandNumberTheoryLecture1
