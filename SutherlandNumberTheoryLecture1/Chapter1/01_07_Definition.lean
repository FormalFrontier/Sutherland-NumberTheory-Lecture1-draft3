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

open scoped BigOperators

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

/-- On a signed prime-power expansion, the lecture's valuation returns the exponent of `p`. -/
theorem padicValuation_eq_exponent_of_factorization [Fact p.Prime]
    (u : ℤˣ) (e : ℕ →₀ ℤ) (hprime : ∀ q ∈ e.support, Nat.Prime q) :
    padicValuation p ((((u : ℤ) : ℚ) * e.prod (fun q n => (q : ℚ) ^ n))) = (e p : WithTop ℤ) := by
  have hval_zpow : ∀ {r : ℚ}, r ≠ 0 → ∀ n : ℤ, padicValRat p (r ^ n) = n * padicValRat p r := by
    intro r hr n
    rcases n with (_ | k)
    · simpa [zpow_ofNat, Int.ofNat_eq_natCast, mul_comm] using
        (padicValRat.pow (p := p) hr (k := _))
    · rw [zpow_negSucc, padicValRat.inv, padicValRat.pow (p := p) hr]
      have hk : (((k + 1 : ℕ) : ℤ)) = (k : ℤ) + 1 := by norm_num
      rw [hk, show (Int.negSucc k : ℤ) = -((k : ℤ) + 1) by rfl]
      ring
  have hu_rat_ne_zero : (((u : ℤ) : ℚ)) ≠ 0 := by
    exact_mod_cast (Units.ne_zero u)
  have hu_val : padicValRat p (((u : ℤ) : ℚ)) = 0 := by
    rcases Int.units_eq_one_or u with rfl | rfl <;> simp
  have hp_prime : Nat.Prime p := Fact.out
  have hp_rat_ne_zero : (p : ℚ) ≠ 0 := by
    exact_mod_cast hp_prime.ne_zero
  have hterm_ne_zero_erase : ∀ q ∈ (e.erase p).support, ((q : ℚ) ^ (e.erase p q)) ≠ 0 := by
    intro q hq
    have hq_data : q ≠ p ∧ e q ≠ 0 := by
      simpa [Finsupp.mem_support_iff, Finsupp.erase_apply] using hq
    exact zpow_ne_zero _ (by
      exact_mod_cast (hprime q (Finsupp.mem_support_iff.mpr hq_data.2)).ne_zero)
  have herase_ne_zero : (e.erase p).prod (fun q n => (q : ℚ) ^ n) ≠ 0 := by
    rw [Finsupp.prod]
    exact Finset.prod_ne_zero_iff.2 hterm_ne_zero_erase
  have hp_not_mem_erase : p ∉ (e.erase p).support := by
    simp [Finsupp.mem_support_iff]
  have herase_val :
      padicValRat p ((e.erase p).prod (fun q n => (q : ℚ) ^ n)) = 0 := by
    rw [Finsupp.prod]
    have hs :
        ∀ t : Finset ℕ, t ⊆ (e.erase p).support →
          padicValRat p (∏ q ∈ t, ((q : ℚ) ^ (e.erase p q))) = 0 := by
      intro t
      refine Finset.induction_on t ?_ ?_
      · intro _; simp
      · intro q t hq_notin ih hsub
        have hq_mem : q ∈ (e.erase p).support := hsub (Finset.mem_insert_self q t)
        have hq_data : q ≠ p ∧ e q ≠ 0 := by
          simpa [Finsupp.mem_support_iff, Finsupp.erase_apply] using hq_mem
        have hqnep : q ≠ p := hq_data.1
        have hqprime : Nat.Prime q := hprime q (Finsupp.mem_support_iff.mpr hq_data.2)
        have hq_term_ne_zero : ((q : ℚ) ^ (e.erase p q)) ≠ 0 := hterm_ne_zero_erase q hq_mem
        have ht_ne_zero : (∏ x ∈ t, ((x : ℚ) ^ (e.erase p x))) ≠ 0 := by
          exact Finset.prod_ne_zero_iff.2 fun x hx => hterm_ne_zero_erase x (hsub <| by simp [hx])
        have hqval : padicValRat p ((q : ℚ) ^ (e.erase p q)) = 0 := by
          rw [hval_zpow (by exact_mod_cast hqprime.ne_zero)]
          letI : Fact q.Prime := ⟨hqprime⟩
          rw [padicValRat.of_nat, padicValNat_primes (p := p) (q := q) hqnep.symm]
          simp
        have hsub' : t ⊆ (e.erase p).support := fun x hx => hsub (by simp [hx])
        have hmul :
            padicValRat p
                (((q : ℚ) ^ (e.erase p q)) * ∏ x ∈ t, ((x : ℚ) ^ (e.erase p x))) =
              padicValRat p ((q : ℚ) ^ (e.erase p q)) +
                padicValRat p (∏ x ∈ t, ((x : ℚ) ^ (e.erase p x))) :=
          padicValRat.mul (p := p) hq_term_ne_zero ht_ne_zero
        rw [Finset.prod_insert hq_notin]
        rw [hmul, hqval, ih hsub']
        simp
    exact hs (e.erase p).support (by intro q hq; exact hq)
  have hp_pow_val : padicValRat p ((p : ℚ) ^ e p) = e p := by
    rw [hval_zpow hp_rat_ne_zero]
    simp [padicValRat.self hp_prime.one_lt]
  have hprod_val : padicValRat p (e.prod (fun q n => (q : ℚ) ^ n)) = e p := by
    rw [← Finsupp.mul_prod_erase' e p (fun q n => (q : ℚ) ^ n) (fun _ => by simp)]
    have hmul :
        padicValRat p (((p : ℚ) ^ e p) * (e.erase p).prod (fun q n => (q : ℚ) ^ n)) =
          padicValRat p ((p : ℚ) ^ e p) +
            padicValRat p ((e.erase p).prod (fun q n => (q : ℚ) ^ n)) :=
      padicValRat.mul (p := p) (zpow_ne_zero _ hp_rat_ne_zero) herase_ne_zero
    rw [hmul, hp_pow_val, herase_val]
    simp
  have hprod_ne_zero : e.prod (fun q n => (q : ℚ) ^ n) ≠ 0 := by
    rw [← Finsupp.mul_prod_erase' e p (fun q n => (q : ℚ) ^ n) (fun _ => by simp)]
    exact mul_ne_zero (zpow_ne_zero _ hp_rat_ne_zero) herase_ne_zero
  have hx_ne_zero :
      (((u : ℤ) : ℚ) * e.prod (fun q n => (q : ℚ) ^ n)) ≠ 0 :=
    mul_ne_zero hu_rat_ne_zero hprod_ne_zero
  have hmain :
      padicValRat p ((((u : ℤ) : ℚ) * e.prod (fun q n => (q : ℚ) ^ n))) = e p := by
    rw [padicValRat.mul hu_rat_ne_zero hprod_ne_zero, hu_val, zero_add, hprod_val]
  rw [padicValuation_of_ne_zero p hx_ne_zero]
  exact_mod_cast hmain

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
