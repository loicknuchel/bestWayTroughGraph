-- fichier : /users4/...
-- description : Corps du paquetage Chemins
--               Calcul du plus court chemin entre deux sommets d'un graphe
--               Algorithme de Dijkstra
-- auteur : 


with Ada.Text_Io, PTas_bin_up ; 
use  Ada.Text_Io ; 


package body Chemins is
	
	type structure_chemin is
	record
		Som : Sommet ;
		Poids : Distance ; 
		Nb_villes : Natural ;
		Villes : Liste_Couple ; 
	end record ; 
	
	chemin_default : constant chemin := new structure_chemin'(Som => 0, Poids => 0, Nb_villes => 0, Villes => Liste_Vide) ;
	
	function "<"(C1, C2 : chemin) return Boolean is
	begin
		if C1.Poids < C2.Poids then 
			return true ;
		else
			return false ;
		end if;
	end ;
   
	package PTas_chemin is new PTas_bin_up(chemin, chemin_default) ; 
	use PTas_chemin ; 
	
	type Tableau_Poids is array(Sommet range <>) of Distance ;
	
	
	function Cpy_Add_Liste_Couple(L : in Liste_Couple ; C : in Couple) return Liste_Couple is
		ret_liste : Liste_Couple ;
		tmp_liste : Liste_Couple ;
		tmp_L : Liste_Couple := L ;
	begin
		if tmp_L /= Liste_Vide then
			ret_liste := Creation_Liste(Acces_Premier(tmp_L), Liste_Vide) ;
			tmp_liste := ret_liste ;
			tmp_L := Acces_Suivant(tmp_L);
			
			while tmp_L /= Liste_Vide loop
				Changer_Suivant(tmp_liste, Creation_Liste(Acces_Premier(tmp_L), Liste_Vide) );
				tmp_liste := Acces_Suivant(tmp_liste);
				tmp_L := Acces_Suivant(tmp_L);
			end loop ;
			
			Changer_Suivant(tmp_liste, Creation_Liste(C, Liste_Vide) );
		else
			ret_liste := Creation_Liste(C, Liste_Vide) ;
		end if ;
		
		return ret_liste ;
	end Cpy_Add_Liste_Couple ;
	
	procedure Print_chemin(C : in chemin) is
		L : Liste_Couple := C.Villes ;
	begin
		while L /= Liste_Vide loop
			Put(Sommet'image(Acces_Sommet(Acces_Premier(L)))&" (p:"&Distance'image(Acces_Distance(Acces_Premier(L))) & ") <-") ;
			L := Acces_Suivant(L);
		end loop ;
		Put(" DEPART");
		new_line ;
	end Print_chemin ;
	
	
	--function Plus_Court_Chemin(G : Graphe ; Xdep, Xarr : Sommet) return Liste_Couple is
	--	Tas_sommet : tas := creation_tas(natural (Dernier_Sommet(G) - Premier_Sommet(G) + 1) );
	--	poids_sommet : Tableau_Poids(Premier_Sommet(G)..Dernier_Sommet(G));
	--	chemin_cour : chemin;
	--	liste_sommet : Liste_Couple;
	--	Xcour, Xtmp : Sommet := Xdep;
	--	Ctmp : Couple;
	--	poids, new_poids : Distance;
	--	nb_elt_tas : Natural := 0;
	--	max_elt_tax : Natural := 0;
	--	all_elt_tas : Natural := 0;
	--	Print_detail : Integer := 0 ;
	--begin
	--	if Xdep = Xarr then
	--		return Cpy_Add_Liste_Couple(Liste_Vide, Creation_Couple(Xdep, 0) ) ;
	--	end if ;
	--	
	--	for I in Premier_Sommet(G)..Dernier_Sommet(G) loop
	--		poids_sommet(I) := Infinite ;
	--	end loop ;
	--	poids_sommet(Xdep) := 0 ;
	--	
	--	
	--	chemin_cour := new structure_chemin'(Som => Xdep, Poids => 0, Nb_villes => 1, Villes => Cpy_Add_Liste_Couple(Liste_Vide, Creation_Couple(Xdep, 0) ) ) ;
	--	Xcour := Xdep ;
	--	
	--	
	--	while Xcour /= Xarr loop
	--		
	--		if Print_detail = 1 then Put("Calcul a partir du Sommet : " & Sommet'image(Xcour) & " (poids=" & Distance'image(chemin_cour.Poids) & ")"); new_line ; end if ;
	--		
	--		
	--		liste_sommet := Liste_Successeurs(G, Xcour);
	--		while liste_sommet /= Liste_Vide loop
	--			Ctmp := Acces_Premier(liste_sommet) ;
	--			Xtmp := Acces_Sommet(Ctmp) ;
	--			poids := poids_sommet(Xtmp) ;
	--			new_poids := Acces_Distance(Ctmp) + poids_sommet(Xcour) ;
	--			
	--			if new_poids < poids then
	--				poids_sommet(Xtmp) := new_poids ;
	--				inserer(Tas_sommet, new structure_chemin'( Som => Xtmp, Poids => new_poids, Nb_villes => chemin_cour.Nb_villes + 1, Villes => Cpy_Add_Liste_Couple(chemin_cour.Villes, Ctmp ) ) ) ; 
	--				nb_elt_tas := nb_elt_tas + 1;
	--				all_elt_tas := all_elt_tas + 1;
	--				if max_elt_tax < nb_elt_tas then max_elt_tax := nb_elt_tas; end if;
	--				
	--				if Print_detail = 1 then  Put("  Chemin nouveau pour" & Sommet'image(Xtmp) & " (poids : " & Distance'image(poids_sommet(Xtmp)) & ") : ");
	--				Print_chemin(new structure_chemin'( Som => Xtmp, Poids => new_poids, Nb_villes => chemin_cour.Nb_villes + 1, Villes => Cpy_Add_Liste_Couple(chemin_cour.Villes, Ctmp ) ) ); end if ;
	--				
	--				if Xtmp=Xarr and then Print_detail=1 then Put("  * Distance terminale trouvee pour sommet"&Sommet'image(Xtmp)&":"&Distance'image(poids_sommet(Xtmp)));new_line;end if;
	--			end if ;
	--			
	--			liste_sommet := Acces_Suivant(liste_sommet);
	--		end loop;
	--		
	--		oter_min(Tas_sommet, chemin_cour) ;
	--		nb_elt_tas := nb_elt_tas - 1;
	--		Xcour := chemin_cour.Som ;
	--		
	--		if Print_detail = 1 then new_line ; end if ;
	--	end loop ;
	--	
	--	Put("Il y a eut au maximum" & Natural'image(max_elt_tax) & " elts dans le tas."); new_line ;
	--	Put("Il y a eut" & Natural'image(all_elt_tas) & " elts ajoutes au total."); new_line ;
	--	Put("Il reste" & Natural'image(nb_elt_tas) & " a la fin de l'algo."); new_line ; new_line ;
	--	
	--	return chemin_cour.Villes;
	--end ; 
	
	function Plus_Court_Chemin(G : Graphe ; Xdep, Xarr : Sommet) return Liste_Couple is
		L : Liste_Couple ;
		chemin_long, nb_villes : Natural ;
	begin
		My_Plus_Court_Chemin(G, Xdep, Xarr, XnoDelault, L, chemin_long, nb_villes) ;
		
		return L ;
	end Plus_Court_Chemin ;
	
	
	--procedure My_Plus_Court_Chemin(G : in Graphe ; Xdep, Xarr : in Sommet ; Villes : out Liste_Couple ; chemin_long, nb_villes : out Natural) is
	--	Tas_sommet : tas := creation_tas(natural (Last_Sommet(G) - Premier_Sommet(G) + 1) );
	--	poids_sommet : Tableau_Poids(Premier_Sommet(G)..Dernier_Sommet(G));
	--	chemin_cour : chemin;
	--	liste_sommet : Liste_Couple;
	--	Xcour, Xtmp : Sommet := Xdep;
	--	Ctmp : Couple;
	--	poids, new_poids : Distance;
	--	nb_elt_tas : Natural := 0;
	--	max_elt_tax : Natural := 0;
	--	all_elt_tas : Natural := 0;
	--	Print_detail : Integer := 0 ;
	--begin
	--	if Xdep = Xarr then
	--		Villes := Cpy_Add_Liste_Couple(Liste_Vide, Creation_Couple(Xdep, 0) ) ;
	--	end if ;
	--	
	--	for I in Premier_Sommet(G)..Dernier_Sommet(G) loop
	--		poids_sommet(I) := Infinite ;
	--	end loop ;
	--	poids_sommet(Xdep) := 0 ;
	--	
	--	
	--	chemin_cour := new structure_chemin'(Som => Xdep, Poids => 0, Nb_villes => 1, Villes => Cpy_Add_Liste_Couple(Liste_Vide, Creation_Couple(Xdep, 0) ) ) ;
	--	Xcour := Xdep ;
	--	
	--	
	--	while Xcour /= Xarr loop
	--		
	--		if Print_detail = 1 then Put("Calcul a partir du Sommet : " & Sommet'image(Xcour) & " (poids=" & Distance'image(chemin_cour.Poids) & ")"); new_line ; end if ;
	--		
	--		
	--		liste_sommet := Liste_Successeurs(G, Xcour);
	--		while liste_sommet /= Liste_Vide loop
	--			Ctmp := Acces_Premier(liste_sommet) ;
	--			Xtmp := Acces_Sommet(Ctmp) ;
	--			poids := poids_sommet(Xtmp) ;
	--			new_poids := Acces_Distance(Ctmp) + poids_sommet(Xcour) ;
	--			
	--			if new_poids < poids then
	--				poids_sommet(Xtmp) := new_poids ;
	--				inserer(Tas_sommet, new structure_chemin'( Som => Xtmp, Poids => new_poids, Nb_villes => chemin_cour.Nb_villes + 1, Villes => Cpy_Add_Liste_Couple(chemin_cour.Villes, Ctmp ) ) ) ; 
	--				nb_elt_tas := nb_elt_tas + 1;
	--				all_elt_tas := all_elt_tas + 1;
	--				if max_elt_tax < nb_elt_tas then max_elt_tax := nb_elt_tas; end if;
	--				
	--				if Print_detail = 1 then  Put("  Chemin nouveau pour" & Sommet'image(Xtmp) & " (poids : " & Distance'image(poids_sommet(Xtmp)) & ") : ");
	--				Print_chemin(new structure_chemin'( Som => Xtmp, Poids => new_poids, Nb_villes => chemin_cour.Nb_villes + 1, Villes => Cpy_Add_Liste_Couple(chemin_cour.Villes, Ctmp ) ) ); end if ;
	--				
	--				if Xtmp=Xarr and then Print_detail=1 then Put("  * Distance finale trouvee pour sommet"&Sommet'image(Xtmp)&":"&Distance'image(poids_sommet(Xtmp)));new_line;end if;
	--			end if ;
	--			
	--			liste_sommet := Acces_Suivant(liste_sommet);
	--		end loop;
	--		
	--		oter_min(Tas_sommet, chemin_cour) ;
	--		nb_elt_tas := nb_elt_tas - 1;
	--		Xcour := chemin_cour.Som ;
	--		
	--		if Print_detail = 1 then new_line ; end if ;
	--	end loop ;
	--	
	--	--Put("Il y a eut au maximum" & Natural'image(max_elt_tax) & " elts dans le tas."); new_line ;
	--	--Put("Il y a eut" & Natural'image(all_elt_tas) & " elts ajoutes dans le tas au total."); new_line ;
	--	--Put("Il reste" & Natural'image(nb_elt_tas) & " elts dans le tas a la fin de l'algo."); new_line ; new_line ;
	--	
	--	Villes := chemin_cour.Villes;
	--	chemin_long := Natural (chemin_cour.Poids);
	--	nb_villes := chemin_cour.Nb_villes;
	--end ; 
	
	procedure My_Plus_Court_Chemin(G : in Graphe ; Xdep, Xarr, Xno : in Sommet ; Villes : out Liste_Couple ; chemin_long, nb_villes : out Natural) is
		Tas_sommet : tas := creation_tas(natural (Last_Sommet(G) - Premier_Sommet(G) + 1) );
		poids_sommet : Tableau_Poids(Premier_Sommet(G)..Dernier_Sommet(G));
		chemin_cour : chemin;
		liste_sommet : Liste_Couple;
		Xcour, Xtmp : Sommet := Xdep;
		Ctmp : Couple;
		poids, new_poids : Distance;
		nb_elt_tas : Natural := 0;
		max_elt_tax : Natural := 0;
		all_elt_tas : Natural := 0;
	begin
		if Xdep = Xarr then
			Villes := Cpy_Add_Liste_Couple(Liste_Vide, Creation_Couple(Xdep, 0) ) ;
		end if ;
		
		for I in Premier_Sommet(G)..Dernier_Sommet(G) loop
			poids_sommet(I) := Infinite ;
		end loop ;
		poids_sommet(Xdep) := 0 ;
		
		
		chemin_cour := new structure_chemin'(Som => Xdep, Poids => 0, Nb_villes => 1, Villes => Cpy_Add_Liste_Couple(Liste_Vide, Creation_Couple(Xdep, 0) ) ) ;
		Xcour := Xdep ;
		
		
		while Xcour /= Xarr loop
			if Xcour /= Xno or Xcour = Xdep or Xcour = Xarr then
				
				liste_sommet := Liste_Successeurs(G, Xcour);
				while liste_sommet /= Liste_Vide loop
					Ctmp := Acces_Premier(liste_sommet) ;
					Xtmp := Acces_Sommet(Ctmp) ;
					poids := poids_sommet(Xtmp) ;
					new_poids := Acces_Distance(Ctmp) + poids_sommet(Xcour) ;
					
					if new_poids < poids then
						poids_sommet(Xtmp) := new_poids ;
						inserer(Tas_sommet, new structure_chemin'( Som => Xtmp, Poids => new_poids, Nb_villes => chemin_cour.Nb_villes + 1, Villes => Cpy_Add_Liste_Couple(chemin_cour.Villes, Ctmp ) ) ) ; 
						nb_elt_tas := nb_elt_tas + 1;
						all_elt_tas := all_elt_tas + 1;
						if max_elt_tax < nb_elt_tas then max_elt_tax := nb_elt_tas; end if;
					end if ;
					
					liste_sommet := Acces_Suivant(liste_sommet);
				end loop;
				
			end if ;
			
			oter_min(Tas_sommet, chemin_cour) ;
			nb_elt_tas := nb_elt_tas - 1;
			Xcour := chemin_cour.Som ;
		end loop ;
		
		--Put("Il y a eut au maximum" & Natural'image(max_elt_tax) & " elts dans le tas."); new_line ;
		--Put("Il y a eut" & Natural'image(all_elt_tas) & " elts ajoutes dans le tas au total."); new_line ;
		--Put("Il reste" & Natural'image(nb_elt_tas) & " elts dans le tas a la fin de l'algo."); new_line ; new_line ;
		
		Villes := chemin_cour.Villes;
		chemin_long := Natural (chemin_cour.Poids);
		nb_villes := chemin_cour.Nb_villes;
		
	end ; 
	
end ;






