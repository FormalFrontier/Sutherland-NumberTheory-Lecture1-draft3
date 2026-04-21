import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_07_Definition»

/-!
# Theorem 1.9: The product formula

For a nonzero rational number `x`, the lecture's product formula is

`|x|_∞ * ∏_p |x|_p = 1`.

To keep the Stage 3.1 statement explicit while avoiding premature proof
infrastructure, this file packages the finite set of relevant primes as the
union of the prime factors of `x.num.natAbs` and `x.den`. Every finite place
outside this support should eventually contribute the trivial factor `1`, so the
book's infinite Euler product is represented here by a finite product over the
nontrivial places.
-/

open scoped BigOperators

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Theorem_01_09

/-- The finite places where a rational number can have a nontrivial `p`-adic factor. -/
def rationalPrimeSupport (x : ℚ) : Finset ℕ :=
  x.num.natAbs.primeFactors ∪ x.den.primeFactors

instance instFactPrimeRationalPrimeSupport (x : ℚ) (p : rationalPrimeSupport x) :
    Fact p.1.Prime := by
  refine ⟨?_⟩
  rcases Finset.mem_union.mp p.2 with hp | hp
  · exact Nat.prime_of_mem_primeFactors hp
  · exact Nat.prime_of_mem_primeFactors hp

/-- Outside the numerator/denominator support, the `p`-adic factor should be trivial. -/
theorem padicAbsoluteValue_eq_one_of_not_mem_rationalPrimeSupport {x : ℚ} {p : ℕ}
    [Fact p.Prime] (hx : x ≠ 0) (hp : p ∉ rationalPrimeSupport x) :
    Rat.AbsoluteValue.padic p x = 1 := by
  sorry

/-- The lecture's product formula for nonzero rational numbers. -/
theorem product_formula {x : ℚ} (hx : x ≠ 0) :
    Rat.AbsoluteValue.real x * ∏ p : rationalPrimeSupport x, Rat.AbsoluteValue.padic p.1 x = 1 := by
  sorry

end Theorem_01_09

end Chapter1
end SutherlandNumberTheoryLecture1
