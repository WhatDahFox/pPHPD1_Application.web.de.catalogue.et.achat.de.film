-- ======================================================================
-- Bob'ines - importation du catalogue de 50 films
-- À exécuter après la création des 11 tables (bobines.sql).
-- Les prix sont fictifs. 
-- Les affiches externes peuvent devenir indisponibles.
-- Les dates de naissance non vérifiées restent NULL.
-- Le schéma ne permet qu'un réalisateur par film :
-- La réexécution évite les doublons logiques selon les champs
-- nom/prénom (personnes) et titre/année (films), sans les imposer
-- comme contraintes UNIQUE dans le schéma existant.
-- ======================================================================

SET NAMES utf8mb4;
USE bobines;

START TRANSACTION;

-- 1. Catégories : 5 catégories attendues.
-- La table categorie.nom possède une contrainte UNIQUE.

INSERT INTO categorie (nom)
SELECT src.nom
FROM (
  SELECT 'Action' AS nom
  UNION ALL SELECT 'Comédie'
  UNION ALL SELECT 'Drame'
  UNION ALL SELECT 'Horreur'
  UNION ALL SELECT 'Thriller'
) AS src
WHERE NOT EXISTS (SELECT 1 FROM categorie c WHERE c.nom = src.nom);

-- 2. Réalisateurs : insertion directe, sans identifiants codés en dur.

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Nolan', 'Christopher', NULL, 'Britannique et américain', 'Christopher Nolan est un réalisateur et scénariste connu pour ses récits construits autour du temps, de la mémoire et de la perception. Il a réalisé Memento, The Dark Knight, Inception, Interstellar et Le Prestige. Ses films mêlent fréquemment spectacle et structures narratives complexes.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Nolan' AND prenom = 'Christopher'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Miller', 'George', NULL, 'Australien', 'George Miller est un réalisateur, scénariste et producteur australien. Il a créé la saga Mad Max et réalisé Mad Max: Fury Road. Sa filmographie comprend également des œuvres très différentes comme Babe : Le Cochon dans la ville et Happy Feet.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Miller' AND prenom = 'George'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Stahelski', 'Chad', NULL, 'Américain', 'Chad Stahelski est un réalisateur et ancien cascadeur américain. Il a participé à la mise en scène des combats de plusieurs productions et a réalisé John Wick. Son travail privilégie une action physique lisible et des chorégraphies précises.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Stahelski' AND prenom = 'Chad'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'McTiernan', 'John', NULL, 'Américain', 'John McTiernan est un réalisateur américain associé au cinéma d''action et au thriller. Il a notamment signé Predator, Piège de cristal et À la poursuite d''Octobre rouge. Ses films reposent souvent sur la tension et la mise en scène de l''espace.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'McTiernan' AND prenom = 'John'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Cameron', 'James', NULL, 'Canadien', 'James Cameron est un réalisateur et scénariste canadien. Il a réalisé Terminator, Terminator 2 : Le Jugement dernier, Aliens, Titanic et Avatar. Il est connu pour son intérêt pour les innovations techniques et les univers de science-fiction.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Cameron' AND prenom = 'James'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Wachowski', 'Lana', NULL, 'Américaine', 'Lana Wachowski est une réalisatrice et scénariste américaine. Elle a coréalisé Matrix avec Lilly Wachowski, ainsi que plusieurs autres projets de science-fiction. La saga Matrix aborde notamment les thèmes de l''identité et de la réalité simulée.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Wachowski' AND prenom = 'Lana'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Scott', 'Ridley', NULL, 'Britannique', 'Ridley Scott est un réalisateur et producteur britannique. Il a réalisé Alien, le huitième passager, Blade Runner, Thelma et Louise et Gladiator. Son cinéma est reconnu pour ses univers visuels et ses reconstitutions ambitieuses.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Scott' AND prenom = 'Ridley'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'McQuarrie', 'Christopher', NULL, 'Américain', 'Christopher McQuarrie est un scénariste et réalisateur américain. Il a réalisé Mission: Impossible – Fallout et d''autres épisodes de cette franchise. Il a également écrit le scénario d''Usual Suspects.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'McQuarrie' AND prenom = 'Christopher'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Wright', 'Edgar', NULL, 'Britannique', 'Edgar Wright est un réalisateur et scénariste britannique. Il a réalisé Shaun of the Dead et Hot Fuzz avec Simon Pegg et Nick Frost. Ses comédies associent montage rythmé, références cinéphiles et humour visuel.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Wright' AND prenom = 'Edgar'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Nakache', 'Olivier', NULL, 'Français', 'Olivier Nakache est un réalisateur et scénariste français. Il travaille régulièrement avec Éric Toledano, avec qui il a coréalisé Intouchables. Leur cinéma aborde souvent les relations humaines par la comédie et le drame.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Nakache' AND prenom = 'Olivier'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Weir', 'Peter', NULL, 'Australien', 'Peter Weir est un réalisateur australien. Il a signé Le Cercle des poètes disparus, The Truman Show et Master and Commander. Ses films interrogent fréquemment la place de l''individu dans un environnement social ou institutionnel.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Weir' AND prenom = 'Peter'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Anderson', 'Wes', NULL, 'Américain', 'Wes Anderson est un réalisateur et scénariste américain. Il a réalisé The Grand Budapest Hotel, Moonrise Kingdom et La Famille Tenenbaum. Son cinéma se distingue par ses compositions symétriques, ses décors stylisés et son humour singulier.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Anderson' AND prenom = 'Wes'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Dayton', 'Jonathan', NULL, 'Américain', 'Jonathan Dayton est un réalisateur américain. Avec Valerie Faris, il a coréalisé Little Miss Sunshine et Ruby Sparks. Leur travail associe personnages atypiques, humour et observation des rapports familiaux.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Dayton' AND prenom = 'Jonathan'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Ramis', 'Harold', NULL, 'Américain', 'Harold Ramis était un réalisateur, acteur et scénariste américain. Il a réalisé Un jour sans fin et Mes doubles, ma femme et moi, et participé à l''écriture de SOS Fantômes. Son œuvre occupe une place importante dans la comédie américaine.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Ramis' AND prenom = 'Harold'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Russell', 'Chuck', NULL, 'Américain', 'Chuck Russell est un réalisateur américain. Il a signé The Mask, Le Blob et Freddy 3 : Les Griffes du cauchemar. Il a travaillé dans la comédie fantastique, l''horreur et le cinéma d''action.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Russell' AND prenom = 'Chuck'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Fleischer', 'Ruben', NULL, 'Américain', 'Ruben Fleischer est un réalisateur américain. Il a réalisé Bienvenue à Zombieland, Venom et Uncharted. Ses films mêlent souvent action, humour et culture populaire.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Fleischer' AND prenom = 'Ruben'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Zemeckis', 'Robert', NULL, 'Américain', 'Robert Zemeckis est un réalisateur et scénariste américain. Il a réalisé Retour vers le futur, Qui veut la peau de Roger Rabbit ? et Forrest Gump. Son cinéma conjugue récit populaire et expérimentations visuelles.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Zemeckis' AND prenom = 'Robert'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Phillips', 'Todd', NULL, 'Américain', 'Todd Phillips est un réalisateur, scénariste et producteur américain. Il a réalisé Very Bad Trip et Joker. Il a travaillé dans des registres allant de la comédie de groupe au drame psychologique.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Phillips' AND prenom = 'Todd'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Darabont', 'Frank', NULL, 'Américain', 'Frank Darabont est un réalisateur et scénariste américain. Il a adapté des œuvres de Stephen King dans Les Évadés et La Ligne verte. Il a également participé au développement de la série The Walking Dead.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Darabont' AND prenom = 'Frank'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Chazelle', 'Damien', NULL, 'Américain', 'Damien Chazelle est un réalisateur et scénariste américain. Il a réalisé Whiplash, La La Land et First Man. Son œuvre explore notamment la création artistique, l''ambition et le coût personnel de la réussite.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Chazelle' AND prenom = 'Damien'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Bong', 'Joon-ho', NULL, 'Sud-coréen', 'Bong Joon-ho est un réalisateur et scénariste sud-coréen. Il a réalisé Memories of Murder, The Host, Snowpiercer et Parasite. Ses films combinent satire sociale, suspense et changements de tonalité.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Bong' AND prenom = 'Joon-ho'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Spielberg', 'Steven', NULL, 'Américain', 'Steven Spielberg est un réalisateur et producteur américain. Il a signé Les Dents de la mer, E.T., Jurassic Park et La Liste de Schindler. Sa filmographie couvre le divertissement, le cinéma historique et le drame.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Spielberg' AND prenom = 'Steven'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Fincher', 'David', NULL, 'Américain', 'David Fincher est un réalisateur américain. Il a réalisé Seven, Fight Club, Zodiac et Gone Girl. Ses films sont souvent caractérisés par une mise en scène précise et un intérêt pour l''enquête ou l''obsession.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Fincher' AND prenom = 'David'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Muccino', 'Gabriele', NULL, 'Italien', 'Gabriele Muccino est un réalisateur et scénariste italien. Il a réalisé À la recherche du bonheur avec Will Smith, ainsi que Sept vies. Ses films abordent fréquemment les choix personnels et les relations familiales.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Muccino' AND prenom = 'Gabriele'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Kubrick', 'Stanley', NULL, 'Américain', 'Stanley Kubrick était un réalisateur américain. Il a réalisé 2001 : L''Odyssée de l''espace, Orange mécanique et Shining. Il est réputé pour la précision de ses compositions et la diversité des genres qu''il a explorés.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Kubrick' AND prenom = 'Stanley'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Wan', 'James', NULL, 'Australien', 'James Wan est un réalisateur et producteur australien né en Malaisie. Il a réalisé Saw, Conjuring : Les Dossiers Warren et Insidious. Il s''est également illustré dans le cinéma d''action avec Fast and Furious 7.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Wan' AND prenom = 'James'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Peele', 'Jordan', NULL, 'Américain', 'Jordan Peele est un réalisateur, scénariste et acteur américain. Il a réalisé Get Out, Us et Nope. Son cinéma d''horreur interroge les peurs sociales et les comportements collectifs.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Peele' AND prenom = 'Jordan'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Carpenter', 'John', NULL, 'Américain', 'John Carpenter est un réalisateur et compositeur américain. Il a réalisé Halloween, The Thing et New York 1997. Ses films ont marqué le cinéma fantastique et d''horreur par leurs ambiances et leurs bandes originales.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Carpenter' AND prenom = 'John'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Craven', 'Wes', NULL, 'Américain', 'Wes Craven était un réalisateur et scénariste américain. Il a réalisé Les Griffes de la nuit et Scream. Son travail a durablement influencé le cinéma d''horreur contemporain.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Craven' AND prenom = 'Wes'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Krasinski', 'John', NULL, 'Américain', 'John Krasinski est un acteur et réalisateur américain. Il a réalisé et interprété un rôle dans Sans un bruit. Il s''est également fait connaître du grand public grâce à la série The Office.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Krasinski' AND prenom = 'John'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Muschietti', 'Andy', NULL, 'Argentin', 'Andy Muschietti est un réalisateur argentin. Il a réalisé Mama et Ça, adaptation du roman de Stephen King. Il a développé une filmographie orientée vers le fantastique et l''horreur.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Muschietti' AND prenom = 'Andy'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Aster', 'Ari', NULL, 'Américain', 'Ari Aster est un réalisateur et scénariste américain. Il a réalisé Hérédité et Midsommar. Ses films mêlent terreur psychologique, relations familiales et mise en scène rigoureuse.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Aster' AND prenom = 'Ari'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Friedkin', 'William', NULL, 'Américain', 'William Friedkin était un réalisateur américain. Il a réalisé French Connection et L''Exorciste. Son cinéma a exploré le thriller, le policier et l''horreur avec un style souvent réaliste et nerveux.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Friedkin' AND prenom = 'William'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Scorsese', 'Martin', NULL, 'Américain', 'Martin Scorsese est un réalisateur américain. Il a réalisé Taxi Driver, Les Affranchis, Shutter Island et Le Loup de Wall Street. Ses films explorent souvent la culpabilité, la violence et les dilemmes moraux.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Scorsese' AND prenom = 'Martin'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Villeneuve', 'Denis', NULL, 'Canadien', 'Denis Villeneuve est un réalisateur canadien. Il a réalisé Incendies, Prisoners, Premier Contact, Blade Runner 2049 et Dune. Son cinéma associe tension, compositions visuelles et récits ambitieux.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Villeneuve' AND prenom = 'Denis'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Demme', 'Jonathan', NULL, 'Américain', 'Jonathan Demme était un réalisateur américain. Il a réalisé Le Silence des agneaux et Philadelphia. Son travail a couvert la fiction, le documentaire et les films musicaux.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Demme' AND prenom = 'Jonathan'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Singer', 'Bryan', NULL, 'Américain', 'Bryan Singer est un réalisateur américain. Il a réalisé Usual Suspects et plusieurs films de la série X-Men. Il a travaillé notamment dans le thriller et le cinéma de super-héros.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Singer' AND prenom = 'Bryan'
);

