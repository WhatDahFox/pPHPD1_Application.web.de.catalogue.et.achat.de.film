
<?php

session_start();

// Vérification de la connexion
if (!isset($_SESSION["utilisateur"]["id_utilisateur"])) {
    header("Location: login.php");
    exit();
}

// Création du jeton CSRF
if (empty($_SESSION["csrf_token"])) {
    $_SESSION["csrf_token"] = bin2hex(random_bytes(32));
}

$csrfToken = $_SESSION["csrf_token"];

// Connexion à la base de données
require_once __DIR__ . "/../config/database.php";

$idUtilisateur = (int) $_SESSION["utilisateur"]["id_utilisateur"];

// Récupération ou création du panier utilisateur
try {
    $requete = $pdo->prepare(
        "SELECT id_panier FROM panier WHERE id_utilisateur = ?"
    );
    $requete->execute([$idUtilisateur]);

    $panier = $requete->fetch(PDO::FETCH_ASSOC);

    if ($panier) {
        $idPanier = (int) $panier["id_panier"];
    } else {
        $requete = $pdo->prepare(
            "INSERT INTO panier (id_utilisateur) VALUES (?)"
        );
        $requete->execute([$idUtilisateur]);

        $idPanier = (int) $pdo->lastInsertId();
    }

} catch (PDOException $e) {
    error_log($e->getMessage());
    http_response_code(500);
    exit("Impossible de récupérer le panier.");
}

// Traitement des actions du panier
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    // Vérification du jeton CSRF
    $tokenRecu = $_POST["csrf_token"] ?? "";

    if (
        !is_string($tokenRecu) ||
        $tokenRecu === "" ||
        empty($_SESSION["csrf_token"]) ||
        !hash_equals($_SESSION["csrf_token"], $tokenRecu)
    ) {
        http_response_code(403);
        exit("Requête invalide.");
    }

    // Ajout d'un film au panier
    if (isset($_POST["ajouter"])) {

        $idFilm = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

        if ($idFilm !== false && $idFilm !== null && $idFilm > 0) {
            try {
                $requete = $pdo->prepare(
                    "SELECT id_film FROM film WHERE id_film = ?"
                );
                $requete->execute([$idFilm]);

                if ($requete->fetch()) {
                    $requete = $pdo->prepare(
                        "INSERT INTO contient (id_film, id_panier, quantite)
                         VALUES (?, ?, 1)
                         ON DUPLICATE KEY UPDATE
                         quantite = LEAST(quantite + 1, 127)"
                    );
                    $requete->execute([$idFilm, $idPanier]);
                }

            } catch (PDOException $e) {
                error_log($e->getMessage());
            }
        }

        header("Location: cart.php");
        exit();
    }

    // Suppression d'un film du panier
    if (isset($_POST["supprimer"])) {

        $idFilm = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

        if ($idFilm !== false && $idFilm !== null && $idFilm > 0) {
            try {
                $requete = $pdo->prepare(
                    "DELETE FROM contient
                     WHERE id_film = ? AND id_panier = ?"
                );
                $requete->execute([$idFilm, $idPanier]);

            } catch (PDOException $e) {
                error_log($e->getMessage());
            }
        }

        header("Location: cart.php");
        exit();
    }

    // Vidage complet du panier
    if (isset($_POST["vider"])) {
        try {
            $requete = $pdo->prepare(
                "DELETE FROM contient WHERE id_panier = ?"
            );
            $requete->execute([$idPanier]);

        } catch (PDOException $e) {
            error_log($e->getMessage());
        }

        header("Location: cart.php");
        exit();
    }

    // Validation de la commande
    if (isset($_POST["valider"])) {

        try {
            $pdo->beginTransaction();

            // Récupération des films et de leurs prix
            $requete = $pdo->prepare(
                "SELECT film.id_film, film.prix, contient.quantite
                 FROM contient
                 INNER JOIN film ON contient.id_film = film.id_film
                 WHERE contient.id_panier = ?
                 FOR UPDATE"
            );
            $requete->execute([$idPanier]);

            $filmsCommande = $requete->fetchAll(PDO::FETCH_ASSOC);

            if (empty($filmsCommande)) {
                throw new Exception("Le panier est vide.");
            }

            // Vérification des quantités et des prix
            foreach ($filmsCommande as $film) {
                $quantite = (int) $film["quantite"];
                $prix = (float) $film["prix"];

                if (
                    $quantite < 1 ||
                    $quantite > 127 ||
                    !is_numeric($film["prix"]) ||
                    !is_finite($prix) ||
                    $prix < 0
                ) {
                    throw new Exception("Informations du panier invalides.");
                }
            }

            // Création de la commande
            $requete = $pdo->prepare(
                "INSERT INTO commande (date_commande, id_utilisateur)
                 VALUES (NOW(), ?)"
            );
            $requete->execute([$idUtilisateur]);

            $idCommande = $pdo->lastInsertId();

            // Enregistrement des films achetés
            $requete = $pdo->prepare(
                "INSERT INTO contenant
                 (id_film, id_commande, quantite, prix_achat)
                 VALUES (?, ?, ?, ?)"
            );

            foreach ($filmsCommande as $film) {
                $requete->execute([
                    (int) $film["id_film"],
                    $idCommande,
                    (int) $film["quantite"],
                    $film["prix"]
                ]);
            }

            // Vidage du panier après l'achat
            $requete = $pdo->prepare(
                "DELETE FROM contient WHERE id_panier = ?"
            );
            $requete->execute([$idPanier]);

            // Confirmation de la transaction
            $pdo->commit();

            header("Location: cart.php?achat=ok");
            exit();

        } catch (Throwable $e) {

            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }

            error_log($e->getMessage());

            $messageValidation = "Une erreur est survenue lors de l'achat.";
        }
    }
}

