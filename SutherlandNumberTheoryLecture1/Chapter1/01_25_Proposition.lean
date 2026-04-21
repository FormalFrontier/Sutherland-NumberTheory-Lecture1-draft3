import SutherlandNumberTheoryLecture1.Chapter1.«01_11_Definition»
import SutherlandNumberTheoryLecture1.Chapter1.«01_19_Definition»

/-!
# Proposition 1.25: valuation rings are integrally closed

The lecture's proposition states that every valuation ring is integrally closed.
Mathlib already packages valuation rings via `ValuationRing A`, together with the
fraction-field dichotomy `ValuationRing.iff_isInteger_or_isInteger`. The
integrally closed conclusion itself is available through the existing instance
chain for valuation rings, so this file records the textbook statement as an
explicit theorem while keeping the valuation-ring criterion visible.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proposition_01_25

variable {A K : Type*} [CommRing A] [IsDomain A] [Field K] [Algebra A K] [IsFractionRing A K]

/-- The defining valuation-ring dichotomy from Definition 1.11, specialized for later use. -/
theorem valuationRing_integer_or_inv_integer [ValuationRing A] (x : K) :
    IsLocalization.IsInteger A x ∨ IsLocalization.IsInteger A x⁻¹ :=
  (valuationRing_iff_forall_isInteger_or_isInteger_inv (A := A) (k := K)).mp inferInstance x

/-- Proposition 1.25: every valuation ring is integrally closed. -/
theorem valuationRing_isIntegrallyClosed [ValuationRing A] : IsIntegrallyClosed A := by
  infer_instance

end Proposition_01_25

end Chapter1
end SutherlandNumberTheoryLecture1
