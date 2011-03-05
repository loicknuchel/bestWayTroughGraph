-- fichier : /users4/...
-- description : Corps du paquetage Itineraires
-- auteur : 

with Types_Base, Lecture, Chemins ; 
use Types_Base, Lecture, Chemins ; 

with Ada.Text_IO, Ada.Integer_Text_IO ; 
use  Ada.Text_IO, Ada.Integer_Text_IO ; 

package body Itineraires is

	-- Lecture du graphe des villes sur l'entree standard
	-- Max_Sommets est le nombre maximal de sommets du graphe.
	-- En sortie, G est le graphe des villes, Cod est le codage des noms de 
	-- villes par les sommets du graphe.
	-- Pour chaque paire de villes on ajoute deux arcs V1->V2 et V2->V1.
	
	procedure Lire_Graphe_Villes (Max_Sommets : in Natural ; G : out Graphe ; Cod : out Codage) is 
		nb_sommet, nb_arc : Natural ;
	begin
		Lire_Graphe_Villes (Max_Sommets, G, Cod, nb_sommet, nb_arc) ;
	end Lire_Graphe_Villes ;
	
	
	procedure Lire_Graphe_Villes (Max_Sommets : in Natural ; G : out Graphe ; Cod : out Codage ; nb_sommet, nb_arc : out Natural) is 
		V1, V2 : Chaine ; 
		D : Natural ; 
		X1,X2 : Sommet;
		X1prime,X2prime : Sommet;
		XLast : Sommet := 0;
	begin
		----------------- A COMPLETER -----------------------
		G := Creation_Graphe(Max_Sommets) ; 
		Cod := Creation_Codage(Max_Sommets) ; 
		nb_sommet := 0 ;
		nb_arc := 0 ;
		Init_Lecture ; 
		
		while not Fin_Lecture loop 
			Lire_Triplet(V1, V2, D) ; 
			
			Chercher_Inserer_Sommet(Cod, V1, X1) ; 
			if X1 = Dernier_Sommet(Cod) and then X1 /= XLast then
				XLast := X1;
				Ajouter_Sommet(G, X1prime) ;
				nb_sommet := nb_sommet + 1 ;
				if X1 /= X1prime then Put("ERROR : creation graphe : itineraires.adb l.35"); new_line; end if;
			end if;
			
			Chercher_Inserer_Sommet(Cod, V2, X2) ; 
			if X2 = Dernier_Sommet(Cod) and then X2 /= XLast then
				XLast := X2;
				Ajouter_Sommet(G, X2prime) ;
				nb_sommet := nb_sommet + 1 ;
				if X2 /= X2prime then Put("ERROR : creation graphe : itineraires.adb l.41"); new_line; end if;
			end if;
			
			--Put(Acces_String(V1) & " -> " & Acces_String(V2) & "(" & Natural'image(D) & ")"); new_line;
			Ajouter_Modifier_Arc(G, X1, X2, Distance (D) ) ; 
			Ajouter_Modifier_Arc(G, X2, X1, Distance (D) ) ;
			nb_arc := nb_arc + 1 ;
		end loop ; 
	end ; 

   
   -- Affichage d'un graphe des villes : pour chaque ville V,
   -- on affiche la liste des villes directement connectees avec V, avec
   -- leur distance a V.
   -- G est le graphe des villes.
   -- Cod est le codage des noms de villes par les sommets du graphe.
   procedure Afficher_Graphe_Villes(G : in Graphe ; Cod : in Codage) is
      L : Liste_Couple ; 
   begin
		Put("Affichage du graphe : "); new_line;
      for X in 1 .. Dernier_Sommet(G) loop 
         Put_Line("Ville : " & Acces_String(Acces_Chaine(Cod, X))) ; 
         L := Liste_Successeurs(G, X) ; 
         Afficher_Liste_Villes_Distances(L,Cod) ; 
      end loop ;  
   end ; 
   
	procedure print(G : in Graphe ; Cod : in Codage) is
		X, Y : Sommet := Premier_Sommet(G);
		B : Boolean;
		D : Distance;
		C : Chaine;
	begin
		new_line ;
		Put("Affichage du graphe : ");
		new_line;
		
		for X in Premier_Sommet(G) .. Dernier_Sommet(G) loop 
			C := Acces_Chaine(Cod, X);
			Put(Sommet'image(X) & " : " & Acces_String(C) & " => ");
			
			for Y in Premier_Sommet(G) .. Dernier_Sommet(G) loop 
				Est_Successeur(G, X, Y, B, D);
				if B = true then
					C := Acces_Chaine(Cod, Y);
					Put(Acces_String(C) & " (" & Distance'image(D) & " ) - ");
				end if;
			end loop;
			
			new_line ;
		end loop;
		new_line;
	end print ;
	
   
   function Calculer_Itineraire(G : in Graphe ; Cod : in Codage ; Ville_Depart, Ville_Arrivee : in Chaine) return Liste_Couple is
		L : Liste_Couple;
		chemin_long, nb_villes : Natural;
   begin
		Calculer_Itineraire(G, Cod, Ville_Depart, Ville_Arrivee, Chaine_Vide, Chaine_Vide, L, chemin_long, nb_villes) ;
		
		return L;
   end Calculer_Itineraire ;
   
   
   procedure Calculer_Itineraire(G : in Graphe ; Cod : in Codage ; Ville_Depart, Ville_Arrivee, Ville_Via, Ville_Interdite : in Chaine ; Villes : out Liste_Couple ; chemin_long, nb_villes : out Natural) is
      B1, B2, B3, B4 : Boolean;
	X1, X2, X3, X4 : sommet;
	Villes2, Villes_tmp : Liste_Couple;
	chemin_long2, nb_villes2 : Natural;
   begin
		Chercher_Sommet(Cod, Ville_Depart, B1, X1) ;
		Chercher_Sommet(Cod, Ville_Arrivee, B2, X2) ;
		if Ville_Via /= Chaine_Vide then Chercher_Sommet(Cod, Ville_Via, B3, X3) ; else B3 := true ; end if ;
		if Ville_Interdite /= Chaine_Vide then Chercher_Sommet(Cod, Ville_Interdite, B4, X4) ; else B4 := true ; X4 := XnoDelault ; end if ;
		
		if B1 = true and B2 = true and B3 = true and B4 = true then
			if Ville_Via = Chaine_Vide then
				My_Plus_Court_Chemin(G, X1, X2, X4, Villes, chemin_long, nb_villes) ;
			else
				My_Plus_Court_Chemin(G, X1, X3, X4, Villes, chemin_long, nb_villes) ;
				My_Plus_Court_Chemin(G, X3, X2, X4, Villes2, chemin_long2, nb_villes2) ;
				
				chemin_long := chemin_long + chemin_long2 ;
				nb_villes := nb_villes + nb_villes2 - 1;
				
				Villes_tmp := Villes ;
				while Acces_Suivant(Villes_tmp) /= Liste_Vide loop
					Villes_tmp := Acces_Suivant(Villes_tmp);
				end loop ;
				
				Changer_Suivant(Villes_tmp, Acces_Suivant(Villes2)) ;
			end if ;
		else
			Villes := Liste_Vide;
			chemin_long := 0;
			nb_villes := 0;
			
			if B1 = false then
				Put("La ville """ & Acces_string(Ville_Depart) & """ n'est pas presente dans le graphe"); new_line;
			end if ;
			if B2 = false then
				Put("La ville """ & Acces_string(Ville_Arrivee) & """ n'est pas presente dans le graphe"); new_line;
			end if ;
			if B3 = false then
				Put("La ville """ & Acces_string(Ville_Via) & """ n'est pas presente dans le graphe"); new_line;
			end if ;
			if B4 = false then
				Put("La ville """ & Acces_string(Ville_Interdite) & """ n'est pas presente dans le graphe"); new_line;
			end if ;
		end if;
   end; 


   -- Affichage d'une liste de villes avec les distances
   -- L est la liste qui contient les sommets 
   -- Cod est le codage des noms de villes par les sommets du graphe
   procedure Afficher_Liste_Villes_Distances(L : in Liste_Couple ; Cod : in Codage ) is
      Cour : Liste_Couple := L ; 
      C : Couple ; 
   begin
      while Cour /= Liste_Vide loop
         C := Acces_Premier(Cour) ; 
         Put_Line("   -> " &
                  Acces_String(Acces_Chaine(Cod, Acces_Sommet(C))) &
                  "  -  " &
                  Distance'Image(Acces_Distance(C))) ;
         Cour := Acces_Suivant(Cour) ; 
      end loop ; 
   end ;  
	
	procedure print(L : in Liste_Couple ; Cod : in Codage) is
		Cour : Liste_Couple := L ; 
		C : Couple ;
		D : Distance := 0 ;
		Dtmp : Distance := 0 ;
		pc : natural := 0 ;
	begin
		while Cour /= Liste_Vide loop
			D := D + Acces_Distance(Acces_Premier(Cour)) ;
			Cour := Acces_Suivant(Cour) ; 
		end loop ; 
		
		if D = 0 then
			D := 1 ;
		end if ;
		
		Put("        D / Dpc  (Dsupp): Ville"); new_line ; new_line ;
		Cour := L ;
		while Cour /= Liste_Vide loop
			C := Acces_Premier(Cour) ; 
			Dtmp := Dtmp + Acces_Distance(C) ;
			pc := natural (Dtmp) * 100 / natural (D) ;
			
			--Put("   -> " & Acces_String(Acces_Chaine(Cod, Acces_Sommet(C))) & "  - " & Distance'image(Dtmp) & " /" & natural'image(pc) & "%  (+" & Distance'Image(Acces_Distance(C)) & ")") ;
			Put("   -> ");
			Put(Item => Natural (Dtmp), Width => 3);
			Put(" / ");
			Put(Item => pc, Width => 3);
			Put("% (+");
			Put(Item => Natural (Acces_Distance(C)), Width => 3);
			Put(") : ");
			Put(Item => Acces_String(Acces_Chaine(Cod, Acces_Sommet(C))) );
			
			if Dtmp = 0 then
				Put("           DEPART");
			end if ;
			if Acces_Suivant(Cour) = Liste_Vide then
				Put("           ARRIVEE");
			end if ;
			
			new_line ;
			
			Cour := Acces_Suivant(Cour) ; 
		end loop ; 
	end ;  

end ; 

