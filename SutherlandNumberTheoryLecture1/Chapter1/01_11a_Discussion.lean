import SutherlandNumberTheoryLecture1.Chapter1.«01_10_Definition»
import SutherlandNumberTheoryLecture1.Chapter1.«01_10a_Discussion»

/-!
# Discussion 1.11a: structural consequences of a discrete valuation

This blob records the lecture's standard structure package for a discrete
valuation ring: existence of a uniformizer, unit-times-power factorization in
the fraction field, the classification of ideals by valuation, total ordering
of ideals, and the maximal ideal cut out by strictly positive valuation.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Discussion_01_11a

open scoped BigOperators

variable {k : Type*} [Field k]
variable (v : RealValuation k)

/-- A discrete valuation ring admits a uniformizer. -/
theorem exists_uniformizer
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))] :
    ∃ π : valuationSubring v, Irreducible π := by
  simpa using (IsDiscreteValuationRing.exists_irreducible (valuationSubring v))

/-- Any two uniformizers differ by multiplication by a unit. -/
theorem associated_of_uniformizer {π π' : valuationSubring v}
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    (hπ : Irreducible π) (hπ' : Irreducible π') :
    Associated π π' := by
  simpa using
    (IsDiscreteValuationRing.associated_of_irreducible (R := valuationSubring v) hπ hπ')

/-- The lecture's `x = u * π^n` factorization for nonzero elements of the fraction field. -/
theorem exists_unique_unit_mul_uniformizer_zpow
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    (π : valuationSubring v) (hπ : Irreducible π) (x : kˣ) :
    ∃! un : Units (valuationSubring v) × ℤ,
      (x : k) =
        ((((un.1 : Units (valuationSubring v)) : valuationSubring v) : k) *
          (((π : valuationSubring v) : k) ^ un.2)) := by
  let w := asValuation v
  have hπu : w.IsUniformizer (π : k) := by
    apply Valuation.isUniformizer_of_maximalIdeal_eq_span (v := w)
    simpa using hπ.maximalIdeal_eq
  have hx0 : w (x : k) ≠ 0 := by
    have hx_top : v (x : k) ≠ ⊤ := (v.ne_top_iff).2 x.ne_zero
    intro hx
    simp at hx
  let vx : (Multiplicative (WithTop ℝ)ᵒᵈ)ˣ := Units.mk0 (w (x : k)) hx0
  have hvx : vx ∈ MonoidWithZeroHom.valueGroup w := by
    apply MonoidWithZeroHom.mem_valueGroup
    exact Set.mem_range.mpr ⟨(x : k), rfl⟩
  rw [hπu.zpowers_eq_valueGroup, Subgroup.mem_zpowers_iff] at hvx
  rcases hvx with ⟨n, hn⟩
  have hvalx : w (x : k) = w (π : k) ^ n := by
    simpa [vx] using congrArg Units.val hn.symm
  have hπpow0 : w (π : k) ^ n ≠ 0 := zpow_ne_zero n hπu.val_ne_zero
  let a : valuationSubring v := ⟨(x : k) * (π : k) ^ (-n), by
    rw [Valuation.mem_valuationSubring_iff]
    change w ((x : k) * (π : k) ^ (-n)) ≤ 1
    have : w (π : k) ^ n * (w (π : k) ^ n)⁻¹ = (1 : Multiplicative (WithTop ℝ)ᵒᵈ) := by
      simpa [mul_comm] using inv_mul_cancel₀ hπpow0
    rw [map_mul, map_zpow₀, hvalx]
    simp [this]
  ⟩
  have ha_unit : IsUnit a :=
    (Valuation.Integers.isUnit_iff_valuation_eq_one (Valuation.integer.integers w)).2 <| by
      change w ((x : k) * (π : k) ^ (-n)) = 1
      have : w (π : k) ^ n * (w (π : k) ^ n)⁻¹ = (1 : Multiplicative (WithTop ℝ)ᵒᵈ) := by
        simpa [mul_comm] using inv_mul_cancel₀ hπpow0
      rw [map_mul, map_zpow₀, hvalx]
      simp [this]
  refine ⟨⟨ha_unit.unit, n⟩, ?_, ?_⟩
  · have hpi0 : ((π : valuationSubring v) : k) ^ n ≠ 0 := by
      have hpi0' : (((π : valuationSubring v) : k)) ≠ 0 := by
        exact_mod_cast hπ.ne_zero
      exact zpow_ne_zero n hpi0'
    change (x : k) =
      ((((ha_unit.unit : Units (valuationSubring v)) : valuationSubring v) : k) * ((π : k) ^ n))
    simp [a, IsUnit.unit_spec, hpi0]
  · intro y hy
    rcases y with ⟨u, m⟩
    simp only at hy
    have hu1 : w ((((u : Units (valuationSubring v)) : valuationSubring v) : k)) = 1 := by
      exact
        (Valuation.Integers.isUnit_iff_valuation_eq_one (Valuation.integer.integers w)).mp u.isUnit
    have huv : w (π : k) ^ n = w (π : k) ^ m := by
      calc
        w (π : k) ^ n = w ((x : k)) := hvalx.symm
        _ =
            w
              ((((u : Units (valuationSubring v)) : valuationSubring v) : k) *
                (((π : valuationSubring v) : k) ^ m)) := by rw [hy]
        _ =
            w ((((u : Units (valuationSubring v)) : valuationSubring v) : k)) *
              w ((π : k) ^ m) := by
            rw [map_mul]
        _ = w (π : k) ^ m := by rw [map_zpow₀, hu1, one_mul]
    have hm : n = m := by
      exact (zpow_right_inj₀ hπu.val_pos (ne_of_lt hπu.val_lt_one)).mp huv
    subst hm
    refine Prod.ext ?_ rfl
    have hwitness :
        (x : k) =
          ((((ha_unit.unit : Units (valuationSubring v)) : valuationSubring v) : k) *
            ((π : k) ^ n)) := by
      have hpi0 : ((π : valuationSubring v) : k) ^ n ≠ 0 := by
        have hpi0' : (((π : valuationSubring v) : k)) ≠ 0 := by
          exact_mod_cast hπ.ne_zero
        exact zpow_ne_zero n hpi0'
      simp [a, IsUnit.unit_spec, hpi0]
    have hrepr :
        ((((ha_unit.unit : Units (valuationSubring v)) : valuationSubring v) : k) *
            ((π : k) ^ n)) =
          ((((u : Units (valuationSubring v)) : valuationSubring v) : k) * ((π : k) ^ n)) := by
      rw [← hwitness, hy]
    have hpi0 : ((π : valuationSubring v) : k) ^ n ≠ 0 := by
      have hpi0' : (((π : valuationSubring v) : k)) ≠ 0 := by
        exact_mod_cast hπ.ne_zero
      exact zpow_ne_zero n hpi0'
    have hunit_eq_k :
        (((ha_unit.unit : Units (valuationSubring v)) : valuationSubring v) : k) =
          (((u : Units (valuationSubring v)) : valuationSubring v) : k) := by
      have := congrArg (fun t : k => t * (((π : valuationSubring v) : k) ^ n)⁻¹) hrepr
      simpa [mul_assoc, hpi0] using this
    apply Units.ext
    simpa using hunit_eq_k.symm

/-- A DVR is a principal ideal ring, hence the lecture's PID conclusion holds. -/
theorem valuationSubring_isPrincipalIdealRing
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))] :
    IsPrincipalIdealRing (valuationSubring v) := by
  infer_instance

