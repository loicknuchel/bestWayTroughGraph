-- Specification du paquetage generique Tables

-- Une table permet d'associer des informations a des chaines de caracteres.
-- Les chaines de caracteres sont de type Chaine (cf. paquetage Chaines).
-- Les informations sont de type Info, parametre formel du paquetage generique.

with Chaines ;
use Chaines ;

generic

   -- Type de l'information associee a une chaine
   type Info is private ;

   -- Une valeur de type Info
   Info_Defaut : Info ;

package Tables is

   -- Le type abstrait Table
   type Table is private ;
	
	function hash(C : in Chaine ; modulo : in Integer ; offset : Integer) return Integer;
	function T_lenght(T : Table) return integer;
	function T_offset(T : Table) return integer;
	
	-- Creation d'une nouvelle table
   -- Taille est une estimation du nombre de chaines a stocker
   -- (implantation : Taille est la taille du tableau de hachage)
   function Creation_Table (Taille : Positive) return Table ;

   -- Recherche de l'information associee a une chaine C dans la table T.
   --   - Si la chaine C est trouvee, Present = vrai et I est l'info
   --     associee a C.
   --   - Si la chaine C n'est pas trouvee, Present = faux et I = Info_Defaut.
   procedure Chercher(T : in Table ; C : in Chaine ; Present : out Boolean ; I : out Info) ;

   -- Insersion de l'information I associee a la chaine C dans la table T.
   --   - Si la chaine C appartient a la table T, l'information associee
   --     est remplacee par I.
   --   - Si la chaine C n'appartient pas a la table T, une nouvelle
   --     entree est creee pour C, et l'information I est associee a C.
   procedure Inserer(T : in Table ; C : in Chaine ; I : in Info) ;

   -- Recherche et insertion :
   -- On cherche la chaine C dans la table T
   --   - Si C appartient a la table T,
   --       . Present = vrai
   --       . Info_Trouvee est l'information associee a C
   --   - Si C n'appartient pas a la table T,
   --       . Present = faux
   --       . une nouvelle entree est creee pour la chaine C, et
   --         l'information associee a C est Info_Entree.
   --       . Info_Trouvee = Info_Entree
   procedure Chercher_Inserer(T : in Table ; C : in Chaine ; Info_Entree : in Info ; Present : out Boolean ; Info_Trouvee : out Info) ;

   -- Iterateur :
   -- On appelle la procedure traiter sur tous les couples
   -- (chaine, info) de la table T.
   generic
      with procedure Traiter (C : in Chaine ; I : in Info) ;
   procedure Parcourir_Table (T : in Table) ;

 
   -- Etant donne une procedure Tracer_Info, qui permet d'afficher 
   -- un objet de type Info, Tracer_Table(T) permet d'afficher le 
   -- contenu de la table T.
   generic
      with procedure Tracer_Info(I : in Info) ; 
   procedure Tracer_Table (T : in Table) ;


private
   type Structure_Table ;
   type Table is access Structure_Table ;
end Tables ;
