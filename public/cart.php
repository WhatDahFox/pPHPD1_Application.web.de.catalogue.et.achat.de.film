
<?php
session_start();

require_once __DIR__ . '/../config/database.php';

// Vérification de la connexion
if (!isset($_SESSION["utilisateur"])) {
    header("Location: login.php");
    exit();
}

// Initialisation du panier
if (!isset($_SESSION["panier"]) || !is_array($_SESSION["panier"])) {
    $_SESSION["panier"] = [];
}

// Gestion des actions
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    // Validation de la commande
    if (isset($_POST["valider_commande"])) {

        if (empty($_SESSION["panier"])) {
            $_SESSION["message_panier"] = "Votre panier est vide.";
            header("Location: cart.php");
            exit();
        }

        try {
            // Récupération des films et de leurs prix actuels
            $ids = array_keys($_SESSION["panier"]);
            $placeholders = implode(",", array_fill(0, count($ids), "?"));

            $requete = $pdo->prepare(
                "SELECT id_film, prix
                 FROM film
                 WHERE id_film IN ($placeholders)"
            );

            $requete->execute($ids);
            $films = $requete->fetchAll(PDO::FETCH_ASSOC);

            if (count($films) !== count($ids)) {
                throw new Exception("Un film du panier n'existe plus.");
            }

            // Début de la transaction
            $pdo->beginTransaction();

            // Création de la commande
            $requeteCommande = $pdo->prepare(
                "INSERT INTO commande (date_commande, id_utilisateur)
                 VALUES (NOW(), ?)"
            );

	$requeteCommande->execute([
   	 $_SESSION["utilisateur"]["id_utilisateur"]
		
		]);
           
            $idCommande = $pdo->lastInsertId();

            // Préparation de l'enregistrement des films achetés
            $requeteContenant = $pdo->prepare(
                "INSERT INTO contenant
                 (id_film, id_commande, quantite, prix_achat)
                 VALUES (?, ?, ?, ?)"
            );

            foreach ($films as $film) {

                $idFilm = (int) $film["id_film"];
                $quantite = (int) ($_SESSION["panier"][$idFilm] ?? 0);
                $prix = (float) $film["prix"];

                if ($quantite < 1 || $quantite > 127 || $prix < 0) {
                    throw new Exception("Les informations du panier sont invalides.");
                }

                $requeteContenant->execute([
                    $idFilm,
                    $idCommande,
                    $quantite,
                    $prix
                ]);
            }

            // Validation définitive
            $pdo->commit();

            // Vidage du panier
            $_SESSION["panier"] = [];

            $_SESSION["message_panier"] =
                "Votre commande a été enregistrée avec succès !";

        } catch (Throwable $e) {

            // Annulation si une erreur survient
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }

            error_log($e->getMessage());

            $_SESSION["message_panier"] =
                "Une erreur est survenue lors de la validation de votre commande.";
        }

        header("Location: cart.php");
        exit();
    }

    // Ajout ou suppression d'un film
    $id = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

    if ($id !== false && $id !== null && $id > 0) {

        // Ajouter un film
        if (isset($_POST["ajouter"])) {

            $requete = $pdo->prepare(
                "SELECT id_film FROM film WHERE id_film = ?"
            );

            $requete->execute([$id]);

            if ($requete->fetch()) {

                $quantiteActuelle = (int) ($_SESSION["panier"][$id] ?? 0);

                if ($quantiteActuelle < 127) {
                    $_SESSION["panier"][$id] = $quantiteActuelle + 1;
                }
            }
        }

        // Supprimer un film
        if (isset($_POST["supprimer"])) {
            unset($_SESSION["panier"][$id]);
        }
    }

    header("Location: cart.php");
    exit();
}

// Récupération des messages
$message = $_SESSION["message_panier"] ?? "";
unset($_SESSION["message_panier"]);

// Récupération des films du panier
$filmsPanier = [];
$total = 0;
$nombreArticles = 0;

if (!empty($_SESSION["panier"])) {

    $ids = array_keys($_SESSION["panier"]);
    $placeholders = implode(",", array_fill(0, count($ids), "?"));

    $requete = $pdo->prepare(
        "SELECT id_film, titre, affiche, prix
         FROM film
         WHERE id_film IN ($placeholders)"
    );

    $requete->execute($ids);

    while ($film = $requete->fetch(PDO::FETCH_ASSOC)) {
        $filmsPanier[$film["id_film"]] = $film;
    }

    foreach ($_SESSION["panier"] as $id => $quantite) {

        if (isset($filmsPanier[$id])) {

            $quantite = (int) $quantite;

            $total += (float) $filmsPanier[$id]["prix"] * $quantite;
            $nombreArticles += $quantite;
        }
    }
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

<header class="bloc header"></header>

<main>

    <h1>Mon panier</h1>

    <?php if (!empty($message)): ?>
        <p class="message_panier">
            <?= htmlspecialchars($message) ?>
        </p>
    <?php endif; ?>

    <section class="section_page section_panier">

        <h2 class="titre_section">Films sélectionnés</h2>

        <div class="liste_panier">

            <?php if (empty($filmsPanier)): ?>

                <p>Votre panier est vide.</p>

            <?php else: ?>

                <?php foreach ($_SESSION["panier"] as $id => $quantite): ?>

                    <?php if (isset($filmsPanier[$id])):

                        $film = $filmsPanier[$id];
                        $quantite = (int) $quantite;
                        $sousTotal = $film["prix"] * $quantite;

                        $affiche = !empty($film["affiche"])
                            ? $film["affiche"]
                            : "./images/affiche_indisponible.png";
                    ?>

                        <article class="ligne_panier">

                            <img
                                class="affiche_panier"
                                src="<?= htmlspecialchars($affiche) ?>"
                                alt="Affiche du film"
                            >

                            <div class="informations_panier">

                                <h3 class="titre_film">
                                    <?= htmlspecialchars($film["titre"]) ?>
                                </h3>

                                <a href="movie.php?id=<?= (int) $id ?>">
                                    Voir les détails du film
                                </a>

                                <p>
                                    Prix unitaire :
                                    <?= number_format($film["prix"], 2, ",", " ") ?> €
                                </p>

                                <p>
                                    Quantité : <?= $quantite ?>
                                </p>

                            </div>

                            <div class="actions_panier">

                                <p class="sous_total_panier">
                                    <?= number_format($sousTotal, 2, ",", " ") ?> €
                                </p>

                                <form method="POST" action="cart.php">

                                    <input
                                        type="hidden"
                                        name="id"
                                        value="<?= (int) $id ?>"
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

                    <?php endif; ?>

                <?php endforeach; ?>

            <?php endif; ?>

        </div>

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
                    <?= number_format($total, 2, ",", " ") ?> €
                </span>
            </p>

        </div>

        <?php if (!empty($filmsPanier)): ?>

            <form method="POST" action="cart.php">

                <button type="submit" name="valider_commande">
                    Valider ma commande
                </button>

            </form>

        <?php endif; ?>

    </section>

    <p><a href="index.php">Retour au catalogue</a></p>

</main>

<footer class="bloc footer"></footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
