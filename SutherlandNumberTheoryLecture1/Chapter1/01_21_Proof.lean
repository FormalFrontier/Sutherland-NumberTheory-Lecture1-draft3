import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_21_Corollary»

/-!
# Proof of Corollary 1.21

The lecture proves Corollary 1.21 by taking the integral closure `A'` of `A`
in `B`, then the integral closure `A''` of `A'` in `B`, and observing that the
second closure collapses back to `A'`. Mathlib packages that idempotence as
`integralClosure_idem`, whose proof uses the same transitivity-of-integrality
step as the textbook. The final "hence integrally closed" conclusion is exactly
`IsIntegrallyClosedIn.of_isIntegralClosure`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_21

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- The nested integral closure `A''` from the lecture is equal to `A'` in bundled form. -/
theorem integralClosure_idempotent_in_ambient :
    integralClosure (integralClosure A B) B = ⊥ := by
  simpa using (integralClosure_idem (R := A) (A := B))

/-- Repackaging the textbook conclusion: the integral closure of `A` in `B` is integrally
closed in `B`. -/
theorem integralClosure_isIntegrallyClosedIn_from_proof :
    IsIntegrallyClosedIn (integralClosure A B) B := by
  simpa using
    (IsIntegrallyClosedIn.of_isIntegralClosure
      (R := A) (A := integralClosure A B) (B := B))

end Proof_01_21

end Chapter1
end SutherlandNumberTheoryLecture1
