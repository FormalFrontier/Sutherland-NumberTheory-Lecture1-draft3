import SutherlandNumberTheoryLecture1.Chapter1.«01_22_Proposition»

/-!
# Corollary 1.23: unique factorization domains and PIDs are integrally closed

The lecture records the standard corollary that every unique factorization
domain is integrally closed, hence every principal ideal domain is integrally
closed as well. Mathlib already packages the UFD statement in the instance
chain culminating in `UniqueFactorizationMonoid.instIsIntegrallyClosed`, so the
PID clause is a one-line specialization of the same infrastructure.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Corollary_01_23

variable {R : Type*} [CommRing R] [IsDomain R]

/-- Corollary 1.23: every unique factorization domain is integrally closed. -/
theorem ufd_isIntegrallyClosed [UniqueFactorizationMonoid R] : IsIntegrallyClosed R :=
  UniqueFactorizationMonoid.instIsIntegrallyClosed

/-- Corollary 1.23: every principal ideal domain is integrally closed. -/
theorem pid_isIntegrallyClosed [IsPrincipalIdealRing R] : IsIntegrallyClosed R := by
  infer_instance

end Corollary_01_23

end Chapter1
end SutherlandNumberTheoryLecture1
