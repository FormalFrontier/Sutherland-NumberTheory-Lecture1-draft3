import Mathlib

/-!
# Definition 1.17: Integral elements and integral extensions

The lecture defines an element `b : B` to be integral over the base ring `A` when
it is a root of a monic polynomial in `A[X]`. Mathlib packages exactly this notion
as `IsIntegral A b`.

The lecture then says that the extension `B` is integral over `A` when every
element of `B` is integral over `A`. Mathlib packages that quantification as the
typeclass `Algebra.IsIntegral A B`.
-/

recall IsIntegral (R A : Type*) [CommRing R] [Ring A] [Algebra R A] : A → Prop

recall Algebra.IsIntegral (R A : Type*) [CommRing R] [Ring A] [Algebra R A] : Prop

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_17

variable {A B : Type*} [CommRing A] [Ring B] [Algebra A B]

/-- Definition 1.17's element-level notion is exactly Mathlib's predicate `IsIntegral`. -/
theorem integral_element_iff (b : B) :
    IsIntegral A b ↔ ∃ p : Polynomial A, Polynomial.Monic p ∧ Polynomial.aeval b p = 0 :=
  Iff.rfl

/-- The lecture's "the extension `B` is integral over `A`" is `Algebra.IsIntegral A B`. -/
theorem integral_extension_iff :
    Algebra.IsIntegral A B ↔ ∀ b : B, IsIntegral A b :=
  Algebra.isIntegral_def

end Definition_01_17

end Chapter1
end SutherlandNumberTheoryLecture1
