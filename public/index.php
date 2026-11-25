<?php

    // Connexion PDO
    require_once __DIR__ . "/../config/database.php";

    // Récupération des 5 films tendances
    $requete = $pdo->query(
            "SELECT id_film, titre, affiche, `resume`, prix
                    FROM film
                    ORDER BY annee_de_sortie DESC, id_film DESC
                    LIMIT 5;");
    $tendances = $requete->fetchAll(PDO::FETCH_ASSOC);
?>


<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Accueil | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <section class="section_page section_presentation">
            <h1 id="titre_accueil"> Bienvenue chez Bob'ines ! </h1>
            <p>
                Découvrez des films, ajoutez vos favoris au panier
                et créez votre collection personnelle.
            </p>
        </section>
        <!-- =================================
        1. Films en tendance
        ===================================== -->

        <section class="section_page section_tendance">
            <h2 class="titre_section" id="titre_tendance"> Films tendances </h2>
            <div class="liste_films">
                <!-- Cartes de films générées dynamiquement -->
                <?php foreach ($tendances as $film): ?>

                    <article class="carte_film">
                        <img
                             class="affiche_film"
                             src="<?= htmlspecialchars(
                                     !empty($film["affiche"]) ? $film["affiche"] : "images/affiche_indisponible.png",
                                     ENT_QUOTES,
                                     'UTF-8'
                             ) ?>"
                             onerror="this.onerror=null; this.src='images/affiche_indisponible.png';"
                             alt="affiche du film <?php echo htmlspecialchars($film["titre"], ENT_QUOTES, 'UTF-8') ?>"
                        >
                        <div class="contenu_carte_film">
                            <h3 class="titre_film"> <?php echo htmlspecialchars($film["titre"], ENT_QUOTES, 'UTF-8') ?> </h3>
                            <p class="description_film"> <?php echo htmlspecialchars($film["resume"], ENT_QUOTES, 'UTF-8') ?> </p>
                            <p class="prix_film"> <?php echo number_format((float) $film["prix"], 2, ",", " ") ?> € </p>
                            <a
                                class="lien_details_film"
                                href="movie.php?id=<?php echo (int) $film["id_film"] ?>"
                            >
                                Voir les détails du film
                            </a>
                            <form action="cart.php" method="post">
                                <input type="hidden" name="id" value="<?= (int) $film["id_film"] ?>">
                                <button class="bouton_panier" type="submit" name="ajouter"> Ajouter au panier </button>
                            </form>
                        </div>
                    </article>

                <?php endforeach; ?>
                <!-- ----------------------------------------- -->
            </div>
        </section>

        <!-- =================================
        2. Recherche de films ou réalisateurs
        ===================================== -->
        <section class="section_page section_recherche">
            <form class="formulaire_recherche" action="search.php" method="get" role="search">  <!-- À l'exécution le formulaire envoie sur search.php -->
                <label for="recherche_film"> Rechercher un film ou un réalisateur </label>
                <div class="champ_recherche">
                    <input
                         id="recherche_film"
                         name="recherche"
                         type="search"
                         placeholder="Titre ou réalisateur..."
                         required
                    >
                    <button type="submit" class="bouton_recherche">
                        Rechercher
                    </button>
                </div>
            </form>
        </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>