INSERT INTO realisateur (nom, prenom, date_de_naissance, nationalite, biographie)
SELECT 'Gilroy', 'Dan', NULL, 'Américain', 'Dan Gilroy est un réalisateur et scénariste américain. Il a écrit et réalisé Night Call, avec Jake Gyllenhaal. Le film questionne les dérives du journalisme d''images et la recherche du sensationnel.'
WHERE NOT EXISTS (
  SELECT 1 FROM realisateur WHERE nom = 'Gilroy' AND prenom = 'Dan'
);

-- 3. Films : récupération de l'ID du réalisateur via une sous-requête.
-- Un même titre + année n'est importé qu'une fois par réexécution.

-- Film 01 - The Dark Knight : Le Chevalier noir (2008)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'The Dark Knight : Le Chevalier noir', 'https://images.metahub.space/poster/medium/tt0468569/img', 'Batman affronte le Joker, un criminel qui transforme Gotham en terrain d''expérimentation du chaos. Alors que la ville cherche un symbole d''espoir, le procureur Harvey Dent voit ses convictions mises à l''épreuve. Le justicier doit choisir entre son idéal et des sacrifices qui pourraient sauver la population.', 2008, 18.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Nolan' AND prenom = 'Christopher')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'The Dark Knight : Le Chevalier noir' AND annee_de_sortie = 2008
);

-- Film 02 - Inception (2010)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Inception', 'https://images.metahub.space/poster/medium/tt1375666/img', 'Dom Cobb dirige une équipe capable de pénétrer les rêves pour y voler des informations. Une mission exceptionnelle lui impose cette fois d''implanter une idée au lieu de la dérober. À mesure que les niveaux de rêve s''emboîtent, ses souvenirs personnels menacent la réussite de l''opération.', 2010, 8.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Nolan' AND prenom = 'Christopher')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Inception' AND annee_de_sortie = 2010
);

-- Film 03 - Mad Max: Fury Road (2015)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Mad Max: Fury Road', 'https://images.metahub.space/poster/medium/tt1392190/img', 'Dans un désert ravagé, Max est entraîné dans la fuite de l''impératrice Furiosa, qui tente de libérer des captives d''un chef tyrannique. Une poursuite motorisée s''engage à travers des terres hostiles. Au milieu des affrontements, les fugitifs découvrent la possibilité de reprendre leur destin en main.', 2015, 11.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Miller' AND prenom = 'George')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Mad Max: Fury Road' AND annee_de_sortie = 2015
);

-- Film 04 - John Wick (2014)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'John Wick', 'https://images.metahub.space/poster/medium/tt2911666/img', 'Un ancien tueur à gages mène une existence discrète après la mort de son épouse. Une agression brutale le pousse à replonger dans un monde criminel qui connaît encore sa réputation. Sa quête de vengeance déclenche une succession d''affrontements contre des adversaires redoutables.', 2014, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Stahelski' AND prenom = 'Chad')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'John Wick' AND annee_de_sortie = 2014
);

-- Film 05 - Piège de cristal (1988)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Piège de cristal', 'https://images.metahub.space/poster/medium/tt0095016/img', 'John McClane, policier new-yorkais, rejoint son épouse à une réception dans un gratte-ciel de Los Angeles. Des criminels prennent le contrôle du bâtiment et retiennent les invités en otages. Isolé et sans renfort immédiat, il improvise une résistance depuis les étages de la tour.', 1988, 6.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'McTiernan' AND prenom = 'John')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Piège de cristal' AND annee_de_sortie = 1988
);

-- Film 06 - Terminator 2 : Le Jugement dernier (1991)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Terminator 2 : Le Jugement dernier', 'https://images.metahub.space/poster/medium/tt0103064/img', 'Un cyborg est envoyé du futur pour protéger John Connor, adolescent destiné à jouer un rôle décisif dans la résistance humaine. Un adversaire capable de changer d''apparence est chargé de le tuer. John et sa mère Sarah tentent de survivre tout en cherchant à modifier un avenir catastrophique.', 1991, 12.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Cameron' AND prenom = 'James')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Terminator 2 : Le Jugement dernier' AND annee_de_sortie = 1991
);

-- Film 07 - Matrix (1999)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Matrix', 'https://images.metahub.space/poster/medium/tt0133093/img', 'Thomas Anderson, pirate informatique connu sous le nom de Neo, découvre que sa réalité pourrait être une simulation. Guidé par Morpheus et Trinity, il apprend à remettre en cause les lois du monde qui l''entoure. Une lutte contre les machines s''engage, tandis que Neo s''interroge sur son rôle dans la résistance.', 1999, 6.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Wachowski' AND prenom = 'Lana')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Matrix' AND annee_de_sortie = 1999
);

-- Film 08 - Gladiator (2000)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Gladiator', 'https://images.metahub.space/poster/medium/tt0172495/img', 'Après la mort de l''empereur Marc Aurèle, le général Maximus est trahi et réduit en esclavage. Devenu gladiateur, il gravit les échelons des arènes de l''Empire romain. Son combat prend une dimension personnelle lorsqu''il se rapproche de celui qui a détruit sa famille.', 2000, 4.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Scott' AND prenom = 'Ridley')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Gladiator' AND annee_de_sortie = 2000
);

-- Film 09 - Mission: Impossible – Fallout (2018)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Mission: Impossible – Fallout', 'https://images.metahub.space/poster/medium/tt4912910/img', 'Ethan Hunt et son équipe doivent empêcher un groupe terroriste d''obtenir des matières nucléaires. Une opération manquée les entraîne dans une course contre la montre à travers plusieurs pays. Alliances incertaines et décisions difficiles compliquent la mission tandis que les conséquences deviennent mondiales.', 2018, 8.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'McQuarrie' AND prenom = 'Christopher')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Mission: Impossible – Fallout' AND annee_de_sortie = 2018
);

-- Film 10 - Hot Fuzz (2007)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Hot Fuzz', 'https://images.metahub.space/poster/medium/tt0425112/img', 'Un policier londonien trop efficace est muté dans un village anglais apparemment tranquille. Avec son nouveau collègue, il commence à relier une série de morts suspectes. Cette enquête improbable transforme une paisible commune en décor d''action spectaculaire et de satire policière.', 2007, 8.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Wright' AND prenom = 'Edgar')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Hot Fuzz' AND annee_de_sortie = 2007
);

-- Film 11 - Intouchables (2011)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Intouchables', 'https://images.metahub.space/poster/medium/tt1675434/img', 'Philippe, un homme fortuné devenu tétraplégique, engage Driss, un jeune homme sans expérience comme auxiliaire de vie. Leur relation se construit malgré leurs différences sociales et leurs caractères opposés. Au fil des jours, chacun découvre une autre manière de regarder le monde.', 2011, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Nakache' AND prenom = 'Olivier')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Intouchables' AND annee_de_sortie = 2011
);

-- Film 12 - The Truman Show (1998)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'The Truman Show', 'https://images.metahub.space/poster/medium/tt0120382/img', 'Truman Burbank mène une vie confortable dans une petite ville où tout semble parfaitement réglé. Des événements étranges éveillent ses soupçons sur son entourage. Il se met à rechercher la vérité sur son quotidien, sans savoir à quel point son existence est observée.', 1998, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Weir' AND prenom = 'Peter')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'The Truman Show' AND annee_de_sortie = 1998
);

-- Film 13 - The Grand Budapest Hotel (2014)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'The Grand Budapest Hotel', 'https://images.metahub.space/poster/medium/tt2278388/img', 'Dans un hôtel prestigieux d''une Europe imaginaire, un concierge excentrique se lie d''amitié avec un jeune employé. La disparition d''une cliente fortunée déclenche une affaire d''héritage et de vol d''œuvre d''art. Leur fuite à travers un continent troublé devient une aventure aussi élégante qu''absurde.', 2014, 8.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Anderson' AND prenom = 'Wes')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'The Grand Budapest Hotel' AND annee_de_sortie = 2014
);

