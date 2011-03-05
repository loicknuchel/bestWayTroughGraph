-- Corps du paquetage Machine_Car de lecture de caracteres

with Ada.Text_Io ;
use  Ada.Text_Io ;

package body Machine_Car is 

   Cour : Character ;         -- le caractere courant 
   No_Ligne : Natural := 1 ;  -- numero de ligne courant ;

   -- Le caractere courant
   function Car_Cour return Character is 
   begin
      return Cour ;
   end Car_Cour ;
-------------------------------------------------------------------------------

   -- Passage au caractere suivant
   procedure Car_Suiv is 
   begin
      if Car_Cour = Car_NUL then 
         raise Erreur_Machine_Car ;
      elsif End_Of_File then 
         Cour := Car_NUL ; 
      else 
         if End_Of_Line then  
            Cour := Car_LF ;
            Skip_Line ;
            No_Ligne := No_Ligne + 1 ;
         else 
            Get(Cour) ; 
         end if ;
      end if ;
   end Car_Suiv ;

-------------------------------------------------------------------------------
   -- Initialisation de la machine caracteres
   procedure Init_Machine_Car is
   begin
      Cour := ' ' ; 
      Car_Suiv ;
   end Init_Machine_Car ;
-------------------------------------------------------------------------------

   -- Numero de la ligne courante
   function Ligne_Cour return Natural is
   begin
      return No_Ligne ;
   end Ligne_Cour ;
-------------------------------------------------------------------------------

   -- Passe les caracteres en attente 
   procedure Vider_Caracteres_En_Attente is 
   begin
      while Car_Cour /= Car_NUL loop 
         Car_Suiv ; 
      end loop ; 
   end Vider_Caracteres_En_Attente ; 
 
end Machine_Car ;

