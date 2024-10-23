/*  Medias (medias_id, nom_fichier, taille, description, type {Photo, Vidéo})  */    
create table medias( 
    medias_id integer NOT NULL, 
    nom_fichier varchar(255) NOT NULL, 
    taille bigint, 
    sensible char(1), 
    type_media varchar(10) NOT NULL, 
    constraint pk_medias_id primary key (medias_id), 
    constraint chk_type_media check (type_media in ('photo', 'video')), 
    constraint chk_sensible check (sensible in ('0', '1')), 
    constraint chk_taille_max check (taille <= 100000000) 
);

/*  Publication (numero_publication, date_publication)  */ 
create table publication(    
    numero_publication integer NOT NULL, 
    date_publication date NOT NULL, 
    description varchar(2200), 
    constraint pk_publication primary key (numero_publication) 
);

/*  Utilisateur (utilisateur_id, nom, prenom, pseudo, certification, age, pays, numero_publication, medias_id) 
    utilisateur.numero_publication REFERENCES publication.numero_publication 
    utilisateur.medias_id REFERENCES medias.medias_id */ 
create table utilisateur( 
    utilisateur_id integer NOT NULL, 
    nom varchar(30) NOT NULL, 
    prenom varchar(30) NOT NULL, 
    pseudo varchar(30), 
    certification char(1), 
    age integer NOT NULL, 
    pays varchar(30), 
    numero_publication integer, 
    medias_id integer, 
    constraint pk_utilisateur primary key (utilisateur_id), 
    foreign key (numero_publication) references publication(numero_publication) on delete cascade, 
    foreign key (medias_id) references medias(medias_id) on delete cascade, 
    constraint chk_certification check (certification in ('0', '1')), 
    constraint chk_age_min check (age >= 13) 
);

/*  Tags (nom)  */ 
create table tags( 
    nom varchar(30) NOT NULL, 
    constraint pk_tags primary key (nom), 
    constraint chk_commence_hashtag CHECK (nom like '#%') 
);

/*  Interragit (numero_interaction, date_interaction, type_interaction, commentaire, numero_publication, utilisateur_id) 
    interragit.numero_publication REFERENCES publication.numero_publication 
    interragit.utilisateur_id REFERENCES utilisateur.utilisateur_id   */
create table interragit( 
    numero_interaction integer NOT NULL, 
    date_interaction date NOT NULL, 
    type_interaction varchar(15) NOT NULL, 
    commentaire varchar(2200), 
    numero_publication integer, 
    utilisateur_id integer, 
    constraint pk_interragit primary key (numero_interaction), 
    foreign key (numero_publication) references publication(numero_publication) on delete cascade, 
    foreign key (utilisateur_id) references utilisateur(utilisateur_id) on delete cascade, 
    constraint chk_type_interaction check (type_interaction in ('Partage', 'Aime', 'Commentaire')) 
);

/*  Contient (nom, numero_publication) 
    contient.nom REFERENCES tags.nom 
    contient.numero_publication REFERENCES publication.numero_publication */ 
create table contient( 
    nom varchar(30), 
    numero_publication integer, 
    constraint fk_contient_nom foreign key (nom) references tags(nom) on delete cascade, 
    constraint fk_contient_numero_publication foreign key (numero_publication) references publication(numero_publication) on delete cascade 
);

/*  Est_abonnee (abonnes_id, suivis_id, date_abonnement) 
    est_abonnee.abonnes_id REFERENCES utilisateur.utilisateur_id 
    est_abonnee.suivis_id REFERENCES utilisateur.utilisateur_id */ 
create table est_abonnee( 
    date_abonnement date NOT NULL, 
    abonnes_id integer, 
    suivis_id integer, 
    constraint fk_est_abonnee_abonnes_id foreign key (abonnes_id) references utilisateur(utilisateur_id) on delete cascade, 
    constraint fk_est_abonnee_suivis_id foreign key (suivis_id) references utilisateur(utilisateur_id) on delete cascade 
);

/*  Suis (utilisateur_id, nom) 
    suis.utilisateur_id REFERENCES utilisateur.utilisateur_id 
    suis.nom REFERENCES tags.nom    */ 
create table suis( 
    utilisateur_id integer, 
    nom varchar(30), 
    constraint fk_suis_utilisateur_id foreign key (utilisateur_id) references utilisateur(utilisateur_id) on delete cascade, 
    constraint fk_suis_nom foreign key (nom) references tags(nom) on delete cascade 
);

/*  Concerne (numero_publication, medias_id) 
    concerne.numero_publication REFERENCES publication.numero_publication 
    concerne.medias_id REFERENCES medias.medias_id */ 
create table concerne( 
    numero_publication integer, 
    medias_id integer, 
    constraint fk_concerne_numero_publication foreign key (numero_publication) references publication(numero_publication) on delete cascade, 
    constraint fk_concerne_medias_id foreign key (medias_id) references medias(medias_id) on delete cascade 
);
