
<?php
session_start();

require_once __DIR__ . '/../includes/films.php';

// Vérification de la connexion
if (!isset($_SESSION["utilisateur"])) {
    header("Location: login.php");
    exit();
}

// Initialisation du panier
if (!isset($_SESSION["panier"])) {
    $_SESSION["panier"] = [];
}

// Gestion des actions du panier
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $id = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

    // Ajouter un film
    if (isset($_POST["ajouter"]) && $id !== false && $id !== null && isset($films[$id])) {
        $_SESSION["panier"][$id] =
            ($_SESSION["panier"][$id] ?? 0) + 1;
    }

    // Supprimer un film
    if (isset($_POST["supprimer"]) && $id !== false && $id !== null) {
        unset($_SESSION["panier"][$id]);
    }

    header("Location: cart.php");
    exit();
}

// Calcul du total et du nombre d'articles
$total = 0;
$nombreArticles = 0;

foreach ($_SESSION["panier"] as $id => $quantite) {
    if (isset($films[$id])) {
        $total += $films[$id]["prix"] * $quantite;
        $nombreArticles += $quantite;
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

    <section class="section_page section_panier">
        <h2 class="titre_section">Films sélectionnés</h2>

        <div class="liste_panier">

            <?php if (empty($_SESSION["panier"])): ?>
                <p>Votre panier est vide.</p>

            <?php else: ?>

                <?php foreach ($_SESSION["panier"] as $id => $quantite): ?>
                    <?php if (isset($films[$id])):
                        $film = $films[$id];
                        $sousTotal = $film["prix"] * $quantite;
                    ?>

                        <article class="ligne_panier">

                            <img class="affiche_panier"
                                 src="images/affiche_indisponible.png"
                                 alt="Affiche indisponible">

                            <div class="informations_panier">
                                <h3 class="titre_film">
                                    <?= htmlspecialchars($film["titre"]) ?>
                                </h3>

                                <a href="movie.php?id=<?= $id ?>">
                                    Voir les détails du film
                                </a>

                                <p>
                                    Prix unitaire :
                                    <?= number_format($film["prix"], 2, ",", " ") ?> €
                                </p>

                                <p>Quantité : <?= $quantite ?></p>
                            </div>

                            <div class="actions_panier">
                                <p class="sous_total_panier">
                                    <?= number_format($sousTotal, 2, ",", " ") ?> €
                                </p>

                                <form method="POST" action="cart.php">
                                    <input type="hidden" name="id" value="<?= $id ?>">
                                    <button class="bouton_supprimer"
                                            type="submit"
                                            name="supprimer">
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
                <span><?= number_format($total, 2, ",", " ") ?> €</span>
            </p>
        </div>
    </section>

    <p><a href="index.php">Retour au catalogue</a></p>

</main>

<footer class="bloc footer"></footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
