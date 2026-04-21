import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_06_Definition»

open scoped BigOperators

/-!
# Discussion 1.6a: The archimedean place and signed prime factorization on `ℚ`

This prose blob isolates two concrete pieces of mathematics that the lecture uses
before introducing the `p`-adic places:

- the usual absolute value on `ℚ`, denoted `|·|_∞`, coming from the real place;
- the existence of infinitely many absolute values on `ℚ` besides `|·|_∞`;
- the unique expansion of a nonzero rational as a sign times finitely many prime
  powers with integer exponents.

The broader discussion about completions and local fields is intentionally left
for later files in the Chapter 1 valuation pipeline.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Discussion_01_06a

/-- The lecture's archimedean absolute value `|·|_∞` on `ℚ` is Mathlib's real place. -/
abbrev ratArchimedeanAbsoluteValue : AbsoluteValue ℚ ℝ :=
  Rat.AbsoluteValue.real

/-- The real place acts by the usual absolute value on rational numbers. -/
theorem ratArchimedeanAbsoluteValue_apply (q : ℚ) :
    ratArchimedeanAbsoluteValue q = |q| := by
  change Rat.AbsoluteValue.real q = |q|
  exact Rat.AbsoluteValue.real_eq_abs q

/-- The lecture emphasizes that the real place is archimedean, i.e. not nonarchimedean. -/
theorem ratArchimedeanAbsoluteValue_not_isNonarchimedean :
    ¬ IsNonarchimedean ratArchimedeanAbsoluteValue := by
  intro hna
  have htwo :=
    IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean
      (f := ratArchimedeanAbsoluteValue) hna (n := 2)
  norm_num [ratArchimedeanAbsoluteValue, Rat.AbsoluteValue.real_eq_abs] at htwo

/-- Besides the archimedean place `|·|_∞`, `ℚ` admits infinitely many other absolute values. -/
theorem infinitelyMany_ratAbsoluteValues_not_isEquiv_archimedean :
    Set.Infinite {f : AbsoluteValue ℚ ℝ | ¬ f.IsEquiv ratArchimedeanAbsoluteValue} := by
  let g : Nat.Primes → {f : AbsoluteValue ℚ ℝ | ¬ f.IsEquiv ratArchimedeanAbsoluteValue} :=
    fun p =>
      let _ : Fact (Nat.Prime (p : ℕ)) := ⟨p.2⟩
      ⟨Rat.AbsoluteValue.padic p, by
        intro h
        exact Rat.AbsoluteValue.not_real_isEquiv_padic p h.symm⟩
  have hg : Function.Injective g := by
    intro p q hpq
    by_contra hpq'
    let _ : Fact (Nat.Prime (p : ℕ)) := ⟨p.2⟩
    let _ : Fact (Nat.Prime (q : ℕ)) := ⟨q.2⟩
    have hval : (g p : AbsoluteValue ℚ ℝ) = g q := congrArg Subtype.val hpq
    have hAtP :
        (g p : AbsoluteValue ℚ ℝ) p = (g q : AbsoluteValue ℚ ℝ) p :=
      congrArg (fun f : AbsoluteValue ℚ ℝ => f p) hval
    have hp_lt_one : (g p : AbsoluteValue ℚ ℝ) p < 1 := by
      have hp_lt_one_q : padicNorm (p : ℕ) p < (1 : ℚ) :=
        padicNorm.padicNorm_p_lt_one_of_prime (p := (p : ℕ))
      have hp_lt_one_r : ((padicNorm (p : ℕ) p : ℚ) : ℝ) < (1 : ℝ) := by
        exact_mod_cast hp_lt_one_q
      simpa [g, Rat.AbsoluteValue.padic_eq_padicNorm] using hp_lt_one_r
    have hq_eq_one : (g q : AbsoluteValue ℚ ℝ) p = 1 := by
      have hqp : (q : ℕ) ≠ p := by
        exact fun h => hpq' (Subtype.ext h.symm)
      have hq_eq_one_q : padicNorm (q : ℕ) p = (1 : ℚ) :=
        padicNorm.padicNorm_of_prime_of_ne (p := (q : ℕ)) (q := (p : ℕ)) hqp
      have hq_eq_one_r : ((padicNorm (q : ℕ) p : ℚ) : ℝ) = (1 : ℝ) := by
        exact_mod_cast hq_eq_one_q
      simpa [g, Rat.AbsoluteValue.padic_eq_padicNorm] using hq_eq_one_r
    exact (ne_of_lt hp_lt_one) (hAtP.trans hq_eq_one)
  let f : Nat.Primes → AbsoluteValue ℚ ℝ := fun p => g p
  have hf : Function.Injective f := by
    intro p q hpq
    exact hg (Subtype.ext hpq)
  have hsubset :
      Set.range f ⊆ {f : AbsoluteValue ℚ ℝ | ¬ f.IsEquiv ratArchimedeanAbsoluteValue} := by
    rintro _ ⟨p, rfl⟩
    exact (g p).property
  exact (Set.infinite_range_of_injective hf).mono hsubset

/-- Every nonzero rational has a unique signed prime-power expansion with finite support. -/
theorem existsUnique_signed_primeFactorization (q : ℚˣ) :
    ∃! data : ℤˣ × (ℕ →₀ ℤ),
      (∀ n ∈ data.2.support, Nat.Prime n) ∧
      (((data.1 : ℤ) : ℚ) * data.2.prod (fun p e => (p : ℚ) ^ e) = (q : ℚ)) := by
  sorry

end Discussion_01_06a

end Chapter1
end SutherlandNumberTheoryLecture1