-- Film 14 - Little Miss Sunshine (2006)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Little Miss Sunshine', 'https://images.metahub.space/poster/medium/tt0449059/img', 'Olive rêve de participer à un concours de beauté pour enfants en Californie. Sa famille, traversée par de nombreux conflits, prend la route dans un vieux minibus. Les incidents du voyage les obligent à dépasser leurs frustrations et à redéfinir ce qui compte vraiment pour eux.', 2006, 8.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Dayton' AND prenom = 'Jonathan')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Little Miss Sunshine' AND annee_de_sortie = 2006
);

-- Film 15 - Un jour sans fin (1993)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Un jour sans fin', 'https://images.metahub.space/poster/medium/tt0107048/img', 'Phil Connors, présentateur météo cynique, est envoyé couvrir une fête locale dans une petite ville. Il découvre qu''il revit sans cesse la même journée. Après avoir tenté de profiter de cette situation, il commence à s''interroger sur son comportement et sur les autres.', 1993, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Ramis' AND prenom = 'Harold')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Un jour sans fin' AND annee_de_sortie = 1993
);

-- Film 16 - The Mask (1994)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'The Mask', 'https://images.metahub.space/poster/medium/tt0110475/img', 'Stanley Ipkiss, employé de banque timide, découvre un masque mystérieux qui transforme son apparence et son comportement. Son double extravagant bouleverse sa vie et attire l''attention de criminels. Entre humour déchaîné et poursuites, il doit apprendre à maîtriser ce nouveau pouvoir.', 1994, 14.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Russell' AND prenom = 'Chuck')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'The Mask' AND annee_de_sortie = 1994
);

-- Film 17 - Shaun of the Dead (2004)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Shaun of the Dead', 'https://images.metahub.space/poster/medium/tt0365748/img', 'Shaun traverse une période difficile et peine à prendre ses responsabilités. Lorsqu''une épidémie transforme les habitants de Londres en zombies, il improvise un plan de survie avec ses proches. La catastrophe devient le cadre d''une comédie mêlant maladresse, amitié et effroi.', 2004, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Wright' AND prenom = 'Edgar')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Shaun of the Dead' AND annee_de_sortie = 2004
);

-- Film 18 - Bienvenue à Zombieland (2009)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Bienvenue à Zombieland', 'https://images.metahub.space/poster/medium/tt1156398/img', 'Dans une Amérique envahie par les zombies, un jeune survivant suit des règles strictes pour rester en vie. Il fait équipe avec un chasseur de morts-vivants et deux sœurs méfiantes. Leur périple combine affrontements sanglants, humour et recherche d''un lieu sûr.', 2009, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Fleischer' AND prenom = 'Ruben')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Bienvenue à Zombieland' AND annee_de_sortie = 2009
);

-- Film 19 - Forrest Gump (1994)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Forrest Gump', 'https://images.metahub.space/poster/medium/tt0109830/img', 'Forrest raconte son parcours singulier au cœur de plusieurs décennies de l''histoire américaine. Ses rencontres et ses exploits inattendus contrastent avec la simplicité de son regard sur le monde. Malgré ses succès, son attachement à Jenny demeure le fil conducteur de sa vie.', 1994, 7.49,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Zemeckis' AND prenom = 'Robert')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Forrest Gump' AND annee_de_sortie = 1994
);

-- Film 20 - Very Bad Trip (2009)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Very Bad Trip', 'https://images.metahub.space/poster/medium/tt1119646/img', 'Quatre amis se rendent à Las Vegas pour fêter un enterrement de vie de garçon. Le lendemain, trois d''entre eux se réveillent sans souvenir de la soirée et le futur marié a disparu. Ils tentent de reconstituer une nuit chaotique en suivant des indices de plus en plus absurdes.', 2009, 10.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Phillips' AND prenom = 'Todd')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Very Bad Trip' AND annee_de_sortie = 2009
);

-- Film 21 - Les Évadés (1994)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Les Évadés', 'https://images.metahub.space/poster/medium/tt0111161/img', 'Andy Dufresne, condamné pour un double meurtre, est incarcéré à Shawshank. Il se lie d''amitié avec Red et tente de préserver sa dignité dans un système brutal. Les années passent tandis que l''espoir et la patience deviennent ses principales ressources.', 1994, 15.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Darabont' AND prenom = 'Frank')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Les Évadés' AND annee_de_sortie = 1994
);

-- Film 22 - La Ligne verte (1999)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'La Ligne verte', 'https://images.metahub.space/poster/medium/tt0120689/img', 'Dans un pénitencier américain des années 1930, un gardien supervise les détenus condamnés à mort. L''arrivée d''un prisonnier à la stature impressionnante bouleverse ses certitudes. Des événements inexplicables font émerger des questions sur la justice, l''innocence et la compassion.', 1999, 6.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Darabont' AND prenom = 'Frank')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'La Ligne verte' AND annee_de_sortie = 1999
);

-- Film 23 - Whiplash (2014)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Whiplash', 'https://images.metahub.space/poster/medium/tt2582802/img', 'Andrew, jeune batteur ambitieux, intègre un prestigieux conservatoire de musique. Il attire l''attention d''un professeur exigeant dont les méthodes dépassent progressivement les limites de l''enseignement. La quête de perfection transforme leur relation en affrontement psychologique.', 2014, 17.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Chazelle' AND prenom = 'Damien')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Whiplash' AND annee_de_sortie = 2014
);

-- Film 24 - Parasite (2019)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Parasite', 'https://images.metahub.space/poster/medium/tt6751668/img', 'Une famille pauvre trouve progressivement une place au service d''un riche foyer de Séoul. Chaque nouveau poste repose sur une dissimulation soigneusement élaborée. L''équilibre fragile entre les deux familles se fissure lorsqu''un secret inattendu vient bouleverser leur arrangement.', 2019, 6.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Bong' AND prenom = 'Joon-ho')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Parasite' AND annee_de_sortie = 2019
);

-- Film 25 - Joker (2019)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Joker', 'https://images.metahub.space/poster/medium/tt7286456/img', 'Arthur Fleck travaille comme clown dans une ville marquée par les tensions sociales. Isolé et en quête de reconnaissance, il subit une série d''humiliations. Sa transformation personnelle devient le catalyseur d''une violence qui dépasse progressivement son propre destin.', 2019, 12.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Phillips' AND prenom = 'Todd')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Joker' AND annee_de_sortie = 2019
);

-- Film 26 - Interstellar (2014)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Interstellar', 'https://images.metahub.space/poster/medium/tt0816692/img', 'La Terre devient de moins en moins habitable et une équipe de scientifiques cherche un nouveau refuge pour l''humanité. Cooper, ancien pilote, accepte de partir en mission à travers l''espace. Le voyage confronte les explorateurs aux limites du temps et à la séparation d''avec leurs familles.', 2014, 7.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Nolan' AND prenom = 'Christopher')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Interstellar' AND annee_de_sortie = 2014
);

-- Film 27 - La Liste de Schindler (1993)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'La Liste de Schindler', 'https://images.metahub.space/poster/medium/tt0108052/img', 'Pendant la Seconde Guerre mondiale, l''industriel Oskar Schindler tire d''abord profit de l''exploitation d''une main-d''œuvre juive. Confronté à la persécution nazie, il change progressivement d''attitude. Il utilise alors ses relations et ses ressources pour protéger des personnes menacées.', 1993, 6.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Spielberg' AND prenom = 'Steven')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'La Liste de Schindler' AND annee_de_sortie = 1993
);

-- Film 28 - La La Land (2016)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'La La Land', 'https://images.metahub.space/poster/medium/tt3783958/img', 'À Los Angeles, Mia, apprentie actrice, rencontre Sebastian, pianiste passionné de jazz. Leur histoire d''amour se construit autour de rêves professionnels exigeants. À mesure que leurs carrières évoluent, ils doivent arbitrer entre leurs ambitions et leur relation.', 2016, 10.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Chazelle' AND prenom = 'Damien')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'La La Land' AND annee_de_sortie = 2016
);

-- Film 29 - Fight Club (1999)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Fight Club', 'https://images.metahub.space/poster/medium/tt0137523/img', 'Un employé épuisé par sa vie quotidienne rencontre Tyler Durden, personnage charismatique qui rejette les conventions sociales. Ensemble, ils créent un club de combats clandestins. Le mouvement se radicalise et entraîne le narrateur vers une remise en question de sa propre identité.', 1999, 9.90,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Fincher' AND prenom = 'David')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Fight Club' AND annee_de_sortie = 1999
);

-- Film 30 - À la recherche du bonheur (2006)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'À la recherche du bonheur', 'https://images.metahub.space/poster/medium/tt0454921/img', 'Chris Gardner tente de se construire une carrière tout en assumant seul l''éducation de son jeune fils. Ses difficultés financières l''entraînent dans une période de grande précarité. Malgré les refus et les sacrifices, il poursuit une opportunité professionnelle qui pourrait changer leur existence.', 2006, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Muccino' AND prenom = 'Gabriele')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'À la recherche du bonheur' AND annee_de_sortie = 2006
);

-- Film 31 - Shining (1980)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Shining', 'https://images.metahub.space/poster/medium/tt0081505/img', 'Jack Torrance devient gardien d''un hôtel isolé dans les montagnes pendant l''hiver. Il s''y installe avec sa femme et son fils, qui perçoit d''étranges phénomènes. La solitude et l''influence inquiétante du lieu mettent progressivement la famille en danger.', 1980, 4.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Kubrick' AND prenom = 'Stanley')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Shining' AND annee_de_sortie = 1980
);

-- Film 32 - Conjuring : Les Dossiers Warren (2013)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Conjuring : Les Dossiers Warren', 'https://images.metahub.space/poster/medium/tt1457767/img', 'Une famille emménage dans une ferme où des événements inexplicables se multiplient. Les enquêteurs paranormaux Ed et Lorraine Warren sont appelés pour comprendre ces manifestations. Leur investigation fait apparaître une menace qui semble liée à l''histoire de la maison.', 2013, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Wan' AND prenom = 'James')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Conjuring : Les Dossiers Warren' AND annee_de_sortie = 2013
);

-- Film 33 - Get Out (2017)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Get Out', 'https://images.metahub.space/poster/medium/tt5052448/img', 'Chris accompagne sa compagne chez les parents de celle-ci pour un premier week-end en famille. Sous une apparente politesse, il remarque des comportements de plus en plus troublants. Sa visite se transforme en cauchemar lorsqu''il découvre ce que cachent réellement ses hôtes.', 2017, 18.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Peele' AND prenom = 'Jordan')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Get Out' AND annee_de_sortie = 2017
);

