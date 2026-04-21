import Mathlib

/-!
# Proof of Proposition 1.22

The lecture proves that `ℤ` is integrally closed by applying the rational-root
test to a rational number integral over `ℤ`. Proposition 1.22 itself is already
packaged in Mathlib as the bundled instance `IsIntegrallyClosed ℤ`; this proof
blob records the lecture's argument directly using Mathlib's monic rational-root
theorem and the denominator-one API for rationals.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Proof_01_22

/-- The lecture's rational-root-test step: an element of `ℚ` integral over `ℤ`
is already an integer in the localization sense. -/
theorem rat_isInteger_of_isIntegral (q : ℚ) (hq : IsIntegral ℤ q) :
    IsLocalization.IsInteger ℤ q := by
  rcases hq with ⟨p, hp, hroot⟩
  exact isInteger_of_is_root_of_monic hp hroot

/-- The denominator of a rational integral over `ℤ` is `1`. -/
theorem rat_den_eq_one_of_isIntegral (q : ℚ) (hq : IsIntegral ℤ q) :
    q.den = 1 := by
  have hRange : q ∈ Set.range Int.cast := by
    simpa using (Rat.isLocalizationIsInteger_iff q).mp (rat_isInteger_of_isIntegral q hq)
  rcases hRange with ⟨z, hz⟩
  simpa [hz] using Rat.den_intCast z

/-- The final textbook conclusion: an integral rational equals the integer given
by its numerator. -/
theorem rat_num_eq_of_isIntegral (q : ℚ) (hq : IsIntegral ℤ q) :
    (q.num : ℚ) = q := by
  exact (Rat.den_eq_one_iff q).mp (rat_den_eq_one_of_isIntegral q hq)

/-- Rewriting the conclusion as explicit membership in `ℤ`. -/
theorem rat_exists_int_of_isIntegral (q : ℚ) (hq : IsIntegral ℤ q) :
    ∃ z : ℤ, (z : ℚ) = q := by
  exact ⟨q.num, Rat.coe_int_num_of_den_eq_one (rat_den_eq_one_of_isIntegral q hq)⟩

end Proof_01_22

end Chapter1
end SutherlandNumberTheoryLecture1
