import Mathlib.NumberTheory.Ostrowski
import Mathlib.Tactic.Recall

/-!
# Theorem 1.8: Ostrowski's theorem

The lecture states that every nontrivial absolute value on `ℚ` is equivalent to
`|·|_p` for some place `p ≤ ∞`. In Mathlib this classification already appears
as `Rat.AbsoluteValue.equiv_real_or_padic`, where the archimedean place `∞` is
the standard absolute value `Rat.AbsoluteValue.real` and the finite places are
the `p`-adic absolute values `Rat.AbsoluteValue.padic p` for prime numbers `p`.

This file records the lecture's theorem by recalling the exact Mathlib
declarations, including the incompatibility between the real place and every
finite `p`-adic place.
-/

recall Rat.AbsoluteValue.real : AbsoluteValue ℚ ℝ

recall Rat.AbsoluteValue.padic (p : ℕ) [Fact p.Prime] : AbsoluteValue ℚ ℝ

recall Rat.AbsoluteValue.equiv_real_or_padic (f : AbsoluteValue ℚ ℝ) (hf_nontriv : f.IsNontrivial) :
    f ≈ Rat.AbsoluteValue.real ∨ ∃! p, ∃ (_ : Fact p.Prime), f ≈ Rat.AbsoluteValue.padic p

recall Rat.AbsoluteValue.not_real_isEquiv_padic (p : ℕ) [Fact p.Prime] :
    ¬ Rat.AbsoluteValue.real.IsEquiv (Rat.AbsoluteValue.padic p)

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

end Chapter1
end SutherlandNumberTheoryLecture1
