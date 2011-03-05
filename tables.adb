-- Corps du paquetage generique Tables

-- Le type Table est implante a l'aide d'une table a adressage disperse.
-- La resolution des collisions est faites par des listes chainees.

with Ada.Text_Io ;
use  Ada.Text_Io ;

package body Tables is

   -- Type Sequence : sequence des couples (chaine, info) associes
   -- a une valeur de dispersion
   type Structure_Sequence ;

   type Sequence is access Structure_Sequence ;

   type Structure_Sequence is
      record
         Ch : Chaine ;
         Inf : Info ;
         Suiv : Sequence ;
      end record ;
	  
   -- Tableau des sequences
   type Structure_Table is array (Integer range <>) of Sequence ;

----------------
-- A COMPLETER
----------------
	function hash(C : Chaine ; modulo : Integer ; offset : Integer) return Integer is
		Res : Integer := 0;
		tmp : string(1..Acces_Longueur(C));
		Polynome : constant Integer := 31;
		Max_integer : integer := integer'Last;
	begin
		tmp(1..Acces_Longueur(C)) := Acces_String(C);
		
		for i in 1..Acces_Longueur(C) loop
			-- invariant : on a sommé le code ASCII des i-1 premiers caractères qu'on a stocké dans res
			Res := (Polynome * Res + character'Pos(tmp(i))) mod Max_integer;
		end loop;
		
		Res := Res Mod modulo + offset;
		
		return Res;
	end hash;
	
	
	function T_lenght(T : Table) return integer is
	begin
		return T'Last - T'First + 1;
	end T_lenght ;
	
	
	function T_offset(T : Table) return integer is
	begin
		return T'First;
	end T_offset ;
	
	
   -- Creation d'une nouvelle table
   -- Taille est une estimation du nombre de chaines a stocker
   -- Implantation : Taille est la taille du tableau de hachage
   function Creation_Table(Taille : Positive) return Table is
		T : Table := new Structure_Table(1..Taille);
   begin
		return T;
   end Creation_Table ;
   
   
   procedure Chercher(T : in Table ; C : in Chaine ; Present : out Boolean ; I : out Info) is
		C_hashee : Integer;
		element : Sequence;
   begin
		C_hashee := hash(C, T_lenght(T), T_offset(T));
		
		if T(C_hashee) /= null then
			element := T(C_hashee);
			while element.Suiv /= null and element.Ch /= C loop
				element := element.Suiv;
			end loop;
			
			if element.Ch = C then
				Present := true;
				I := element.Inf;
			else 
				Present := false;
				I := Info_Defaut;
			end if;
		else
			Present := false;
			I := Info_Defaut;
		end if;
   end Chercher ;
   
	
   procedure Inserer(T : in Table ; C : in Chaine ; I : in Info) is
		C_hashee : Integer;
		element : Sequence;
   begin
		C_hashee := hash(C, T_lenght(T), T_offset(T));
		
		if T(C_hashee) /= null then
			element := T(C_hashee);
			while element.Suiv /= null and element.Ch /= C loop
				element := element.Suiv;
			end loop;
			
			if element.Ch = C then
				element.Inf := I;
			else 
				element.Suiv := new Structure_Sequence'(Ch => C, Inf => I, Suiv => null);
			end if;
		else
			T(C_hashee) := new Structure_Sequence'(Ch => C, Inf => I, Suiv => null);
		end if;
   end Inserer ;
	
	
   procedure Chercher_Inserer(T : in Table ; C : in Chaine ; Info_Entree : in Info ; Present : out Boolean ; Info_Trouvee : out Info) is
		C_hashee : Integer;
		element : Sequence;
   begin
		C_hashee := hash(C, T_lenght(T), T_offset(T));
		
		if T(C_hashee) /= null then
			element := T(C_hashee);
			while element.Ch /= C and element.Suiv /= null loop
				element := element.Suiv;
			end loop;
			
			if element.Ch = C then
				Present := true;
				Info_Trouvee := element.Inf;
			else 
				Present := false;
				Info_Trouvee := Info_Entree;
				element.Suiv := new Structure_Sequence'(Ch => C, Inf => Info_Entree, Suiv => null);
			end if;
		else
			Present := false;
			Info_Trouvee := Info_Entree;
			T(C_hashee) := new Structure_Sequence'(Ch => C, Inf => Info_Entree, Suiv => null);
		end if;
   end Chercher_Inserer ;
	
	
	
	
   procedure Parcourir_Table (T : in Table) is
		element : Sequence;
   begin
		for I in T'First..T'Last loop
			element := T(I);
			while element /= null loop
				Traiter(element.Ch, element.Inf);
				element := element.Suiv;
			end loop;
		end loop;
   end Parcourir_Table ;
	
	
   -- Cette procedure est destinee a aider le deboggage.
   -- On affiche donc : 
   --  . les valeurs des indices du tableau qui correspond a la table T. 
   --  . pour chaque indice, l'ensemble des couples (chaine, info)
   --    qui correspondent a cet indice.
   procedure Tracer_Table (T : in Table) is
		element : Sequence;
   begin
		for I in T'First..T'Last loop
			element := T(I);
			while element /= null loop
				Put(integer'image(hash(element.Ch, T_lenght(T), T_offset(T))) & " : " & Acces_String(element.Ch) & " :");
				Tracer_Info(element.Inf);
				new_line;
				element := element.Suiv;
			end loop;
		end loop;
   end Tracer_Table ; 
	
	
end Tables ;