/-- A DVR is a unique factorization domain. -/
theorem valuationSubring_isUniqueFactorizationMonoid
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))] :
    UniqueFactorizationMonoid (valuationSubring v) := by
  infer_instance

/-- The principal ideal generated by a power of a uniformizer is the invariant valuation cutoff
locus. -/
theorem span_pow_uniformizer_eq_valuation_ge
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    (π : valuationSubring v) (_hπ : Irreducible π) (n : ℕ) :
    (((Ideal.span ({π ^ n} : Set (valuationSubring v))) : Ideal (valuationSubring v)) :
        Set (valuationSubring v)) =
      {a : valuationSubring v | asValuation v (a : k) ≤ asValuation v (π : k) ^ n} := by
  let w := asValuation v
  let hv : w.Integers w.valuationSubring := Valuation.valuationSubring.integers (v := w)
  ext a
  simpa [w, valuationSubring, Ideal.mem_span_singleton, map_pow] using
    (hv.dvd_iff_le (x := π ^ n) (y := a))

/-- Under the lecture's normalization `v(π) = 1`, the cutoff can be written additively as
`n ≤ v(a)`. -/
theorem span_pow_uniformizer_eq_valuation_ge_normalized (π : valuationSubring v)
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    (hπ : Irreducible π) (hπnorm : v (π : k) = 1) (n : ℕ) :
    (((Ideal.span ({π ^ n} : Set (valuationSubring v))) : Ideal (valuationSubring v)) :
        Set (valuationSubring v)) =
      {a : valuationSubring v | (((n : ℝ) : WithTop ℝ) ≤ v (a : k))} := by
  rw [span_pow_uniformizer_eq_valuation_ge (v := v) π hπ n]
  ext a
  change (asValuation v (a : k) ≤ asValuation v (π : k) ^ n) ↔
      (((n : ℝ) : WithTop ℝ) ≤ v (a : k))
  have hpow :
      (Multiplicative.ofAdd (OrderDual.toDual (1 : WithTop ℝ)) :
        Multiplicative (WithTop ℝ)ᵒᵈ) ^ n =
        Multiplicative.ofAdd (OrderDual.toDual (((n : ℝ) : WithTop ℝ))) := by
    induction n with
    | zero =>
        simp
    | succ n ihn =>
        rw [pow_succ, ihn]
        simp [Nat.cast_add]
  rw [show asValuation v (π : k) ^ n =
      Multiplicative.ofAdd (OrderDual.toDual (((n : ℝ) : WithTop ℝ))) by
        rw [show asValuation v (π : k) =
            (Multiplicative.ofAdd (OrderDual.toDual (1 : WithTop ℝ)) :
              Multiplicative (WithTop ℝ)ᵒᵈ) by
              simp [asValuation, AddValuation.toValuation_apply, hπnorm]]
        exact hpow]
  change OrderDual.toDual (v (a : k)) ≤ OrderDual.toDual (((n : ℝ) : WithTop ℝ)) ↔
      (((n : ℝ) : WithTop ℝ) ≤ v (a : k))
  rfl

