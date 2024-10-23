-- Un utilisateur mineur ne peut pas posséder des médias sensible
CREATE OR REPLACE TRIGGER protection_enfance1 
BEFORE INSERT ON Utilisateur 
FOR EACH ROW 
DECLARE 
    tmp Medias.sensible%TYPE; 
BEGIN 
    -- Récupérer le champ "sensible" pour le media en cours d'insertion
    SELECT M.sensible 
    INTO tmp 
    FROM Medias M 
    WHERE M.MediasID = :new.MediasID; 

    -- Vérifier si l'utilisateur est mineur (age < 18)
    IF tmp = '1' AND :new.age < 18 THEN 
        RAISE_APPLICATION_ERROR(-20004, 'Vous n\''avez pas le droit de posséder ce média !'); 
    END IF; 
END;
/

-- L'attribut commentaire vaut null si le type d'intéraction est différent de 'Commentaire' 
CREATE OR REPLACE TRIGGER commentaire_null 
BEFORE INSERT ON Interragit 
FOR EACH ROW 
BEGIN 
    -- Si le type n'est pas 'Commentaire', rendre le commentaire nul
    IF :new.Type != 'Commentaire' THEN 
        :new.commentaire := NULL; 
    END IF; 
END; 
/

-- Trigger pour garantir qu'un utilisateur a au moins 13 ans lors de la création de son compte.
CREATE OR REPLACE TRIGGER age_verification 
BEFORE INSERT ON Utilisateur 
FOR EACH ROW 
BEGIN 
    -- Vérifie que l'utilisateur a au moins 13 ans
    IF :new.age < 13 THEN 
        RAISE_APPLICATION_ERROR(-20005, 'Vous devez avoir au moins 13 ans pour créer un compte.');
    END IF; 
END;
/

-- Trigger pour s'assurer que la description d'un média ne dépasse pas 2200 caractères.
CREATE OR REPLACE TRIGGER media_description_length 
BEFORE INSERT OR UPDATE ON Medias 
FOR EACH ROW 
BEGIN 
    -- Vérifie que la description ne dépasse pas 2200 caractères
    IF LENGTH(:new.description) > 2200 THEN 
        RAISE_APPLICATION_ERROR(-20006, 'La description ne peut pas dépasser 2200 caractères.');
    END IF; 
END;
/

-- Trigger pour empêcher la création de tags contenant des espaces ou des accents.
CREATE OR REPLACE TRIGGER tag_format_verification 
BEFORE INSERT ON Tags 
FOR EACH ROW 
BEGIN 
    -- Vérifie que le tag ne contient pas d'espaces
    IF INSTR(:new.nom, ' ') > 0 THEN 
        RAISE_APPLICATION_ERROR(-20007, 'Les tags ne doivent pas contenir d\''espaces.');
    END IF;

    -- Vérifie que le tag ne contient pas d'accents (exemple simple, peut être élargi)
    IF REGEXP_LIKE(:new.nom, '[éèêëàâîôû]') THEN 
        RAISE_APPLICATION_ERROR(-20008, 'Les tags ne doivent pas contenir d\''accents.');
    END IF;
END;
/

-- Trigger pour empêcher un utilisateur de publier le même média plusieurs fois.
CREATE OR REPLACE TRIGGER unique_media_per_publication 
BEFORE INSERT ON Publication 
FOR EACH ROW 
DECLARE 
    media_count NUMBER;
BEGIN 
    -- Compte le nombre de fois que ce média a déjà été utilisé dans des publications
    SELECT COUNT(*) INTO media_count 
    FROM Concerne 
    WHERE MediasID = :new.MediasID;

    IF media_count > 0 THEN 
        RAISE_APPLICATION_ERROR(-20009, 'Vous ne pouvez pas publier le même média plusieurs fois.');
    END IF; 
END;
/
-- Trigger pour s'assurer que la taille d'un média ne dépasse pas 100 Mo.
CREATE OR REPLACE TRIGGER media_size_verification 
BEFORE INSERT OR UPDATE ON Medias 
FOR EACH ROW 
BEGIN 
    -- Vérifie que la taille ne dépasse pas 100 Mo
    IF :new.taille > 100 * 1024 * 1024 THEN 
        RAISE_APPLICATION_ERROR(-20010, 'La taille du média ne peut pas dépasser 100 Mo.');
    END IF; 
END;
/

