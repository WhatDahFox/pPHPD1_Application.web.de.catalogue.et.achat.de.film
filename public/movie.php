
<?php
require_once __DIR__ . '/../includes/films.php';

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

if (!$id || !isset($films[$id])) {
    http_response_code(404);
    $film = null;
} else {
    $film = $films[$id];
}
?>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du film | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/movie.css">
</head>
<body class="conteneur">

<header class="bloc header"></header>

<main>
<?php if ($film === null): ?>
    <h1>Film introuvable</h1>
    <a href="index.php">Retour au catalogue</a>
<?php else: ?>
    <h1>Fiche du film</h1>

    <section class="section_page section_film">
        <h2 class="titre_section">Détails du film</h2>

        <article class="details_film">
            <div class="conteneur_affiche">
                <img class="affiche_details"
                     src="./images/affiche_indisponible.png"
                     alt="Affiche indisponible">
            </div>

            <div class="informations_film">
                <h3 class="titre_details_film">
                    <?= htmlspecialchars($film['titre']) ?>
                </h3>

                <div class="donnees_film">
                    <p><strong>Année de sortie :</strong>
                        <?= htmlspecialchars((string) $film['annee']) ?></p>
                    <p><strong>Catégorie :</strong>
                        <?= htmlspecialchars($film['categorie']) ?></p>
                    <p><strong>Réalisateur :</strong>
                        <?= htmlspecialchars($film['realisateur']) ?></p>
                </div>

                <div class="synopsis_film">
                    <h4>Synopsis</h4>
                    <p>Le résumé de ce film sera ajouté ultérieurement.</p>
                </div>

                <div class="achat_film">
                    <p class="prix_details_film">
                        <?= number_format($film['prix'], 2, ',', ' ') ?> €
                    </p>

                    <form method="POST" action="cart.php">
                        <input type="hidden" name="id" value="<?= $id ?>">
                        <button class="bouton_panier" type="submit" name="ajouter">
                            Ajouter au panier
                        </button>
                    </form>
                </div>
            </div>
        </article>
    </section>
<?php endif; ?>
</main>

<footer class="bloc footer"></footer>
<script type="module" src="./js/layout.js"></script>
</body>
</html>
