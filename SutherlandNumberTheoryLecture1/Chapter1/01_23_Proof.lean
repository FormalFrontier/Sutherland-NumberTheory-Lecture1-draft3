import SutherlandNumberTheoryLecture1.Chapter1.«01_23_Corollary»

/-!
# Proof of Corollary 1.23

The lecture says that the proof of Proposition 1.22 works for any unique
factorization domain. In Mathlib that generalization is already bundled as the
instance `UniqueFactorizationMonoid.instIsIntegrallyClosed`, exposed in the
preceding corollary scaffold. This proof blob records the textbook sentence as
an explicit theorem that reuses that packaged UFD-level result.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_23

variable {R : Type*} [CommRing R] [IsDomain R] [UniqueFactorizationMonoid R]

/-- The lecture's "same proof works for any UFD" sentence, discharged by the
previous corollary scaffold. -/
theorem proof_ufd_isIntegrallyClosed : IsIntegrallyClosed R := by
  exact ufd_isIntegrallyClosed

end Proof_01_23

end Chapter1
end SutherlandNumberTheoryLecture1
