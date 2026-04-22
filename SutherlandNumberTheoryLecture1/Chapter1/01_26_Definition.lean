import Mathlib

/-!
# Definition 1.26: Number fields and rings of integers

The lecture defines a number field as a finite extension of `ℚ`. Mathlib packages
that exact notion as the typeclass `NumberField K`.

The lecture then defines the ring of integers `\mathcal{O}_K` as the integral
closure of `ℤ` in `K`. Mathlib packages that exact object as
`NumberField.RingOfIntegers K`, and this type is definitionally
`integralClosure ℤ K`.
-/

recall NumberField (K : Type*) [Field K] : Prop

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_26

variable (K : Type*) [Field K]

/-- Definition 1.26's "number field" structure includes finite dimensionality over `ℚ`. -/
theorem numberField_to_finiteDimensional [NumberField K] :
    FiniteDimensional ℚ K := by
  infer_instance

/-- Definition 1.26's ring of integers is literally the integral closure of `ℤ` in `K`. -/
theorem ringOfIntegers_eq_integralClosure :
    NumberField.RingOfIntegers K = integralClosure ℤ K :=
  rfl

/-- Mathlib's bundled ring of integers carries the lecture's integral-closure structure. -/
theorem ringOfIntegers_isIntegralClosure :
    IsIntegralClosure (NumberField.RingOfIntegers K) ℤ K := by
  infer_instance

end Definition_01_26

end Chapter1
end SutherlandNumberTheoryLecture1
