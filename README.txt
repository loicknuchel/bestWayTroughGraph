TP5  Itineraire
===============
Le but general de ce TP est decrire un programme qui permet de calculer a partir d'une ville de depart et d'une ville d'arrivee :
- L'itineraire le plus court entre ces deux villes
- Les villes a traverser
- La distance totale du plus court chemin

Pour cela, on dispose d'un fichier qui contient une liste de triplets de la forme (Ville1, Ville2, D), indiquant que les villes Ville1 et Ville2 sont directement connectees et a distance D. Un triplet peut soit introduire une nouvelle donnee, soit assurer une correction de distance entre deux villes. L'ensemble des triplets permet l'initialisation du systeme.

Les fichiers correspondant a ce TP se trouvent dans ~devernay/TPAlgo05/TP5_Itineraires.



Partie1 : Construction de graphe.
Completez la fonction Lire_Graphe_Villes dans itineraires.adb. Pour ce faire, utilisez le paquetage Lecture pour lire les triplets, le paquetage Codage pour coder les villes et le paquetage Graphe pour construire le graphe. Pour chaque ville, on ajoute seulement un sommet au graphe. Pour chaque paire de villes on ajoute deux arcs (ville1->ville2 et ville2->ville1). Ces arcs contiennent la distance. Le fichier test_itineraires.adb permet de tester cette construction de graphe.

Partie2 : Realisation d'une file d'attente avec priorite.
Cette file d'attente est dans la suite utilisee dans l'algorithme de Dijkstra. Une file d'attente avec priorite est une structure permettant de stocker des objets dont chacun est muni d'une valeur de priorite. Les operations usuelles sont l'ajout d'un element et la suppression d'un element de priorite maximale. 

Implementez un paquetage generique PTas pour une file d'attente qui est a realiser avec un tas (ptas.ads et ptas.adb). Les objets et les priorites sont de type quelconque. Il s'agit de realiser les fonctions/procedures suivantes :
- creation_tas
- Est_Vide, Est_Pleine
- Inserer (ajouter un nouvel objet dans la file)
- Oter_min (Suppression d'un objet de priorite maximale)
- acces_min (Acces a un objet de priorite maximale)


Partie3 : Calcul du plus court chemin.
Completez le paquetage chemins.adb pour le calcul du plus court chemin (algorithme de Dijkstra). Pensez a utiliser le paquetage PTas. Le calcul du plus court chemin est appele par la fonction Calculer-Itineraire dans itineraires.adb.


Impression des fichiers ptas.ads, ptas.adb, test_ptas.adb, itineraires.adb et chemins.adb.
Envoi par mail de ces fichiers (frederic.devernay@inrialpes.fr)
