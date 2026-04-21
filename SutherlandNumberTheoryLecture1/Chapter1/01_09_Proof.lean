import SutherlandNumberTheoryLecture1.Chapter1.«01_09_Theorem»

/-!
# Proof of Theorem 1.9

The lecture sends the proof of the product formula to Problem Set 1. This module
keeps that proof blob visible in Stage 3.1 by packaging the deferred obligations
from `Chapter1/01_09_Theorem` as named declarations, rather than leaving the
blob as a citation-only note.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_09

open scoped BigOperators

/-- Problem Set 1 proves that finite places outside the rational prime support are trivial. -/
theorem problemSet1_padicAbsoluteValue_eq_one_of_not_mem_rationalPrimeSupport {x : ℚ} {p : ℕ}
    [Fact p.Prime] (hx : x ≠ 0) (hp : p ∉ rationalPrimeSupport x) :
    Rat.AbsoluteValue.padic p x = 1 :=
  padicAbsoluteValue_eq_one_of_not_mem_rationalPrimeSupport hx hp

/-- Problem Set 1 supplies the finite-support product formula used in the lecture. -/
theorem problemSet1_product_formula {x : ℚ} (hx : x ≠ 0) :
    Rat.AbsoluteValue.real x * ∏ p : rationalPrimeSupport x, Rat.AbsoluteValue.padic p.1 x = 1 :=
  product_formula hx

end Proof_01_09

end Chapter1
end SutherlandNumberTheoryLecture1