-- Film 34 - Alien, le huitième passager (1979)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Alien, le huitième passager', 'https://images.metahub.space/poster/medium/tt0078748/img', 'L''équipage du Nostromo interrompt son voyage après avoir capté un signal inconnu. Une exploration sur une planète lointaine entraîne à bord une menace biologique redoutable. Les survivants tentent de comprendre et d''éliminer une créature qui les traque dans les couloirs du vaisseau.', 1979, 15.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Scott' AND prenom = 'Ridley')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Alien, le huitième passager' AND annee_de_sortie = 1979
);

-- Film 35 - The Thing (1982)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'The Thing', 'https://images.metahub.space/poster/medium/tt0084787/img', 'Dans une station scientifique antarctique, des chercheurs découvrent une forme de vie capable d''imiter parfaitement les organismes qu''elle absorbe. La suspicion gagne le groupe, car personne ne sait plus qui est humain. L''isolement et la peur transforment leur lutte pour survivre en crise de confiance.', 1982, 4.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Carpenter' AND prenom = 'John')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'The Thing' AND annee_de_sortie = 1982
);

-- Film 36 - Scream (1996)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Scream', 'https://images.metahub.space/poster/medium/tt0117571/img', 'Une série de meurtres frappe une petite ville américaine. Sidney Prescott devient la cible d''un assassin masqué qui joue avec les codes des films d''horreur. L''enquête mêle secrets du passé, fausses pistes et humour macabre.', 1996, 9.90,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Craven' AND prenom = 'Wes')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Scream' AND annee_de_sortie = 1996
);

-- Film 37 - Sans un bruit (2018)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Sans un bruit', 'https://images.metahub.space/poster/medium/tt6644200/img', 'Dans un monde envahi par des créatures qui attaquent au moindre bruit, une famille apprend à vivre dans le silence. Chaque geste quotidien devient un risque mortel. Lorsque des événements imprévus menacent leur refuge, les parents doivent protéger leurs enfants sans attirer les monstres.', 2018, 9.90,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Krasinski' AND prenom = 'John')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Sans un bruit' AND annee_de_sortie = 2018
);

-- Film 38 - Ça (2017)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Ça', 'https://images.metahub.space/poster/medium/tt1396484/img', 'Dans la ville de Derry, plusieurs enfants disparaissent mystérieusement. Un groupe d''amis découvre qu''une présence malveillante, souvent déguisée en clown, exploite leurs peurs. Les adolescents décident d''affronter ensemble la menace qui hante leur communauté.', 2017, 8.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Muschietti' AND prenom = 'Andy')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Ça' AND annee_de_sortie = 2017
);

-- Film 39 - Hérédité (2018)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Hérédité', 'https://images.metahub.space/poster/medium/tt7784604/img', 'Après la mort de sa mère, Annie tente de préserver une famille déjà fragilisée. Des événements troublants et des découvertes sur son héritage font basculer leur quotidien. Les tensions familiales se mêlent peu à peu à une menace surnaturelle.', 2018, 7.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Aster' AND prenom = 'Ari')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Hérédité' AND annee_de_sortie = 2018
);

-- Film 40 - L'Exorciste (1973)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'L''Exorciste', 'https://images.metahub.space/poster/medium/tt0070047/img', 'À Washington, une mère s''inquiète des transformations inquiétantes de sa jeune fille. Les médecins ne parvenant pas à expliquer son état, elle sollicite l''aide de religieux. Une confrontation intense s''engage autour d''une possible possession démoniaque.', 1973, 11.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Friedkin' AND prenom = 'William')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'L''Exorciste' AND annee_de_sortie = 1973
);

-- Film 41 - Seven (1995)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Seven', 'https://images.metahub.space/poster/medium/tt0114369/img', 'Deux policiers enquêtent sur une série de crimes dont la mise en scène évoque les sept péchés capitaux. Le jeune inspecteur Mills et son collègue Somerset suivent les indices laissés par un assassin méthodique. Leur investigation les mène vers une conclusion particulièrement éprouvante.', 1995, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Fincher' AND prenom = 'David')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Seven' AND annee_de_sortie = 1995
);

-- Film 42 - Shutter Island (2010)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Shutter Island', 'https://images.metahub.space/poster/medium/tt1130884/img', 'Deux agents fédéraux débarquent sur une île où se trouve un hôpital psychiatrique sécurisé. Ils recherchent une patiente disparue dans des circonstances mystérieuses. Alors qu''une tempête bloque leur départ, l''enquête met en doute les apparences et les souvenirs de l''un des agents.', 2010, 13.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Scorsese' AND prenom = 'Martin')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Shutter Island' AND annee_de_sortie = 2010
);

-- Film 43 - Gone Girl (2014)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Gone Girl', 'https://images.metahub.space/poster/medium/tt2267998/img', 'Le jour de leur anniversaire de mariage, Amy disparaît et son époux Nick devient rapidement suspect. L''enquête policière et l''attention des médias exposent les fissures de leur couple. Les révélations successives transforment la perception de chacun des protagonistes.', 2014, 14.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Fincher' AND prenom = 'David')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Gone Girl' AND annee_de_sortie = 2014
);

-- Film 44 - Prisoners (2013)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Prisoners', 'https://images.metahub.space/poster/medium/tt1392214/img', 'Deux fillettes disparaissent lors d''une journée entre voisins. Un père désespéré décide d''agir en marge de l''enquête menée par un inspecteur déterminé. La recherche de la vérité l''amène à franchir des limites morales de plus en plus inquiétantes.', 2013, 15.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Villeneuve' AND prenom = 'Denis')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Prisoners' AND annee_de_sortie = 2013
);

-- Film 45 - Le Silence des agneaux (1991)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Le Silence des agneaux', 'https://images.metahub.space/poster/medium/tt0102926/img', 'Clarice Starling, jeune recrue du FBI, sollicite l''aide d''un psychiatre détenu pour comprendre un meurtrier en série. Le brillant Hannibal Lecter accepte de dialoguer, mais impose un jeu psychologique troublant. Clarice doit naviguer entre manipulation, enquête et souvenirs personnels.', 1991, 16.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Demme' AND prenom = 'Jonathan')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Le Silence des agneaux' AND annee_de_sortie = 1991
);

-- Film 46 - Zodiac (2007)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Zodiac', 'https://images.metahub.space/poster/medium/tt0443706/img', 'À San Francisco, des lettres énigmatiques revendiquent des meurtres attribués au Zodiac. Des policiers et des journalistes consacrent des années à suivre les pistes du dossier. Leur obsession révèle les difficultés d''une enquête sans certitudes et les conséquences sur leurs vies.', 2007, 15.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Fincher' AND prenom = 'David')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Zodiac' AND annee_de_sortie = 2007
);

-- Film 47 - Memento (2000)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Memento', 'https://images.metahub.space/poster/medium/tt0209144/img', 'Leonard enquête sur la mort de sa femme alors qu''il ne peut plus former de nouveaux souvenirs durables. Il utilise photographies, notes et tatouages pour organiser sa recherche. Le récit fragmenté interroge la fiabilité de sa mémoire et de ses certitudes.', 2000, 11.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Nolan' AND prenom = 'Christopher')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Memento' AND annee_de_sortie = 2000
);

-- Film 48 - Usual Suspects (1995)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Usual Suspects', 'https://images.metahub.space/poster/medium/tt0114814/img', 'Après une explosion meurtrière sur un bateau, un survivant raconte aux enquêteurs comment plusieurs criminels ont été réunis pour un coup dangereux. Son témoignage fait émerger la figure presque mythique de Keyser Söze. Les récits contradictoires laissent planer le doute sur la vérité des événements.', 1995, 18.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Singer' AND prenom = 'Bryan')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Usual Suspects' AND annee_de_sortie = 1995
);

-- Film 49 - Night Call (2014)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Night Call', 'https://images.metahub.space/poster/medium/tt2872718/img', 'Lou Bloom découvre qu''il peut vendre aux chaînes de télévision des images d''accidents et de crimes filmés la nuit à Los Angeles. Son ambition le conduit à franchir des limites éthiques toujours plus graves. Le film explore le sensationnalisme médiatique et la fascination pour la violence.', 2014, 4.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Gilroy' AND prenom = 'Dan')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Night Call' AND annee_de_sortie = 2014
);

-- Film 50 - Le Prestige (2006)
INSERT INTO film (titre, affiche, resume, annee_de_sortie, prix, id_realisateur)
SELECT 'Le Prestige', 'https://images.metahub.space/poster/medium/tt0482571/img', 'Deux illusionnistes londoniens se lancent dans une rivalité alimentée par la jalousie et les secrets professionnels. Chacun cherche à surpasser l''autre grâce à des numéros toujours plus impressionnants. Leur obsession du tour parfait finit par bouleverser leurs vies et celles de leurs proches.', 2006, 10.99,
       (SELECT MIN(id_realisateur) FROM realisateur WHERE nom = 'Nolan' AND prenom = 'Christopher')
WHERE NOT EXISTS (
  SELECT 1 FROM film WHERE titre = 'Le Prestige' AND annee_de_sortie = 2006
);

-- 4. Acteurs : les 150 rôles concernent 132 acteurs distincts.

INSERT INTO acteur (nom, prenom)
SELECT 'Bale', 'Christian'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Bale' AND prenom = 'Christian'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Ledger', 'Heath'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Ledger' AND prenom = 'Heath'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Eckhart', 'Aaron'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Eckhart' AND prenom = 'Aaron'
);

