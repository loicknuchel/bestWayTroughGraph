-- Paquetage generique de tas

generic 

   -- Nombre maximal d'elements que l'on peut stocker dans le tas 
   -- taille_max : positive ; 

   -- Type des elements du tas
   type element is private ;

   -- Un objet de type element
   element_defaut : element ; 

   -- Relation d'egalite sur les elements du tas
   with function "=" (E1, E2 : element) return boolean is <> ; 

   -- Relation d'ordre sur les elements du tas 
   with function "<" (E1, E2 : element) return boolean is <> ; 

   -- 'is <>' signifie que nous pouvons omettre le parametre effectif 
   -- correspondant, si au momemnt de l'instantiation, il y a un unique 
   -- sous programme visible avec le meme designateur et des specifications 
   -- homologues. (cf. Programmer en Ada 95 page 381.)

package PTas_bin is

   -- Le type tas
   type tas is private ; 

   -- creation d'un tas vide, pouvant contenir au maximum taille_max elements 
   function creation_tas(taille_max : natural) return tas ; 
   
   -- est_vide(T) est vrai si T est vide 
   function est_vide(T : tas) return boolean ;

   -- est_plein(T) est vrai ssi T est plein (on ne peut plus inserer d'element)
   function est_plein(T : tas) return boolean ; 

   -- Acces a l'element minimum d'un tas T
   -- Precondition : not est_vide(T)
   function acces_min(T : tas) return element ; 

   -- Suppression du minimum dans un tas T
   -- on recupere la valeur du minimum dans E 
   -- Precondition : not est_vide(T)
   procedure oter_min(T : in out tas ; E : out element) ; 

   -- Insertion de l'element E dans le tas T
   -- Precondition : not est_plein(T) 
   procedure inserer(T : in out tas ; E : in element) ; 
   
   function nb_elt_tas(T : in tas) return natural ;
	
   function access_elt(T : in tas ; elt : in natural) return element ;
   
   -- Exception levee si une precondition n'est pas respectee
   erreur_tas : exception ; 

private 

   type structure_tas ; 
   type tas is access structure_tas ; 

end PTas_bin ; 

