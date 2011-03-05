-- Paquetage Codages.
-- Ce paquetage permet de definir un codage entre un ensemble de n chaines 
-- de caracteres et les sommets de 1 a n.
-- Acces_Sommet permet d'obtenir le sommet associe a une chaine. 
-- Acces_Chaine permet d'obtenir la chaine associee a un sommet. 

with Types_Base, Chaines ; 
use Types_Base, Chaines ; 

-- le type Sommet est defini dans Type_Base
-- le type Chaine est defini dans Chaines

package Codages is

   -- Le type Codage
   type Codage is private ; 

   -- Creation_Codage(Taille_Max) cree un codage ne comprenant aucune chaine 
   -- de caracteres. Taille_Max est le nombre maximal de chaines que peut
   -- contenir le codage. 
   function Creation_Codage(Taille_Max : Natural) return Codage ; 

   -- Dernier_Sommet(Cod) est le nombre de sommets (egal au nombre de 
   -- chaines de caracteres) que contient le codage Cod.
   function Dernier_Sommet(Cod : Codage) return Sommet ; 

   -- Acces_Chaine(cod, X) est la chaine associee au sommet X dans le codage 
   -- Cod.
   -- Precondition : 1 <= X <= Dernier_Sommet(Cod)
   function Acces_Chaine(Cod : Codage ; X : Sommet) return Chaine ; 

   -- Appartient_Codage(Cod, C) est vrai ssi la chaine C appartient 
   -- au codage Cod.
   function Appartient_Codage(Cod : Codage ;  C : Chaine) return Boolean ; 

   -- Acces_Sommet(Cod, C) est le sommet associe a la chaine C dans le codage 
   -- Cod.
   -- Precondition : la chaine C appartient au codage Cod.
   function Acces_Sommet(Cod : Codage ; C : Chaine) return Sommet ; 

   -- Chercher_Sommet(Cod, C, Present, X) cherche le sommet associe
   -- a la chaine C. 
   -- Si C ne fait pas partie du codage, Present = faux.
   -- Sinon, Present = vrai et X est le sommet associe a la chaine
   procedure Chercher_Sommet(Cod : in Codage ; C : in Chaine ; Present : out Boolean ; X : out Sommet) ; 

   -- Chercher_Inserer_Sommet(cod, C, X) cherche le sommet associe a la 
   -- chaine C. Si C ne fait pas partie du codage, on l'ajoute.
   -- En sortie, X est le sommet associe a C.
   -- Precondition : Dernier_Sommet(Cod) est strictement inferieur a la 
   -- taille maximum de Cod.
   procedure Chercher_Inserer_Sommet(Cod : in Codage ; C : in Chaine ; X : out Sommet) ; 

   -- Exception levee lorsqu'une precondition n'est pas verifiee.
   Erreur_Codage : exception ; 

private

   type Structure_Codage ; 
   type Codage is access Structure_Codage ; 

end ; 

