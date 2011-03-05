-- Procedure de test pour le calcul du plus court chemin entre deux villes.
-- Usage : test_itineraires fichier_test.
-- Le fichier Unix fichier_test contient une liste de triplets.

-- Pour recuperer le nom fichier_test de la commande Unix,
-- on utilise le paquetage Command_Line.
-- Ce paquetage fournit (entre autres) les trois fonctions suivantes :
--  . function Argument_Count return Natural ;
-- qui donne le nombre de parametres de la commande (sans compter
-- la commande elle-meme)
--  . function Argument (Number : in Positive) return String ;
-- qui donne la string associee au i-eme argument de la commande
--  . function Command_Name return String ;
-- qui donne le nom de la commande
-- cf. RM A.15

-- Exemple :
--    test_itineraires fich
-- donne les valeurs suivantes :
--    Argument_Count = 1
--    Argument(1) = "fich"
--    Command_Name = "test_itineraire"

with Chaines, Lecture, Types_Base, Graphes, Codages, Itineraires ; 
use  Chaines, Lecture, Types_Base, Graphes, Codages, Itineraires ;

with Ada.Text_Io, Ada.Command_Line, Ada.Real_Time, Ada.Float_Text_IO ;
use  Ada.Text_Io, Ada.Command_Line, Ada.Real_Time, Ada.Float_Text_IO ;

procedure Test_Itineraires is

	--------------------------------------------------------------------------
	-- Mess_Erreur
	--------------------------------------------------------------------------
	-- Affichage d'un message d'erreur en cas d'utilisation incorrecte
	-- (nombre de parametres different de 1)
	
	procedure Mess_Erreur is
	begin
		Put_Line("Usage : " & Command_Name & " <nom_fichier>") ;
	end Mess_Erreur ;
	
	G : Graphe ; 
	Cod : Codage ; 
	Nb_Max_Villes : constant Natural := 1000000 ; 
	Ville_Depart, Ville_Arrivee, Ville_Via, Ville_Interdite, no_ville : Chaine ; 
	Fich_Entree : File_Type ; 
	L : Liste_Couple;
	nb_arc, nb_sommet : Natural ;
	chemin_long, nb_villes : Natural := 0;
	
	t_debut, t_fin : Time;

