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

with ptas, ptas_bin, ptas_bin_up ; 

with Ada.Text_Io ;
use  Ada.Text_Io ;

procedure Test_Ptas is
	
	
	package PTas_int is new PTas(integer, 0) ; 
	package PTas_bin_int is new PTas_bin(integer, 0) ; 
	package PTas_bin_up_int is new PTas_bin_up(integer, 0) ; 
	use PTas_bin_up_int ; 
	
	type Tab is array (integer range <>) of Natural ;
	
	
	procedure Print_tas(T : in tas) is
	begin
		Put("Elements dans l'ordre (" & natural'image(nb_elt_tas(T)) & " elts, min =" & natural'image(acces_min(T)) & " ) :"); new_line ;
		for I in 1..nb_elt_tas(T) loop
			Put("element" & integer'image(I) & " :" & natural'image(access_elt(T, I))) ; new_line ;
		end loop ;
	end Print_tas ;
	
	
	procedure Print_arbre(T : in tas) is
		J, nbetage, etage, cour, long_etage, cpt : natural ;
		nbelts : natural := nb_elt_tas(T) ;
		pad : Tab(1..7) := (0, 2, 5, 9, 17, 33, 60);
		bar : Tab(1..7) := (0, 0, 1, 5, 13, 29, 45);
		intfils : Tab(1..7) := (0, 4, 10, 18, 34, 50, 0);
		intinter : Tab(1..7) := (0, 4, 10, 18, 30, 0, 0);
		Ipad : Tab(1..7) := (0, 2, 4, 8, 16, 32, 56);
		Iintfils : Tab(1..7) := (0, 2, 6, 14, 30, 62, 80);
		Iintinter : Tab(1..7) := (0, 4, 8, 16, 32, 40, 0);
	begin
		if nbelts < 64 then
			Put("Affichage de l'arbre (" & natural'image(nb_elt_tas(T)) & " elts, min :" & natural'image(acces_min(T)) & " ) :"); new_line ; 
			
			nbetage := 0;
			cour := 1;
			while cour <= nbelts loop
				cour := cour * 2;
				nbetage := nbetage + 1;
			end loop ;
			etage := nbetage ;
			
			cour := 1;
			long_etage := 1;
			while etage > 0 loop
				if etage /= nbetage then
					for I in 1..Ipad(etage+1) loop
						Put(" ");
					end loop ;
					
					cpt := 0;
					for J in 1..long_etage/2 loop
						if cour + cpt <= nbelts then
							Put("/");
							cpt := cpt + 1;
						end if ;
						
						if cour + cpt <= nbelts then
							for K in 1..Iintfils(etage+1) loop
								Put(" ");
							end loop ;
							Put("\");
							for K in 1..Iintinter(etage+1) loop
								Put(" ");
							end loop ;
							cpt := cpt + 1;
						end if;
					end loop ;
					
					for I in 1..Ipad(etage+1) loop
						Put(" ");
					end loop ;
				end if ;
				
				
				
				new_line ;
				
				
				
				for I in 1..pad(etage) loop
					Put(" ");
				end loop ;
				
				J := 1;
				while J <= long_etage and cour <= nbelts loop
					for I in 1..bar(etage) loop
						Put("_");
					end loop ;
					
					Put( natural'image( access_elt(T, cour) ) & " " );
					if access_elt(T, cour) < 10 then
						Put(" ");
					end if ;
					cour := cour + 1 ;
				
					for I in 1..bar(etage) loop
						Put("_");
					end loop ;
					
					for I in 1..intfils(etage) loop
						Put(" ");
					end loop ;
					
					J:= J + 1;
				end loop ;
				
				for I in 1..pad(etage) loop
					Put(" ");
				end loop ;
				
				
				
				etage := etage - 1 ;
				long_etage := long_etage * 2 ;
				new_line ;
			end loop ;
		else
			Put("L'arbre contient plus de 63 elts. On ne peut pas l'afficher"); new_line ;
		end if ;
		
		new_line ;
	end Print_arbre ;
	

--|                                                                                                                                | blanc avant   |	barres pad	| intervalle fils	| intervalle branche	| etage | nb
--|                                 _____________________________(99)_____________________________                                 | (33 )	   | (29_)		|			|				| 6	  | 01
--|                                /                                                              \                                | (32 )	   | 			| (62 )		|				| 5-	  | 
--|                 _____________(83)_____________                                  _____________(83)_____________                 | (17 )	   | (13_)		| (34 )		| 				| 5	  | 03
--|                /                              \                                /                              \                | (16 )	   |			| (30 )		| (32 )			| 4-	  |
--|         _____(75)_____                  _____(75)_____                  _____(75)_____                  _____(75)_____         | (09 )	   | (05_)		| (18 )		| (18 )			| 4	  | 07
--|        /              \                /              \                /              \                /              \        | (08 )	   |			| (14 )		| (16 )			| 3-	  |
--|     _(60)_          _(52)_          _(60)_          _(52)_          _(60)_          _(52)_          _(60)_          _(52)_     | (05 )	   | (01_)		| (10 )		| (10 )			| 3	  | 15
--|    /      \        /      \        /      \        /      \        /      \        /      \        /      \        /      \    | (04 )	   |			| (06 )		| (08 )			| 2-	  |
--|  (45)    (56)    (09)    (05)    (45)    (56)    (09)    (05)    (45)    (56)    (09)    (05)    (45)    (56)    (09)    (05)  | (02 )	   |			| (04 )		| (04 )			| 2	  | 31
--|  /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \    /  \  | (02 )	   |			| (02 )		| (04 )			| 1-	  |
--|(25)(30)(38)(41)(02)(03)(01)(04)(25)(30)(38)(41)(02)(03)(01)(04)(25)(30)(38)(41)(02)(03)(01)(04)(25)(30)(38)(41)(02)(03)(01)(04)| (00 )	   |			| (00 )		| (00 )			| 1	  | 63
--

	
	T, U : tas;
	tmp, cpt : integer;
	
begin
	new_line ; Put("Debut du test :"); new_line ; new_line ;
	
	
	U := creation_tas(100) ;
	cpt := 0;
	for I in reverse 1..63 loop
		inserer(U, I);
		cpt := cpt + 1 ;
		if cpt = 1 or cpt = 3 or cpt = 7 or cpt = 15 or cpt = 31 or cpt = 63 then
			Print_arbre(U);
		end if ;
	end loop ;
	
	
	new_line ; new_line ; new_line ; new_line ; new_line ; new_line ; new_line ; new_line ; new_line ;
	
	
	T := creation_tas(100);
	
	inserer(T, 52);
	inserer(T, 30);
	inserer(T, 60);
	inserer(T, 45);
	inserer(T, 38);
	inserer(T, 9);
	inserer(T, 5);
	inserer(T, 25);
	inserer(T, 40);
	inserer(T, 35);
	
	--Print_tas(T);
	Print_arbre(T);
	new_line ;
	--         _____(60)_____
	--        /              \
	--     _(45)_          _(52)_
	--    /      \        /      \
	--  (40)    (38)    (09)    (05)
	--  /  \    /
	--(25)(30)(35)
	-- 
	-- 60 45 52 40 38 9 5 25 30 35
	
	
	
	
	
	new_line ; Put("Suppression des elts :"); new_line ; new_line ; new_line ;
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--         _____(60)_____
	--        /              \
	--     _(45)_          _(52)_
	--    /      \        /      \
	--  (40)    (38)    (09)    (25)
	--  /  \
	--(30)(35)
	-- 
	-- 60 45 52 40 38 9 25 30 35
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--         _____(60)_____
	--        /              \
	--     _(45)_          _(52)_
	--    /      \        /      \
	--  (40)    (38)    (25)    (30)
	--  /
	--(35)
	-- 
	-- 60 45 52 40 38 25 30 35
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--       _(60)_
	--      /      \
	--    (45)    (52)
	--    /  \    /  \
	--  (40)(38)(30)(35)
	-- 
	-- 60 45 52 40 38 30 35
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--       _(60)_
	--      /      \
	--    (45)    (52)
	--    /  \    /
	--  (40)(38)(35)
	-- 
	-- 60 45 52 40 38 35
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--       _(60)_
	--      /      \
	--    (45)    (52)
	--    /  \
	--  (40)(38)
	-- 
	-- 60 45 52 40 38
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--       _(60)_
	--      /      \
	--    (45)    (52)
	--    /
	--  (40)
	-- 
	-- 60 45 52 40
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--      (60)
	--      /  \
	--    (45)(52)
	-- 
	-- 60 45 52
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--      (60)
	--      /
	--    (52)
	-- 
	-- 60 52
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	Print_arbre(T);
	--      (60)
	-- 
	-- 60
	
	
	oter_min(T, tmp) ;
	Put("element supprime :" & integer'image(tmp)) ; new_line ;
	if est_vide(T) = true then
		Put("L'arbre est vide !"); new_line ;
	else
		Put("Error, l'arbre n'est pas vide !"); new_line ;
	end if ;
	--Print_arbre(T);
	
	
	new_line ; Put("Fin du test."); new_line ; new_line ;
end ; 


