import Mathlib
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

/-- The lecture's piecewise formula is Mathlib's packaged trivial absolute value. -/
noncomputable example : AbsoluteValue k ℝ := by
  classical
  exact AbsoluteValue.trivial

/-- Away from zero, the trivial absolute value takes the constant value `1`. -/
example {x : k} (hx : x ≠ 0) : (show AbsoluteValue k ℝ from by
    classical
    exact AbsoluteValue.trivial (R := k) (S := ℝ)) x = 1 := by
  classical
  simpa using AbsoluteValue.trivial_apply (S := ℝ) hx

/-- Example 1.3 explicitly records that the trivial absolute value is nonarchimedean. -/
theorem trivial_isNonarchimedean : IsNonarchimedean (show AbsoluteValue k ℝ from by
    classical
    exact AbsoluteValue.trivial (R := k) (S := ℝ)) := by
  classical
  intro x y
  by_cases hx : x = 0
  · simp [AbsoluteValue.trivial, hx]
  by_cases hy : y = 0
  · simp [AbsoluteValue.trivial, hy]
  simp [AbsoluteValue.trivial, hx, hy]
  split_ifs <;> norm_num

end Example_01_03

end Chapter1
end SutherlandNumberTheoryLecture1
