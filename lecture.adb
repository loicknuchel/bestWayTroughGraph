-- Corps du paquetage Lecture d'analyse syntaxique des donnees

with Ada.Text_Io, Machine_Car ;
use Ada.Text_Io, Machine_Car ;

package body Lecture is
----------------------------------------------------------------------------
   -- Passer les espaces et fins de lignes
   procedure Passer_Sep is 
   begin
      while Car_Cour = ' ' or Car_Cour = Car_LF loop 
         Car_Suiv ;
      end loop ;  
   end Passer_Sep ;
----------------------------------------------------------------------------

   -- Initialisation de la lecture des triplets
   procedure Init_Lecture is
   begin
      Init_Machine_Car ;
   end Init_Lecture ;
-----------------------------------------------------------------------------
   
   -- Fin_Lecture = True ssi apres avoir passe les separateurs on est en 
   -- fin de fichier 
   function Fin_Lecture return Boolean is
   begin
      Passer_Sep ; 
      return Car_Cour = Car_NUL ;
   end Fin_Lecture ;
-----------------------------------------------------------------------------

   -- Erreur de syntaxe : on affiche un message d'erreur 
   -- et on leve l'exception Erreur_Syntaxe 
   procedure Lever_Erreur_Syntaxe is 
   begin
      Put_Line("Erreur de syntaxe ligne" & Integer'Image(Ligne_Cour)) ;
      Put_Line(
         "   ... dernier caractere lu : " & Character'Image(Car_Cour)) ; 
      Vider_Caracteres_En_Attente ;
      raise Erreur_Syntaxe ;
   end Lever_Erreur_Syntaxe ;


----------------
-- A COMPLETER
----------------
-------------------------------------------------------------------------------

	procedure Lire_Ville(V : out Chaine) is
	begin
		V := Creation_Chaine("");
		while ( character'Pos(Car_Cour) >= character'Pos('a') and character'Pos(Car_Cour) <= character'Pos('z') )
			or ( character'Pos(Car_Cour) >= character'Pos('A') and character'Pos(Car_Cour) <= character'Pos('Z') )
			or Car_Cour = '-'
			or Car_Cour = ''' loop
		   	Ajouter_Caractere(V , Car_Cour) ;
		   	Car_Suiv ;
		end loop; 
		Majuscule(V) ;
	end Lire_Ville ;
	
	
   procedure Lire_Triplet (V1, V2 : out Chaine ; D : out Natural) is
   	Distance : Chaine := Creation_Chaine("") ;
   begin
   	
   	Passer_Sep; -- enlever les sep
  
   	if Car_Cour /= '(' then
   		Lever_Erreur_Syntaxe ;
   	end if;
   	
   	Car_Suiv ;
   	
   	Passer_Sep; -- enlever les sep
   	
   	Lire_Ville(V1) ;
   	
   	Passer_Sep; -- enlever les sep
   	
   	if Car_Cour /= ',' then
   		Lever_Erreur_Syntaxe ;
   	end if;
   	
   	Car_Suiv ;
   	Passer_Sep; -- enlever les sep
   	
   	Lire_Ville(V2) ;
   	
   	Passer_Sep; -- enlever les sep
   	
   	if Car_Cour /= ',' then
   		Lever_Erreur_Syntaxe ;
   	end if;
   	
   	Car_Suiv ;
   	Passer_Sep; -- enlever les sep
	
   	while character'Pos(Car_Cour) >= character'Pos('0') and character'Pos(Car_Cour) <= character'Pos('9') loop
		Ajouter_Caractere(Distance , Car_Cour) ;
		Car_Suiv ;
	end loop; 
   	
   	Passer_Sep; -- enlever les sep
   	
   	if Car_Cour /= ')' then
   		Lever_Erreur_Syntaxe ;
   	end if;
      
      Car_Suiv ;
      
      if Car_Cour /= Car_LF and Car_Cour /= ' ' and Car_Cour /= Car_NUL then
	      Lever_Erreur_Syntaxe ;
      end if ;
      
      D := Natural'Value(Acces_String(Distance)) ;
      
   end Lire_Triplet ;

end Lecture ;

