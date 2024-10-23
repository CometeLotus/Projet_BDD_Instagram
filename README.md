# Projet de Base de Données - Instagram

Ce projet consiste en la création d'une base de données pour modéliser les fonctionnalités principales du réseau social Instagram. Ce dépôt contient différents scripts SQL pour créer, insérer, manipuler des données, ainsi que gérer les droits et déclencher des actions automatiques dans la base.

## Table des matières

- [Description du Projet](#description-du-projet)
- [Fichiers Disponibles](#fichiers-disponibles)
- [Documentation](#documentation)

## Description du Projet

L'objectif de ce projet est de construire une base de données relationnelle qui modélise les principales fonctionnalités d'Instagram, telles que les utilisateurs, les publications, les interactions (likes, commentaires), les tags et les abonnements. Il s'agit d'un projet réalisé dans le cadre de la 3ème année de Licence.

Le projet comporte les aspects suivants :
- Création de tables et gestion des contraintes d'intégrité.
- Gestion des droits d'accès et des vues spécifiques.
- Automatisation de certaines actions via des triggers (déclencheurs).
- Insertion et manipulation des données.

## Fichiers Disponibles

- **Tables.sql** : Ce fichier contient les requêtes SQL pour la création des tables de la base de données ainsi que les contraintes d'intégrité.
- **Insertion.sql** : Contient les requêtes pour insérer les données dans les tables.
- **Manipulation.sql** : Ce fichier contient des requêtes SQL pour manipuler les données (sélections, mises à jour, suppressions).
- **Droits.sql** : Définit les vues et les droits d'accès pour différents types d'utilisateurs.
- **Trigger.sql** : Contient les triggers (déclencheurs) qui automatisent certaines actions, par exemple la verification de la taille des medias.
- **Metadonnes.sql** : Ce fichier contient des requêtes pour la gestion des métadonnées et des statistiques sur la base de données.
- **Rapport_BDD_Instagram.pdf** : Rapport détaillé du projet, incluant la modélisation Entité-Association, les décisions de conception, et les requêtes d'analyse.
- **Modele_EA.png** : Un diagramme Entité-Association représentant le modèle conceptuel de la base de données.

## Documentation

Pour plus de détails sur la conception du modèle et les choix techniques, veuillez consulter le fichier PDF **Rapport_BDD_Instagram.pdf**. Ce document contient également des informations sur les requêtes d'analyse des données et des statistiques.