INSERT INTO acteur (nom, prenom)
SELECT 'DiCaprio', 'Leonardo'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'DiCaprio' AND prenom = 'Leonardo'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Gordon-Levitt', 'Joseph'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Gordon-Levitt' AND prenom = 'Joseph'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Cotillard', 'Marion'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Cotillard' AND prenom = 'Marion'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Hardy', 'Tom'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Hardy' AND prenom = 'Tom'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Theron', 'Charlize'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Theron' AND prenom = 'Charlize'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Hoult', 'Nicholas'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Hoult' AND prenom = 'Nicholas'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Reeves', 'Keanu'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Reeves' AND prenom = 'Keanu'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Nyqvist', 'Michael'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Nyqvist' AND prenom = 'Michael'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Dafoe', 'Willem'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Dafoe' AND prenom = 'Willem'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Willis', 'Bruce'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Willis' AND prenom = 'Bruce'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Rickman', 'Alan'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Rickman' AND prenom = 'Alan'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Bedelia', 'Bonnie'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Bedelia' AND prenom = 'Bonnie'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Schwarzenegger', 'Arnold'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Schwarzenegger' AND prenom = 'Arnold'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Hamilton', 'Linda'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Hamilton' AND prenom = 'Linda'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Furlong', 'Edward'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Furlong' AND prenom = 'Edward'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Fishburne', 'Laurence'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Fishburne' AND prenom = 'Laurence'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Moss', 'Carrie-Anne'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Moss' AND prenom = 'Carrie-Anne'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Crowe', 'Russell'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Crowe' AND prenom = 'Russell'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Phoenix', 'Joaquin'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Phoenix' AND prenom = 'Joaquin'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Nielsen', 'Connie'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Nielsen' AND prenom = 'Connie'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Cruise', 'Tom'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Cruise' AND prenom = 'Tom'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Cavill', 'Henry'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Cavill' AND prenom = 'Henry'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Ferguson', 'Rebecca'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Ferguson' AND prenom = 'Rebecca'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Pegg', 'Simon'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Pegg' AND prenom = 'Simon'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Frost', 'Nick'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Frost' AND prenom = 'Nick'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Dalton', 'Timothy'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Dalton' AND prenom = 'Timothy'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Cluzet', 'François'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Cluzet' AND prenom = 'François'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Sy', 'Omar'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Sy' AND prenom = 'Omar'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Le Ny', 'Anne'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Le Ny' AND prenom = 'Anne'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Carrey', 'Jim'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Carrey' AND prenom = 'Jim'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Linney', 'Laura'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Linney' AND prenom = 'Laura'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Harris', 'Ed'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Harris' AND prenom = 'Ed'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Fiennes', 'Ralph'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Fiennes' AND prenom = 'Ralph'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Revolori', 'Tony'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Revolori' AND prenom = 'Tony'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Ronan', 'Saoirse'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Ronan' AND prenom = 'Saoirse'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Breslin', 'Abigail'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Breslin' AND prenom = 'Abigail'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Kinnear', 'Greg'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Kinnear' AND prenom = 'Greg'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Carell', 'Steve'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Carell' AND prenom = 'Steve'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Murray', 'Bill'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Murray' AND prenom = 'Bill'
);

INSERT INTO acteur (nom, prenom)
SELECT 'MacDowell', 'Andie'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'MacDowell' AND prenom = 'Andie'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Elliott', 'Chris'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Elliott' AND prenom = 'Chris'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Diaz', 'Cameron'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Diaz' AND prenom = 'Cameron'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Riegert', 'Peter'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Riegert' AND prenom = 'Peter'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Ashfield', 'Kate'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Ashfield' AND prenom = 'Kate'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Eisenberg', 'Jesse'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Eisenberg' AND prenom = 'Jesse'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Harrelson', 'Woody'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Harrelson' AND prenom = 'Woody'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Stone', 'Emma'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Stone' AND prenom = 'Emma'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Hanks', 'Tom'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Hanks' AND prenom = 'Tom'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Wright', 'Robin'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Wright' AND prenom = 'Robin'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Sinise', 'Gary'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Sinise' AND prenom = 'Gary'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Cooper', 'Bradley'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Cooper' AND prenom = 'Bradley'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Helms', 'Ed'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Helms' AND prenom = 'Ed'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Galifianakis', 'Zach'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Galifianakis' AND prenom = 'Zach'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Robbins', 'Tim'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Robbins' AND prenom = 'Tim'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Freeman', 'Morgan'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Freeman' AND prenom = 'Morgan'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Gunton', 'Bob'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Gunton' AND prenom = 'Bob'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Clarke Duncan', 'Michael'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Clarke Duncan' AND prenom = 'Michael'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Morse', 'David'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Morse' AND prenom = 'David'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Teller', 'Miles'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Teller' AND prenom = 'Miles'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Simmons', 'J.K.'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Simmons' AND prenom = 'J.K.'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Benoist', 'Melissa'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Benoist' AND prenom = 'Melissa'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Kang-ho', 'Song'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Kang-ho' AND prenom = 'Song'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Sun-kyun', 'Lee'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Sun-kyun' AND prenom = 'Lee'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Yeo-jeong', 'Cho'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Yeo-jeong' AND prenom = 'Cho'
);

INSERT INTO acteur (nom, prenom)
SELECT 'De Niro', 'Robert'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'De Niro' AND prenom = 'Robert'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Beetz', 'Zazie'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Beetz' AND prenom = 'Zazie'
);

INSERT INTO acteur (nom, prenom)
SELECT 'McConaughey', 'Matthew'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'McConaughey' AND prenom = 'Matthew'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Hathaway', 'Anne'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Hathaway' AND prenom = 'Anne'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Chastain', 'Jessica'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Chastain' AND prenom = 'Jessica'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Neeson', 'Liam'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Neeson' AND prenom = 'Liam'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Kingsley', 'Ben'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Kingsley' AND prenom = 'Ben'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Gosling', 'Ryan'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Gosling' AND prenom = 'Ryan'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Legend', 'John'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Legend' AND prenom = 'John'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Norton', 'Edward'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Norton' AND prenom = 'Edward'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Pitt', 'Brad'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Pitt' AND prenom = 'Brad'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Bonham Carter', 'Helena'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Bonham Carter' AND prenom = 'Helena'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Smith', 'Will'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Smith' AND prenom = 'Will'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Smith', 'Jaden'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Smith' AND prenom = 'Jaden'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Newton', 'Thandiwe'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Newton' AND prenom = 'Thandiwe'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Nicholson', 'Jack'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Nicholson' AND prenom = 'Jack'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Duvall', 'Shelley'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Duvall' AND prenom = 'Shelley'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Lloyd', 'Danny'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Lloyd' AND prenom = 'Danny'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Wilson', 'Patrick'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Wilson' AND prenom = 'Patrick'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Farmiga', 'Vera'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Farmiga' AND prenom = 'Vera'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Taylor', 'Lili'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Taylor' AND prenom = 'Lili'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Kaluuya', 'Daniel'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Kaluuya' AND prenom = 'Daniel'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Williams', 'Allison'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Williams' AND prenom = 'Allison'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Whitford', 'Bradley'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Whitford' AND prenom = 'Bradley'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Weaver', 'Sigourney'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Weaver' AND prenom = 'Sigourney'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Skerritt', 'Tom'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Skerritt' AND prenom = 'Tom'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Hurt', 'John'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Hurt' AND prenom = 'John'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Russell', 'Kurt'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Russell' AND prenom = 'Kurt'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Brimley', 'Wilford'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Brimley' AND prenom = 'Wilford'
);

INSERT INTO acteur (nom, prenom)
SELECT 'David', 'Keith'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'David' AND prenom = 'Keith'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Campbell', 'Neve'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Campbell' AND prenom = 'Neve'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Cox', 'Courteney'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Cox' AND prenom = 'Courteney'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Arquette', 'David'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Arquette' AND prenom = 'David'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Blunt', 'Emily'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Blunt' AND prenom = 'Emily'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Krasinski', 'John'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Krasinski' AND prenom = 'John'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Simmonds', 'Millicent'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Simmonds' AND prenom = 'Millicent'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Skarsgård', 'Bill'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Skarsgård' AND prenom = 'Bill'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Martell', 'Jaeden'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Martell' AND prenom = 'Jaeden'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Lillis', 'Sophia'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Lillis' AND prenom = 'Sophia'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Collette', 'Toni'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Collette' AND prenom = 'Toni'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Wolff', 'Alex'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Wolff' AND prenom = 'Alex'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Shapiro', 'Milly'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Shapiro' AND prenom = 'Milly'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Burstyn', 'Ellen'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Burstyn' AND prenom = 'Ellen'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Blair', 'Linda'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Blair' AND prenom = 'Linda'
);

INSERT INTO acteur (nom, prenom)
SELECT 'von Sydow', 'Max'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'von Sydow' AND prenom = 'Max'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Paltrow', 'Gwyneth'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Paltrow' AND prenom = 'Gwyneth'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Ruffalo', 'Mark'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Ruffalo' AND prenom = 'Mark'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Affleck', 'Ben'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Affleck' AND prenom = 'Ben'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Pike', 'Rosamund'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Pike' AND prenom = 'Rosamund'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Harris', 'Neil Patrick'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Harris' AND prenom = 'Neil Patrick'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Jackman', 'Hugh'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Jackman' AND prenom = 'Hugh'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Gyllenhaal', 'Jake'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Gyllenhaal' AND prenom = 'Jake'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Davis', 'Viola'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Davis' AND prenom = 'Viola'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Foster', 'Jodie'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Foster' AND prenom = 'Jodie'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Hopkins', 'Anthony'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Hopkins' AND prenom = 'Anthony'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Glenn', 'Scott'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Glenn' AND prenom = 'Scott'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Downey Jr.', 'Robert'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Downey Jr.' AND prenom = 'Robert'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Pearce', 'Guy'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Pearce' AND prenom = 'Guy'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Pantoliano', 'Joe'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Pantoliano' AND prenom = 'Joe'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Spacey', 'Kevin'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Spacey' AND prenom = 'Kevin'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Byrne', 'Gabriel'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Byrne' AND prenom = 'Gabriel'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Palminteri', 'Chazz'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Palminteri' AND prenom = 'Chazz'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Russo', 'Rene'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Russo' AND prenom = 'Rene'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Ahmed', 'Riz'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Ahmed' AND prenom = 'Riz'
);

INSERT INTO acteur (nom, prenom)
SELECT 'Caine', 'Michael'
WHERE NOT EXISTS (
  SELECT 1 FROM acteur WHERE nom = 'Caine' AND prenom = 'Michael'
);

-- 5. Associations entre films et catégories (96 liens).
-- Un film peut appartenir à plusieurs catégories.

