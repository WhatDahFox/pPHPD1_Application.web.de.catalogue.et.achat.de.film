
CREATE DATABASE IF NOT EXISTS bobines
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE bobines;


CREATE TABLE IF NOT EXISTS realisateur(
    id_realisateur INT AUTO_INCREMENT,
    nom VARCHAR(50)  NOT NULL,
    prenom VARCHAR(50)  NOT NULL,
    date_de_naissance DATE,
    nationalite VARCHAR(50) ,
    biographie TEXT,
    portrait VARCHAR(500),
    PRIMARY KEY(id_realisateur)
);

CREATE TABLE IF NOT EXISTS acteur(
    id_acteur INT AUTO_INCREMENT,
    nom VARCHAR(50)  NOT NULL,
    prenom VARCHAR(50)  NOT NULL,
    PRIMARY KEY(id_acteur)
);

CREATE TABLE IF NOT EXISTS utilisateur(
    id_utilisateur INT AUTO_INCREMENT,
    nom VARCHAR(50)  NOT NULL,
    adresse_mail VARCHAR(255)  NOT NULL,
    mdp VARCHAR(255)  NOT NULL,
    PRIMARY KEY(id_utilisateur),
    UNIQUE(adresse_mail)
);

CREATE TABLE IF NOT EXISTS categorie(
    id_categorie INT AUTO_INCREMENT,
    nom VARCHAR(50)  NOT NULL,
    PRIMARY KEY(id_categorie),
    UNIQUE(nom)
);

CREATE TABLE IF NOT EXISTS panier(
    id_panier INT AUTO_INCREMENT,
    id_utilisateur INT NOT NULL,
    PRIMARY KEY(id_panier),
    UNIQUE(id_utilisateur),
    FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE IF NOT EXISTS commande(
    id_commande INT AUTO_INCREMENT,
    date_commande DATETIME NOT NULL,
    id_utilisateur INT NOT NULL,
    PRIMARY KEY(id_commande),
    FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE IF NOT EXISTS film(
    id_film INT AUTO_INCREMENT,
    titre VARCHAR(250)  NOT NULL,
    affiche VARCHAR(500) ,
    resume TEXT,
    annee_de_sortie SMALLINT NOT NULL,
    prix DECIMAL(8,2)   NOT NULL,
    id_realisateur INT NOT NULL,
    PRIMARY KEY(id_film),
    FOREIGN KEY(id_realisateur) REFERENCES realisateur(id_realisateur),
    CHECK (prix >= 0)
);

CREATE TABLE IF NOT EXISTS ont_joue_dans(
    id_film INT,
    id_acteur INT,
    PRIMARY KEY(id_film, id_acteur),
    FOREIGN KEY(id_film) REFERENCES film(id_film),
    FOREIGN KEY(id_acteur) REFERENCES acteur(id_acteur)
);

CREATE TABLE IF NOT EXISTS fait_partie_de(
    id_film INT,
    id_categorie INT,
    PRIMARY KEY(id_film, id_categorie),
    FOREIGN KEY(id_film) REFERENCES film(id_film),
    FOREIGN KEY(id_categorie) REFERENCES categorie(id_categorie)
);

CREATE TABLE IF NOT EXISTS contient(
    id_film INT,
    id_panier INT,
    quantite TINYINT NOT NULL,
    PRIMARY KEY(id_film, id_panier),
    FOREIGN KEY(id_film) REFERENCES film(id_film),
    FOREIGN KEY(id_panier) REFERENCES panier(id_panier),
    CHECK (quantite > 0)
);

CREATE TABLE IF NOT EXISTS contenant(
    id_film INT,
    id_commande INT,
    quantite TINYINT NOT NULL,
    prix_achat DECIMAL(8,2)   NOT NULL,
    PRIMARY KEY(id_film, id_commande),
    FOREIGN KEY(id_film) REFERENCES film(id_film),
    FOREIGN KEY(id_commande) REFERENCES commande(id_commande),
    CHECK (quantite > 0),
    CHECK (prix_achat >= 0)
);
