import Mathlib

/-!
# Proof of Theorem 1.8

The lecture defers the proof of Ostrowski's theorem to Problem Set 1. Mathlib
already contains the exact classification theorem as
`Rat.AbsoluteValue.equiv_real_or_padic`, so the formal proof is a direct
citation of that result.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

/-- The lecture's deferred proof is exactly Mathlib's classification theorem. -/
theorem ostrowski_theorem_proof (f : AbsoluteValue ℚ ℝ) (hf_nontriv : f.IsNontrivial) :
    f ≈ Rat.AbsoluteValue.real ∨ ∃! p, ∃ (_ : Fact p.Prime), f ≈ Rat.AbsoluteValue.padic p :=
  Rat.AbsoluteValue.equiv_real_or_padic f hf_nontriv

end Chapter1
end SutherlandNumberTheoryLecture1
