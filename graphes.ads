
-- Paquetage de construction et manipulation d'un graphe.
-- Les sommets du graphe sont les entiers (de type 'Sommet') 
-- de 1 a Dernier_Sommet.
-- Les arcs sont etiquetes par des distances.

with Types_Base ; 
use  Types_Base ; 

-- Les types Sommet, Distance, Couple et Liste_Couple sont definis 
-- dans Types_Base  


package Graphes is

   -- Le type Graphe
   type Graphe is private ; 

   -- Creation_Graphe(Taille_Max) cree un graphe vide (c'est-a-dire 
   -- ne comportant aucun sommet et aucun arc).
   -- Taille_Max est le nombre maximal de sommets que le graphe pourra 
   -- contenir.
   function Creation_Graphe (Taille_Max : Natural) return Graphe ; 

   -- Les sommets du graphe vont de 1 a Dernier_Sommet(G) 
   function Dernier_Sommet(G : in Graphe) return Sommet ; 
   function Premier_Sommet(G : in Graphe) return Sommet ; 
   function Last_Sommet(G : in Graphe) return Sommet ;

   -- Ajouter_Sommet(G, X) permet d'ajouter un nouveau sommet au graphe G.
   -- X est ce nouveau sommet.
   -- Precondition : Dernier_Sommet(G) est strictement inferieur a la taille
   -- maximum du graphe.
   procedure Ajouter_Sommet(G : in out Graphe ; X : out Sommet) ; 

   -- Si le graphe G contient un arc de X1 vers X2 : la distance associee
   -- a cet arc est modifiee et prend la valeur D.
   -- Sinon, un arc etiquete par la distance D est ajoute dans G.
   -- Precondition : X1 et X2 sont des sommets du graphe.
   procedure Ajouter_Modifier_Arc(G : in out Graphe ; X1, X2 : in Sommet ; D : in Distance) ; 


   -- Liste_Successeurs(G, X) est la liste des successeurs du sommet
   -- X dans le graphe G.
   -- Precondition : X est un sommet du graphe.
   function Liste_Successeurs(G : in Graphe ; X : in Sommet) return Liste_Couple ; 


   -- S'il existe un arc de X1 vers X2 dans G, Succ = vrai et D est la 
   -- distance associee a l'arc.
   -- Sinon Succ = faux.
   -- Precondition : X1 et X2 sont des sommets du graphe.
   procedure Est_Successeur(G : in Graphe ; X1, X2 : Sommet ; Succ : out Boolean ; D : out Distance) ; 
   
   -- affiche le graphe
   procedure print(G : Graphe) ;
   
   
   -- Exception levee losqu'une precondition n'est pas respectee
   Erreur_Graphes : exception ; 

private 

   type Structure_Graphe ; 
   type Graphe is access Structure_Graphe ; 

end ; 

