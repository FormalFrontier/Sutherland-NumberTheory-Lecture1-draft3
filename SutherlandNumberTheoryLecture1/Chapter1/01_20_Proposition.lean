import SutherlandNumberTheoryLecture1.Chapter1.«01_17_Definition»

/-!
# Proposition 1.20: Integrality is transitive in towers

The lecture's proposition says that if `C / B / A` is a tower of ring extensions with
`B` integral over `A` and `C` integral over `B`, then `C` is integral over `A`.
Mathlib packages the element-level transitivity statement as `isIntegral_trans`, so
the extension-level proposition is a direct pointwise application of that theorem.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proposition_01_20

variable {A B C : Type*} [CommRing A] [CommRing B] [Ring C]
variable [Algebra A B] [Algebra B C] [Algebra A C] [IsScalarTower A B C]

/-- Proposition 1.20: integrality is transitive in a tower `C / B / A`. -/
theorem integralExtension_trans [Algebra.IsIntegral A B] [Algebra.IsIntegral B C] :
    Algebra.IsIntegral A C := by
  rw [Algebra.isIntegral_def]
  intro c
  exact isIntegral_trans c (Algebra.IsIntegral.isIntegral (R := B) c)

end Proposition_01_20

end Chapter1
end SutherlandNumberTheoryLecture1
