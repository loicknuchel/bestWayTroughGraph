-- Specification du paquetage Machine_Car de lecture de caracteres

with Ada.Characters.Latin_1 ; 
use  Ada.Characters.Latin_1 ;

package Machine_Car is 

   -- Le caractere courant
   function Car_Cour return Character ;

   -- Les deux constantes Car_NUL et Car_LF, de type Character, representent 
   -- respectivement fin de fichier et fin de ligne
   Car_NUL : constant Character := Ada.Characters.Latin_1.NUL ; 
   Car_LF  : constant Character := Ada.Characters.Latin_1.LF ; 

   -- Passage au caractere suivant
   -- Precondition : Car_Cour /= Car_NUL 
   procedure Car_Suiv ;

   -- Initialisation de la machine caracteres
   procedure Init_Machine_Car ;

   -- Numero de la ligne courante
   function Ligne_Cour return Natural ;

   -- Passe les caracteres en attente 
   procedure Vider_Caracteres_En_Attente ; 

   -- Exception levee si une precondition n'est pas respectee
   Erreur_Machine_Car : exception ; 

end Machine_Car ;

