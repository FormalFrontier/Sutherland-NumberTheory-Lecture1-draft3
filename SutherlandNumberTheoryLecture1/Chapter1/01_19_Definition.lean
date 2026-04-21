import Mathlib

/-!
# Definition 1.19: Integral closure and integrally closed domains

The lecture defines the integral closure of a base ring `A` inside an ambient
extension `B` as the set of elements of `B` that are integral over `A`. Mathlib
packages this object directly as the subalgebra `integralClosure A B`.

The accompanying property "A is integrally closed in B" is likewise already
bundled in Mathlib as `IsIntegrallyClosedIn A B`, and for a domain the special
case in its fraction field is the predicate `IsIntegrallyClosed A`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_19

variable {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]

/-- Definition 1.19's ambient-extension construction is the bundled integral closure. -/
theorem integralClosure_isIntegralClosure :
    IsIntegralClosure (integralClosure A B) A B :=
  integralClosure.isIntegralClosure A B

/-- Definition 1.19's ambient-extension object is Mathlib's `integralClosure A B`. -/
theorem mem_integralClosure_iff_isIntegral {b : B} :
    b ∈ integralClosure A B ↔ IsIntegral A b := by
  rw [mem_integralClosure_iff]

/-- The lecture's equality `\widetilde A = A` is `integralClosure A B = ⊥` in bundled form. -/
theorem integralClosure_eq_bot_iff_isIntegrallyClosedIn
    (hAB : Function.Injective (algebraMap A B)) :
    integralClosure A B = ⊥ ↔ IsIntegrallyClosedIn A B :=
  IsIntegrallyClosedIn.integralClosure_eq_bot_iff (R := A) (A := B) hAB

end Definition_01_19

section Definition_01_19_FractionField

variable (A : Type*) [CommRing A]

/-- For a domain, the lecture's normalization is the integral closure in its fraction field. -/
theorem normalization_isIntegralClosure [IsDomain A] :
    IsIntegralClosure (integralClosure A (FractionRing A)) A (FractionRing A) :=
  integralClosure.isIntegralClosure A (FractionRing A)

/-- For a domain, the lecture's normalization is the integral closure in its fraction field. -/
theorem mem_normalization_iff_isIntegral [IsDomain A] {x : FractionRing A} :
    x ∈ integralClosure A (FractionRing A) ↔ IsIntegral A x := by
  rw [mem_integralClosure_iff]

/-- The lecture's "normal"/"integrally closed" terminology is `IsIntegrallyClosed A`. -/
theorem isIntegrallyClosed_iff_isIntegrallyClosedIn_fractionRing [IsDomain A] :
    IsIntegrallyClosed A ↔ IsIntegrallyClosedIn A (FractionRing A) :=
  isIntegrallyClosed_iff_isIntegrallyClosedIn (R := A) (K := FractionRing A)

end Definition_01_19_FractionField

end Chapter1
end SutherlandNumberTheoryLecture1
