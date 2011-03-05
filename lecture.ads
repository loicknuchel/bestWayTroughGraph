-- Specification du paquetage Lecture d'analyse syntaxique des donnees
   
with Chaines ;
use Chaines ;

package Lecture is


   -- Initialisation de la lecture des triplets
   -- Init_Lecture appelle Init_Machine_Car
   -- Init_Machine_Car initialise cour et va à Car_Suiv
   -- Car_Suiv lit les caractères de la chaîne et fait attention aux erreurs possibles
   procedure Init_Lecture ;
   
   -- fin_lecture = true ssi apres avoir passe les separateurs, on est en fin 
   -- de fichier 
   function Fin_Lecture return Boolean ;

   -- Lecture du prochain triplet
   -- Precondition : fin_lecture = false
   -- Les noms de ville sont mis en majuscules.
   procedure Lire_Triplet (V1, V2 : out Chaine ; D : out Natural) ;
   
   -- 

   -- exception pour les erreurs de syntaxe
   Erreur_Syntaxe : exception ;

   -- exception levee si une precondition n'est pas respectee
   Erreur_Lecture : exception ; 

end Lecture ;
 
