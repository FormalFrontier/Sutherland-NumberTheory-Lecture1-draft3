import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_02_Definition»

/-!
# Lemma 1.4: A criterion for nonarchimedean absolute values

The lecture characterizes the nonarchimedean property of an absolute value on a
field `k` by bounding the values of the natural-number sums `1 + ⋯ + 1`.
Mathlib already provides the forward implication: a nonarchimedean absolute
value satisfies `|n| ≤ 1` for every natural number `n`. This file records the
full iff statement from the lecture and isolates the converse as the remaining
book-level bridge lemma.
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

/-- The converse direction is the book-specific bridge deferred to the proof stage. -/
theorem isNonarchimedean_of_natCast_le_one (abv : AbsoluteValue k ℝ)
    (h_nat : ∀ n : ℕ, abv n ≤ 1) :
    IsNonarchimedean abv := by
  sorry

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
