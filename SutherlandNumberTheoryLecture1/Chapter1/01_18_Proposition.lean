import Mathlib

/-!
# Proposition 1.18: Integral elements are closed under addition and multiplication

The lecture proves that if `α, β : B` are integral over the base ring `A`, then
so are `α + β` and `α * β`. Mathlib already packages these exact closure facts
as `IsIntegral.add` and `IsIntegral.mul`, so the formalization records the
proposition directly against that existing API rather than reproducing the
textbook proof line by line.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proposition_01_18

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- If `α` and `β` are integral over `A`, then `α + β` is integral over `A`. -/
theorem integral_add {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α + β) :=
  IsIntegral.add (R := A) (A := B) hα hβ

/-- If `α` and `β` are integral over `A`, then `α * β` is integral over `A`. -/
theorem integral_mul {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α * β) :=
  IsIntegral.mul (R := A) (A := B) hα hβ

end Proposition_01_18

end Chapter1
end SutherlandNumberTheoryLecture1
