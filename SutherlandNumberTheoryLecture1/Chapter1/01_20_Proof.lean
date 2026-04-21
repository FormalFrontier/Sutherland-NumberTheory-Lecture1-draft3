import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_20_Proposition»

/-!
# Proof of Proposition 1.20

The lecture's proof is the standard elementwise transitivity argument for
integrality in a tower `C / B / A`. Mathlib already packages the key step as
`isIntegral_trans`, so this module records that proof blob as explicit Lean
declarations on top of `Chapter1/01_20_Proposition`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_20

variable {A B C : Type*} [CommRing A] [CommRing B] [CommRing C]
variable [Algebra A B] [Algebra B C] [Algebra A C] [IsScalarTower A B C]

/-- The proof blob's core step is the elementwise tower-transitivity of integrality. -/
theorem isIntegral_of_isIntegral_tower [Algebra.IsIntegral A B] [Algebra.IsIntegral B C]
    (c : C) : IsIntegral A c := by
  exact isIntegral_trans c (Algebra.IsIntegral.isIntegral (R := B) c)

/-- Repackaging the elementwise argument recovers Proposition 1.20. -/
theorem integral_extension_trans_from_proof [Algebra.IsIntegral A B] [Algebra.IsIntegral B C] :
    Algebra.IsIntegral A C :=
  integral_extension_trans (A := A) (B := B) (C := C)

end Proof_01_20

end Chapter1
end SutherlandNumberTheoryLecture1
