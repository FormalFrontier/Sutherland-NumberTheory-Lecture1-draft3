import Mathlib

/-!
# Definition 1.12: Local rings

The lecture defines a local ring as a commutative ring with a unique maximal
ideal. Mathlib packages that condition as the predicate `IsLocalRing`, and the
distinguished maximal ideal is available as `IsLocalRing.maximalIdeal`.
-/

recall IsLocalRing (R : Type*) [Semiring R] : Prop
recall IsLocalRing.maximalIdeal (R : Type*) [CommSemiring R] [IsLocalRing R] : Ideal R

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_12

variable {R : Type*} [CommRing R]

/-- Definition 1.12's unique-maximal-ideal condition is exactly `IsLocalRing`. -/
theorem localRing_iff_existsUnique_maximalIdeal :
    IsLocalRing R ↔ ∃! I : Ideal R, I.IsMaximal := by
  constructor
  · intro h
    letI : IsLocalRing R := h
    simpa using IsLocalRing.maximal_ideal_unique R
  · intro h
    exact IsLocalRing.of_unique_max_ideal h

/-- In a local ring, Mathlib's `maximalIdeal` is the lecture's distinguished maximal ideal. -/
theorem maximalIdeal_isMaximal [IsLocalRing R] :
    (IsLocalRing.maximalIdeal R).IsMaximal :=
  inferInstance

end Definition_01_12

end Chapter1
end SutherlandNumberTheoryLecture1
