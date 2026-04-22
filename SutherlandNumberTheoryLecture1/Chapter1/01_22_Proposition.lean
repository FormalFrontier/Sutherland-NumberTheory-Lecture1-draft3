import Mathlib

/-!
# Proposition 1.22: `ℤ` is integrally closed

The lecture records that the integers form an integrally closed domain.
Mathlib already exposes this through the standard instance chain, so the
formalization can state the claim directly as `IsIntegrallyClosed ℤ`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proposition_01_22

/-- Proposition 1.22: `ℤ` is an integrally closed domain. -/
theorem integers_isIntegrallyClosed : IsIntegrallyClosed ℤ :=
  inferInstance

end Proposition_01_22

end Chapter1
end SutherlandNumberTheoryLecture1
