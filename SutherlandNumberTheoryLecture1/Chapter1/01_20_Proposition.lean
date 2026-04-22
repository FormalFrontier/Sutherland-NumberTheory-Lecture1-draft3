import Mathlib.RingTheory.Algebraic.Integral

/-!
# Proposition 1.20: Integrality is transitive in towers

The lecture's proposition says that if `C / B / A` is a tower of ring extensions
with `B` integral over `A` and `C` integral over `B`, then `C` is integral over
`A`. Mathlib already packages this extension-level transitivity statement as
`Algebra.IsIntegral.trans`, so the file is just a direct wrapper around the
bundled theorem.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proposition_01_20

variable {A B C : Type*} [CommRing A] [CommRing B] [CommRing C]
variable [Algebra A B] [Algebra B C] [Algebra A C] [IsScalarTower A B C]

/-- Proposition 1.20: integrality is transitive in a tower `C / B / A`. -/
theorem integral_extension_trans [Algebra.IsIntegral A B] [Algebra.IsIntegral B C] :
    Algebra.IsIntegral A C :=
  Algebra.IsIntegral.trans B

end Proposition_01_20

end Chapter1
end SutherlandNumberTheoryLecture1
