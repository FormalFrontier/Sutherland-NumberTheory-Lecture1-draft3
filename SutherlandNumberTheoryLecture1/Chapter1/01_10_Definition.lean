import Mathlib

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
    exact fun x => if x = 0 then 0 else c ^ (v x).untop₀

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
  have hnonneg : ∀ x, 0 ≤ derivedAbsoluteValueFn v c x := by
    intro x
    by_cases hx : x = 0
    · simp [derivedAbsoluteValueFn, hx]
    · simp [derivedAbsoluteValueFn, hx, Real.rpow_nonneg hc0.le]
  have hle_max : ∀ x y, derivedAbsoluteValueFn v c (x + y) ≤
      max (derivedAbsoluteValueFn v c x) (derivedAbsoluteValueFn v c y) := by
    intro x y
    by_cases hxy : x + y = 0
    · have : 0 ≤ max (derivedAbsoluteValueFn v c x) (derivedAbsoluteValueFn v c y) :=
        le_max_of_le_left (hnonneg x)
      simpa [derivedAbsoluteValueFn, hxy] using this
    · by_cases hx : x = 0
      · have hy' : y ≠ 0 := by simpa [hx] using hxy
        simp [derivedAbsoluteValueFn, hx, hy']
      · by_cases hy : y = 0
        · have hx' : x ≠ 0 := hx
          simp [derivedAbsoluteValueFn, hy, hx']
        · have hx' : v x ≠ ⊤ := (v.ne_top_iff).2 hx
          have hy' : v y ≠ ⊤ := (v.ne_top_iff).2 hy
          have hxy' : v (x + y) ≠ ⊤ := (v.ne_top_iff).2 hxy
          have hmin : (min (v x) (v y)).untop₀ ≤ (v (x + y)).untop₀ := by
            exact WithTop.untop₀_le_untop₀ hxy' (v.map_add x y)
          have hpow :
              c ^ (v (x + y)).untop₀ ≤ c ^ (min (v x) (v y)).untop₀ :=
            (Real.strictAnti_rpow_of_base_lt_one hc0 hc1).antitone hmin
          have hmin_eq :
              c ^ (min (v x) (v y)).untop₀ =
                max (c ^ (v x).untop₀) (c ^ (v y).untop₀) := by
            rw [WithTop.untop₀_min hx' hy']
            simpa using
              (Antitone.map_min
                (f := fun t : ℝ => c ^ t)
                (Real.strictAnti_rpow_of_base_lt_one hc0 hc1).antitone)
          simpa [derivedAbsoluteValueFn, hx, hy, hxy] using hpow.trans_eq hmin_eq
  refine ⟨
    { toFun := derivedAbsoluteValueFn v c
      map_mul' := by
        intro x y
        by_cases hx : x = 0
        · simp [derivedAbsoluteValueFn, hx]
        · by_cases hy : y = 0
          · simp [derivedAbsoluteValueFn, hy]
          · have hxy : x * y ≠ 0 := mul_ne_zero hx hy
            have hx' : v x ≠ ⊤ := (v.ne_top_iff).2 hx
            have hy' : v y ≠ ⊤ := (v.ne_top_iff).2 hy
            simp [derivedAbsoluteValueFn, hx, hy, hxy, v.map_mul, Real.rpow_add hc0, hx', hy']
      nonneg' := hnonneg
      eq_zero' := by
        intro x
        by_cases hx : x = 0
        · simp [derivedAbsoluteValueFn, hx]
        · have hpos : 0 < derivedAbsoluteValueFn v c x := by
            simp [derivedAbsoluteValueFn, hx, Real.rpow_pos_of_pos hc0]
          constructor
          · intro h
            exact False.elim ((ne_of_gt hpos) h)
          · intro h
            exact (hx h).elim
      add_le' := by
        intro x y
        exact (hle_max x y).trans <|
          max_le_iff.mpr
            ⟨le_add_of_nonneg_right (hnonneg y), le_add_of_nonneg_left (hnonneg x)⟩ },
    hle_max,
    fun _ => rfl⟩

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
