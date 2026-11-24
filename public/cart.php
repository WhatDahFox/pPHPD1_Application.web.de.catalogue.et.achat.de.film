<?php

    // Démarrage de la session PHP
    session_start();

    // Vérification de la connexion
    if (!isset($_SESSION["utilisateur"]["id_utilisateur"])) {
        header("Location: login.php");
        exit();
    }

    // Connexion PDO
    require_once __DIR__ . "/../config/database.php";

    // Récupération ou création du panier utilisateur
    try {
        $idUtilisateur = $_SESSION["utilisateur"]["id_utilisateur"];

        // Recherche du panier existant
        $sql = "SELECT id_panier FROM panier WHERE id_utilisateur = ?";
        $requete = $pdo->prepare($sql);
        $requete->execute([$idUtilisateur]);

        $panier = $requete->fetch(PDO::FETCH_ASSOC);

        if ($panier) {
            $idPanier = $panier["id_panier"];

        } else {
            // Création du panier pour un nouvel utilisateur
            $sql = "INSERT INTO panier (id_utilisateur) VALUES (?)";
            $requete = $pdo->prepare($sql);
            $requete->execute([$idUtilisateur]);

            $idPanier = $pdo->lastInsertId();
        }

    } catch (PDOException $e) {
        error_log($e->getMessage());
        http_response_code(500);
        exit("Impossible de récupérer le panier.");
    }

    // Ajout d'un film au panier
    if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["ajouter"])) {

        $idFilm = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

        if ($idFilm !== false && $idFilm !== null && $idFilm > 0) {

            try {
                // Vérification de l'existence du film
                $sql = "SELECT id_film FROM film WHERE id_film = ?";
                $requete = $pdo->prepare($sql);
                $requete->execute([$idFilm]);

                if ($requete->fetch()) {

                    // Ajout du film ou augmentation de sa quantité
                    $sql = "INSERT INTO contient (id_film, id_panier, quantite)
                            VALUES (?, ?, 1)
                            ON DUPLICATE KEY UPDATE quantite = LEAST(quantite + 1, 127)";

                    $requete = $pdo->prepare($sql);
                    $requete->execute([$idFilm, $idPanier]);
                }

            } catch (PDOException $e) {
                error_log($e->getMessage());
            }
        }

        // Redirection vers le panier
        header("Location: cart.php");
        exit();
    }

    // Suppression d'un film du panier
    if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["supprimer"])) {

        $idFilm = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

        if ($idFilm !== false && $idFilm !== null && $idFilm > 0) {

            try {
                // Suppression du film appartenant au panier utilisateur
                $sql = "DELETE FROM contient
                        WHERE id_film = ? AND id_panier = ?";

                $requete = $pdo->prepare($sql);
                $requete->execute([$idFilm, $idPanier]);

            } catch (PDOException $e) {
                error_log($e->getMessage());
            }
        }

        // Redirection vers le panier
        header("Location: cart.php");
        exit();
    }

    // Vidage intégral du panier
    if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["vider"])) {

        try {
            // Suppression de tous les films du panier utilisateur
            $sql = "DELETE FROM contient WHERE id_panier = ?";

            $requete = $pdo->prepare($sql);
            $requete->execute([$idPanier]);

        } catch (PDOException $e) {
            error_log($e->getMessage());
        }

        // Redirection vers le panier
        header("Location: cart.php");
        exit();
    }

    $erreurChargementPanier = false;

    // Récupération des films présents dans le panier
    try {
        $sql = "SELECT film.id_film, film.titre, film.affiche,
                       film.prix, contient.quantite
                FROM contient
                INNER JOIN film ON contient.id_film = film.id_film
                WHERE contient.id_panier = ?";

        $requete = $pdo->prepare($sql);
        $requete->execute([$idPanier]);

        $filmsPanier = $requete->fetchAll(PDO::FETCH_ASSOC);

    } catch (PDOException $e) {
        error_log($e->getMessage());
        $filmsPanier = [];
        $erreurChargementPanier = true;
    }

    // Calcul du nombre d'articles et du montant total
    $nombreArticles = 0;
    $totalPanier = 0;

    foreach ($filmsPanier as $film) {
        $quantite = (int) $film["quantite"];
        $prix = (float) $film["prix"];

        $nombreArticles += $quantite;
        $totalPanier += $prix * $quantite;
    }

    // Validation du panier et enregistrement de la commande
    $messageValidation = "";

    if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["valider"])) {

        if ($erreurChargementPanier) {
            $messageValidation = "Impossible de récupérer votre panier. Veuillez réessayer.";

        } elseif (!empty($filmsPanier)) {

            try {
                // Démarrage de la transaction
                $pdo->beginTransaction();

                // Création de la commande
                $sql = "INSERT INTO commande (date_commande, id_utilisateur)
                        VALUES (NOW(), ?)";

                $requete = $pdo->prepare($sql);
                $requete->execute([$idUtilisateur]);

                $idCommande = $pdo->lastInsertId();

                // Enregistrement des films achetés
                $sql = "INSERT INTO contenant
                        (id_film, id_commande, quantite, prix_achat)
                        VALUES (?, ?, ?, ?)";

                $requete = $pdo->prepare($sql);

                foreach ($filmsPanier as $film) {

                    $requete->execute([
                            $film["id_film"],
                            $idCommande,
                            $film["quantite"],
                            $film["prix"]
                    ]);
                }

                // Vidage du panier après l'achat
                $sql = "DELETE FROM contient WHERE id_panier = ?";

                $requete = $pdo->prepare($sql);
                $requete->execute([$idPanier]);

                // Confirmation de toutes les opérations SQL
                $pdo->commit();

                // Redirection après validation
                header("Location: cart.php?achat=ok");
                exit();

            } catch (PDOException $e) {

                // Annulation de l'ensemble de la transaction
                if ($pdo->inTransaction()) {
                    $pdo->rollBack();
                }

                error_log($e->getMessage());
                $messageValidation = "Une erreur est survenue lors de l'achat.";
            }

        } else {
            $messageValidation = "Impossible de valider un panier vide.";
        }
    }

    // Confirmation après redirection
    if (isset($_GET["achat"]) && $_GET["achat"] === "ok") {
        $messageValidation = "Votre achat a été enregistré avec succès.";
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
                <?php if ($erreurChargementPanier): ?>
                    <p> Impossible de charger votre panier. Veuillez réessayer ultérieurement. </p>
                <?php elseif (empty($filmsPanier)): ?>
                    <p> Votre panier est vide. </p>
                    <p> <a href="index.php"> Retour au catalogue </a> </p>
                <?php else: ?>
                    <?php foreach ($filmsPanier as $film): ?>
                        <article class="ligne_panier">
                            <img
                                    class="affiche_panier"
                                    src="<?= htmlspecialchars(
                                            !empty($film["affiche"]) ? $film["affiche"] : "images/affiche_indisponible.png",
                                            ENT_QUOTES,
                                            'UTF-8'
                                    ) ?>"
                                    alt="Affiche de <?= htmlspecialchars($film["titre"], ENT_QUOTES, 'UTF-8') ?>"
                            >
                            <div class="informations_panier">
                                <h3 class="titre_film">
                                    <?= htmlspecialchars($film["titre"], ENT_QUOTES, 'UTF-8') ?>
                                </h3>
                                <a href="movie.php?id=<?= (int) $film["id_film"] ?>"> Voir les détails du film </a>
                                <p>
                                    Prix unitaire :
                                    <?= number_format((float) $film["prix"], 2, ",", " ") ?> €
                                </p>
                                <label for="quantite_film_<?= (int) $film["id_film"] ?>"> Quantité : </label>
                                <input
                                        class="quantite_panier"
                                        id="quantite_film_<?= (int) $film["id_film"] ?>"
                                        type="number"
                                        value="<?= (int) $film["quantite"] ?>"
                                        min="1"
                                        disabled
                                >
                            </div>
                            <div class="actions_panier">
                                <p class="sous_total_panier">
                                    <?= number_format((float) $film["prix"] * (int) $film["quantite"], 2, ",", " ") ?> €
                                </p>
                                <form action="cart.php" method="post">
                                    <input type="hidden" name="id" value="<?= (int) $film["id_film"] ?>">
                                    <button class="bouton_supprimer" type="submit" name="supprimer"> Supprimer </button>
                                </form>
                            </div>
                        </article>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
            <?php if (!empty($filmsPanier)): ?>
                <form action="cart.php" method="post">
                    <button class="bouton_supprimer" type="submit" name="vider"> Vider le panier </button>
                </form>
            <?php endif; ?>
        </section>
                <!-- =================================
                2. Récapitulatif du panier
                ===================================== -->

                <section class="section_page section_total_panier">
                    <h2 class="titre_section"> Récapitulatif </h2>
                    <div class="recapitulatif_panier">
                        <p> <strong> Nombre d'articles : </strong> <?= $nombreArticles ?> </p>
                        <p class="total_panier">
                            <strong> Total : </strong>
                            <span> <?= number_format($totalPanier, 2, ",", " ") ?> € </span>
                        </p>
                        <form action="cart.php" method="post">
                            <button
                                    class="bouton_valider"
                                    type="submit"
                                    name="valider"
                                    <?= (empty($filmsPanier) || $erreurChargementPanier) ? "disabled" : "" ?>
                            >
                                Valider le panier
                            </button>
                            <?php if ($messageValidation !== ""): ?>
                                <p> <?= htmlspecialchars($messageValidation, ENT_QUOTES, 'UTF-8') ?> </p>
                            <?php endif; ?>
                        </form>
                    </div>
                </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>