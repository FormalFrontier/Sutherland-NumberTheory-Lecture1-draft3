import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
# Proof of Corollary 1.21

The lecture proves Corollary 1.21 by taking the integral closure `A'` of `A`
in `B`, then the integral closure `A''` of `A'` in `B`, and observing that the
second closure collapses back to `A'`. This file records that textbook route:
we convert Mathlib's bundled idempotence theorem `integralClosure_idem` into
the claimed integrally-closed conclusion via `integralClosure_eq_bot_iff`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_21

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- Corollary 1.21, proved via the lecture's nested-integral-closure argument. -/
theorem integralClosure_isIntegrallyClosedIn_via_idempotence :
    IsIntegrallyClosedIn (integralClosure A B) B := by
  refine
    (IsIntegrallyClosedIn.integralClosure_eq_bot_iff (R := integralClosure A B) (A := B)
      (hRA := fun x y h => Subtype.ext h)).mp ?_
  simpa using integralClosure_idem (R := A) (A := B)

end Proof_01_21

end Chapter1
end SutherlandNumberTheoryLecture1
