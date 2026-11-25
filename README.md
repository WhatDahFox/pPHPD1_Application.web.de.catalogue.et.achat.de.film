### DOCUMENTATION TECHNIQUE ET INSTRUCTIONS D'INSTALLATION



1. ###### Démarrer MySQL



* Démarrer MySQL depuis XAMPP.
* Se connecter à HeidiSQL.



2. ###### Créer et remplir la BDD



Exécuter dans l'ordre les scripts :



* database/bobines.sql --- Création de la BDD et des tables
* database/data.sql --- Insertion des données



3. ###### Créer l'utilisateur dans HeidiSQL



Requête dans heidiSQL :


	CREATE USER 'bobines'@'localhost'
	IDENTIFIED BY 'VotreMotDePasse';

	GRANT SELECT, INSERT, UPDATE, DELETE
	ON bobines.\*
	TO 'bobines'@'localhost';

4. ###### Configurer la connexion à la base de données

* Copier le fichier `.env.test` et le renommer en `.env`.
* Renseigner les paramètres de connexion à MySQL.
* Utiliser le mot de passe défini lors de la création de l'utilisateur MySQL.