// Récupération des films présents dans le panier
$filmsPanier = [];
$erreurChargementPanier = false;

try {
    $requete = $pdo->prepare(
        "SELECT film.id_film, film.titre, film.affiche,
                film.prix, contient.quantite
         FROM contient
         INNER JOIN film ON contient.id_film = film.id_film
         WHERE contient.id_panier = ?"
    );
    $requete->execute([$idPanier]);

    $filmsPanier = $requete->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    error_log($e->getMessage());
    $erreurChargementPanier = true;
}

// Calcul du nombre d'articles et du total
$nombreArticles = 0;
$totalPanier = 0;

foreach ($filmsPanier as $film) {
    $quantite = (int) $film["quantite"];
    $prix = (float) $film["prix"];

    $nombreArticles += $quantite;
    $totalPanier += $prix * $quantite;
}

// Messages de validation
$messageValidation = $messageValidation ?? "";

if (isset($_GET["achat"]) && $_GET["achat"] === "ok") {
    $messageValidation = "Votre achat a été enregistré avec succès.";
}

?>

<!doctype html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panier | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/cart.css">
</head>

<body class="conteneur">

<header class="bloc header">
    <!-- Insertion header en JS -->
</header>

<main>

    <h1>Mon panier</h1>

    <?php if ($messageValidation !== ""): ?>
        <p class="message_panier">
            <?= htmlspecialchars($messageValidation, ENT_QUOTES, "UTF-8") ?>
        </p>
    <?php endif; ?>

    <section class="section_page section_panier">

        <h2 class="titre_section">Films sélectionnés</h2>

        <div class="liste_panier">

            <?php if ($erreurChargementPanier): ?>

                <p>Impossible de charger votre panier. Veuillez réessayer ultérieurement.</p>

            <?php elseif (empty($filmsPanier)): ?>

                <p>Votre panier est vide.</p>
                <p><a href="index.php">Retour au catalogue</a></p>

            <?php else: ?>

                <?php foreach ($filmsPanier as $film): ?>

                    <article class="ligne_panier">

                        <img
                            class="affiche_panier"
                            src="<?= htmlspecialchars(
                                !empty($film["affiche"])
                                    ? $film["affiche"]
                                    : "./images/affiche_indisponible.png",
                                ENT_QUOTES,
                                "UTF-8"
                            ) ?>"
                            alt="Affiche de <?= htmlspecialchars(
                                $film["titre"],
                                ENT_QUOTES,
                                "UTF-8"
                            ) ?>"
                        >

                        <div class="informations_panier">

                            <h3 class="titre_film">
                                <?= htmlspecialchars(
                                    $film["titre"],
                                    ENT_QUOTES,
                                    "UTF-8"
                                ) ?>
                            </h3>

                            <a href="movie.php?id=<?= (int) $film["id_film"] ?>">
                                Voir les détails du film
                            </a>

                            <p>
                                Prix unitaire :
                                <?= number_format(
                                    (float) $film["prix"],
                                    2,
                                    ",",
                                    " "
                                ) ?> €
                            </p>

                            <label for="quantite_film_<?= (int) $film["id_film"] ?>">
                                Quantité :
                            </label>

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
                                <?= number_format(
                                    (float) $film["prix"] * (int) $film["quantite"],
                                    2,
                                    ",",
                                    " "
                                ) ?> €
                            </p>

                            <form action="cart.php" method="post">

                                <input
                                    type="hidden"
                                    name="csrf_token"
                                    value="<?= htmlspecialchars(
                                        $csrfToken,
                                        ENT_QUOTES,
                                        "UTF-8"
                                    ) ?>"
                                >

                                <input
                                    type="hidden"
                                    name="id"
                                    value="<?= (int) $film["id_film"] ?>"
                                >

                                <button
                                    class="bouton_supprimer"
                                    type="submit"
                                    name="supprimer"
                                >
                                    Supprimer
                                </button>

                            </form>

                        </div>

                    </article>

                <?php endforeach; ?>

            <?php endif; ?>

        </div>

        <?php if (!empty($filmsPanier)): ?>

            <form action="cart.php" method="post">

                <input
                    type="hidden"
                    name="csrf_token"
                    value="<?= htmlspecialchars(
                        $csrfToken,
                        ENT_QUOTES,
                        "UTF-8"
                    ) ?>"
                >

                <button class="bouton_supprimer" type="submit" name="vider">
                    Vider le panier
                </button>

            </form>

        <?php endif; ?>

    </section>

    <section class="section_page section_total_panier">

        <h2 class="titre_section">Récapitulatif</h2>

        <div class="recapitulatif_panier">

            <p>
                <strong>Nombre d'articles :</strong>
                <?= $nombreArticles ?>
            </p>

            <p class="total_panier">
                <strong>Total :</strong>
                <span>
                    <?= number_format($totalPanier, 2, ",", " ") ?> €
                </span>
            </p>

            <form action="cart.php" method="post">

                <input
                    type="hidden"
                    name="csrf_token"
                    value="<?= htmlspecialchars(
                        $csrfToken,
                        ENT_QUOTES,
                        "UTF-8"
                    ) ?>"
                >

                <button
                    class="bouton_valider"
                    type="submit"
                    name="valider"
                    <?= (empty($filmsPanier) || $erreurChargementPanier)
                        ? "disabled"
                        : "" ?>
                >
                    Valider le panier
                </button>

            </form>

        </div>

    </section>

    <p><a href="index.php">Retour au catalogue</a></p>

</main>

<footer class="bloc footer">
    <!-- Insertion footer en JS -->
</footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
