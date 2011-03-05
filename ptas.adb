with Ada.Text_Io ; 
use  Ada.Text_Io ; 

package body PTas is
	
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
		
		return T.Tab(T.Dernier);
	end acces_min ;
	
	
	-- Suppression du minimum dans un tas T
	-- on recupere la valeur du minimum dans E 
	-- Precondition : not est_vide(T)
	procedure oter_min(T : in out tas ; E : out element) is
	begin
		if est_vide(T) = true then
			raise erreur_tas;
		end if;
		
		T.Dernier := T.Dernier - 1;
		E := T.Tab(T.Dernier + 1);
	end oter_min ;
	
	
	-- Insertion de l'element E dans le tas T
	-- Precondition : not est_plein(T) 
	procedure inserer(T : in out tas ; E : in element) is
		I : natural := T.Dernier;
	begin
		if est_plein(T) = true then
			raise erreur_tas;
		end if;
		
		if est_vide(T) = true then
			T.Dernier := T.Dernier + 1 ;
			T.Tab(T.Dernier) := E ;
		else
			while I in T.Tab'range and then T.Tab(I) < E loop
				T.Tab(I+1) := T.Tab(I);
				I := I - 1;
			end loop;
			T.Tab(I+1) := E ;
			T.Dernier := T.Dernier + 1 ;
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

end PTas ; 

