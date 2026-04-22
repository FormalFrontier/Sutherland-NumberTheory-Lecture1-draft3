import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
# Corollary 1.21: The integral closure is integrally closed

For a ring extension `B / A`, the lecture observes that the integral closure of
`A` in `B` is itself integrally closed in `B`. Mathlib packages this corollary
directly as an instance on `integralClosure A B`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Corollary_01_21

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- Corollary 1.21: the integral closure of `A` in `B` is integrally closed in `B`. -/
theorem integralClosure_isIntegrallyClosedIn :
    IsIntegrallyClosedIn (integralClosure A B) B :=
  inferInstance

end Corollary_01_21

end Chapter1
end SutherlandNumberTheoryLecture1
