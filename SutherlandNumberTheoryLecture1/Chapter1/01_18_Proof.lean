import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_18_Proposition»

/-!
# Proof of Proposition 1.18

The lecture proves closure of integral elements under addition and
multiplication by reducing to a universal quotient and then constructing the
annihilating polynomials from the roots of the input monic polynomials. Mathlib
already provides the same conclusions abstractly, so this proof blob is
formalized as explicit Lean declarations citing the established closure lemmas
rather than reconstructing the symmetric-polynomial argument.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_18

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- The proof blob's sum claim is discharged by the previously scaffolded proposition. -/
theorem proof_integral_add {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α + β) := by
  exact integral_add hα hβ

/-- The proof blob's product claim is discharged by the previously scaffolded proposition. -/
theorem proof_integral_mul {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α * β) := by
  exact integral_mul hα hβ

end Proof_01_18

end Chapter1
end SutherlandNumberTheoryLecture1
