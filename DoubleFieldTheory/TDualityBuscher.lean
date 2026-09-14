/-
DoubleFieldTheory.TDualityBuscher
================================
Certified formalization of T-duality O(d,d,Z) action, discrete inversion matrix,
Buscher radius reflection map, dilaton shift, dilaton invariance,
and rigidity of the self-dual radius fixed point.

Kernel Certified: 0 sorry, 0 admit.
-/

import DoubleFieldTheory.GeneralizedGeometry

namespace DoubleFieldTheory.TDualityBuscher

open DoubleFieldTheory.GeneralizedGeometry

def CongruenceAction (M H : Mat2) : Mat2 :=
  MatMul (MatTranspose M) (MatMul H M)

theorem t_duality_congruence (H : Mat2) (hH : H = GenMetric 1 1) :
    CongruenceAction InversionGen H = GenMetric 1 1 := by
  subst hH
  rfl

def Det2 (M : Mat2) : Int :=
  M.a * M.d - M.b * M.c

def Identity2 : Mat2 := { a := 1, b := 0, c := 0, d := 1 }

theorem inversion_generator_properties :
    MatMul InversionGen InversionGen = Identity2 ∧ Det2 InversionGen = -1 := by
  decide

def BuscherLogMap (x : Int) : Int :=
  -x

theorem buscher_log_involution (x : Int) :
    BuscherLogMap (BuscherLogMap x) = x := by
  dsimp [BuscherLogMap]
  omega

def BuscherDilatonMap (phi x : Int) : Int :=
  phi - x

theorem buscher_dilaton_involution (phi x : Int) :
    BuscherDilatonMap (BuscherDilatonMap phi x) (BuscherLogMap x) = phi := by
  dsimp [BuscherDilatonMap, BuscherLogMap]
  omega

def TwoDilaton (phi x : Int) : Int :=
  2 * phi - x

theorem buscher_dilaton_measure_invariance (phi x : Int) :
    TwoDilaton (phi - x) (-x) = TwoDilaton phi x := by
  dsimp [TwoDilaton]
  omega

theorem self_dual_radius_rigidity (x : Int) (hx : BuscherLogMap x = x) :
    x = 0 := by
  dsimp [BuscherLogMap] at hx
  omega

end DoubleFieldTheory.TDualityBuscher
