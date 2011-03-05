with Ada.Text_Io ; 
use  Ada.Text_Io ; 

package body PTas_bin is
	
	-- propriété de forme: tous les niveaux de l'arbre, à moins que probablement dernier (le plus profond) soient entièrement remplis, et, si le dernier niveau de l'arbre n'est pas complet, les noeuds de ce niveau sont remplis de gauche à droite.
	-- propriété de tas: chaque noeud est supérieur ou égal à chacun de ses enfants selon un certain attribut de comparaison qui est fixe pour la structure de données entière.
	--
	-- pour un noeud i : le pere a l'indice i/2 et les fils sont a l'indice 2i et 2i+1
	
	type Tableau_Elt is array(natural range <>) of element ; 
	
	
	type structure_tas(Max : natural) is
	record
		Dernier : natural ; 
		Tab : Tableau_Elt(1 .. Max) ; 
	end record ; 
	
	
	function creation_tas(taille_max : natural) return tas is
		T : tas := new structure_tas(taille_max);
	begin
		T.Dernier := T.Tab'First - 1;
		return T;
	end creation_tas ;
	
	
	-- est_vide(T) est vrai si T est vide 
	function est_vide(T : tas) return boolean is
	begin
		return T.Dernier = T.Tab'First - 1;
	end est_vide ;
	
	
	-- est_plein(T) est vrai ssi T est plein (on ne peut plus inserer d'element)
	function est_plein(T : tas) return boolean is
	begin
		return T.Dernier = T.Tab'Last;
	end est_plein ;
	
	
	-- Acces a l'element minimum d'un tas T
	-- Precondition : not est_vide(T)
	function acces_min(T : tas) return element is
		tmp : element := T.Tab(T.Dernier / 2 + 1);
	begin
		if est_vide(T) = true then
			raise erreur_tas;
		end if;
		
		for I in T.Dernier / 2 + 1 .. T.Dernier loop
			if T.Tab(I) < tmp then
				tmp := T.Tab(I) ;
			end if ;
		end loop ;
		
		return tmp ;
	end acces_min ;
	
	
	-- Suppression du minimum dans un tas T
	-- on recupere la valeur du minimum dans E 
	-- Precondition : not est_vide(T)
	procedure oter_min(T : in out tas ; E : out element) is
		Tab : Tableau_Elt(1 .. T.Dernier - T.Dernier / 2) ;
		tmp : element := T.Tab(T.Dernier / 2 + 1);
	begin
		if est_vide(T) = true then
			raise erreur_tas;
		end if;
		
		-- choix du min
		for I in T.Dernier / 2 + 1 .. T.Dernier loop
			Tab(I - T.Dernier / 2) := T.Tab(I) ;
			if T.Tab(I) < tmp then
				tmp := T.Tab(I) ;
			end if ;
		end loop ;
		
		-- suppression de ts les derniers elts
		T.Dernier := T.Dernier / 2 ;
		E := tmp ;
		
		-- ajout de ts les elts qui ne sont pas le min
		for I in Tab'range loop
			if Tab(I) /= tmp then
				inserer(T, Tab(I)) ;
			end if ;
		end loop ;
		
	end oter_min ;
	
	
	-- Insertion de l'element E dans le tas T
	-- Precondition : not est_plein(T) 
	procedure inserer(T : in out tas ; E : in element) is
		I : natural := T.Dernier;
		tmp : element ;
	begin
		if est_plein(T) = true then
			raise erreur_tas;
		end if;
		
		if est_vide(T) = true then
			T.Dernier := T.Dernier + 1 ;
			T.Tab(T.Dernier) := E ;
		else
			T.Dernier := T.Dernier + 1 ;
			I := T.Dernier ;
			T.Tab(I) := E ;
			
			while I/2 > 0 and then T.Tab(I/2) < T.Tab(I) loop
				tmp := T.Tab(I/2) ;
				T.Tab(I/2) := T.Tab(I) ;
				T.Tab(I) := tmp ;
				I := I/2 ;
			end loop ;
			
		end if ;
	end inserer ;
	
	
	function nb_elt_tas(T : in tas) return natural is
	begin
		return T.Dernier ;
	end nb_elt_tas ;
	
	
	function access_elt(T : in tas ; elt : in natural) return element is
	begin
		if elt not in 1..T.Dernier then
			raise erreur_tas;
		end if;
		
		return T.Tab(elt);
	end access_elt ;
	
end PTas_bin ; 

