import Mathlib
import SutherlandNumberTheoryLecture1.Chapter1.«01_15a_Discussion»

/-!
# Theorem 1.16

The lecture lists seven equivalent ways to recognize a discrete valuation ring.
This theorem file packages those seven bullets as explicit Lean predicates. The
proofs of equivalence live in the companion `01_16_Proof` item file so the
entire formalization stays within tracked book items.
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

end Theorem_01_16

end Chapter1
end SutherlandNumberTheoryLecture1