begin
   
	if Argument_Count /= 1 then
		Mess_Erreur ;         -- Le nombre de parametres est different de 1
	else
		declare 
			-- Le nom du fichier ou les triplets vont etre lus
			Nom_Fich : constant string := Argument(1) ; 
		begin            
			-- Ouverture du fichier Unix Nom_Fich
			-- Si ce fichier n'existe pas, l'exception Name_Error est levee
			-- On associe au fichier Unix Nom_Fich le fichier Ada Fich_Entree
			Open(Fich_Entree, In_File, Nom_Fich) ;
			
			-- Le fichier d'entree par defaut est Fich_Entree
			Set_Input(Fich_Entree) ;
			
			-- On lit le graphe des villes dans le fichier Nom_Fich
			--Lire_Graphe_Villes(Nb_Max_Villes, G, Cod) ; 
			t_debut := Clock;
			Lire_Graphe_Villes(Nb_Max_Villes, G, Cod, nb_sommet, nb_arc) ; 
			t_fin := Clock;
			
			-- Le fichier d'entree par defaut est l'entree standard
			Set_Input(Standard_Input) ;
			
			new_line ; new_line ;
			Put("Graphe lu :" & Natural'image(nb_sommet) & " sommets et" & Natural'image(nb_arc) & " arcs presents") ; new_line ;
			Put("Temps de lecture : "); 
			Put(Float(To_Duration(t_fin - t_debut)),4,6,0); 
			Put(" secondes"); new_line ; new_line ;
			--Afficher_Graphe_Villes(G, Cod) ;
			if nb_sommet < 50 then Print(G, Cod) ; end if ;
			
			
			no_ville := Creation_Chaine(".") ;
			
			
			while true loop
				Put("*********************************************************************"); new_line ;
				Put("Entrez la ville de depart : ") ; 
				Get_Line(Ville_Depart) ; 
				Majuscule(Ville_Depart) ; 
				
				if Appartient_Codage(Cod, Ville_Depart) = true then
					Put("Entrez la ville d'arrivee : ") ; 
					Get_Line(Ville_Arrivee) ; 
					Majuscule(Ville_Arrivee) ; 
					
					if Appartient_Codage(Cod, Ville_Arrivee) = true then
						Put("Entrez une ville obligatoire ou """ & Acces_String(no_ville) & """ : ") ; 
						Get_Line(Ville_Via) ; 
						Majuscule(Ville_Via) ; 
						if Ville_Via = no_ville then
							Ville_Via := Chaine_Vide ;
						end if ;
						
						if Appartient_Codage(Cod, Ville_Via) = true or Ville_Via = Chaine_Vide then
							Put("Entrez une ville interdite ou """ & Acces_String(no_ville) & """ : ") ; 
							Get_Line(Ville_Interdite) ; 
							Majuscule(Ville_Interdite) ; 
							if Ville_Interdite = no_ville then
								Ville_Interdite := Chaine_Vide ;
							end if ;
							
							if Appartient_Codage(Cod, Ville_Interdite) = true or Ville_Interdite = Chaine_Vide then
								t_debut := Clock;
								--L := Calculer_Itineraire(G, Cod, Ville_Depart, Ville_Arrivee) ;
								Calculer_Itineraire(G, Cod, Ville_Depart, Ville_Arrivee, Ville_Via, Ville_Interdite, L, chemin_long, nb_villes) ;
								t_fin := Clock;
							
							
								new_line ; 
								Put("********** Chemin calcule : ");
								if Ville_Interdite /= Chaine_Vide then Put("\" & Acces_String(Ville_Interdite) & " : "); end if ;
								Put(Acces_String(Ville_Depart) & " -> ");
								if Ville_Via /= Chaine_Vide then Put("" & Acces_String(Ville_Via) & " -> "); end if ;
								Put(Acces_String(Ville_Arrivee));
								Put(" **********"); new_line ; new_line ;
							
								print(L,Cod); new_line ;
							
								Put(" Distance totale :" & Natural'image(chemin_long)); new_line ;
								Put(" Nbre de villes traversees :" & Natural'image(nb_villes)); new_line ; new_line ;
							
								Put("Temps de calcul total : "); 
								Put(Float(To_Duration(t_fin - t_debut)),4,6,0); 
								Put(" secondes"); new_line ; new_line ; new_line ;  new_line ; 
							else
								new_line ; Put("  Le sommet """ & Acces_String(Ville_Via) & """ n'existe pas !"); new_line ; new_line ;
							end if ;
						else
							new_line ; Put("  Le sommet """ & Acces_String(Ville_Via) & """ n'existe pas !"); new_line ; new_line ;
						end if ;
					else
						new_line ; Put("  Le sommet """ & Acces_String(Ville_Arrivee) & """ n'existe pas !"); new_line ; new_line ;
					end if ;
				else
					new_line ; Put("  Le sommet """ & Acces_String(Ville_Depart) & """ n'existe pas !"); new_line ; new_line ;
				end if ;
				
			end loop ;
		end ; 
	end if ;  
         
exception 
	-- Recuperation de l'exception Name_Error, levee par la procedure
	-- Open en cas de nom de fichier incorrect
	when Name_Error =>
	Put_Line("Erreur : fichier " & Argument(1) & " inexistant") ;
	-- Recuperation de l'exception Erreur_Syntaxe, levee par la procedure 
	-- Lire_Graphe_Villes en cas d'erreur de syntaxe dans le fichier des 
	-- triplets. 
	when Erreur_Syntaxe => null ; 
end ; 


