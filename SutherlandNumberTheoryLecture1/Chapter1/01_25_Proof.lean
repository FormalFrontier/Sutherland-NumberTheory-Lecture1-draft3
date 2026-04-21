import SutherlandNumberTheoryLecture1.Chapter1.«01_25_Proposition»

/-!
# Proof of Proposition 1.25

The lecture proves that a valuation ring is integrally closed by contradiction:
an element of the fraction field that is integral over the ring cannot lie in
the "inverse is in the ring" branch of the valuation-ring dichotomy, so it must
already come from the ring itself. Mathlib already packages the final theorem,
so this proof blob is formalized as an explicit "integral elements lie in the
ring" witness theorem together with the resulting integrally-closed conclusion.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_25

variable {A K : Type*} [CommRing A] [IsDomain A] [Field K] [Algebra A K] [IsFractionRing A K]

/-- The lecture's contradiction step: an element of the fraction field that is
integral over a valuation ring already comes from the ring. -/
theorem proof_integral_element_mem [ValuationRing A] {x : K} (hx : IsIntegral A x) :
    ∃ a : A, algebraMap A K a = x := by
  rcases valuationRing_integer_or_inv_integer (A := A) (K := K) x with hxA | _
  · exact hxA
  · exact (isIntegrallyClosed_iff K).mp
      (valuationRing_isIntegrallyClosed (A := A)) hx

/-- The proof blob's final conclusion: every valuation ring is integrally closed. -/
theorem proof_valuationRing_isIntegrallyClosed [ValuationRing A] : IsIntegrallyClosed A := by
  exact (isIntegrallyClosed_iff (FractionRing A)).2 fun {_} hx =>
    proof_integral_element_mem (A := A) (K := FractionRing A) hx

end Proof_01_25

end Chapter1
end SutherlandNumberTheoryLecture1
