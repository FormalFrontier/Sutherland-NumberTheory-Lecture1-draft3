import Mathlib.Analysis.AbsoluteValue.Equivalence
import SutherlandNumberTheoryLecture1.Chapter1.«01_02_Definition»

/-!
# Example 1.3: The trivial absolute value

The lecture's piecewise-defined trivial absolute value is already packaged in
Mathlib as `AbsoluteValue.trivial`. This file records that packaged example and
then isolates the book's explicit claim that the trivial absolute value is
nonarchimedean.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Example_01_03

variable {k : Type*} [Field k]

/-- The lecture's trivial absolute value is Mathlib's packaged `AbsoluteValue.trivial`. -/
noncomputable def trivialAbsoluteValue : AbsoluteValue k ℝ := by
  classical
  exact AbsoluteValue.trivial (R := k) (S := ℝ)

/-- The zero branch of the lecture's piecewise formula. -/
@[simp] theorem trivialAbsoluteValue_apply_zero :
    trivialAbsoluteValue (k := k) 0 = 0 := by
  simp [trivialAbsoluteValue]

/-- Away from zero, the trivial absolute value takes the constant value `1`. -/
theorem trivialAbsoluteValue_apply_of_ne_zero {x : k} (hx : x ≠ 0) :
    trivialAbsoluteValue (k := k) x = 1 := by
  classical
  simpa [trivialAbsoluteValue] using AbsoluteValue.trivial_apply (S := ℝ) hx

/-- Example 1.3 explicitly records that the trivial absolute value is nonarchimedean. -/
theorem trivialAbsoluteValue_isNonarchimedean :
    IsNonarchimedean (trivialAbsoluteValue (k := k)) := by
  classical
  intro x y
  by_cases hx : x = 0
  · simp [trivialAbsoluteValue, hx]
  by_cases hy : y = 0
  · simp [trivialAbsoluteValue, hy]
  have hx1 : trivialAbsoluteValue (k := k) x = 1 :=
    trivialAbsoluteValue_apply_of_ne_zero (k := k) hx
  have hy1 : trivialAbsoluteValue (k := k) y = 1 :=
    trivialAbsoluteValue_apply_of_ne_zero (k := k) hy
  by_cases hxy : x + y = 0
  · simp [hxy, hx1, hy1]
  · have hxy1 : trivialAbsoluteValue (k := k) (x + y) = 1 :=
      trivialAbsoluteValue_apply_of_ne_zero (k := k) hxy
    simp [hx1, hy1, hxy1]

end Example_01_03

end Chapter1
end SutherlandNumberTheoryLecture1
