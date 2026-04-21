import Mathlib.Algebra.GCDMonoid.IntegrallyClosed
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.RingTheory.Valuation.ValuationRing

/-!
# Proof of Proposition 1.25

The lecture proves that a valuation ring is integrally closed by contradiction:
an element of the fraction field that is integral over the ring must already lie
in the ring. Mathlib already packages both the witness-extraction step as
`IsIntegrallyClosed.algebraMap_eq_of_integral` and the valuation-ring conclusion
through typeclass search, so this proof blob cites those declarations directly.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_25

variable {A K : Type*} [CommRing A] [IsDomain A] [Field K] [Algebra A K] [IsFractionRing A K]

/-- The lecture's contradiction step: an element of the fraction field that is
integral over a valuation ring already comes from the ring. -/
theorem proof_integral_element_mem [ValuationRing A] {x : K} (hx : IsIntegral A x) :
    ∃ a : A, algebraMap A K a = x := by
  simpa using
    (IsIntegrallyClosed.algebraMap_eq_of_integral (R := A) (K := K) hx)

/-- The proof blob's final conclusion: every valuation ring is integrally closed. -/
theorem proof_valuationRing_isIntegrallyClosed [ValuationRing A] : IsIntegrallyClosed A := by
  infer_instance

end Proof_01_25

end Chapter1
end SutherlandNumberTheoryLecture1
