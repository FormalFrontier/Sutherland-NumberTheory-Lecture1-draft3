import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_19_Definition»

/-!
# Proposition 1.22: `ℤ` is integrally closed

The lecture's proposition states that the integers form an integrally closed
domain. Mathlib already packages this through the standard instance chain from
unique factorization domains to integrally closed domains, so the scaffold can
record the claim directly as `IsIntegrallyClosed ℤ` instead of replaying the
lecture's rational-root argument.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proposition_01_22

/-- Proposition 1.22: the ring of integers is integrally closed. -/
theorem integers_isIntegrallyClosed : IsIntegrallyClosed ℤ :=
  inferInstance

end Proposition_01_22

end Chapter1
end SutherlandNumberTheoryLecture1
