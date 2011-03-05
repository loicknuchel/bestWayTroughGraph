-- Corps du paquetage Types_Base

package body Types_Base is

   type Structure_Couple is 
      record 
         Som : Sommet ; 
         Dist : Distance ; 
      end record ; 

   type Structure_Liste_Couple is
      record 
         Prem : Couple ; 
         Suiv : Liste_Couple ; 
      end record ; 
----------------------------------------------------------------------------
   function Creation_Couple(X : Sommet ; D : Distance) return Couple is
   begin
      return new Structure_Couple'(X, D) ; 
   end ; 
-----------------------------------------------------------------------------

   function Acces_Sommet(C : Couple) return Sommet is
   begin
      return C.Som ;
   exception
      when Constraint_Error => raise Erreur_Couple ; 
   end ; 
-----------------------------------------------------------------------------

   function Acces_Distance(C : Couple) return Distance is
   begin
      return C.Dist ; 
   exception 
      when Constraint_Error => raise Erreur_Couple ; 
   end ; 

   procedure Changer_Sommet(C : in Couple ; X : in Sommet) is
   begin
      C.Som := X ; 
   exception 
      when Constraint_Error => raise Erreur_Couple ; 
   end ; 
-------------------------------------------------------------------------------
   procedure Changer_Distance(C : in Couple ; D : in Distance) is
   begin
      C.Dist := D ; 
   exception 
      when Constraint_Error => raise Erreur_Couple ; 
   end ; 
-------------------------------------------------------------------------------
   function Creation_Liste(C : Couple ; L : Liste_Couple) return Liste_Couple is
   begin
      return new Structure_Liste_Couple'(C, L) ; 
   end ; 
-------------------------------------------------------------------------------

   function Acces_Premier(L : Liste_Couple) return Couple is
   begin
      return L.Prem ; 
   exception 
      when Constraint_Error => raise Erreur_Liste_Couple ; 
   end ; 
-------------------------------------------------------------------------------

   function Acces_Suivant(L : Liste_Couple) return Liste_Couple is
   begin
      return L.Suiv ; 
   exception 
      when Constraint_Error => raise Erreur_Liste_Couple ; 
   end ; 
------------------------------------------------------------------------------

   procedure Changer_Premier(L : in Liste_Couple ; C : in Couple) is
   begin
      L.Prem := C ; 
   exception 
      when Constraint_Error => raise Erreur_Liste_Couple ; 
   end ; 
------------------------------------------------------------------------------

   procedure Changer_Suivant(L : in Liste_Couple ; Suiv : in Liste_Couple) is
   begin
      L.Suiv := Suiv ; 
   exception
      when Constraint_Error => raise Erreur_Liste_Couple ; 
   end ; 
 
end ; 
