import SutherlandNumberTheoryLecture1.Chapter1.«01_10_Definition»

/-!
# Example 1.15: the Laurent-series valuation

The lecture's standard example takes the `t`-adic valuation on the Laurent
series field `k((t))`, identifies the corresponding valuation ring with the
power series ring `k[[t]]`, and interprets the valuation on nonzero elements as
order of vanishing at the origin.

Mathlib already equips `LaurentSeries k` with the `X`-adic valuation extending
the valuation on `PowerSeries k`, so this file records the example using the
bundled `Valued` and `PowerSeries.order` APIs.
-/

open scoped LaurentSeries

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Example_01_15

variable (k : Type*) [Field k]

/-- The bundled `t`-adic valuation on `k((t))`. -/
noncomputable abbrev laurentSeriesValuation :
    Valuation (LaurentSeries k) (WithZero (Multiplicative ℤ)) :=
  Valued.v

/-- The valuation ring cut out by the Laurent-series valuation. -/
noncomputable abbrev laurentSeriesValuationRing : ValuationSubring (LaurentSeries k) :=
  (laurentSeriesValuation k).valuationSubring

/-- The power-series subring inside the Laurent-series field. -/
noncomputable abbrev powerSeriesSubring : Subring (LaurentSeries k) :=
  LaurentSeries.powerSeries_as_subring k

/-- The order of vanishing at `0` for a power series. -/
noncomputable def orderOfVanishingAtZero (f : PowerSeries k) : ℕ∞ :=
  PowerSeries.order f

/-- The elements with nonnegative valuation are exactly the power series. -/
theorem mem_laurentSeriesValuationRing_iff_exists_powerSeries (f : LaurentSeries k) :
    f ∈ laurentSeriesValuationRing k ↔
      ∃ F : PowerSeries k, HahnSeries.ofPowerSeries ℤ k F = f := by
  simpa [laurentSeriesValuationRing, laurentSeriesValuation, Valuation.mem_valuationSubring_iff]
    using (LaurentSeries.val_le_one_iff_eq_coe (K := k) f)

/-- The lecture's identification `k[[t]] = {f : k((t)) | v(f) ≥ 0}`. -/
theorem laurentSeriesValuationRing_eq_powerSeriesSubring :
    (laurentSeriesValuationRing k).toSubring = powerSeriesSubring k := by
  ext f
  rw [Subring.mem_map]
  simpa [powerSeriesSubring] using
    (mem_laurentSeriesValuationRing_iff_exists_powerSeries (k := k) f)

/-- This wrapper keeps the lecture's "order of vanishing" terminology visible. -/
theorem orderOfVanishingAtZero_eq_order (f : PowerSeries k) :
    orderOfVanishingAtZero k f = PowerSeries.order f := rfl

/-- The order of vanishing records that coefficients below the valuation cutoff vanish. -/
theorem coeff_eq_zero_of_lt_orderOfVanishingAtZero (f : PowerSeries k) {n : ℕ}
    (hn : n < orderOfVanishingAtZero k f) :
    PowerSeries.coeff n f = 0 := by
  exact PowerSeries.coeff_of_lt_order n hn

/-- The lecture's order-of-vanishing valuation at a point `α` is the Laurent expansion analogue
of the `t`-adic case. -/
theorem exists_orderOfVanishingAtPoint_valuation (α : k) :
    ∃ v : Valuation (RatFunc k) (WithZero (Multiplicative ℤ)),
      v (RatFunc.X - RatFunc.C α) = WithZero.exp (-1 : ℤ) := by
  let P : IsDedekindDomain.HeightOneSpectrum (Polynomial k) :=
    { asIdeal := Ideal.span ({Polynomial.X - Polynomial.C α} : Set (Polynomial k))
      isPrime := by
        exact (Ideal.span_singleton_prime (Polynomial.X_sub_C_ne_zero α)).mpr
          (Polynomial.irreducible_X_sub_C α).prime
      ne_bot := by
        exact Ideal.span_singleton_eq_bot.not.mpr (Polynomial.X_sub_C_ne_zero α) }
  have hX_sub_C_ne : Polynomial.X - Polynomial.C α ≠ 0 := Polynomial.X_sub_C_ne_zero α
  have hP_span :
      P.asIdeal = Ideal.span ({Polynomial.X - Polynomial.C α} : Set (Polynomial k)) := rfl
  refine ⟨P.valuation (RatFunc k), ?_⟩
  rw [show RatFunc.X - RatFunc.C α =
      algebraMap (Polynomial k) (RatFunc k) (Polynomial.X - Polynomial.C α) by
        simp [RatFunc.algebraMap_X]]
  rw [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
    IsDedekindDomain.HeightOneSpectrum.intValuation_singleton _ hX_sub_C_ne hP_span]

end Example_01_15

end Chapter1
end SutherlandNumberTheoryLecture1
