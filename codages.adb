-- Corps du paquetage Codages.
--
-- Un codage est un pointeur sur un type article comprenant les champs
--   . 'Dernier' : un entier (de type sommet) representant le dernier 
--                 sommet alloue
--   . 'Tab' :     un tableau indexe sur les sommets de chaines
--   . 'Dico' :    une table de hachage (cf. paquetage Tables) de sommets,
--                 utilisation d'une table de hachage pour acces rapide aux chaines

with Tables ; 
with Ada.Text_Io;
use Ada.Text_Io;

package body Codages is

   -- Instantiation du paquetage generique Tables avec pour info des sommets.
   package Tables_Sommets is new Tables(Sommet, 0) ; 
   use Tables_Sommets ; 

   -- tables de hachage pour acceder plus rapidement aux chaines
   type Tableau_Chaine is array(Sommet range <>) of Chaine ; 

   type Structure_Codage(Max : Sommet) is
      record
         Dernier : Sommet ; 
         Tab : Tableau_Chaine(1 .. Max) ; 
         Dico : Table ; 
      end record ; 
-------------------------------------------------------------------------------
        

   function Creation_Codage(Taille_Max : Natural) return Codage is
		Cod : codage := new Structure_Codage( sommet (Taille_Max) );
   begin
		Cod.Dernier := Cod.Tab'First - 1;
		Cod.Dico := Creation_Table( Taille_Max + Taille_Max/3 ); -- pour que la table de hashage soit remplie a 75 pour 100 environ
		return Cod;
   end ; 
------------------------------------------------------------------------------

   function Dernier_Sommet(Cod : Codage) return Sommet is
   begin
		return Cod.Dernier;
   end ; 

-----------------------------------------------------------------------------
   function Acces_Chaine(Cod : Codage ; X : Sommet) return Chaine is
   begin
		if X in Cod.Tab'First..Cod.Dernier then
			return Cod.Tab(X);
		else
			raise Erreur_Codage;
		end if;
   end ; 
------------------------------------------------------------------------------
   function Appartient_Codage(Cod : Codage; C : Chaine) return Boolean is
		Present : Boolean;
		X : Sommet;
   begin
		Chercher(Cod.Dico, C, Present, X);
		return Present; 
   end ; 
------------------------------------------------------------------------------
   function Acces_Sommet(Cod : Codage ; C : Chaine) return Sommet is
		Present : Boolean;
		X : Sommet;
   begin
		Chercher(Cod.Dico, C, Present, X);
		if Present = true then
			return X;
		else
			raise Erreur_Codage;
		end if;
   end ; 
------------------------------------------------------------------------------
   procedure Chercher_Sommet(Cod : in Codage ; C : in Chaine ; Present : out Boolean ; X : out Sommet) is
   begin
		Chercher(Cod.Dico, C, Present, X);
   end ; 
------------------------------------------------------------------------------
   procedure Chercher_Inserer_Sommet (Cod : Codage ; C : in Chaine ; X : out Sommet) is
		Present : Boolean;
   begin
		if Dernier_Sommet(Cod) < Cod.Tab'Last then
			Chercher_Inserer(Cod.Dico, C, Dernier_Sommet(Cod)+1, Present, X);
			if Present = False then
				Cod.Dernier := Dernier_Sommet(Cod)+1;
				Cod.Tab(Dernier_Sommet(Cod)) := C;
			end if;
		else
			raise Erreur_Codage;
		end if;
   end ; 

end ; 


