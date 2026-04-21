import Mathlib

/-!
# Corollary 1.21: The integral closure is integrally closed

For a ring extension `B / A`, the lecture observes that the integral closure of
`A` in `B` is itself integrally closed in `B`. Mathlib already packages the
integral closure as `integralClosure A B` and proves the corresponding ambient
integrally-closed statement via `IsIntegrallyClosedIn.of_isIntegralClosure`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Corollary_01_21

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- Corollary 1.21: the integral closure of `A` in `B` is integrally closed in `B`. -/
theorem integralClosure_isIntegrallyClosedIn :
    IsIntegrallyClosedIn (integralClosure A B) B := by
  simpa using
    (IsIntegrallyClosedIn.of_isIntegralClosure
      (R := A) (A := integralClosure A B) (B := B))

end Corollary_01_21

end Chapter1
end SutherlandNumberTheoryLecture1
