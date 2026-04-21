import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_12_Definition»

/-!
# Definition 1.13: Residue fields

The lecture defines the residue field of a local ring `A` with maximal ideal
`\mathfrak m` to be the quotient field `A / \mathfrak m`. Mathlib already
bundles exactly this construction as `IsLocalRing.ResidueField A`, together
with the canonical quotient map `IsLocalRing.residue A`.
-/

recall IsLocalRing.ResidueField (R : Type*) [CommRing R] [IsLocalRing R] : Type _
recall IsLocalRing.residue (R : Type*) [CommRing R] [IsLocalRing R] :
    R →+* IsLocalRing.ResidueField R

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_13

variable (A : Type*) [CommRing A] [IsLocalRing A]

/-- Definition 1.13's residue field is the quotient by the local ring's maximal ideal. -/
theorem residueField_eq_quotient :
    IsLocalRing.ResidueField A = (A ⧸ IsLocalRing.maximalIdeal A) :=
  rfl

/-- The accompanying quotient map is Mathlib's bundled residue map. -/
theorem residue_eq_idealQuotient_mk :
    IsLocalRing.residue A = Ideal.Quotient.mk (IsLocalRing.maximalIdeal A) :=
  rfl

end Definition_01_13

end Chapter1
end SutherlandNumberTheoryLecture1
