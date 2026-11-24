<?php

    // Démarrage de la session PHP
    session_start();

    // Vérification de la connexion
    if (!isset($_SESSION["utilisateur"]["id_utilisateur"])) {
        header("Location: login.php");
        exit();
    }

?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Panier | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/cart.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Mon panier </h1>

        <!-- =================================
        1. Liste des films du panier
        ===================================== -->

        <section class="section_page section_panier">
            <h2 class="titre_section"> Films sélectionnés </h2>
            <div class="liste_panier">
                <!-- film provisoire -->
                <article class="ligne_panier">
                    <img class="affiche_panier" src="images/affiche_indisponible.png" alt="Affiche du film">
                    <div class="informations_panier">
                        <h3 class="titre_film">Film exemple 1</h3>
                        <a href="movie.php">Voir les détails du film</a>
                        <p> Prix unitaire : 10 € </p>
                        <label for="quantite_film_1">Quantité :</label>
                        <input class="quantite_panier" id="quantite_film_1" type="number" value="2" min="1" disabled>
                    </div>
                    <div class="actions_panier">
                        <p class="sous_total_panier">20 €</p>
                        <button class="bouton_supprimer" type="button" disabled>Supprimer</button>
                    </div>
                </article>
                <!-- ---------------- -->
                <!-- film provisoire -->
                <article class="ligne_panier">
                    <img class="affiche_panier" src="images/affiche_indisponible.png" alt="Affiche du film">
                    <div class="informations_panier">
                        <h3 class="titre_film">Film exemple 1</h3>
                        <a href="movie.php">Voir les détails du film</a>
                        <p>Prix unitaire : 20 €</p>
                        <label for="quantite_film_2">Quantité :</label>
                        <input class="quantite_panier" id="quantite_film_2" type="number" value="2" min="1" disabled>
                    </div>
                    <div class="actions_panier">
                        <p class="sous_total_panier">40 €</p>
                        <button class="bouton_supprimer" type="button" disabled>Supprimer</button>
                    </div>
                </article>
                <!-- ---------------- -->
                <!-- film provisoire -->
                <article class="ligne_panier">
                    <img class="affiche_panier" src="images/affiche_indisponible.png" alt="Affiche du film">
                    <div class="informations_panier">
                        <h3 class="titre_film">Film exemple 1</h3>
                        <a href="movie.php">Voir les détails du film</a>
                        <p>Prix unitaire : 30 €</p>
                        <label for="quantite_film_3">Quantité :</label>
                        <input class="quantite_panier" id="quantite_film_3" type="number" value="2" min="1" disabled>
                    </div>
                    <div class="actions_panier">
                        <p class="sous_total_panier">60 €</p>
                        <button class="bouton_supprimer" type="button" disabled>Supprimer</button>
                    </div>
                </article>
                <!-- ---------------- -->
            </div>
        </section>
                <!-- =================================
                2. Récapitulatif du panier
                ===================================== -->

                <section class="section_page section_total_panier">
                    <h2 class="titre_section"> Récapitulatif </h2>
                    <div class="recapitulatif_panier">
                        <p> <strong> Nombre d'articles : </strong> 6 </p>
                        <p class="total_panier">
                            <strong> Total : </strong>
                            <span> 120 € </span>
                        </p>
                        <button class="bouton_valider" type="button" disabled> Valider le panier </button>
                    </div>
                </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>