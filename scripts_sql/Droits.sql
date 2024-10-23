-- Un utilisateur mineur ne peut pas voir les publications qui concerne des médias sensible
CREATE VIEW mineur AS
SELECT P.numero_publication, P.date_publication, P.description
FROM Publication P
JOIN Concerne C ON P.numero_publication = C.numero_publication
JOIN Medias M ON C.mediasID = M.mediasID
WHERE M.sensible = '0';

-- Un utilisateur peut voir que le pseudo, nom, prenom et la certification d'un autre utilisateur
CREATE VIEW autre_utilisateur AS
SELECT U.nom, U.prenom, U.pseudo, U.certification
FROM Utilisateur U;

-- Vue pour les utilisateurs adultes qui peuvent voir les publications avec des médias sensibles.
CREATE VIEW adulte AS
SELECT P.numero_publication, P.date_publication, P.description
FROM Publication P
JOIN Concerne C ON P.numero_publication = C.numero_publication
JOIN Medias M ON C.mediasID = M.mediasID
WHERE M.sensible = '1';

-- Vue pour permettre aux utilisateurs de voir leurs abonnés.
CREATE VIEW mes_abonnes AS
SELECT U.nom, U.prenom, U.pseudo
FROM Est_abonnee E
JOIN Utilisateur U ON E.abonnesID = U.identifiant
WHERE E.identifiant = USER;

-- Vue pour voir l'historique des interactions (likes, commentaires, partages) d'un utilisateur sur ses propres publications.
CREATE VIEW interactions_utilisateur AS
SELECT I.type, I.date_interaction, P.numero_publication
FROM Interragit I
JOIN Publication P ON I.numero_publication = P.numero_publication
WHERE I.identifiant = USER;

-- Vue pour afficher toutes les publications ainsi que le nombre d'interactions pour chaque publication.
CREATE VIEW publications_interactions AS
SELECT P.numero_publication, P.date_publication, P.description, COUNT(I.numero_interaction) AS nb_interactions
FROM Publication P
LEFT JOIN Interragit I ON P.numero_publication = I.numero_publication
GROUP BY P.numero_publication, P.date_publication, P.description;

-- Vue pour permettre aux utilisateurs de voir les publications avec leurs tags associés.
CREATE VIEW publications_avec_tags AS
SELECT P.numero_publication, P.date_publication, P.description, C.nom AS tag
FROM Publication P
JOIN Contient C ON P.numero_publication = C.numero_publication;

-- Vue pour afficher uniquement les utilisateurs certifiés.
CREATE VIEW utilisateurs_certifies AS
SELECT U.nom, U.prenom, U.pseudo
FROM Utilisateur U
WHERE U.certification = 'certifiée';

-- Vue pour afficher les médias publiés par un utilisateur spécifique.
CREATE VIEW mes_medias AS
SELECT M.nom_fichier, M.taille, M.sensible
FROM Medias M
JOIN Concerne C ON M.mediasID = C.mediasID
JOIN Publication P ON C.numero_publication = P.numero_publication
WHERE P.identifiant = USER;

-- Vue pour afficher les médias publiés par un utilisateur spécifique.
CREATE VIEW mes_medias AS
SELECT M.nom_fichier, M.taille, M.sensible
FROM Medias M
JOIN Concerne C ON M.mediasID = C.mediasID
JOIN Publication P ON C.numero_publication = P.numero_publication
WHERE P.identifiant = USER;

-- Vue pour afficher le nombre total de publications par utilisateur.
CREATE VIEW comptage_publications AS
SELECT U.identifiant, U.nom, U.prenom, COUNT(P.numero_publication) AS nb_publications
FROM Utilisateur U
LEFT JOIN Publication P ON U.identifiant = P.identifiant
GROUP BY U.identifiant, U.nom, U.prenom;

