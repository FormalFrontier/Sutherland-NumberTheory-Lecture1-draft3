import Mathlib

open Polynomial

/-!
# Introduction 1.0: Global-field vocabulary

The lecture opens by packaging the standard ambient objects that motivate the rest
of Chapter 1: prime fields, number fields, the `F_q[t]`/`ℤ` analogy, and global
function fields. Mathlib already bundles these notions through characteristic-based
algebra maps, `NumberField`, `AdjoinRoot`, `RatFunc`, and `FunctionField`.

The final paragraph of the blob surveys completions and local fields. That material
belongs to the later valuation/completion development, so it remains commentary here
rather than blocking the current Stage 3.1 scaffold.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Introduction_01_00

variable (K : Type*) [Field K]

/-- The lecture's ambient starting ring `ℤ` is a principal ideal domain. -/
theorem int_isPID : IsPrincipalIdealRing ℤ := by
  infer_instance

/-- The lecture's field of fractions of `ℤ` is Mathlib's `ℚ`. -/
theorem int_fractionRing_isRat : IsFractionRing ℤ ℚ := by
  infer_instance

/-- Quotienting `ℤ` by the principal ideal `(p)` gives the prime field `𝔽_p`. -/
def int_quotient_span_nat_equiv_zmod (p : ℕ) :
    (ℤ ⧸ Ideal.span ({(p : ℤ)} : Set ℤ)) ≃+* ZMod p := by
  exact Int.quotientSpanNatEquivZMod p

/-- In characteristic zero, the lecture's prime field is `ℚ`. -/
theorem charZero_contains_rat [CharZero K] : Nonempty (Algebra ℚ K) := by
  exact ⟨inferInstance⟩

/-- In characteristic `p`, the lecture's prime field is `𝔽_p`, realized as `ZMod p`. -/
theorem charP_contains_zmod (p : ℕ) [Fact p.Prime] [CharP K p] :
    Nonempty (Algebra (ZMod p) K) := by
  letI : Algebra (ZMod p) K := ZMod.algebra K p
  exact ⟨inferInstance⟩

/-- A bundled number field is, by definition, a finite extension of `ℚ`. -/
theorem numberField_isFiniteExtension [NumberField K] : FiniteDimensional ℚ K := by
  infer_instance

/-- The lecture's quotients `ℚ[X]/(f)` by irreducibles are fields in Mathlib via `AdjoinRoot`. -/
theorem quotientByIrreducibleField (f : Polynomial ℚ) [Fact (Irreducible f)] :
    Nonempty (Field (AdjoinRoot f)) := by
  exact ⟨inferInstance⟩

/-- These irreducible polynomial quotients are the lecture's basic examples of number fields. -/
theorem quotient_by_irreducible_isNumberField (f : Polynomial ℚ) [Fact (Irreducible f)] :
    NumberField (AdjoinRoot f) := by
  infer_instance

/-- The lecture's presentation of number fields uses that `ℚ[X]` is a PID. -/
theorem rational_polynomial_isPID : IsPrincipalIdealRing (Polynomial ℚ) := by
  infer_instance

/-- Over a field, irreducible polynomials generate maximal ideals, matching the quotient
presentation used for the lecture's number-field examples. -/
theorem irreducible_generates_maximal_ideal_over_rat
    (f : Polynomial ℚ) [Fact (Irreducible f)] :
    (Ideal.span ({f} : Set (Polynomial ℚ))).IsMaximal := by
  sorry

variable (Fq F : Type*) [Field Fq] [Field F] [Algebra (RatFunc Fq) F]

/-- Mathlib's `FunctionField` predicate packages the lecture's definition of a global function
field as a finite extension of `F_q(t)`. -/
theorem globalFunctionField_isFiniteExtension [FunctionField Fq F] :
    FiniteDimensional (RatFunc Fq) F := by
  infer_instance

/-- The `F_q[t]` side of the lecture's analogy uses the standard PID instance for polynomial
rings over fields. -/
theorem polynomial_over_field_isPID : IsPrincipalIdealRing (Polynomial Fq) := by
  infer_instance

/-- Quotients of `F_q[t]` by irreducibles are fields, matching the residue-field part of the
lecture's `F_q[t]` versus `ℤ` analogy. -/
theorem quotientByIrreducibleOverFunctionFieldBaseField
    (f : Polynomial Fq) [Fact (Irreducible f)] : Nonempty (Field (AdjoinRoot f)) := by
  exact ⟨inferInstance⟩

/-- When the coefficient field is finite, the lecture further records these residue fields as
finite fields. We isolate that claim here for later proof refinement. -/
theorem quotient_by_irreducible_over_finite_field_isFinite
    [Finite Fq] (f : Polynomial Fq) [Fact (Irreducible f)] : Finite (AdjoinRoot f) := by
  sorry

/-- The lecture sharpens the previous residue-field claim by identifying the quotient with a
finite field of size `q^d`, where `q = |F_q|` and `d = deg f`. -/
theorem quotient_by_irreducible_over_finite_field_card
    [Finite Fq] (f : Polynomial Fq) [Fact (Irreducible f)] :
    Nat.card (AdjoinRoot f) = Nat.card Fq ^ f.natDegree := by
  sorry

end Introduction_01_00

end Chapter1
end SutherlandNumberTheoryLecture1
