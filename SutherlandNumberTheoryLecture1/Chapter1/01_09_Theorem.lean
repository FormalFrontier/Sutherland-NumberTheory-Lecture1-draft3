import Mathlib.NumberTheory.Ostrowski
import SutherlandNumberTheoryLecture1.Chapter1.«01_07_Definition»

/-!
# Theorem 1.9: The product formula

For a nonzero rational number `x`, the lecture's product formula is

`|x|_∞ * ∏_p |x|_p = 1`.

To keep the Stage 3.1 statement explicit while avoiding premature proof
infrastructure, this file packages the finite set of relevant primes as the
union of the prime factors of `x.num.natAbs` and `x.den`. Every finite place
outside this support should eventually contribute the trivial factor `1`, so the
book's infinite Euler product is represented here by a finite product over the
nontrivial places.
-/

open scoped BigOperators

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Theorem_01_09

/-- The finite places where a rational number can have a nontrivial `p`-adic factor. -/
def rationalPrimeSupport (x : ℚ) : Finset ℕ :=
  x.num.natAbs.primeFactors ∪ x.den.primeFactors

instance instFactPrimeRationalPrimeSupport (x : ℚ) (p : rationalPrimeSupport x) :
    Fact p.1.Prime := by
  refine ⟨?_⟩
  rcases Finset.mem_union.mp p.2 with hp | hp
  · exact Nat.prime_of_mem_primeFactors hp
  · exact Nat.prime_of_mem_primeFactors hp

/-- Outside the numerator/denominator support, the `p`-adic factor should be trivial. -/
theorem padicAbsoluteValue_eq_one_of_not_mem_rationalPrimeSupport {x : ℚ} {p : ℕ}
    [Fact p.Prime] (hx : x ≠ 0) (hp : p ∉ rationalPrimeSupport x) :
    Rat.AbsoluteValue.padic p x = 1 := by
  rw [Rat.AbsoluteValue.padic_eq_padicNorm]
  have hnum_ne_zero : x.num.natAbs ≠ 0 := by
    simpa using Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hx)
  have hnum_not_mem : p ∉ x.num.natAbs.primeFactors := by
    intro hmem
    exact hp <| Finset.mem_union.mpr <| Or.inl hmem
  have hden_not_mem : p ∉ x.den.primeFactors := by
    intro hmem
    exact hp <| Finset.mem_union.mpr <| Or.inr hmem
  have hnum_not_dvd : ¬ p ∣ x.num.natAbs := by
    intro hdiv
    exact hnum_not_mem <| Nat.mem_primeFactors.mpr ⟨Fact.out, hdiv, hnum_ne_zero⟩
  have hden_not_dvd : ¬ p ∣ x.den := by
    intro hdiv
    exact hden_not_mem <| Nat.mem_primeFactors.mpr ⟨Fact.out, hdiv, Rat.den_ne_zero _⟩
  have hnum_val : padicValInt p x.num = 0 := by
    rw [padicValInt]
    exact padicValNat.eq_zero_of_not_dvd hnum_not_dvd
  have hden_val : padicValNat p x.den = 0 := padicValNat.eq_zero_of_not_dvd hden_not_dvd
  rw [padicNorm.eq_zpow_of_nonzero hx, padicValRat_def, hnum_val, hden_val]
  simp