-- Film 01 - The Dark Knight : Le Chevalier noir : Action, Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Thriller', 'Drame')
WHERE f.titre = 'The Dark Knight : Le Chevalier noir' AND f.annee_de_sortie = 2008
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Dark Knight : Le Chevalier noir' AND f2.annee_de_sortie = 2008)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 02 - Inception : Action, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Thriller')
WHERE f.titre = 'Inception' AND f.annee_de_sortie = 2010
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Inception' AND f2.annee_de_sortie = 2010)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 03 - Mad Max: Fury Road : Action, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Thriller')
WHERE f.titre = 'Mad Max: Fury Road' AND f.annee_de_sortie = 2015
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Mad Max: Fury Road' AND f2.annee_de_sortie = 2015)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 04 - John Wick : Action, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Thriller')
WHERE f.titre = 'John Wick' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'John Wick' AND f2.annee_de_sortie = 2014)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 05 - Piège de cristal : Action, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Thriller')
WHERE f.titre = 'Piège de cristal' AND f.annee_de_sortie = 1988
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Piège de cristal' AND f2.annee_de_sortie = 1988)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 06 - Terminator 2 : Le Jugement dernier : Action, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Thriller')
WHERE f.titre = 'Terminator 2 : Le Jugement dernier' AND f.annee_de_sortie = 1991
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Terminator 2 : Le Jugement dernier' AND f2.annee_de_sortie = 1991)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 07 - Matrix : Action, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Thriller')
WHERE f.titre = 'Matrix' AND f.annee_de_sortie = 1999
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Matrix' AND f2.annee_de_sortie = 1999)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 08 - Gladiator : Action, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Drame')
WHERE f.titre = 'Gladiator' AND f.annee_de_sortie = 2000
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Gladiator' AND f2.annee_de_sortie = 2000)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 09 - Mission: Impossible – Fallout : Action, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Thriller')
WHERE f.titre = 'Mission: Impossible – Fallout' AND f.annee_de_sortie = 2018
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Mission: Impossible – Fallout' AND f2.annee_de_sortie = 2018)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 10 - Hot Fuzz : Action, Comédie, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Action', 'Comédie', 'Thriller')
WHERE f.titre = 'Hot Fuzz' AND f.annee_de_sortie = 2007
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Hot Fuzz' AND f2.annee_de_sortie = 2007)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 11 - Intouchables : Comédie, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie', 'Drame')
WHERE f.titre = 'Intouchables' AND f.annee_de_sortie = 2011
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Intouchables' AND f2.annee_de_sortie = 2011)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 12 - The Truman Show : Comédie, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie', 'Drame')
WHERE f.titre = 'The Truman Show' AND f.annee_de_sortie = 1998
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Truman Show' AND f2.annee_de_sortie = 1998)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 13 - The Grand Budapest Hotel : Comédie, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie', 'Drame')
WHERE f.titre = 'The Grand Budapest Hotel' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Grand Budapest Hotel' AND f2.annee_de_sortie = 2014)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 14 - Little Miss Sunshine : Comédie, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie', 'Drame')
WHERE f.titre = 'Little Miss Sunshine' AND f.annee_de_sortie = 2006
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Little Miss Sunshine' AND f2.annee_de_sortie = 2006)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 15 - Un jour sans fin : Comédie
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie')
WHERE f.titre = 'Un jour sans fin' AND f.annee_de_sortie = 1993
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Un jour sans fin' AND f2.annee_de_sortie = 1993)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 16 - The Mask : Comédie, Action
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie', 'Action')
WHERE f.titre = 'The Mask' AND f.annee_de_sortie = 1994
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Mask' AND f2.annee_de_sortie = 1994)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 17 - Shaun of the Dead : Comédie, Horreur
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie', 'Horreur')
WHERE f.titre = 'Shaun of the Dead' AND f.annee_de_sortie = 2004
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Shaun of the Dead' AND f2.annee_de_sortie = 2004)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 18 - Bienvenue à Zombieland : Comédie, Horreur, Action
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie', 'Horreur', 'Action')
WHERE f.titre = 'Bienvenue à Zombieland' AND f.annee_de_sortie = 2009
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Bienvenue à Zombieland' AND f2.annee_de_sortie = 2009)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 19 - Forrest Gump : Comédie, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie', 'Drame')
WHERE f.titre = 'Forrest Gump' AND f.annee_de_sortie = 1994
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Forrest Gump' AND f2.annee_de_sortie = 1994)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 20 - Very Bad Trip : Comédie
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Comédie')
WHERE f.titre = 'Very Bad Trip' AND f.annee_de_sortie = 2009
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Very Bad Trip' AND f2.annee_de_sortie = 2009)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 21 - Les Évadés : Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame')
WHERE f.titre = 'Les Évadés' AND f.annee_de_sortie = 1994
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Les Évadés' AND f2.annee_de_sortie = 1994)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 22 - La Ligne verte : Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame')
WHERE f.titre = 'La Ligne verte' AND f.annee_de_sortie = 1999
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'La Ligne verte' AND f2.annee_de_sortie = 1999)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 23 - Whiplash : Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame')
WHERE f.titre = 'Whiplash' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Whiplash' AND f2.annee_de_sortie = 2014)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 24 - Parasite : Drame, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame', 'Thriller')
WHERE f.titre = 'Parasite' AND f.annee_de_sortie = 2019
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Parasite' AND f2.annee_de_sortie = 2019)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 25 - Joker : Drame, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame', 'Thriller')
WHERE f.titre = 'Joker' AND f.annee_de_sortie = 2019
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Joker' AND f2.annee_de_sortie = 2019)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 26 - Interstellar : Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame')
WHERE f.titre = 'Interstellar' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Interstellar' AND f2.annee_de_sortie = 2014)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 27 - La Liste de Schindler : Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame')
WHERE f.titre = 'La Liste de Schindler' AND f.annee_de_sortie = 1993
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'La Liste de Schindler' AND f2.annee_de_sortie = 1993)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 28 - La La Land : Drame, Comédie
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame', 'Comédie')
WHERE f.titre = 'La La Land' AND f.annee_de_sortie = 2016
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'La La Land' AND f2.annee_de_sortie = 2016)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 29 - Fight Club : Drame, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame', 'Thriller')
WHERE f.titre = 'Fight Club' AND f.annee_de_sortie = 1999
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Fight Club' AND f2.annee_de_sortie = 1999)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 30 - À la recherche du bonheur : Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Drame')
WHERE f.titre = 'À la recherche du bonheur' AND f.annee_de_sortie = 2006
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'À la recherche du bonheur' AND f2.annee_de_sortie = 2006)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 31 - Shining : Horreur, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Thriller')
WHERE f.titre = 'Shining' AND f.annee_de_sortie = 1980
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Shining' AND f2.annee_de_sortie = 1980)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 32 - Conjuring : Les Dossiers Warren : Horreur, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Thriller')
WHERE f.titre = 'Conjuring : Les Dossiers Warren' AND f.annee_de_sortie = 2013
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Conjuring : Les Dossiers Warren' AND f2.annee_de_sortie = 2013)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 33 - Get Out : Horreur, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Thriller')
WHERE f.titre = 'Get Out' AND f.annee_de_sortie = 2017
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Get Out' AND f2.annee_de_sortie = 2017)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 34 - Alien, le huitième passager : Horreur, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Thriller')
WHERE f.titre = 'Alien, le huitième passager' AND f.annee_de_sortie = 1979
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Alien, le huitième passager' AND f2.annee_de_sortie = 1979)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 35 - The Thing : Horreur, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Thriller')
WHERE f.titre = 'The Thing' AND f.annee_de_sortie = 1982
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Thing' AND f2.annee_de_sortie = 1982)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 36 - Scream : Horreur, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Thriller')
WHERE f.titre = 'Scream' AND f.annee_de_sortie = 1996
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Scream' AND f2.annee_de_sortie = 1996)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 37 - Sans un bruit : Horreur, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Thriller')
WHERE f.titre = 'Sans un bruit' AND f.annee_de_sortie = 2018
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Sans un bruit' AND f2.annee_de_sortie = 2018)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 38 - Ça : Horreur, Thriller
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Thriller')
WHERE f.titre = 'Ça' AND f.annee_de_sortie = 2017
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Ça' AND f2.annee_de_sortie = 2017)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 39 - Hérédité : Horreur, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Drame')
WHERE f.titre = 'Hérédité' AND f.annee_de_sortie = 2018
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Hérédité' AND f2.annee_de_sortie = 2018)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 40 - L'Exorciste : Horreur, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Horreur', 'Drame')
WHERE f.titre = 'L''Exorciste' AND f.annee_de_sortie = 1973
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'L''Exorciste' AND f2.annee_de_sortie = 1973)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 41 - Seven : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Seven' AND f.annee_de_sortie = 1995
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Seven' AND f2.annee_de_sortie = 1995)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 42 - Shutter Island : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Shutter Island' AND f.annee_de_sortie = 2010
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Shutter Island' AND f2.annee_de_sortie = 2010)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 43 - Gone Girl : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Gone Girl' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Gone Girl' AND f2.annee_de_sortie = 2014)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 44 - Prisoners : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Prisoners' AND f.annee_de_sortie = 2013
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Prisoners' AND f2.annee_de_sortie = 2013)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 45 - Le Silence des agneaux : Thriller, Horreur, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Horreur', 'Drame')
WHERE f.titre = 'Le Silence des agneaux' AND f.annee_de_sortie = 1991
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Le Silence des agneaux' AND f2.annee_de_sortie = 1991)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 46 - Zodiac : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Zodiac' AND f.annee_de_sortie = 2007
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Zodiac' AND f2.annee_de_sortie = 2007)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 47 - Memento : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Memento' AND f.annee_de_sortie = 2000
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Memento' AND f2.annee_de_sortie = 2000)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 48 - Usual Suspects : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Usual Suspects' AND f.annee_de_sortie = 1995
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Usual Suspects' AND f2.annee_de_sortie = 1995)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 49 - Night Call : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Night Call' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Night Call' AND f2.annee_de_sortie = 2014)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- Film 50 - Le Prestige : Thriller, Drame
INSERT INTO fait_partie_de (id_film, id_categorie)
SELECT f.id_film, c.id_categorie
FROM film f
JOIN categorie c ON c.nom IN ('Thriller', 'Drame')
WHERE f.titre = 'Le Prestige' AND f.annee_de_sortie = 2006
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Le Prestige' AND f2.annee_de_sortie = 2006)
  AND NOT EXISTS (SELECT 1 FROM fait_partie_de fc
                  WHERE fc.id_film = f.id_film AND fc.id_categorie = c.id_categorie);

-- 6. Associations films / acteurs (3 acteurs pour chacun des 50 films).

-- Film 01 - The Dark Knight : Le Chevalier noir
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Christian' AND a.nom = 'Bale') OR
       (a.prenom = 'Heath' AND a.nom = 'Ledger') OR
       (a.prenom = 'Aaron' AND a.nom = 'Eckhart'))
