-- Corps du paquetage pour les chaines de caracteres de longueur bornee 

-- Pour ecrire les differentes operations sur le type Chaine, 
-- on n'utilisera pas les operations predefinies Ada du type String, 
-- en particulier "=", "<", "&", et To_Upper.
-- Par contre, on pourra utiliser les operations "=" et "<" sur le type 
-- Character, ainsi que les fonctions Character'Pos et Character'Val. 

with Ada.Text_Io, Ada.Exceptions ; 
use Ada.Text_Io, Ada.Exceptions ;


package body Chaines is

	--exception
	--	when Erreur_Chaine => 
	--		Put("except ");
	
   function Acces_String(C : Chaine) return String is
   begin
      return C.Texte(C.Texte'First..C.Long) ;
   end ;

----------------------------------------------------------------

   function Acces_Longueur(C : Chaine) return Natural is 
   begin
      return C.Long ; 
   end ;

----------------------------------------------------------------

   function Creation_Chaine(S : String) return Chaine is
   	C : Chaine;
   begin
      if S'Length > Chaine_Max then
      	raise Erreur_Chaine;
      else
      	C.Long := S'Length;
      	C.Texte(1 .. C.Long) := S(S'First .. S'Last);
      	return C ;
      end if;
   end ; 

----------------------------------------------------------------

   function "="(C1, C2 : Chaine) return Boolean is
   begin
   	if C1.Long = C2.Long then
   		for I in 1..Acces_Longueur(C1) loop
   			if C1.Texte(I) /= C2.Texte(I) then
   				return False;
   			end if;
   		end loop;
      	return True ;
      else
      	return False;
      end if;
   end ;

----------------------------------------------------------------

   function "<"(C1, C2 : Chaine) return Boolean is
   	min : Natural := C1.Long;
   begin
   	if C1.Long > C2.Long then 
   		min := C2.Long;
   	end if;
   	
   	for I in C1.Texte'First..min loop
			if Character'Pos(C1.Texte(I)) < Character'Pos(C2.Texte(I)) then
				return True;
			elsif Character'Pos(C1.Texte(I)) > Character'Pos(C2.Texte(I)) then
				return False;
			end if;
		end loop;
	
      if C1.Long < C2.Long then
      	return True ; 
      else
      	return False ;
      end if; 
   end ;
 
----------------------------------------------------------------

   procedure Ajouter_Caractere(C : in out Chaine ; X : in Character) is
   begin
   	if C.Long > (Chaine_Max - 1) then
   		raise Erreur_Chaine;
   	else
   		C.long := C.Long + 1 ;
   		C.Texte(C.Long) := X ;
   	end if ;
   end ;
 
----------------------------------------------------------------
 
   procedure Ajouter_Chaine(A : in out Chaine ; B : in Chaine) is
   begin
   	if A.Long + B.Long > Chaine_Max then
   		raise Erreur_Chaine;
   	else
   		for i in 1..B.Long loop
   			Ajouter_Caractere(A, B.Texte(i));
   		end loop;
   	end if ;
   end ;

----------------------------------------------------------------

   function "&"(C1, C2 : in Chaine) return Chaine is
   	C : Chaine;
   begin
   	Ajouter_Chaine(C, C1);
   	Ajouter_Chaine(C, C2);
   	
      return C ; 
   end ; 

----------------------------------------------------------------

   procedure Majuscule(C : in out Chaine) is
   begin
   	for i in C.Texte'First..C.Texte'Last loop
   		if C.Texte(i) in 'a' .. 'z' then
			C.Texte(i) := character'Val( character'Pos('A') - character'Pos('a') + character'Pos(C.Texte(i)) ); 
		end if; 
   	end loop ;
   end ; 

----------------------------------------------------------------

   procedure Put(C : in Chaine) is
   begin
   	Put(C.Texte(1..C.Long));
   end ;

----------------------------------------------------------------

   procedure Put_Line(C : in Chaine) is
   begin
      Put(C.Texte(1..C.Long));
   	new_line; 
   end ;

----------------------------------------------------------------

   procedure Get_Line(C : out Chaine) is
   	tmp : Character := '0';
   	i : integer := 0;
   begin
   	Get(tmp);
   	while not End_Of_Line loop
   		i := i + 1;
   		C.Texte(i) := tmp;
   		Get(tmp);
   	end loop ;
	i := i + 1;
	C.Texte(i) := tmp;
   	C.Long := i;
   end ; 

end Chaines ;

