-- Paquetage pour les chaines de caracteres de longueur bornee
-- Specification

package Chaines is

   -- Taille maximale des chaines considerees
   Chaine_Max : constant Natural := 80 ;

   -- Le type des chaines de caracteres de longueur bornee
   type Chaine is private ;

   -- La chaine vide
   Chaine_Vide : constant Chaine ;

   -- Exception levee en cas de debordement (creation d'une chaine dont la
   -- longueur depasse Chaine_Max)
   Erreur_Chaine : exception ;
	
   -- Creation_Chaine(S) est la chaine correspondant a S
   -- En cas de debordement, l'exception Erreur_Chaine est levee
   function Creation_Chaine(S : String) return Chaine ;

   -- Acces_String(C) est la string correspondant a C
   function Acces_String(C : Chaine) return String ;

   -- Acces_Longueur(C) est la longueur de la chaine C
   function Acces_Longueur(C : Chaine) return Natural ;

   -- Majuscule(C) passe la chaine C en majuscules
   -- (les caracteres autres que 'a' .. 'z' ne sont pas modifies)
   procedure Majuscule(C : in out Chaine) ;

   -- C1 = C2 est vrai ssi les deux chaines C1 et C2 ont les memes caracteres
   function "="(C1, C2 : Chaine) return Boolean ;

   -- C1 < C2 est vrai ssi la chaine C1 est strictement avant la chaine C2
   -- (ordre lexicographique)
   function "<"(C1, C2 : Chaine) return Boolean ;

   -- Ajouter_Caractere(C, X) ajoute le caractere X au bout de la chaine C
   -- En cas de debordement, l'exception Erreur_Chaine est levee
   procedure Ajouter_Caractere(C : in out Chaine ; X : in Character) ;

   -- Ajouter_Chaine(A, B) ajoute la chaine B au bout de la chaine A
   -- En cas de debordement, l'exception Erreur_Chaine est levee
   procedure Ajouter_Chaine(A : in out Chaine ; B : in Chaine) ;

   -- C1 & C2 est la concatenation des chaines C1 et C2
   -- En cas de debordement, l'exception Erreur_Chaine est levee
   function "&"(C1, C2 : in Chaine) return Chaine ;

   -- Put(C) affiche la chaine C
   procedure Put(C : in Chaine) ;

   -- Put_Line(C) affiche la chaine C suivie d'un retour chariot
   procedure Put_Line(C : in Chaine) ;

   -- Get_Line(C) lit une chaine C sur l'entree standard
   procedure Get_Line(C : out Chaine) ;

private
   -- definition du type Chaine
   type Chaine is
      record
           -- Long :  longueur de la chaine que l'on considere
           Long : Natural := 0  ;
           -- Texte : les caracteres de la chaine
           Texte : String(1 .. Chaine_Max) ;
      end record ;

   -- definition de la chaine vide
   Chaine_Vide : constant Chaine := (Long => 0, Texte => (others => '.')) ;
end Chaines ;


