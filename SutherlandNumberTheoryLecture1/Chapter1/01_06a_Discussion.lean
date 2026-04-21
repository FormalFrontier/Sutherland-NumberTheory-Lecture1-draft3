import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_06_Definition»

open scoped BigOperators

/-!
# Discussion 1.6a: The archimedean place and signed prime factorization on `ℚ`

This prose blob isolates two concrete pieces of mathematics that the lecture uses
before introducing the `p`-adic places:

- the usual absolute value on `ℚ`, denoted `|·|_∞`, coming from the real place;
- the unique expansion of a nonzero rational as a sign times finitely many prime
  powers with integer exponents.

The broader discussion about completions and local fields is intentionally left
for later files in the Chapter 1 valuation pipeline.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Discussion_01_06a

/-- The lecture's archimedean absolute value `|·|_∞` on `ℚ` is Mathlib's real place. -/
abbrev ratArchimedeanAbsoluteValue : AbsoluteValue ℚ ℝ :=
  Rat.AbsoluteValue.real

/-- The real place acts by the usual absolute value on rational numbers. -/
theorem ratArchimedeanAbsoluteValue_apply (q : ℚ) :
    ratArchimedeanAbsoluteValue q = |q| := by
  change Rat.AbsoluteValue.real q = |q|
  exact Rat.AbsoluteValue.real_eq_abs q

/-- The lecture emphasizes that the real place is archimedean, i.e. not nonarchimedean. -/
theorem ratArchimedeanAbsoluteValue_not_isNonarchimedean :
    ¬ IsNonarchimedean ratArchimedeanAbsoluteValue := by
  sorry

/-- Every nonzero rational has a unique signed prime-power expansion with finite support. -/
theorem existsUnique_signed_primeFactorization (q : ℚˣ) :
    ∃! data : ℤˣ × (ℕ →₀ ℤ),
      (∀ n ∈ data.2.support, Nat.Prime n) ∧
      (((data.1 : ℤ) : ℚ) * data.2.prod (fun p e => (p : ℚ) ^ e) = (q : ℚ)) := by
  sorry

end Discussion_01_06a

end Chapter1
end SutherlandNumberTheoryLecture1
