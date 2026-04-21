import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_02_Definition»

/-!
# Definition 1.7: The `p`-adic valuation and absolute value

For a prime `p`, Mathlib already provides the two constructions used in the
lecture:

- `padicValRat p : ℚ → ℤ` records the exponent of `p` in a nonzero rational;
- `Rat.AbsoluteValue.padic p : AbsoluteValue ℚ ℝ` is the induced `p`-adic
  absolute value.

The only mismatch is that the lecture writes `v_p(0) = ∞`, while Mathlib's raw
integer-valued `padicValRat` returns `0` at `0`. This file therefore packages
the lecture's valuation as a `WithTop ℤ`-valued wrapper and records the zero and
nonzero formulas explicitly.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_07

variable (p : ℕ)

/-- The lecture's `p`-adic valuation on `ℚ`, with the convention `v_p(0) = ∞`. -/
def padicValuation (x : ℚ) : WithTop ℤ :=
  if x = 0 then ⊤ else (padicValRat p x : WithTop ℤ)

@[simp] theorem padicValuation_zero :
    padicValuation p 0 = ⊤ := by
  simp [padicValuation]

/-- Away from zero, the lecture's valuation is Mathlib's `padicValRat`. -/
theorem padicValuation_of_ne_zero {x : ℚ} (hx : x ≠ 0) :
    padicValuation p x = (padicValRat p x : WithTop ℤ) := by
  simp [padicValuation, hx]

end Definition_01_07

section Definition_01_07_AbsoluteValue

variable (p : ℕ) [Fact p.Prime]

/-- The induced `p`-adic absolute value is Mathlib's packaged rational absolute value. -/
theorem padicAbsoluteValue_eq (x : ℚ) :
    Rat.AbsoluteValue.padic p x = (padicNorm p x : ℝ) := by
  norm_num [Rat.AbsoluteValue.padic_eq_padicNorm]

@[simp] theorem padicAbsoluteValue_apply_zero :
    Rat.AbsoluteValue.padic p 0 = 0 := by
  simp

/-- For nonzero rationals, the `p`-adic absolute value is `p^{-v_p(x)}`. -/
theorem padicAbsoluteValue_apply_of_ne_zero {x : ℚ} (hx : x ≠ 0) :
    Rat.AbsoluteValue.padic p x = (((p : ℚ) ^ (-padicValRat p x) : ℚ) : ℝ) := by
  rw [padicAbsoluteValue_eq]
  exact_mod_cast padicNorm.eq_zpow_of_nonzero (p := p) hx

/-- The lecture's `p`-adic absolute value is nonarchimedean. -/
theorem padicAbsoluteValue_isNonarchimedean :
    IsNonarchimedean (Rat.AbsoluteValue.padic p) := by
  intro x y
  simpa [padicAbsoluteValue_eq] using (padicNorm.nonarchimedean (p := p) (q := x) (r := y))

end Definition_01_07_AbsoluteValue

end Chapter1
end SutherlandNumberTheoryLecture1