/-- The lecture's product formula for nonzero rational numbers. -/
theorem product_formula {x : ℚ} (hx : x ≠ 0) :
    Rat.AbsoluteValue.real x * ∏ p : rationalPrimeSupport x, Rat.AbsoluteValue.padic p.1 x = 1 := by
  have hnum_ne_zero : x.num.natAbs ≠ 0 := by
    simpa using Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hx)
  have hpadic (p : rationalPrimeSupport x) :
      Rat.AbsoluteValue.padic p.1 x =
        ((((p.1 : ℚ) ^ (x.den.factorization p.1 : ℤ)) /
          ((p.1 : ℚ) ^ (x.num.natAbs.factorization p.1 : ℤ)) : ℚ) : ℝ) := by
    rw [Rat.AbsoluteValue.padic_eq_padicNorm, padicNorm.eq_zpow_of_nonzero hx]
    rw [padicValRat_def, padicValInt]
    rw [← Nat.factorization_def x.num.natAbs Fact.out, ← Nat.factorization_def x.den Fact.out]
    rw [neg_sub, sub_eq_add_neg, zpow_add₀]
    · rw [zpow_natCast, zpow_neg, zpow_natCast, div_eq_mul_inv]
    · exact_mod_cast (Fact.out : p.1.Prime).ne_zero
  have hnum_prod :
      ∏ p ∈ x.num.natAbs.primeFactors, ((p : ℚ) ^ (x.num.natAbs.factorization p : ℤ)) =
        (x.num.natAbs : ℚ) := by
    exact_mod_cast (Nat.prod_factorization_pow_eq_self hnum_ne_zero)
  have hden_prod :
      ∏ p ∈ x.den.primeFactors, ((p : ℚ) ^ (x.den.factorization p : ℤ)) = (x.den : ℚ) := by
    exact_mod_cast (Nat.prod_factorization_pow_eq_self (Rat.den_ne_zero _))
  have hs_num :
      ∏ p ∈ rationalPrimeSupport x, ((p : ℚ) ^ (x.num.natAbs.factorization p : ℤ)) =
        (x.num.natAbs : ℚ) := by
    rw [show rationalPrimeSupport x = x.num.natAbs.primeFactors ∪ x.den.primeFactors by rfl]
    rw [Finset.prod_union_eq_left]
    · exact hnum_prod
    · intro p hpden hpnum
      have hnodvd : ¬ p ∣ x.num.natAbs := by
        intro hdiv
        exact hpnum <|
          Nat.mem_primeFactors.mpr ⟨Nat.prime_of_mem_primeFactors hpden, hdiv, hnum_ne_zero⟩
      simp [Nat.factorization_eq_zero_of_not_dvd hnodvd]
  have hs_den :
      ∏ p ∈ rationalPrimeSupport x, ((p : ℚ) ^ (x.den.factorization p : ℤ)) = (x.den : ℚ) := by
    rw [show rationalPrimeSupport x = x.num.natAbs.primeFactors ∪ x.den.primeFactors by rfl]
    rw [Finset.prod_union_eq_right]
    · exact hden_prod
    · intro p hpnum hpden
      have hnodvd : ¬ p ∣ x.den := by
        intro hdiv
        exact hpden <|
          Nat.mem_primeFactors.mpr
            ⟨Nat.prime_of_mem_primeFactors hpnum, hdiv, Rat.den_ne_zero _⟩
      simp [Nat.factorization_eq_zero_of_not_dvd hnodvd]
  have hq_nat :
      ((x.num.natAbs : ℚ) / x.den : ℚ) *
          ∏ p ∈ rationalPrimeSupport x,
            (((p : ℚ) ^ (x.den.factorization p : ℤ)) /
              ((p : ℚ) ^ (x.num.natAbs.factorization p : ℤ)) : ℚ) = 1 := by
    rw [Finset.prod_div_distrib, hs_den, hs_num]
    field_simp
  have hq :
      ((x.num.natAbs : ℚ) / x.den : ℚ) *
          ∏ p : rationalPrimeSupport x,
            (((p.1 : ℚ) ^ (x.den.factorization p.1 : ℤ)) /
              ((p.1 : ℚ) ^ (x.num.natAbs.factorization p.1 : ℤ)) : ℚ) = 1 := by
    have hattach :
        ∏ i ∈ (rationalPrimeSupport x).attach,
            (((i.1 : ℚ) ^ (x.den.factorization i.1 : ℤ)) /
              ((i.1 : ℚ) ^ (x.num.natAbs.factorization i.1 : ℤ)) : ℚ) =
          ∏ p ∈ rationalPrimeSupport x,
            (((p : ℚ) ^ (x.den.factorization p : ℤ)) /
              ((p : ℚ) ^ (x.num.natAbs.factorization p : ℤ)) : ℚ) := by
      simpa using
        (Finset.prod_attach (s := rationalPrimeSupport x)
          (f := fun p =>
            (((p : ℚ) ^ (x.den.factorization p : ℤ)) /
              ((p : ℚ) ^ (x.num.natAbs.factorization p : ℤ)) : ℚ)))
    rw [Finset.prod_coe_sort_eq_attach, hattach]
    exact hq_nat
  have habs : (|x| : ℚ) = ((x.num.natAbs : ℚ) / x.den : ℚ) := by
    rw [Rat.abs_def, Rat.divInt_eq_div]
    norm_num
  have habsR : (((|x| : ℚ)) : ℝ) = ((((x.num.natAbs : ℚ) / x.den : ℚ)) : ℝ) := by
    exact congrArg (fun q : ℚ => (q : ℝ)) habs
  calc
    Rat.AbsoluteValue.real x * ∏ p : rationalPrimeSupport x, Rat.AbsoluteValue.padic p.1 x
    _ = ((((x.num.natAbs : ℚ) / x.den : ℚ) : ℝ) *
            ∏ p : rationalPrimeSupport x,
              ((((p.1 : ℚ) ^ (x.den.factorization p.1 : ℤ)) /
                ((p.1 : ℚ) ^ (x.num.natAbs.factorization p.1 : ℤ)) : ℚ) : ℝ)) := by
            rw [Rat.AbsoluteValue.real_eq_abs]
            rw [habsR]
            simp_rw [hpadic]
    _ = 1 := by
      exact_mod_cast hq

end Theorem_01_09

end Chapter1
end SutherlandNumberTheoryLecture1