WHERE f.titre = 'The Dark Knight : Le Chevalier noir' AND f.annee_de_sortie = 2008
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Dark Knight : Le Chevalier noir' AND f2.annee_de_sortie = 2008)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 02 - Inception
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Leonardo' AND a.nom = 'DiCaprio') OR
       (a.prenom = 'Joseph' AND a.nom = 'Gordon-Levitt') OR
       (a.prenom = 'Marion' AND a.nom = 'Cotillard'))
WHERE f.titre = 'Inception' AND f.annee_de_sortie = 2010
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Inception' AND f2.annee_de_sortie = 2010)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 03 - Mad Max: Fury Road
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Tom' AND a.nom = 'Hardy') OR
       (a.prenom = 'Charlize' AND a.nom = 'Theron') OR
       (a.prenom = 'Nicholas' AND a.nom = 'Hoult'))
WHERE f.titre = 'Mad Max: Fury Road' AND f.annee_de_sortie = 2015
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Mad Max: Fury Road' AND f2.annee_de_sortie = 2015)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 04 - John Wick
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Keanu' AND a.nom = 'Reeves') OR
       (a.prenom = 'Michael' AND a.nom = 'Nyqvist') OR
       (a.prenom = 'Willem' AND a.nom = 'Dafoe'))
WHERE f.titre = 'John Wick' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'John Wick' AND f2.annee_de_sortie = 2014)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 05 - Piège de cristal
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Bruce' AND a.nom = 'Willis') OR
       (a.prenom = 'Alan' AND a.nom = 'Rickman') OR
       (a.prenom = 'Bonnie' AND a.nom = 'Bedelia'))
WHERE f.titre = 'Piège de cristal' AND f.annee_de_sortie = 1988
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Piège de cristal' AND f2.annee_de_sortie = 1988)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 06 - Terminator 2 : Le Jugement dernier
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Arnold' AND a.nom = 'Schwarzenegger') OR
       (a.prenom = 'Linda' AND a.nom = 'Hamilton') OR
       (a.prenom = 'Edward' AND a.nom = 'Furlong'))
WHERE f.titre = 'Terminator 2 : Le Jugement dernier' AND f.annee_de_sortie = 1991
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Terminator 2 : Le Jugement dernier' AND f2.annee_de_sortie = 1991)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 07 - Matrix
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Keanu' AND a.nom = 'Reeves') OR
       (a.prenom = 'Laurence' AND a.nom = 'Fishburne') OR
       (a.prenom = 'Carrie-Anne' AND a.nom = 'Moss'))
WHERE f.titre = 'Matrix' AND f.annee_de_sortie = 1999
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Matrix' AND f2.annee_de_sortie = 1999)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 08 - Gladiator
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Russell' AND a.nom = 'Crowe') OR
       (a.prenom = 'Joaquin' AND a.nom = 'Phoenix') OR
       (a.prenom = 'Connie' AND a.nom = 'Nielsen'))
WHERE f.titre = 'Gladiator' AND f.annee_de_sortie = 2000
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Gladiator' AND f2.annee_de_sortie = 2000)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 09 - Mission: Impossible – Fallout
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Tom' AND a.nom = 'Cruise') OR
       (a.prenom = 'Henry' AND a.nom = 'Cavill') OR
       (a.prenom = 'Rebecca' AND a.nom = 'Ferguson'))
WHERE f.titre = 'Mission: Impossible – Fallout' AND f.annee_de_sortie = 2018
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Mission: Impossible – Fallout' AND f2.annee_de_sortie = 2018)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 10 - Hot Fuzz
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Simon' AND a.nom = 'Pegg') OR
       (a.prenom = 'Nick' AND a.nom = 'Frost') OR
       (a.prenom = 'Timothy' AND a.nom = 'Dalton'))
WHERE f.titre = 'Hot Fuzz' AND f.annee_de_sortie = 2007
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Hot Fuzz' AND f2.annee_de_sortie = 2007)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 11 - Intouchables
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'François' AND a.nom = 'Cluzet') OR
       (a.prenom = 'Omar' AND a.nom = 'Sy') OR
       (a.prenom = 'Anne' AND a.nom = 'Le Ny'))
WHERE f.titre = 'Intouchables' AND f.annee_de_sortie = 2011
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Intouchables' AND f2.annee_de_sortie = 2011)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 12 - The Truman Show
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Jim' AND a.nom = 'Carrey') OR
       (a.prenom = 'Laura' AND a.nom = 'Linney') OR
       (a.prenom = 'Ed' AND a.nom = 'Harris'))
WHERE f.titre = 'The Truman Show' AND f.annee_de_sortie = 1998
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Truman Show' AND f2.annee_de_sortie = 1998)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 13 - The Grand Budapest Hotel
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Ralph' AND a.nom = 'Fiennes') OR
       (a.prenom = 'Tony' AND a.nom = 'Revolori') OR
       (a.prenom = 'Saoirse' AND a.nom = 'Ronan'))
WHERE f.titre = 'The Grand Budapest Hotel' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Grand Budapest Hotel' AND f2.annee_de_sortie = 2014)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 14 - Little Miss Sunshine
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Abigail' AND a.nom = 'Breslin') OR
       (a.prenom = 'Greg' AND a.nom = 'Kinnear') OR
       (a.prenom = 'Steve' AND a.nom = 'Carell'))
WHERE f.titre = 'Little Miss Sunshine' AND f.annee_de_sortie = 2006
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Little Miss Sunshine' AND f2.annee_de_sortie = 2006)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 15 - Un jour sans fin
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Bill' AND a.nom = 'Murray') OR
       (a.prenom = 'Andie' AND a.nom = 'MacDowell') OR
       (a.prenom = 'Chris' AND a.nom = 'Elliott'))
WHERE f.titre = 'Un jour sans fin' AND f.annee_de_sortie = 1993
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Un jour sans fin' AND f2.annee_de_sortie = 1993)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 16 - The Mask
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Jim' AND a.nom = 'Carrey') OR
       (a.prenom = 'Cameron' AND a.nom = 'Diaz') OR
       (a.prenom = 'Peter' AND a.nom = 'Riegert'))
WHERE f.titre = 'The Mask' AND f.annee_de_sortie = 1994
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Mask' AND f2.annee_de_sortie = 1994)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 17 - Shaun of the Dead
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Simon' AND a.nom = 'Pegg') OR
       (a.prenom = 'Nick' AND a.nom = 'Frost') OR
       (a.prenom = 'Kate' AND a.nom = 'Ashfield'))
WHERE f.titre = 'Shaun of the Dead' AND f.annee_de_sortie = 2004
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Shaun of the Dead' AND f2.annee_de_sortie = 2004)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 18 - Bienvenue à Zombieland
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Jesse' AND a.nom = 'Eisenberg') OR
       (a.prenom = 'Woody' AND a.nom = 'Harrelson') OR
       (a.prenom = 'Emma' AND a.nom = 'Stone'))
WHERE f.titre = 'Bienvenue à Zombieland' AND f.annee_de_sortie = 2009
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Bienvenue à Zombieland' AND f2.annee_de_sortie = 2009)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 19 - Forrest Gump
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Tom' AND a.nom = 'Hanks') OR
       (a.prenom = 'Robin' AND a.nom = 'Wright') OR
       (a.prenom = 'Gary' AND a.nom = 'Sinise'))
WHERE f.titre = 'Forrest Gump' AND f.annee_de_sortie = 1994
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Forrest Gump' AND f2.annee_de_sortie = 1994)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 20 - Very Bad Trip
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Bradley' AND a.nom = 'Cooper') OR
       (a.prenom = 'Ed' AND a.nom = 'Helms') OR
       (a.prenom = 'Zach' AND a.nom = 'Galifianakis'))
WHERE f.titre = 'Very Bad Trip' AND f.annee_de_sortie = 2009
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Very Bad Trip' AND f2.annee_de_sortie = 2009)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 21 - Les Évadés
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Tim' AND a.nom = 'Robbins') OR
       (a.prenom = 'Morgan' AND a.nom = 'Freeman') OR
       (a.prenom = 'Bob' AND a.nom = 'Gunton'))
WHERE f.titre = 'Les Évadés' AND f.annee_de_sortie = 1994
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Les Évadés' AND f2.annee_de_sortie = 1994)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 22 - La Ligne verte
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Tom' AND a.nom = 'Hanks') OR
       (a.prenom = 'Michael' AND a.nom = 'Clarke Duncan') OR
       (a.prenom = 'David' AND a.nom = 'Morse'))
WHERE f.titre = 'La Ligne verte' AND f.annee_de_sortie = 1999
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'La Ligne verte' AND f2.annee_de_sortie = 1999)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 23 - Whiplash
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Miles' AND a.nom = 'Teller') OR
       (a.prenom = 'J.K.' AND a.nom = 'Simmons') OR
       (a.prenom = 'Melissa' AND a.nom = 'Benoist'))
WHERE f.titre = 'Whiplash' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Whiplash' AND f2.annee_de_sortie = 2014)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 24 - Parasite
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Song' AND a.nom = 'Kang-ho') OR
       (a.prenom = 'Lee' AND a.nom = 'Sun-kyun') OR
       (a.prenom = 'Cho' AND a.nom = 'Yeo-jeong'))
WHERE f.titre = 'Parasite' AND f.annee_de_sortie = 2019
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Parasite' AND f2.annee_de_sortie = 2019)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 25 - Joker
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Joaquin' AND a.nom = 'Phoenix') OR
       (a.prenom = 'Robert' AND a.nom = 'De Niro') OR
       (a.prenom = 'Zazie' AND a.nom = 'Beetz'))
WHERE f.titre = 'Joker' AND f.annee_de_sortie = 2019
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Joker' AND f2.annee_de_sortie = 2019)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 26 - Interstellar
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Matthew' AND a.nom = 'McConaughey') OR
       (a.prenom = 'Anne' AND a.nom = 'Hathaway') OR
       (a.prenom = 'Jessica' AND a.nom = 'Chastain'))
WHERE f.titre = 'Interstellar' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Interstellar' AND f2.annee_de_sortie = 2014)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 27 - La Liste de Schindler
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Liam' AND a.nom = 'Neeson') OR
       (a.prenom = 'Ben' AND a.nom = 'Kingsley') OR
       (a.prenom = 'Ralph' AND a.nom = 'Fiennes'))
WHERE f.titre = 'La Liste de Schindler' AND f.annee_de_sortie = 1993
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'La Liste de Schindler' AND f2.annee_de_sortie = 1993)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 28 - La La Land
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Ryan' AND a.nom = 'Gosling') OR
       (a.prenom = 'Emma' AND a.nom = 'Stone') OR
       (a.prenom = 'John' AND a.nom = 'Legend'))
