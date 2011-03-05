with Ada.Text_Io ; 
use  Ada.Text_Io ; 

package body PTas_bin_up is
	
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
	begin
		if est_vide(T) = true then
			raise erreur_tas;
		end if;
		
		return T.Tab(1) ;
	end acces_min ;
	
	
	-- Suppression du minimum dans un tas T
	-- on recupere la valeur du minimum dans E 
	-- Precondition : not est_vide(T)
	procedure oter_min(T : in out tas ; E : out element) is
		I : natural := 1 ;
		J : natural ;
		tmp : element ;
	begin
		if est_vide(T) = true then
			raise erreur_tas;
		end if;
		
		E := T.Tab(1) ;
		T.Tab(1) := T.Tab(T.Dernier) ;
		T.Dernier := T.Dernier - 1 ;
		
		while 2*I <= T.Dernier and then ( T.Tab(2*I) < T.Tab(I) or T.Tab(2*I+1) < T.Tab(I) ) loop
			if 2*I = T.Dernier then
				J := 2*I ;
			else
				if T.Tab(2*I) < T.Tab(2*I+1) then
					J := 2*I ;
				else
					J := 2*I+1 ;
				end if ;
			end if ;
			
			tmp := T.Tab(I) ;
			T.Tab(I) := T.Tab(J) ;
			T.Tab(J) := tmp ;
			I := J ;
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
			
			while I/2 > 0 and then T.Tab(I) < T.Tab(I/2) loop
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
	
end PTas_bin_up ; 

