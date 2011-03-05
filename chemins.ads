-- Specification du paquetage Chemins
-- Calcul du plus court chemin entre deux sommets dans un graphe

with Types_Base, Graphes ; 
use  Types_Base, Graphes ; 

package Chemins is
   
   type chemin is private ;
   
   Infinite : constant Distance := Distance (Integer'Last) ; 
   XnoDelault : constant Sommet := 0 ;
   
   -- Plus_Court_Chemin(G, X1, Xn) est la liste de couples (Sommet, Distance)
   --     [(X1, D1), (X2, D2), (X3, D3), ... (Xn, Dn)] ou 
   -- Di est la distance entre les sommets X1 et Xi ;
   -- et (X1, X2, ... Xn) est le plus court chemin entre X1 et Xn
   -- dans le graphe G.
   -- S'il n'existe pas de chemin entre X1 et Xn, 
   -- Plus_Court_Chemin(G, X1, Xn) = Liste_Vide.
   function Plus_Court_Chemin(G : Graphe ; Xdep, Xarr : Sommet) return Liste_Couple ;
   --procedure My_Plus_Court_Chemin(G : in Graphe ; Xdep, Xarr : in Sommet ; Villes : out Liste_Couple ; chemin_long, nb_villes : out Natural);
   procedure My_Plus_Court_Chemin(G : in Graphe ; Xdep, Xarr, Xno : in Sommet ; Villes : out Liste_Couple ; chemin_long, nb_villes : out Natural);

   Erreur_Chemins : exception ; 

private 

   type structure_chemin ; 
   type chemin is access structure_chemin ; 
   
end ;