/-- The ideal generated by `π^n` depends only on `n`, not on the chosen uniformizer. -/
theorem span_pow_uniformizer_eq_span_pow_uniformizer
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    {π π' : valuationSubring v} (hπ : Irreducible π) (hπ' : Irreducible π') (n : ℕ) :
    Ideal.span ({π ^ n} : Set (valuationSubring v)) =
      Ideal.span ({π' ^ n} : Set (valuationSubring v)) := by
  rw [← Ideal.span_singleton_pow, ← Ideal.span_singleton_pow, ← hπ.maximalIdeal_eq,
    ← hπ'.maximalIdeal_eq]

/-- Every nonzero ideal is a power of the maximal ideal, equivalently a power of a uniformizer. -/
theorem exists_eq_span_pow_uniformizer_of_ne_bot
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    (I : Ideal (valuationSubring v)) (hI : I ≠ ⊥) :
    ∃ π : valuationSubring v, Irreducible π ∧ ∃ n : ℕ, I = Ideal.span ({π ^ n} : Set _) := by
  obtain ⟨π, hπ⟩ := exists_uniformizer (v := v)
  obtain ⟨n, hn⟩ := IsDiscreteValuationRing.ideal_eq_span_pow_irreducible hI hπ
  exact ⟨π, hπ, n, hn⟩

/-- The ideals of a DVR are linearly ordered by inclusion. -/
theorem ideals_are_totally_ordered
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    (I J : Ideal (valuationSubring v)) :
    I ≤ J ∨ J ≤ I := by
  obtain ⟨π, hπ⟩ := exists_uniformizer (v := v)
  by_cases hIbot : I = ⊥
  · left
    simp [hIbot]
  by_cases hJbot : J = ⊥
  · right
    simp [hJbot]
  obtain ⟨n, rfl⟩ := IsDiscreteValuationRing.ideal_eq_span_pow_irreducible hIbot hπ
  obtain ⟨m, rfl⟩ := IsDiscreteValuationRing.ideal_eq_span_pow_irreducible hJbot hπ
  rcases Nat.le_total n m with hnm | hmn
  · right
    rw [Ideal.span_singleton_le_span_singleton]
    refine ⟨π ^ (m - n), ?_⟩
    simpa [pow_add, mul_comm, mul_left_comm, mul_assoc] using
      congrArg (fun t : ℕ => π ^ t) (Nat.add_sub_of_le hnm).symm
  · left
    rw [Ideal.span_singleton_le_span_singleton]
    refine ⟨π ^ (n - m), ?_⟩
    simpa [pow_add, mul_comm, mul_left_comm, mul_assoc] using
      congrArg (fun t : ℕ => π ^ t) (Nat.add_sub_of_le hmn).symm

/-- A uniformizer generates the unique maximal ideal. -/
theorem maximalIdeal_eq_span_uniformizer
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    (π : valuationSubring v) (hπ : Irreducible π) :
    IsLocalRing.maximalIdeal (valuationSubring v) =
      Ideal.span ({π} : Set (valuationSubring v)) := by
  simpa [IsDiscreteValuationRing.irreducible_iff_uniformizer] using hπ.maximalIdeal_eq

/-- The unique maximal ideal is cut out by strictly positive valuation. -/
theorem maximalIdeal_eq_positive_valuation_locus
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))] :
    (((IsLocalRing.maximalIdeal (valuationSubring v)) : Ideal (valuationSubring v)) :
        Set (valuationSubring v)) =
      {a : valuationSubring v | 0 < v (a : k)} := by
  ext a
  simpa using mem_maximalIdeal_iff_valuation_pos (v := v) a

/-- The maximal ideal of a DVR is the only maximal ideal. -/
theorem eq_maximalIdeal_of_isMaximal
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    {I : Ideal (valuationSubring v)} (hI : I.IsMaximal) :
    I = IsLocalRing.maximalIdeal (valuationSubring v) := by
  exact Ideal.IsMaximal.eq_of_le hI
    (Ideal.IsMaximal.ne_top (IsLocalRing.maximalIdeal.isMaximal (valuationSubring v)))
    (IsLocalRing.le_maximalIdeal hI.ne_top)

/-- The maximal ideal of a DVR is the only nonzero prime ideal. -/
theorem eq_maximalIdeal_of_isPrime_of_ne_bot {I : Ideal (valuationSubring v)}
    [IsCyclic (MonoidWithZeroHom.valueGroup (asValuation v))]
    [Nontrivial (MonoidWithZeroHom.valueGroup (asValuation v))]
    (hI : I.IsPrime) (hIbot : I ≠ ⊥) :
    I = IsLocalRing.maximalIdeal (valuationSubring v) := by
  rcases
      (IsDiscreteValuationRing.iff_pid_with_one_nonzero_prime (valuationSubring v)).mp
        (by infer_instance : IsDiscreteValuationRing (valuationSubring v)) with
    ⟨_, hunique⟩
  refine hunique.unique ⟨hIbot, hI⟩ ?_
  exact ⟨Ring.ne_bot_of_isMaximal_of_not_isField inferInstance
    (IsDiscreteValuationRing.not_isField (valuationSubring v)),
    Ideal.IsMaximal.isPrime inferInstance⟩

end Discussion_01_11a

end Chapter1
end SutherlandNumberTheoryLecture1
