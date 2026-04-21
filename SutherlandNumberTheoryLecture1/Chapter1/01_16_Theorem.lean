import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_15a_Discussion»

/-!
# Theorem 1.16: equivalent characterizations of DVRs

The lecture lists seven equivalent ways to recognize a discrete valuation ring.
Mathlib's main anchor is `IsDiscreteValuationRing.TFAE`, which already bundles
most of the local/noetherian characterizations. The remaining lecture phrasing is
recorded here as explicit Lean predicates so the later proof file can bridge the
book's wording to the bundled theorem.

The final bullet's "maximal noetherian ring of dimension one" language is
formalized as a noetherian one-dimensional domain that admits no proper
intermediate `A`-subalgebra inside its fraction field.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Theorem_01_16

variable (A : Type*) [CommRing A] [IsDomain A]

/-- Bullet 1: `A` is a discrete valuation ring. -/
def IsDvr : Prop :=
  IsDiscreteValuationRing A

/-- Bullet 2: `A` is a noetherian valuation ring that is not a field. -/
def IsNoetherianValuationRingNotField : Prop :=
  ∃ (_ : IsNoetherianRing A) (_ : ValuationRing A), ¬ IsField A

/-- Bullet 3: `A` is a local PID that is not a field. -/
def IsLocalPidNotField : Prop :=
  ∃ (_ : IsLocalRing A) (_ : IsPrincipalIdealRing A), ¬ IsField A

/-- Bullet 4: `A` is an integrally closed noetherian local ring of dimension one. -/
def IsIntegrallyClosedNoetherianLocalDimOne : Prop :=
  ∃ (_ : IsNoetherianRing A) (_ : IsLocalRing A), IsIntegrallyClosed A ∧ ringKrullDim A = 1

/-- Bullet 5: `A` is a regular noetherian local ring of dimension one. -/
def IsRegularNoetherianLocalDimOne : Prop :=
  ∃ (_ : IsNoetherianRing A) (_ : IsLocalRing A) (_ : IsRegularLocalRing A),
    ringKrullDim A = 1

/-- Bullet 6: `A` is a noetherian local ring whose maximal ideal is nonzero and principal. -/
def HasPrincipalNonzeroMaximalIdeal : Prop :=
  ∃ (_ : IsNoetherianRing A) (_ : IsLocalRing A),
    IsLocalRing.maximalIdeal A ≠ ⊥ ∧ (IsLocalRing.maximalIdeal A).IsPrincipal

/-- Bullet 7: `A` is a maximal noetherian ring of dimension one inside its fraction field. -/
def IsMaximalNoetherianRingOfDimOne : Prop :=
  ∃ (_ : IsNoetherianRing A), ringKrullDim A = 1 ∧
    ∀ S : Subalgebra A (FractionRing A), S ≠ ⊤ → S = ⊥

/-- The lecture's seven characterizations of DVRs, packaged as a single TFAE statement. -/
theorem dvr_characterization_tfae :
    List.TFAE
      [IsDvr A,
        IsNoetherianValuationRingNotField A,
        IsLocalPidNotField A,
        IsIntegrallyClosedNoetherianLocalDimOne A,
        IsRegularNoetherianLocalDimOne A,
        HasPrincipalNonzeroMaximalIdeal A,
        IsMaximalNoetherianRingOfDimOne A] := by
  sorry

end Theorem_01_16

end Chapter1
end SutherlandNumberTheoryLecture1
