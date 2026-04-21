import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
# Proof of Corollary 1.21

The lecture proves Corollary 1.21 by taking the integral closure `A'` of `A`
in `B`, then the integral closure `A''` of `A'` in `B`, and observing that the
second closure collapses back to `A'`. Mathlib packages that idempotence as
`integralClosure_idem`, whose proof uses the same transitivity-of-integrality
step as the textbook. The corollary file cites Mathlib's ambient
integrally-closed theorem directly, so this proof blob only retains the
intermediate idempotence statement that mirrors the lecture's argument.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_21

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- The nested integral closure `A''` from the lecture is equal to `A'` in bundled form. -/
theorem integralClosure_idempotent_in_ambient :
    integralClosure (integralClosure A B) B = ⊥ := by
  simpa using integralClosure_idem (R := A) (A := B)

end Proof_01_21

end Chapter1
end SutherlandNumberTheoryLecture1
