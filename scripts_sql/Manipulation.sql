--Toutes les publications de l'utilisateur 23 qui contiennent le tag '#amour'. 
select P.numero_publication 
from Publication P 
join Contient C on P.numero_publication = C.numero_publication
join Utilisateur U on P.identifiant = U.identifiant
where U.identifiant = 23 
and C.nom = '#amour';

--Tous les abonnés de l’utilisateur 10 qui ont commenté la publication 15 de cet utilisateur. 
select X.abonnesID 
from Est_abonnee X 
join Interragit I on I.identifiant = X.abonnesID 
where X.identifiant = 10 
and I.numero_publication = 15 
and I.type = 'Commentaire';

--L'âge moyen des utilisateurs qui publient une publication contenant le tag '#girl'. 
select AVG(U.age) as age_moyen 
from Utilisateur U 
join Publication P on U.identifiant = P.identifiant
join Contient C on P.numero_publication = C.numero_publication
where C.nom = '#girl';

-- Le pays qui a le plus d’utilisateurs qui suivent le tag '#voyage'. 
select U.pays 
from Utilisateur U 
join Suis S on U.identifiant = S.identifiant 
where S.nom = '#voyage'
group by U.pays 
order by count(U.identifiant) desc 
limit 1;

-- Tous les utilisateurs qui ont partagé le médias 10. 
select I.identifiant 
from Interragit I 
join Concerne C on I.numero_publication = C.numero_publication 
where C.mediasID = 10 
and I.type = 'Partage';

-- Tous les utilisateurs qui ont publiés un média sensible. 
select U.identifiant 
from Utilisateur U 
join Publication P on U.identifiant = P.identifiant
join Concerne C on P.numero_publication = C.numero_publication
join Medias M on C.mediasID = M.mediasID
where M.sensible = '1';

-- Les tags suivis par aucun utilisateur.
select T.nom 
from Tags T 
where T.nom not in (select S.nom from Suis S);

-- Quelles sont toutes les publications de l'utilisateur “x” qui contiennent le tag “y” ?
SELECT P.numero_publication 
FROM Publication P 
JOIN Utilisateur U ON U.numero_publication = P.numero_publication 
JOIN Contient C ON C.numero_publication = P.numero_publication 
WHERE U.identifiant = x 
AND C.nom = 'y';

-- Quel est le tag qui apparaît le plus souvent dans les publications pendant la période de Noël (15 décembre - 31 décembre) ?
SELECT C.nom, COUNT(*) AS occurrences 
FROM Publication P 
JOIN Contient C ON C.numero_publication = P.numero_publication 
WHERE P.date_publication BETWEEN '2023-12-15' AND '2023-12-31' 
GROUP BY C.nom 
ORDER BY occurrences DESC 
LIMIT 1;

-- Qui sont tous les abonnés de l’utilisateur “x” qui ont commenté la publication “z” ?
SELECT I.identifiant 
FROM Interragit I 
JOIN (SELECT AbonnesID FROM Est_abonnee WHERE identifiant = x) AS X 
ON I.identifiant = X.AbonesID 
WHERE I.numero_publication = z AND I.type = 'Commentaire';

-- Quel pays a le plus d'utilisateurs suivant le tag “x” ?
SELECT U.pays 
FROM Utilisateur U 
JOIN Suis S ON S.identifiant = U.identifiant 
WHERE S.nom = 'x' 
GROUP BY U.pays 
ORDER BY COUNT(U.identifiant) DESC 
LIMIT 1;

-- Qui sont les abonnés de l’utilisateur 'x' qui ont publié au moins une photo et une vidéo ?
SELECT X.AbonnesID 
FROM (SELECT AbonnesID FROM Est_abonnee WHERE identifiant = x) AS X 
JOIN Interragit I ON I.identifiant = X.AbonnesID 
JOIN Concerne C ON C.numero_publication = I.numero_publication 
WHERE C.MediasID IN (SELECT MediasID FROM Medias WHERE type IN ('Photo', 'Vidéo')) 
GROUP BY X.AbonnesID 
HAVING COUNT(DISTINCT C.type) = 2;

-- Quel est le classement des pays en termes d'interactions ?
SELECT U.pays, COUNT(I.numero_interraction) AS nb_interractions 
FROM Utilisateur U 
JOIN Interragit I ON I.identifiant = U.identifiant 
GROUP BY U.pays 
ORDER BY nb_interractions DESC;

-- Combien d'abonnés en commun existent entre l’utilisateur ‘x’ et l’utilisateur ‘y’ ?
SELECT COUNT(*) AS abonnés_communs 
FROM Est_abonnee E1 
JOIN Est_abonnee E2 ON E1.AbonnesID = E2.AbonnesID 
WHERE E1.identifiant = x AND E2.identifiant = y;

-- Qui sont les utilisateurs abonnés à 'x' mais pas à 'y’ ?
SELECT E.AbonnesID 
FROM Est_abonnee E 
WHERE E.identifiant = x AND E.AbonnesID NOT IN (SELECT AbonnesID FROM Est_abonnee WHERE identifiant = y);

-- Qui a partagé le média ‘x’ ?
SELECT I.identifiant 
FROM Interragit I 
JOIN Concerne C ON C.numero_publication = I.numero_publication 
WHERE C.MediasID = x AND I.type = 'Partage';


-- Quels sont les tags contenus dans la publication la plus partagée ?
SELECT C.nom 
FROM Contient C 
JOIN (SELECT numero_publication FROM Interragit WHERE type = 'Partage' GROUP BY numero_publication ORDER BY COUNT(*) DESC LIMIT 1) AS P 
ON C.numero_publication = P.numero_publication;

-- Quelle est la publication la plus aimée de tous les utilisateurs ?
SELECT numero_publication, COUNT(*) AS nb_aimes 
FROM Interragit 
WHERE type = 'Aime' 
GROUP BY numero_publication 
ORDER BY nb_aimes DESC 
LIMIT 1;

-- Quel est le classement des utilisateurs certifiés basé sur la moyenne des "J’aime" par publication ?
SELECT U.identifiant, AVG(A.nb_aimes) AS moyenne_aimes 
FROM Utilisateur U 
JOIN (SELECT I.identifiant, I.numero_publication, COUNT(*) AS nb_aimes 
      FROM Interragit I 
      WHERE I.type = 'Aime' 
      GROUP BY I.numero_publication, I.identifiant) AS A 
ON U.identifiant = A.identifiant 
WHERE U.certification = 'certifiée' 
GROUP BY U.identifiant 
ORDER BY moyenne_aimes DESC;

-- Quel type d'interaction est le plus utilisé pour chaque média ?
SELECT C.MediasID, I.type, COUNT(*) AS nb_interactions 
FROM Interragit I 
JOIN Concerne C ON C.numero_publication = I.numero_publication 
GROUP BY C.MediasID, I.type 
ORDER BY C.MediasID, nb_interactions DESC;

-- Qui a publié un média sensible ?
SELECT U.identifiant 
FROM Utilisateur U 
JOIN Concerne C ON C.numero_publication = U.numero_publication 
JOIN Medias M ON M.MediasID = C.MediasID 
WHERE M.sensible = '1';

-- Quel pays a posté le plus de médias contenant le tag ‘x’ ?
SELECT U.pays, COUNT(C.MediasID) AS nb_medias 
FROM Utilisateur U 
JOIN Publication P ON P.identifiant = U.identifiant 
JOIN Contient C ON C.numero_publication = P.numero_publication 
WHERE C.nom = 'x' 
GROUP BY U.pays 
ORDER BY nb_medias DESC 
LIMIT 1;

