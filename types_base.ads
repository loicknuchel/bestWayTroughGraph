-- Le paquetage Types_Base definit quelques types de base : 
--   . le type 'Sommet'      (pour les sommets d'un graphe)
--   . le type 'Distance'    (pour les distances entre deux sommets)
--   . le type 'Couple' : couple (sommet, distance)
--   . le type 'Liste_Couple' : liste de couples (sommet, distance)
-- Les types 'Couple' et 'Liste_Couple' sont definis comme des types
-- abstraits, avec constructeurs, selecteurs et mutateurs.
-- Ils sont implantes a l'aide de pointeurs (on a donc une "semantique des 
-- pointeurs" pour les affectations et les tests d'egalite).

package Types_Base is

   -----------------
   -- Le type Sommet 
   -----------------
   type Sommet is new Natural ; 

   -------------------
   -- Le type Distance
   -------------------
   type Distance is new Natural ; 

   -----------------
   -- Le type Couple 
   -----------------
   type Couple is private ; 
   
   -- Couple indefini
   Couple_Indef : constant Couple ; 

   -- Constructeur de couple 
   function Creation_Couple(X : Sommet ; D : Distance) return Couple ; 
 
   -- Selecteur de sommet
   -- Precondition : C /= Couple_Indef
   function Acces_Sommet(C : Couple) return Sommet ; 

   -- Selecteur de distance
   -- Precondition : C /= Couple_Indef
   function Acces_Distance(C : Couple) return Distance ; 

   -- Mutateur de sommet
   -- Precondition : C /= Couple_Indef
   procedure Changer_Sommet(C : in Couple ; X : in Sommet) ; 

   -- Mutateur de distance
   -- Precondition : C /= Couple_Indef
   procedure Changer_Distance(C : in Couple ; D : in Distance) ; 

   -- Exception levee lorsqu'une precondition n'est pas definie dans les 
   -- selecteurs et mutateur de couple
   Erreur_Couple : exception ; 

   -----------------------
   -- Le type Liste_Couple
   -----------------------
   type Liste_Couple is private ; 

   -- Liste vide de couple
   Liste_Vide : constant Liste_Couple ; 

   -- Constructeur de liste
   function Creation_Liste(C : Couple ; L : Liste_Couple) return Liste_Couple ; 

   -- Acces au premier element 
   -- Precondition : L /= Liste_Vide
   function Acces_Premier(L : Liste_Couple) return Couple ; 

   -- Acces au reste de la liste
   -- Precondition : L /= Liste_Vide
   function Acces_Suivant(L : Liste_Couple) return Liste_Couple ; 

   -- Mutation du premier element d'une liste
   -- Precondition : L /= Liste_Vide
   procedure Changer_Premier(L : in Liste_Couple ; C : in Couple) ; 

   -- Mutation du reste d'une liste
   -- Precondition : L /= Liste_Vide
   procedure Changer_Suivant(L : in Liste_Couple ; Suiv : in Liste_Couple) ; 

   -- Exception levee lorsqu'une precondition n'est pas definie dans les 
   -- selecteurs et mutateur de liste_couple
   Erreur_Liste_Couple : exception ; 
   
private 

   type Structure_Couple ; 
   type Couple is access Structure_Couple ; 
   Couple_Indef : constant Couple := null ; 
   type Structure_Liste_Couple ; 
   type Liste_Couple is access Structure_Liste_Couple ; 
   Liste_Vide : constant Liste_Couple := null ; 

end ; 

