# Bob'ines – Documentation technique et instructions d'installation

## 1. Prérequis techniques

* PHP 8 ou supérieur.
* MySQL.
* XAMPP ou un environnement équivalent.
* Extensions PHP `pdo_mysql` et `mbstring`.
* HeidiSQL ou un autre outil de gestion de base de données.

## 2. Procédure d'installation

### 2.1 – Préparation de l'environnement

* Extraire l'archive du projet.
* Démarrer MySQL depuis XAMPP.
* Se connecter à MySQL depuis HeidiSQL avec un compte administrateur.

### 2.2 – Création et peuplement de la base de données

Exécuter les scripts suivants dans l'ordre :

* `database/bobines.sql` : création de la base de données, des tables et des contraintes.
* `database/data.sql` : insertion du catalogue de 50 films et des données associées.

### 2.3 – Création de l'utilisateur MySQL

Exécuter les requêtes suivantes en choisissant un mot de passe :

```sql
CREATE USER 'bobines'@'localhost'
IDENTIFIED BY 'VotreMotDePasse';

GRANT SELECT, INSERT, UPDATE, DELETE
ON bobines.*
TO 'bobines'@'localhost';
```

### 2.4 – Configuration de la connexion SQL

Copier le fichier `.env.test` et renommer la copie en `.env`.

Renseigner les paramètres de connexion :

```ini
DB_HOST=127.0.0.1
DB_NAME=bobines
DB_USER=bobines
DB_PASSWORD=VotreMotDePasse
```

Le mot de passe doit correspondre à celui défini précédemment.

### 2.5 – Lancement du site

Depuis la racine du projet, exécuter :

```bash
php -S localhost:8000 -t public
```

Accéder ensuite au site : http://localhost:8000

## 3. Architecture du projet

| Dossier | Contenu |
|---|---|
| `config/` | Configuration de la connexion à la BDD. |
| `database/` | Scripts SQL de création et de peuplement. |
| `docs/` | MCD, MLD, fichier Looping et script LDD. |
| `public/` | Pages PHP accessibles depuis le navigateur. |
| `public/css/` | Feuilles de style. |
| `public/js/` | Scripts JavaScript. |
| `public/images/` | Ressources graphiques. |

La modélisation de la base de données a été réalisée avec Looping. Les fichiers sources et les schémas sont disponibles dans le dossier `docs/`.

## 4. Sécurité

Les mesures de sécurité suivantes ont été mises en place :

* **Injection SQL :** utilisation de requêtes préparées avec PDO.
* **XSS :** échappement des données affichées avec `htmlspecialchars()`.
* **CSRF :** utilisation et vérification de jetons dans les formulaires POST.
* **Mots de passe :** hachage avec `password_hash()` et vérification avec `password_verify()`.
* **Sessions :** contrôle de l'authentification et des accès aux pages privées.
* **Données :** validation des informations transmises par les utilisateurs côté serveur.
* **Connexion SQL :** identifiants stockés dans un fichier `.env` exclu du suivi Git et droits MySQL limités.
* **Commandes :** utilisation de transactions SQL pour garantir la cohérence des données lors des achats.

## 5. Dépôt GitHub

Le code source du projet ainsi que l'historique des commits sont
disponibles sur notre dépôt GitHub :

https://github.com/WhatDahFox/pPHPD1_Application.web.de.catalogue.et.achat.de.film

Actuellement privé, le dépôt sera rendu public à compter du
26 novembre 2026.