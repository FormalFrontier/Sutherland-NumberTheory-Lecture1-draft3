import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_02_Definition»

/-!
# Definition 1.10: Valuations, valuation rings, and DVRs

The lecture presents a valuation on a field `k` as a homomorphism `kˣ → ℝ`
satisfying the additive nonarchimedean inequality, then extends it to
`k → ℝ ∪ {∞}` by sending `0` to `∞`. Mathlib already packages that extended
object as `AddValuation k (WithTop ℝ)`, so this file records the lecture's
definition directly in terms of the bundled additive valuation API.

The derived nonarchimedean absolute value `|x|ᵥ = c ^ v(x)` for `0 < c < 1`
is recorded via its explicit underlying formula and a theorem-level existence
claim, so the construction remains visible without introducing a sorry'd data
definition.

For the valuation ring and DVR clauses, the lecture's constructions match
Mathlib's bundled objects:

- `v.toValuation.valuationSubring` is the valuation ring attached to `v`
- `IsDiscreteValuationRing` is the bundled DVR predicate

The lecture's normalization "the value group is equal to `ℤ`" is recorded as a
set-level predicate on the real values taken on units; Mathlib's more invariant
discreteness API is `Valuation.IsRankOneDiscrete`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Definition_01_10

variable {k : Type*} [Field k]

/-- The lecture's real-valued valuation is Mathlib's bundled additive valuation. -/
abbrev RealValuation (k : Type*) [Field k] := AddValuation k (WithTop ℝ)

/-- The multiplicative valuation underlying the bundled additive valuation. -/
noncomputable abbrev asValuation (v : RealValuation k) :
    Valuation k (Multiplicative (WithTop ℝ)ᵒᵈ) :=
  AddValuation.toValuation v

/-- The real value taken by the valuation on a nonzero element, packaged via a unit. -/
noncomputable def valueOfUnit (v : RealValuation k) (u : kˣ) : ℝ :=
  (v (u : k)).untop ((v.ne_top_iff).2 u.ne_zero)

/-- The lecture's value group, viewed as the set of real values attained on `kˣ`. -/
def valueGroup (v : RealValuation k) : Set ℝ :=
  Set.range (valueOfUnit v)

/-- The lecture normalizes a discrete valuation by requiring the value group to be `ℤ`. -/
def IsDiscrete (v : RealValuation k) : Prop :=
  valueGroup v = Set.range (fun n : ℤ => (n : ℝ))

/-- The lecture's valuation ring is Mathlib's `valuationSubring`
attached to the bundled valuation. -/
noncomputable abbrev valuationSubring (v : RealValuation k) : ValuationSubring k :=
  (asValuation v).valuationSubring

/-- The lecture's formula `|x|ᵥ = c ^ v(x)` on nonzero elements, extended by `0` at the origin. -/
noncomputable def derivedAbsoluteValueFn (v : RealValuation k) (c : ℝ) : k → ℝ :=
  by
    classical
    exact fun x => if hx : x = 0 then 0 else c ^ ((v x).untop ((v.ne_top_iff).2 hx))

/-- The lecture's set-level description of the valuation ring agrees with Mathlib's bundled one. -/
theorem mem_valuationSubring_iff (v : RealValuation k) (x : k) :
    x ∈ valuationSubring v ↔ 0 ≤ v x := by
  change (asValuation v) x ≤ 1 ↔ 0 ≤ v x
  change OrderDual.toDual (v x) ≤ OrderDual.toDual (0 : WithTop ℝ) ↔ 0 ≤ v x
  rfl

/-- The lecture's formula `|x|ᵥ = c ^ v(x)` yields a nonarchimedean absolute value. -/
theorem exists_derivedAbsoluteValue (v : RealValuation k) (c : ℝ) (hc0 : 0 < c) (hc1 : c < 1) :
    ∃ abv : AbsoluteValue k ℝ, IsNonarchimedean abv ∧
      ∀ x, abv x = derivedAbsoluteValueFn v c x := by
  sorry

/-- A valuation ring coming from a cyclic nontrivial value group is a DVR in Mathlib's sense. -/
instance instIsDiscreteValuationRing (v : RealValuation k)
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))] :
    IsDiscreteValuationRing (valuationSubring v) := by
  change IsDiscreteValuationRing ((asValuation v).valuationSubring)
  infer_instance

/-- The lecture notes that a DVR cannot be a field. -/
theorem valuationSubring_maximalIdeal_ne_bot (v : RealValuation k)
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))] :
    IsLocalRing.maximalIdeal (valuationSubring v) ≠ ⊥ := by
  exact IsLocalRing.isField_iff_maximalIdeal_eq.not.mp
    (Valuation.valuationSubring_not_isField (asValuation v))

end Definition_01_10

end Chapter1
end SutherlandNumberTheoryLecture1
