--liste_ora_constraints. 
SELECT table_name,constraint_name,constraint_type 
FROM user_constraints;

--liste_ora_triggers. 
SELECT table_name,trigger_name,trigger_type,trigger_body 
FROM user_triggers 
ORDER BY table_name;

-- Lister tous les index existants dans la base de données.
SELECT 
    index_name,
    table_name,
    uniqueness,
    column_name
FROM 
    user_ind_columns
JOIN 
    user_indexes ON user_ind_columns.index_name = user_indexes.index_name
ORDER BY 
    table_name, index_name;

-- Obtenir la liste des vues dans la base de données.
SELECT 
    view_name,
    text
FROM 
    user_views
ORDER BY 
    view_name;

-- Lister toutes les séquences créées dans la base de données, avec leurs valeurs minimum et maximum.
SELECT 
    sequence_name,
    min_value,
    max_value,
    increment_by,
    last_number
FROM 
    user_sequences
ORDER BY 
    sequence_name;

-- Affichage de toutes les procédures et fonctions stockées dans la base de données.
SELECT 
    object_name,
    object_type,
    created,
    last_ddl_time
FROM 
    user_objects
WHERE 
    object_type IN ('PROCEDURE', 'FUNCTION')
ORDER BY 
    object_name;

-- Extraire des informations détaillées sur les tables et leurs colonnes.
SELECT 
    table_name,
    column_name,
    data_type,
    data_length,
    nullable
FROM 
    user_tab_columns
ORDER BY 
    table_name, column_id;

-- Lister les rôles et les privilèges associés à un utilisateur.
SELECT 
    grantee,
    granted_role
FROM 
    user_role_privs
ORDER BY 
    grantee;

-- Affichage de tous les objets de la base de données classés par type.
SELECT 
    object_type,
    count(*) AS object_count
FROM 
    user_objects
GROUP BY 
    object_type
ORDER BY 
    object_type;

-- Affichage des verrous en cours sur les objets de la base de données.
SELECT 
    object_name,
    lock_type,
    mode_held,
    mode_requested
FROM 
    user_locks;

-- Verification des logins des utilisateurs ainsi que leur statut (activé/désactivé).
SELECT 
    username,
    account_status
FROM 
    dba_users
ORDER BY 
    username;

-- Extraction des événements du système (logs, erreurs) pour la base de données
SELECT 
    event,
    total_time,
    total_waits,
    average_wait
FROM 
    v$system_event;
