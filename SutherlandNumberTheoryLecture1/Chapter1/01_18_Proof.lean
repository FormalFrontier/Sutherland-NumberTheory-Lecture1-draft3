import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

/-!
# Proof of Proposition 1.18

The lecture proves closure of integral elements under addition and
multiplication by reducing to a universal quotient and then constructing the
annihilating polynomials from the roots of the input monic polynomials. Mathlib
already provides the same conclusions abstractly as `IsIntegral.add` and
`IsIntegral.mul`, so this proof blob cites those declarations directly rather
than routing through an extra project-local wrapper layer.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_18

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- The proof blob's sum claim is Mathlib's closure of integral elements under addition. -/
theorem proof_integral_add {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α + β) := by
  simpa using IsIntegral.add (R := A) (A := B) hα hβ

/-- The proof blob's product claim is Mathlib's closure of integral elements under multiplication. -/
theorem proof_integral_mul {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α * β) := by
  simpa using IsIntegral.mul (R := A) (A := B) hα hβ

end Proof_01_18

end Chapter1
end SutherlandNumberTheoryLecture1
