<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Réalisateur | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/director.css">
</head>

<body class="conteneur">

<header class="bloc header">
    <!-- Insertion header en JS -->
</header>

<main>
    <h1> Fiche du réalisateur </h1>

    <!-- =================================
    1. Présentation du réalisateur
    ===================================== -->

    <section class="section_page section_realisateur">
        <h2 class="titre_section"> Présentation </h2>
        <article class="details_realisateur">
            <div class="conteneur_portrait">
                <img class="portrait_realisateur" src="images/portrait_indisponible.png" alt="Portrait de realisateur">
            </div>
            <div class="informations_realisateur">
                <h3 class="nom_realisateur"> Nom du réalisateur </h3>
                <div class="donnees_realisateur">
                    <p><strong> Nationalité : </strong> Exemple </p>
                    <p><strong> Date de naissance : </strong> Exemple </p>
                </div>
                <div class="biographie_realisateur">
                    <h4> Biographie </h4>
                    <p>
                        Biographie provisoire du réalisateur.
                        Cette présentation sera remplacée par les
                        informations récupérées depuis MySQL.
                    </p>
                </div>
            </div>
        </article>
    </section>

    <!-- =================================
    2. Les films du réalisateur
    ===================================== -->

    <section class="section_page section_films_realisateur">
        <h2 class="titre_section"> Filmographie </h2>
        <div class="liste_films">
            <!-- Carte provisoire -->
            <article class="carte_film">
                <img class="affiche_film" src="images/affiche_indisponible.png" alt="Affiche du film">
                <div class="contenu_carte_film">
                    <h3 class="titre_film">Titre exemple</h3>
                    <p class="description_film">
                        Résumé provisoire du film.
                        Cette description sera remplacée
                        par les données de MySQL.
                    </p>
                    <p class="prix_film">9,90 €</p>
                    <a class="lien_details_film" href="movie.php">Voir les détails du film</a>
                    <button class="bouton_panier" type="button" disabled>Ajouter au panier</button>
                </div>
            </article>
            <!-- Carte provisoire -->
            <article class="carte_film">
                <img class="affiche_film" src="images/affiche_indisponible.png" alt="Affiche du film">
                <div class="contenu_carte_film">
                    <h3 class="titre_film">Titre exemple</h3>
                    <p class="description_film">
                        Résumé provisoire du film.
                        Cette description sera remplacée
                        par les données de MySQL.
                    </p>
                    <p class="prix_film">9,90 €</p>
                    <a class="lien_details_film" href="movie.php">Voir les détails du film</a>
                    <button class="bouton_panier" type="button" disabled>Ajouter au panier</button>
                </div>
            </article>
            <!-- Carte provisoire -->
            <article class="carte_film">
                <img class="affiche_film" src="images/affiche_indisponible.png" alt="Affiche du film">
                <div class="contenu_carte_film">
                    <h3 class="titre_film">Titre exemple</h3>
                    <p class="description_film">
                        Résumé provisoire du film.
                        Cette description sera remplacée
                        par les données de MySQL.
                    </p>
                    <p class="prix_film">9,90 €</p>
                    <a class="lien_details_film" href="movie.php">Voir les détails du film</a>
                    <button class="bouton_panier" type="button" disabled>Ajouter au panier</button>
                </div>
            </article>
            <!-- Carte provisoire -->
            <article class="carte_film">
                <img class="affiche_film" src="images/affiche_indisponible.png" alt="Affiche du film">
                <div class="contenu_carte_film">
                    <h3 class="titre_film">Titre exemple</h3>
                    <p class="description_film">
                        Résumé provisoire du film.
                        Cette description sera remplacée
                        par les données de MySQL.
                    </p>
                    <p class="prix_film">9,90 €</p>
                    <a class="lien_details_film" href="movie.php">Voir les détails du film</a>
                    <button class="bouton_panier" type="button" disabled>Ajouter au panier</button>
                </div>
            </article>
            <!-- Carte provisoire -->
            <article class="carte_film">
                <img class="affiche_film" src="images/affiche_indisponible.png" alt="Affiche du film">
                <div class="contenu_carte_film">
                    <h3 class="titre_film">Titre exemple</h3>
                    <p class="description_film">
                        Résumé provisoire du film.
                        Cette description sera remplacée
                        par les données de MySQL.
                    </p>
                    <p class="prix_film">9,90 €</p>
                    <a class="lien_details_film" href="movie.php">Voir les détails du film</a>
                    <button class="bouton_panier" type="button" disabled>Ajouter au panier</button>
                </div>
            </article>
            <!-- ---------------- -->
        </div>
    </section>
</main>

<footer class="bloc footer">
    <!-- Insertion footer en JS -->
</footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>