-- Specification du paquetage Itineraires

with Chaines, Graphes, Codages, Types_Base ; 
use  Chaines, Graphes, Codages, Types_Base ; 

package Itineraires is

   -- Lecture du graphe des villes sur l'entree standard
   -- Max_Sommets est le nombre maximal de sommets du graphe.
   -- En sortie, G est le graphe des villes, Cod est le codage des noms de 
   -- villes par les sommets du graphe.
   -- Pour chaque paire de villes on ajoute deux arcs V1->V2 et V2->V1.
   procedure Lire_Graphe_Villes(Max_Sommets : in Natural ; G : out Graphe ; Cod : out Codage) ; 
   procedure Lire_Graphe_Villes (Max_Sommets : in Natural ; G : out Graphe ; Cod : out Codage ; nb_sommet, nb_arc : out Natural) ;


   -- Affichage d'un graphe des villes : pour chaque ville V,
   -- on affiche la liste des villes directement connectees avec V, avec
   -- leur distance a V.
   -- G est le graphe des villes.
   -- Cod est le codage des noms de villes par les sommets du graphe.
   procedure Afficher_Graphe_Villes(G : in Graphe ; Cod : in Codage) ; 
   procedure print(G : in Graphe ; Cod : in Codage);

   -- Calcul de l'itineraire le plus court entre deux villes
   -- Ville_Depart et Ville_Arrivee. 
   -- G est le graphe des villes.
   -- Cod est le codage des noms de villes par les sommets du graphe.
   -- Si Ville_Depart ou Ville_Arrivee ne sont pas des noms de 
   -- villes repertoriees dans Cod, un message d'erreur est affiche
   function Calculer_Itineraire (G : in Graphe ; Cod : in Codage ; Ville_Depart, Ville_Arrivee : in Chaine) return Liste_Couple; 
   procedure Calculer_Itineraire(G : in Graphe ; Cod : in Codage ; Ville_Depart, Ville_Arrivee, Ville_Via, Ville_Interdite : in Chaine ; Villes : out Liste_Couple ; chemin_long, nb_villes : out Natural);


   -- Affichage d'une liste de villes avec la distance 
   -- L est la liste qui contient les sommets 
   -- Cod est le codage des noms de villes par les sommets du graphe
   procedure Afficher_Liste_Villes_Distances(L : in Liste_Couple ; Cod : in Codage);
   procedure print(L : in Liste_Couple ; Cod : in Codage);

   Erreur_Itineraires : exception ; 

end ; 

