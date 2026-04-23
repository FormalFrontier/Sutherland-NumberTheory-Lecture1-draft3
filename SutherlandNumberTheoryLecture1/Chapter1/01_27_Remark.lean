import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
# Remark 1.27: orders and the maximal order `O_K`

The lecture uses `\mathcal{O}_K` to stress that the ring of integers of a number
field `K` is an order in `K`. For a finite-dimensional `ℚ`-algebra `K`, the
book defines an order as a subring that is also a free `ℤ`-module of full rank;
equivalently, it is a full-rank `ℤ`-lattice in `K` that is closed under
multiplication and contains `1`.

Mathlib already packages the maximal order itself as `NumberField.RingOfIntegers K`.
This file makes the lecture's surrounding order-language explicit by:

- defining the local predicate `IsOrder` on `Subalgebra ℤ K`;
- separating the lattice-only formulation from the ring-closure conditions;
- expressing maximality by the canonical `ℤ`-algebra map from any order into
  `NumberField.RingOfIntegers K`.
-/

namespace SutherlandNumberTheoryLecture1
namespace Chapter1

section Remark_01_27

variable (K : Type*) [Field K] [NumberField K]

/-- Remark 1.27 notes that `\mathbf{Z}_K` is also used for the ring of integers
of `K`; we record that alternate textbook notation as a local abbreviation. -/
abbrev ZK : Type _ := NumberField.RingOfIntegers K

/-- In the lecture, an order in a finite-dimensional `ℚ`-algebra `K` is a
`ℤ`-subalgebra that is free and finite as a `ℤ`-module, with rank equal to
`[K : ℚ]`. -/
def IsOrder (O : Subalgebra ℤ K) : Prop :=
  Module.Free ℤ O ∧
    Module.Finite ℤ O ∧
    Module.finrank ℤ O = Module.finrank ℚ K

/-- The lattice portion of the lecture's order definition, separated from the
ring structure. -/
def IsZLattice (L : Submodule ℤ K) : Prop :=
  Module.Free ℤ L ∧
    Module.Finite ℤ L ∧
    Module.finrank ℤ L = Module.finrank ℚ K

/-- A `ℤ`-submodule of `K` is "also a ring" in the sense of Remark 1.27 if it
contains `1` and is closed under multiplication. -/
def IsRingSubmodule (L : Submodule ℤ K) : Prop :=
  (1 : K) ∈ L ∧ ∀ ⦃x y : K⦄, x ∈ L → y ∈ L → x * y ∈ L

/-- The alternate notation `\mathbf{Z}_K` denotes the same ring of integers as
`\mathcal{O}_K`. -/
theorem zk_eq_ringOfIntegers (K : Type*) [Field K] [NumberField K] :
    ZK K = NumberField.RingOfIntegers K :=
  rfl

/-- Remark 1.27's two descriptions of an order are equivalent for a bundled
`ℤ`-subalgebra: the order predicate is exactly the statement that the underlying
`ℤ`-submodule is a full-rank lattice, together with the evident ring-closure
properties. -/
theorem isOrder_iff_isZLattice_and_isRingSubmodule (O : Subalgebra ℤ K) :
    IsOrder K O ↔ IsZLattice K O.toSubmodule ∧ IsRingSubmodule K O.toSubmodule := by
  constructor
  · rintro ⟨hfree, hfinite, hrank⟩
    refine ⟨?_, ?_⟩
    · simpa [IsZLattice, Subalgebra.finrank_toSubmodule] using ⟨hfree, hfinite, hrank⟩
    · change (1 : K) ∈ O.toSubmodule ∧
        ∀ ⦃x y : K⦄, x ∈ O.toSubmodule → y ∈ O.toSubmodule → x * y ∈ O.toSubmodule
      constructor
      · exact O.one_mem
      · intro x y hx hy
        exact O.mul_mem hx hy
  · rintro ⟨hLattice, _⟩
    rcases hLattice with ⟨hfree, hfinite, hrank⟩
    refine ⟨by simpa using hfree, by simpa using hfinite, ?_⟩
    simpa [IsZLattice, Subalgebra.finrank_toSubmodule] using hrank

/-- Any order is integral over `ℤ`, since it is finite as a `ℤ`-module. -/
theorem isIntegral_order (O : Subalgebra ℤ K) (hO : IsOrder K O) :
    Algebra.IsIntegral ℤ O := by
  rcases hO with ⟨_, hfinite, _⟩
  letI : Module.Finite ℤ O := hfinite
  infer_instance

/-- The maximal-order clause of Remark 1.27: every order in `K` maps canonically
into Mathlib's bundled ring of integers. This `AlgHom` realizes the textbook's
"contains every order" statement inside the ambient field `K`. -/
noncomputable def orderToRingOfIntegers (O : Subalgebra ℤ K) (hO : IsOrder K O) :
    O →ₐ[ℤ] NumberField.RingOfIntegers K := by
  letI : Algebra.IsIntegral ℤ O := isIntegral_order K O hO
  exact (IsIntegralClosure.lift ℤ (NumberField.RingOfIntegers K) K : O →ₐ[ℤ]
    NumberField.RingOfIntegers K)

/-- After composing `orderToRingOfIntegers` with the inclusion of
`NumberField.RingOfIntegers K` into `K`, one recovers the original inclusion of
the order into `K`. -/
theorem ringOfIntegers_contains_every_order (O : Subalgebra ℤ K) (hO : IsOrder K O) :
    (algebraMap (NumberField.RingOfIntegers K) K).comp (orderToRingOfIntegers K O hO) =
      algebraMap O K := by
  letI : Algebra.IsIntegral ℤ O := isIntegral_order K O hO
  ext x
  simp [orderToRingOfIntegers, IsIntegralClosure.algebraMap_lift]

end Remark_01_27

end Chapter1
end SutherlandNumberTheoryLecture1
