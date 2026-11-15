<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Accueil | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/movie.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1>Fiche du film</h1>

        <!-- =================================
        1. Détails du film
        ===================================== -->

        <section class="section_page section_film">
            <h2 class="titre_section"> Détails du film </h2>
            <article class="details_film">

                <!-- Affiche du film -->
                <div class="conteneur_affiche">
                    <img
                            class="affiche_details"
                            src="./images/affiche_indisponible.png"
                            alt="Affiche du film"
                    >
                </div>
                <!-- -------------------- -->
                <!-- Informations du film -->
                <div class="informations_film">
                    <h3 class="titre_details_film">
                        Titre exemple
                    </h3>
                    <div class="donnees_film">
                        <p>
                            <strong> Année de sortie : </strong>
                            <span> 2026 </span>
                        </p>
                        <p>
                            <strong> Catégorie : </strong>
                            <span> Action </span>
                        </p>
                        <p>
                            <strong> Réalisateur : </strong>
                            <a class="lien_realisateur" href="/director.php">
                                Nom du réalisateur
                            </a>
                        </p>
                        <p>
                            <strong> Acteurs : </strong>
                            <span> Acteur 1, Acteur 2, Acteur 3 </span>
                        </p>
                    </div>
                    <!-- -------------------- -->
                    <!-- Synopsis -->
                    <div class="synopsis_film">
                        <h4> Synopsis </h4>
                        <p>
                            Résumé provisoire du film.
                            Cette description sera remplacée
                            par les informations enregistrées
                            dans la base de données.
                        </p>
                    </div>
                    <!-- -------------------- -->
                    <!-- Achat -->
                    <div class="achat_film">
                        <p class="prix_details_film"> 9,90 € </p>
                        <button class="bouton_panier"
                                type="button"
                                disabled>
                            Ajouter au panier
                        </button>
                    </div>
                    <!-- -------------------- -->

                </div>
            </article>
        </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>