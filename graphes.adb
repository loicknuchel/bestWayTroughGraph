-- Corps du paquetage Graphes.

with Ada.Text_Io ;
use  Ada.Text_Io ;

-- Un graphe est un pointeur sur un type article avec discriminant 
-- comprenant les champs :
--   . discriminant 'Max' : le sommet maximal du graphe 
--   . 'Dernier' : le dernier sommet du graphe
--   . 'Tab' : tableau indexe sur les sommets de 1 a Max de 
--     'Liste_Couple'

package body Graphes is

   type Tableau_Liste is array(Sommet range <>) of Liste_Couple ;
   
   type Structure_Graphe(Max : Sommet) is 
      record 
         Dernier : Sommet ; 
         Tab : Tableau_Liste(1 .. Max) ; 
      end record ; 

------------------------------------------------------------------------------
   function Creation_Graphe (Taille_Max : Natural) return Graphe is
		G : Graphe := new Structure_Graphe( sommet (Taille_Max) ); 
   begin
		G.Dernier := G.Tab'First - 1;
		return G;
   end ; 
------------------------------------------------------------------------------
   function Dernier_Sommet(G : in Graphe) return Sommet is
   begin
		return G.Dernier ;
   end ; 
   
   function Premier_Sommet(G : in Graphe) return Sommet is
   begin
		return G.Tab'First ;
   end ; 
   
   function Last_Sommet(G : in Graphe) return Sommet is
   begin
		return G.Tab'Last ;
   end ; 
------------------------------------------------------------------------------ 
   procedure Ajouter_Sommet(G : in out Graphe ; X : out Sommet) is
   begin
		if Dernier_Sommet(G) < G.Tab'Last then
			G.Dernier := Dernier_Sommet(G) + 1;
			G.Tab(Dernier_Sommet(G)) := Liste_Vide;
			X := Dernier_Sommet(G);
		else
			raise Erreur_Graphes ;
		end if;
   end ; 
-----------------------------------------------------------------------------         
   procedure Ajouter_Modifier_Arc(G : in out Graphe ; X1, X2 : in Sommet ; D : in Distance) is
		P, S : Sommet;
		L : Liste_Couple;
   begin
		if X1 <= Dernier_Sommet(G) and X2 <= Dernier_Sommet(G) then
			--if X1 < X2 then -- pour stocker l'arc dans le plus petit des deux sommets
			--	P := X1;
			--	S := X2;
			--else
			--	P := X2;
			--	S := X1;
			--end if;
			P := X1;
			S := X2;
			
			if G.Tab(P) = Liste_Vide then
				G.Tab(P) := Creation_Liste( Creation_Couple(S, D), Liste_Vide ) ;
			else
				-- on ajoute l'arc dans le plus petit des sommets et de maniere croissante pour les numeros de sommet
				L := Liste_Successeurs(G, P);
				while Acces_Suivant(L) /= Liste_Vide and then Acces_Sommet( Acces_Premier(L) ) < S loop
					L := Acces_Suivant(L);
				end loop;
				
				if Acces_Sommet( Acces_Premier(L) ) = S then
					Changer_Distance(Acces_Premier(L), D) ;
				else
					Changer_Suivant(L, Creation_Liste( Creation_Couple(S, D), Acces_Suivant(L) ) );
				end if;
			end if;
		else
			raise Erreur_Graphes ;
		end if;
   end ; 
-----------------------------------------------------------------------------
   function Liste_Successeurs(G : in Graphe ; X : in Sommet) return Liste_Couple is
   begin
		if X <= Dernier_Sommet(G) then
			return G.Tab(X);
		else
			raise Erreur_Graphes ;
		end if;
   end ;  
----------------------------------------------------------------------------
   procedure Est_Successeur(G : in Graphe ; X1, X2 : Sommet ; Succ : out Boolean ; D : out Distance) is
		P, S : Sommet;
		L : Liste_Couple;
   begin
		if X1 <= Dernier_Sommet(G) and X2 <= Dernier_Sommet(G) then
			--if X1 < X2 then -- On recherche l'arc dans le plus petit des sommets (il a ete stocke de cette maniere : cf Ajouter_Modifier_Arc)
			--	P := X1;
			--	S := X2;
			--else
			--	P := X2;
			--	S := X1;
			--end if;
			P := X1;
			S := X2;
			
			L := Liste_Successeurs(G, P);
			if L /= Liste_Vide then 
				while Acces_Suivant(L) /= Liste_Vide and then Acces_Sommet( Acces_Premier( L ) ) /= S loop
					L := Acces_Suivant(L) ;
				end loop;
			end if;
			
			if L /= Liste_Vide and then Acces_Sommet( Acces_Premier( L ) ) = S then
				Succ := true;
				D := Acces_Distance( Acces_Premier( L ) ) ;
			else
				Succ := false;
			end if;
		else
			raise Erreur_Graphes ;
		end if;
   end ; 
   
   procedure print(G : Graphe) is
		X, Y : Sommet := G.Tab'First;
		B : Boolean;
		D : Distance;
   begin
		new_line ;
		Put("Affichage du graphe : ");
		new_line;
		
		while X <= Dernier_Sommet(G) loop
			Put(sommet'image(X) & " :");
			
			Y := G.Tab'First;
			while Y <= Dernier_Sommet(G) loop
				Est_Successeur(G, X, Y, B, D);
				if B = true then
					Put(sommet'image(Y) & " (" & Distance'image(D) & " ) - ");
				end if;
				Y := Y + 1;
			end loop;
			
			new_line ;
			X := X + 1;
		end loop;
		new_line;
   end print;

end ; 

