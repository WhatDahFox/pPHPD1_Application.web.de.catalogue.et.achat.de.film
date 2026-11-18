<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Recherche | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/search.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Recherche de films </h1>

        <!-- =================================
        1. Formulaire de recherche
        ===================================== -->

        <section class="section_page section_recherche">
            <form class="formulaire_recherche" action="/search.php" method="get" role="search">
                <label for="recherche_film"> Rechercher un film ou un réalisateur </label>
                <div class="champ_recherche">
                    <input
                        id="recherche_film"
                        name="recherche"
                        type="search"
                        placeholder="Titre ou réalisateur..."
                        required
                    >
                    <button class="bouton_recherche" type="submit"> Rechercher </button>
                </div>
            </form>
        </section>

        <!-- =================================
        2. Résultats de la recherche
        ===================================== -->

        <section class="section_page section_resultats">
            <h2 class="titre_section"> Résultats de la recherche </h2>
            <div class="liste_films">
                <!-- Carte de film provisoire pour l'exemple -->
                <article class="carte_film">
                    <img class="affiche_film" src="images/affiche_indisponible.png" alt="affiche du film">
                    <div class="contenu_carte_film">
                        <h3 class="titre_film"> Titre exemple </h3>
                        <p class="description_film">
                            Résumé du film affiché sur trois lignes
                            maximum pour conserver une carte homogène.
                        </p>
                        <p class="prix_film"> 9,90 € </p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- ----------------------------------------- -->
                <!-- Carte de film provisoire pour l'exemple -->
                <article class="carte_film">
                    <img class="affiche_film" src="images/affiche_indisponible.png" alt="affiche du film">
                    <div class="contenu_carte_film">
                        <h3 class="titre_film"> Titre exemple </h3>
                        <p class="description_film">
                            Résumé du film affiché sur trois lignes
                            maximum pour conserver une carte homogène.
                        </p>
                        <p class="prix_film"> 9,90 € </p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- ----------------------------------------- -->
                <!-- Carte de film provisoire pour l'exemple -->
                <article class="carte_film">
                    <img class="affiche_film" src="images/affiche_indisponible.png" alt="affiche du film">
                    <div class="contenu_carte_film">
                        <h3 class="titre_film"> Titre exemple </h3>
                        <p class="description_film">
                            Résumé du film affiché sur trois lignes
                            maximum pour conserver une carte homogène.
                        </p>
                        <p class="prix_film"> 9,90 € </p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- ----------------------------------------- -->
                <!-- Carte de film provisoire pour l'exemple -->
                <article class="carte_film">
                    <img class="affiche_film" src="images/affiche_indisponible.png" alt="affiche du film">
                    <div class="contenu_carte_film">
                        <h3 class="titre_film"> Titre exemple </h3>
                        <p class="description_film">
                            Résumé du film affiché sur trois lignes
                            maximum pour conserver une carte homogène.
                        </p>
                        <p class="prix_film"> 9,90 € </p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- ----------------------------------------- -->
                <!-- Carte de film provisoire pour l'exemple -->
                <article class="carte_film">
                    <img class="affiche_film" src="images/affiche_indisponible.png" alt="affiche du film">
                    <div class="contenu_carte_film">
                        <h3 class="titre_film"> Titre exemple </h3>
                        <p class="description_film">
                            Résumé du film affiché sur trois lignes
                            maximum pour conserver une carte homogène.
                        </p>
                        <p class="prix_film"> 9,90 € </p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- ----------------------------------------- -->
            </div>
        </section>

    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>