import Mathlib.NumberTheory.Ostrowski
import Mathlib.NumberTheory.Padics.PadicNorm
import Mathlib.Tactic
import SutherlandNumberTheoryLecture1.Chapter1.«01_07_Definition»

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
  let n := q.1.num.natAbs
  let d := q.1.den
  let s := n.primeFactors ∪ d.primeFactors
  have hq_ne_zero : (q : ℚ) ≠ 0 := Units.ne_zero q
  have hnum_ne_zero : q.1.num ≠ 0 := Rat.num_ne_zero.mpr hq_ne_zero
  have hn_ne_zero : n ≠ 0 := by
    change q.1.num.natAbs ≠ 0
    exact Int.natAbs_ne_zero.mpr hnum_ne_zero
  have hd_ne_zero : d ≠ 0 := Rat.den_ne_zero _
  let u : ℤˣ := if hnonneg : 0 ≤ q.1.num then 1 else -1
  have hu_eq_sign : (u : ℤ) = q.1.num.sign := by
    by_cases hnonneg : 0 ≤ q.1.num
    · have hpos : 0 < q.1.num := lt_of_le_of_ne hnonneg (by simpa using hnum_ne_zero.symm)
      simp [u, hnonneg, Int.sign_eq_one_of_pos hpos]
    · have hneg : q.1.num < 0 := lt_of_not_ge hnonneg
      simp [u, hnonneg, Int.sign_eq_neg_one_of_neg hneg]
  let e : ℕ →₀ ℤ :=
    Finsupp.onFinset s
      (fun p => (n.factorization p : ℤ) - d.factorization p)
      (by
        intro p hp
        by_cases hnp : n.factorization p = 0
        · have hdp : d.factorization p ≠ 0 := by
            intro hdp
            exact hp <| by simp [hnp, hdp]
          refine Finset.mem_union.mpr <| Or.inr <| (Nat.mem_primeFactors.mpr ?_)
          have hprime : p.Prime := by
            by_contra hpprime
            exact hdp <| by simp [Nat.factorization_eq_zero_of_not_prime d hpprime]
          exact ⟨hprime, Nat.dvd_of_factorization_pos hdp, hd_ne_zero⟩
        · refine Finset.mem_union.mpr <| Or.inl <| (Nat.mem_primeFactors.mpr ?_)
          have hprime : p.Prime := by
            by_contra hpprime
            exact hnp <| by simp [Nat.factorization_eq_zero_of_not_prime n hpprime]
          exact ⟨hprime, Nat.dvd_of_factorization_pos hnp, hn_ne_zero⟩)
  have hprime_e : ∀ p ∈ e.support, Nat.Prime p := by
    intro p hp
    have hs : p ∈ s := Finsupp.support_onFinset_subset hp
    rcases Finset.mem_union.mp hs with hs | hs
    · exact Nat.prime_of_mem_primeFactors hs
    · exact Nat.prime_of_mem_primeFactors hs
  have he_prod :
      e.prod (fun p z => (p : ℚ) ^ z) = (n : ℚ) / d := by
    have hs_e :
        ∀ p : ℕ,
          ((n.factorization p : ℤ) - d.factorization p) ≠ 0 → p ∈ s := by
      intro p hp
      exact by
        by_cases hnp : n.factorization p = 0
        · have hdp : d.factorization p ≠ 0 := by
            intro hdp
            exact hp <| by simp [hnp, hdp]
          refine Finset.mem_union.mpr <| Or.inr <| (Nat.mem_primeFactors.mpr ?_)
          have hprime : p.Prime := by
            by_contra hpprime
            exact hdp <| by simp [Nat.factorization_eq_zero_of_not_prime d hpprime]
          exact ⟨hprime, Nat.dvd_of_factorization_pos hdp, hd_ne_zero⟩
        · refine Finset.mem_union.mpr <| Or.inl <| (Nat.mem_primeFactors.mpr ?_)
          have hprime : p.Prime := by
            by_contra hpprime
            exact hnp <| by simp [Nat.factorization_eq_zero_of_not_prime n hpprime]
          exact ⟨hprime, Nat.dvd_of_factorization_pos hnp, hn_ne_zero⟩
    rw [show e = Finsupp.onFinset s (fun p => (n.factorization p : ℤ) - d.factorization p) hs_e by
      rfl]
    rw [Finsupp.onFinset_prod hs_e (by intro p; simp)]
    calc
      ∏ p ∈ s, (p : ℚ) ^ ((n.factorization p : ℤ) - d.factorization p)
          = ∏ p ∈ s, ((p : ℚ) ^ (n.factorization p : ℤ)) / ((p : ℚ) ^ (d.factorization p : ℤ)) := by
              refine Finset.prod_congr rfl ?_
              intro p hp
              have hp_prime : Nat.Prime p := by
                rcases Finset.mem_union.mp hp with hp | hp
                · exact Nat.prime_of_mem_primeFactors hp
                · exact Nat.prime_of_mem_primeFactors hp
              rw [zpow_sub₀]
              exact_mod_cast hp_prime.ne_zero
      _ = (∏ p ∈ s, (p : ℚ) ^ (n.factorization p : ℤ)) /
            ∏ p ∈ s, (p : ℚ) ^ (d.factorization p : ℤ) := by
              rw [Finset.prod_div_distrib]
      _ = (n : ℚ) / ∏ p ∈ s, (p : ℚ) ^ (d.factorization p : ℤ) := by
            have hnum_prod :
                ∏ p ∈ n.primeFactors, (p : ℚ) ^ (n.factorization p : ℤ) = (n : ℚ) := by
              exact_mod_cast
                (show ∏ p ∈ n.primeFactors, (p : ℕ) ^ n.factorization p = n by
                  simpa using Nat.prod_factorization_pow_eq_self hn_ne_zero)
            have hs_num :
                ∏ p ∈ n.primeFactors, (p : ℚ) ^ (n.factorization p : ℤ) =
                  ∏ p ∈ s, (p : ℚ) ^ (n.factorization p : ℤ) := by
              refine Finset.prod_subset (by intro p hp; exact Finset.mem_union.mpr (Or.inl hp)) ?_
              intro p hp hs_not
              have hp_prime : Nat.Prime p := by
                rcases Finset.mem_union.mp hp with hp | hp
                · exact Nat.prime_of_mem_primeFactors hp
                · exact Nat.prime_of_mem_primeFactors hp
              have hnodvd : ¬ p ∣ n := by
                intro hdiv
                exact hs_not <| (Nat.mem_primeFactors.mpr ⟨hp_prime, hdiv, hn_ne_zero⟩)
              simp [Nat.factorization_eq_zero_of_not_dvd hnodvd]
            rw [← hs_num, hnum_prod]
      _ = (n : ℚ) / d := by
            have hden_prod :
                ∏ p ∈ d.primeFactors, (p : ℚ) ^ (d.factorization p : ℤ) = (d : ℚ) := by
              exact_mod_cast
                (show ∏ p ∈ d.primeFactors, (p : ℕ) ^ d.factorization p = d by
                  simpa using Nat.prod_factorization_pow_eq_self hd_ne_zero)
            have hs_den :
                ∏ p ∈ d.primeFactors, (p : ℚ) ^ (d.factorization p : ℤ) =
                  ∏ p ∈ s, (p : ℚ) ^ (d.factorization p : ℤ) := by
              refine Finset.prod_subset (by intro p hp; exact Finset.mem_union.mpr (Or.inr hp)) ?_
              intro p hp hs_not
              have hp_prime : Nat.Prime p := by
                rcases Finset.mem_union.mp hp with hp | hp
                · exact Nat.prime_of_mem_primeFactors hp
                · exact Nat.prime_of_mem_primeFactors hp
              have hnodvd : ¬ p ∣ d := by
                intro hdiv
                exact hs_not <| (Nat.mem_primeFactors.mpr ⟨hp_prime, hdiv, hd_ne_zero⟩)
              simp [Nat.factorization_eq_zero_of_not_dvd hnodvd]
            rw [← hs_den, hden_prod]
  have hu_num : (((u : ℤ) : ℚ) * (n : ℚ)) = q.1.num := by
    calc
      (((u : ℤ) : ℚ) * (n : ℚ))
          = ((q.1.num.sign : ℤ) : ℚ) * (n : ℚ) := by rw [hu_eq_sign]
      _ = ((q.1.num.sign * n : ℤ) : ℚ) := by norm_num
      _ = q.1.num := by
        simpa [n] using
          (show (((q.1.num.sign * q.1.num.natAbs : ℤ) : ℤ) : ℚ) = q.1.num by
            exact_mod_cast (Int.sign_mul_natAbs q.1.num))
  have hq_prod : (((u : ℤ) : ℚ) * e.prod (fun p z => (p : ℚ) ^ z) = (q : ℚ)) := by
    calc
      (((u : ℤ) : ℚ) * e.prod (fun p z => (p : ℚ) ^ z))
          = (((u : ℤ) : ℚ) * ((n : ℚ) / d)) := by rw [he_prod]
      _ = (((u : ℤ) : ℚ) * (n : ℚ)) / d := by ring
      _ = (q.1.num : ℚ) / d := by rw [hu_num]
      _ = (q : ℚ) := Rat.num_div_den _
  refine ⟨⟨u, e⟩, ⟨hprime_e, hq_prod⟩, ?_⟩
  intro data hdata
  rcases data with ⟨u', e'⟩
  rcases hdata with ⟨hprime_e', hq_prod'⟩
  have he_eq : e' = e := by
    apply Finsupp.ext
    intro p
    by_cases hp : Nat.Prime p
    · letI : Fact p.Prime := ⟨hp⟩
      have hval_e :
          padicValuation p (q : ℚ) = (e p : WithTop ℤ) := by
        simpa [hq_prod] using
          (padicValuation_eq_exponent_of_factorization (p := p) u e hprime_e)
      have hval_e' :
          padicValuation p (q : ℚ) = (e' p : WithTop ℤ) := by
        simpa [hq_prod'] using
          (padicValuation_eq_exponent_of_factorization (p := p) u' e' hprime_e')
      have : (e p : WithTop ℤ) = (e' p : WithTop ℤ) := by
        rw [← hval_e, hval_e']
      simpa using this.symm
    · have he_zero : e p = 0 := by
        by_contra he
        exact hp (hprime_e p (Finsupp.mem_support_iff.mpr he))
      have he'_zero : e' p = 0 := by
        by_contra he'
        exact hp (hprime_e' p (Finsupp.mem_support_iff.mpr he'))
      simp [he_zero, he'_zero]
  have he_prod_ne_zero : e.prod (fun p z => (p : ℚ) ^ z) ≠ 0 := by
    rw [he_prod]
    exact div_ne_zero (by exact_mod_cast hn_ne_zero) (by exact_mod_cast hd_ne_zero)
  have hu_cast :
      ((u' : ℤ) : ℚ) = ((u : ℤ) : ℚ) := by
    have hmul :
        (((u' : ℤ) : ℚ) * e.prod (fun p z => (p : ℚ) ^ z)) =
          (((u : ℤ) : ℚ) * e.prod (fun p z => (p : ℚ) ^ z)) := by
      simpa [he_eq] using hq_prod'.trans hq_prod.symm
    exact mul_right_cancel₀ he_prod_ne_zero hmul
  have hu_eq : u' = u := by
    apply Units.ext
    exact_mod_cast hu_cast
  simp [hu_eq, he_eq]

end Discussion_01_06a

end Chapter1
end SutherlandNumberTheoryLecture1
