<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Catégories | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/category.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Nos catégories de films </h1>

        <!-- =================================
        1. Navigation entre les catégories
        ===================================== -->

        <nav class="navigation_categories">
            <a class="lien_categorie" href="category.php?categorie=action"> Action </a>
            <a class="lien_categorie" href="category.php?categorie=comedie"> Comédie </a>
            <a class="lien_categorie" href="category.php?categorie=drame"> Drame </a>
            <a class="lien_categorie" href="category.php?categorie=horreur"> Horreur </a>
            <a class="lien_categorie" href="category.php?categorie=thriller"> Thriller </a>
        </nav>

        <!-- =================================
        2. Films de la catégorie
        ===================================== -->

        <section class="section_page section_categorie">
            <h2 class="titre_section"> Films de la catégorie </h2>
            <div class="liste_films">
                <!-- Carte provisoire -->
                <article class="carte_film">
                    <img
                            class="affiche_film"
                            src="images/affiche_indisponible.png"
                            alt="Affiche du film"
                    >
                    <div class="contenu_carte_film">
                        <h3 class="titre_film">Titre exemple</h3>
                        <p class="description_film">
                            Résumé provisoire du film.
                            Cette description sera remplacée
                            par les données de MySQL.
                        </p>
                        <p class="prix_film">9,90 €</p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- Carte provisoire -->
                <article class="carte_film">
                    <img
                            class="affiche_film"
                            src="images/affiche_indisponible.png"
                            alt="Affiche du film"
                    >
                    <div class="contenu_carte_film">
                        <h3 class="titre_film">Titre exemple</h3>
                        <p class="description_film">
                            Résumé provisoire du film.
                            Cette description sera remplacée
                            par les données de MySQL.
                        </p>
                        <p class="prix_film">9,90 €</p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- Carte provisoire -->
                <article class="carte_film">
                    <img
                            class="affiche_film"
                            src="images/affiche_indisponible.png"
                            alt="Affiche du film"
                    >
                    <div class="contenu_carte_film">
                        <h3 class="titre_film">Titre exemple</h3>
                        <p class="description_film">
                            Résumé provisoire du film.
                            Cette description sera remplacée
                            par les données de MySQL.
                        </p>
                        <p class="prix_film">9,90 €</p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- Carte provisoire -->
                <article class="carte_film">
                    <img
                            class="affiche_film"
                            src="images/affiche_indisponible.png"
                            alt="Affiche du film"
                    >
                    <div class="contenu_carte_film">
                        <h3 class="titre_film">Titre exemple</h3>
                        <p class="description_film">
                            Résumé provisoire du film.
                            Cette description sera remplacée
                            par les données de MySQL.
                        </p>
                        <p class="prix_film">9,90 €</p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- Carte provisoire -->
                <article class="carte_film">
                    <img
                            class="affiche_film"
                            src="images/affiche_indisponible.png"
                            alt="Affiche du film"
                    >
                    <div class="contenu_carte_film">
                        <h3 class="titre_film">Titre exemple</h3>
                        <p class="description_film">
                            Résumé provisoire du film.
                            Cette description sera remplacée
                            par les données de MySQL.
                        </p>
                        <p class="prix_film">9,90 €</p>
                        <a class="lien_details_film" href="movie.php">
                            Voir les détails du film
                        </a>
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>
                <!-- ----------------- -->
            </div>
        </section>

    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>