WHERE f.titre = 'La La Land' AND f.annee_de_sortie = 2016
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'La La Land' AND f2.annee_de_sortie = 2016)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 29 - Fight Club
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Edward' AND a.nom = 'Norton') OR
       (a.prenom = 'Brad' AND a.nom = 'Pitt') OR
       (a.prenom = 'Helena' AND a.nom = 'Bonham Carter'))
WHERE f.titre = 'Fight Club' AND f.annee_de_sortie = 1999
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Fight Club' AND f2.annee_de_sortie = 1999)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 30 - À la recherche du bonheur
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Will' AND a.nom = 'Smith') OR
       (a.prenom = 'Jaden' AND a.nom = 'Smith') OR
       (a.prenom = 'Thandiwe' AND a.nom = 'Newton'))
WHERE f.titre = 'À la recherche du bonheur' AND f.annee_de_sortie = 2006
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'À la recherche du bonheur' AND f2.annee_de_sortie = 2006)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 31 - Shining
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Jack' AND a.nom = 'Nicholson') OR
       (a.prenom = 'Shelley' AND a.nom = 'Duvall') OR
       (a.prenom = 'Danny' AND a.nom = 'Lloyd'))
WHERE f.titre = 'Shining' AND f.annee_de_sortie = 1980
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Shining' AND f2.annee_de_sortie = 1980)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 32 - Conjuring : Les Dossiers Warren
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Patrick' AND a.nom = 'Wilson') OR
       (a.prenom = 'Vera' AND a.nom = 'Farmiga') OR
       (a.prenom = 'Lili' AND a.nom = 'Taylor'))
WHERE f.titre = 'Conjuring : Les Dossiers Warren' AND f.annee_de_sortie = 2013
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Conjuring : Les Dossiers Warren' AND f2.annee_de_sortie = 2013)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 33 - Get Out
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Daniel' AND a.nom = 'Kaluuya') OR
       (a.prenom = 'Allison' AND a.nom = 'Williams') OR
       (a.prenom = 'Bradley' AND a.nom = 'Whitford'))
WHERE f.titre = 'Get Out' AND f.annee_de_sortie = 2017
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Get Out' AND f2.annee_de_sortie = 2017)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 34 - Alien, le huitième passager
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Sigourney' AND a.nom = 'Weaver') OR
       (a.prenom = 'Tom' AND a.nom = 'Skerritt') OR
       (a.prenom = 'John' AND a.nom = 'Hurt'))
WHERE f.titre = 'Alien, le huitième passager' AND f.annee_de_sortie = 1979
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Alien, le huitième passager' AND f2.annee_de_sortie = 1979)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 35 - The Thing
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Kurt' AND a.nom = 'Russell') OR
       (a.prenom = 'Wilford' AND a.nom = 'Brimley') OR
       (a.prenom = 'Keith' AND a.nom = 'David'))
WHERE f.titre = 'The Thing' AND f.annee_de_sortie = 1982
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'The Thing' AND f2.annee_de_sortie = 1982)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 36 - Scream
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Neve' AND a.nom = 'Campbell') OR
       (a.prenom = 'Courteney' AND a.nom = 'Cox') OR
       (a.prenom = 'David' AND a.nom = 'Arquette'))
WHERE f.titre = 'Scream' AND f.annee_de_sortie = 1996
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Scream' AND f2.annee_de_sortie = 1996)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 37 - Sans un bruit
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Emily' AND a.nom = 'Blunt') OR
       (a.prenom = 'John' AND a.nom = 'Krasinski') OR
       (a.prenom = 'Millicent' AND a.nom = 'Simmonds'))
WHERE f.titre = 'Sans un bruit' AND f.annee_de_sortie = 2018
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Sans un bruit' AND f2.annee_de_sortie = 2018)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 38 - Ça
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Bill' AND a.nom = 'Skarsgård') OR
       (a.prenom = 'Jaeden' AND a.nom = 'Martell') OR
       (a.prenom = 'Sophia' AND a.nom = 'Lillis'))
WHERE f.titre = 'Ça' AND f.annee_de_sortie = 2017
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Ça' AND f2.annee_de_sortie = 2017)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 39 - Hérédité
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Toni' AND a.nom = 'Collette') OR
       (a.prenom = 'Alex' AND a.nom = 'Wolff') OR
       (a.prenom = 'Milly' AND a.nom = 'Shapiro'))
WHERE f.titre = 'Hérédité' AND f.annee_de_sortie = 2018
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Hérédité' AND f2.annee_de_sortie = 2018)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 40 - L'Exorciste
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Ellen' AND a.nom = 'Burstyn') OR
       (a.prenom = 'Linda' AND a.nom = 'Blair') OR
       (a.prenom = 'Max' AND a.nom = 'von Sydow'))
WHERE f.titre = 'L''Exorciste' AND f.annee_de_sortie = 1973
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'L''Exorciste' AND f2.annee_de_sortie = 1973)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 41 - Seven
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Brad' AND a.nom = 'Pitt') OR
       (a.prenom = 'Morgan' AND a.nom = 'Freeman') OR
       (a.prenom = 'Gwyneth' AND a.nom = 'Paltrow'))
WHERE f.titre = 'Seven' AND f.annee_de_sortie = 1995
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Seven' AND f2.annee_de_sortie = 1995)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 42 - Shutter Island
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Leonardo' AND a.nom = 'DiCaprio') OR
       (a.prenom = 'Mark' AND a.nom = 'Ruffalo') OR
       (a.prenom = 'Ben' AND a.nom = 'Kingsley'))
WHERE f.titre = 'Shutter Island' AND f.annee_de_sortie = 2010
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Shutter Island' AND f2.annee_de_sortie = 2010)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 43 - Gone Girl
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Ben' AND a.nom = 'Affleck') OR
       (a.prenom = 'Rosamund' AND a.nom = 'Pike') OR
       (a.prenom = 'Neil Patrick' AND a.nom = 'Harris'))
WHERE f.titre = 'Gone Girl' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Gone Girl' AND f2.annee_de_sortie = 2014)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 44 - Prisoners
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Hugh' AND a.nom = 'Jackman') OR
       (a.prenom = 'Jake' AND a.nom = 'Gyllenhaal') OR
       (a.prenom = 'Viola' AND a.nom = 'Davis'))
WHERE f.titre = 'Prisoners' AND f.annee_de_sortie = 2013
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Prisoners' AND f2.annee_de_sortie = 2013)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 45 - Le Silence des agneaux
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Jodie' AND a.nom = 'Foster') OR
       (a.prenom = 'Anthony' AND a.nom = 'Hopkins') OR
       (a.prenom = 'Scott' AND a.nom = 'Glenn'))
WHERE f.titre = 'Le Silence des agneaux' AND f.annee_de_sortie = 1991
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Le Silence des agneaux' AND f2.annee_de_sortie = 1991)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 46 - Zodiac
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Jake' AND a.nom = 'Gyllenhaal') OR
       (a.prenom = 'Mark' AND a.nom = 'Ruffalo') OR
       (a.prenom = 'Robert' AND a.nom = 'Downey Jr.'))
WHERE f.titre = 'Zodiac' AND f.annee_de_sortie = 2007
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Zodiac' AND f2.annee_de_sortie = 2007)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 47 - Memento
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Guy' AND a.nom = 'Pearce') OR
       (a.prenom = 'Carrie-Anne' AND a.nom = 'Moss') OR
       (a.prenom = 'Joe' AND a.nom = 'Pantoliano'))
WHERE f.titre = 'Memento' AND f.annee_de_sortie = 2000
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Memento' AND f2.annee_de_sortie = 2000)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 48 - Usual Suspects
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Kevin' AND a.nom = 'Spacey') OR
       (a.prenom = 'Gabriel' AND a.nom = 'Byrne') OR
       (a.prenom = 'Chazz' AND a.nom = 'Palminteri'))
WHERE f.titre = 'Usual Suspects' AND f.annee_de_sortie = 1995
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Usual Suspects' AND f2.annee_de_sortie = 1995)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 49 - Night Call
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Jake' AND a.nom = 'Gyllenhaal') OR
       (a.prenom = 'Rene' AND a.nom = 'Russo') OR
       (a.prenom = 'Riz' AND a.nom = 'Ahmed'))
WHERE f.titre = 'Night Call' AND f.annee_de_sortie = 2014
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Night Call' AND f2.annee_de_sortie = 2014)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

-- Film 50 - Le Prestige
INSERT INTO ont_joue_dans (id_film, id_acteur)
SELECT f.id_film, a.id_acteur
FROM film f
JOIN acteur a ON ((a.prenom = 'Hugh' AND a.nom = 'Jackman') OR
       (a.prenom = 'Christian' AND a.nom = 'Bale') OR
       (a.prenom = 'Michael' AND a.nom = 'Caine'))
WHERE f.titre = 'Le Prestige' AND f.annee_de_sortie = 2006
  AND f.id_film = (SELECT MIN(f2.id_film) FROM film f2
                   WHERE f2.titre = 'Le Prestige' AND f2.annee_de_sortie = 2006)
  AND a.id_acteur = (SELECT MIN(a2.id_acteur) FROM acteur a2
                     WHERE a2.prenom = a.prenom AND a2.nom = a.nom)
  AND NOT EXISTS (SELECT 1 FROM ont_joue_dans fa
                  WHERE fa.id_film = f.id_film AND fa.id_acteur = a.id_acteur);

COMMIT;

-- 7. Vérifications : ces résultats comptent les données TOTALES en base.
-- Dans une base initialement vide, le résultat attendu est :
-- 50 films, 38 réalisateurs, 132 acteurs,
-- 96 liens film/catégorie, 150 liens film/acteur.

SELECT c.nom AS categorie, COUNT(DISTINCT fc.id_film) AS nombre_films
FROM categorie c
LEFT JOIN fait_partie_de fc ON fc.id_categorie = c.id_categorie
GROUP BY c.id_categorie, c.nom
ORDER BY c.id_categorie;

SELECT 'film' AS table_nom, COUNT(*) AS lignes FROM film
UNION ALL SELECT 'realisateur', COUNT(*) FROM realisateur
UNION ALL SELECT 'acteur', COUNT(*) FROM acteur
UNION ALL SELECT 'fait_partie_de', COUNT(*) FROM fait_partie_de
UNION ALL SELECT 'ont_joue_dans', COUNT(*) FROM ont_joue_dans;

-- Les tables utilisateur, panier, commande, contient et contenant
-- ne sont jamais modifiées par cet import.
