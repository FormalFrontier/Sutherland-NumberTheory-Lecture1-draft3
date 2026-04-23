import Mathlib.Analysis.AbsoluteValue.Equivalence

/-!
# Definition 1.2: Absolute values

The lecture defines an absolute value on a field `k` as a function `k → ℝ_{\ge 0}`
satisfying positive-definiteness, multiplicativity, and the triangle inequality.
Mathlib packages this data as `AbsoluteValue k ℝ`: the codomain is `ℝ`, and the
bundled structure records the nonnegativity proof that keeps values in `ℝ_{\ge 0}`.

This file therefore records the lecture's Definition 1.2 by pointing to the bundled
Mathlib structure and isolating the stronger nonarchimedean axiom as a separate
declaration.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_02

variable {k : Type*} [Field k]

/-- The lecture's strengthened axiom (4) is exactly the usual nonarchimedean condition. -/
theorem isNonarchimedean_iff (abv : AbsoluteValue k ℝ) :
    IsNonarchimedean abv ↔ ∀ x y : k, abv (x + y) ≤ max (abv x) (abv y) :=
  Iff.rfl

end Definition_01_02

end Chapter1
end SutherlandNumberTheoryLecture1
