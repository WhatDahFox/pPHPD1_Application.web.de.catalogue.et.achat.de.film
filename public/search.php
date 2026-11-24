
<?php
require_once __DIR__ . '/../includes/films.php';

$recherche = trim($_GET['recherche'] ?? '');
$resultats = [];

if ($recherche !== '') {
    foreach ($films as $id => $film) {
        if (
            stripos($film['titre'], $recherche) !== false ||
            stripos($film['realisateur'], $recherche) !== false ||
            stripos($film['categorie'], $recherche) !== false
        ) {
            $resultats[$id] = $film;
        }
    }
}
?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/search.css">
</head>

<body class="conteneur">

<header class="bloc header"></header>

<main>
    <h1>Recherche de films</h1>

    <section class="section_page section_recherche">

        <form class="formulaire_recherche"
              action="search.php"
              method="get"
              role="search">

            <label for="recherche_film">
                Rechercher un film, un réalisateur ou une catégorie
            </label>

            <div class="champ_recherche">
                <input
                    id="recherche_film"
                    name="recherche"
                    type="search"
                    placeholder="Titre, réalisateur ou catégorie..."
                    value="<?= htmlspecialchars($recherche) ?>"
                    required
                >

                <button class="bouton_recherche" type="submit">
                    Rechercher
                </button>
            </div>
        </form>

    </section>

    <section class="section_page section_resultats">

        <?php if ($recherche === ''): ?>

            <h2 class="titre_section">Résultats de la recherche</h2>
            <p>Saisissez un mot pour rechercher dans le catalogue.</p>

        <?php elseif (empty($resultats)): ?>

            <h2 class="titre_section">Aucun résultat</h2>
            <p>
                Aucun film trouvé pour :
                <strong><?= htmlspecialchars($recherche) ?></strong>
            </p>

        <?php else: ?>

            <h2 class="titre_section">
                <?= count($resultats) ?> résultat(s) pour
                « <?= htmlspecialchars($recherche) ?> »
            </h2>

            <div class="liste_films">

                <?php foreach ($resultats as $id => $film): ?>

                    <article class="carte_film">

                        <img
                            class="affiche_film"
                            src="./images/affiche_indisponible.png"
                            alt="Affiche indisponible"
                        >

                        <div class="contenu_carte_film">

                            <h3 class="titre_film">
                                <?= htmlspecialchars($film['titre']) ?>
                            </h3>

                            <p class="description_film">
                                <?= htmlspecialchars($film['categorie']) ?>
                                -
                                <?= htmlspecialchars((string) $film['annee']) ?>
                                -
                                <?= htmlspecialchars($film['realisateur']) ?>
                            </p>

                            <p class="prix_film">
                                <?= number_format($film['prix'], 2, ',', ' ') ?> €
                            </p>

                            <a class="lien_details_film"
                               href="movie.php?id=<?= (int) $id ?>">
                                Voir les détails du film
                            </a>

                            <form method="POST" action="cart.php">
                                <input type="hidden" name="id" value="<?= (int) $id ?>">

                                <button class="bouton_panier"
                                        type="submit"
                                        name="ajouter">
                                    Ajouter au panier
                                </button>
                            </form>

                        </div>
                    </article>

                <?php endforeach; ?>

            </div>

        <?php endif; ?>

    </section>

    <p><a href="index.php">Retour à l'accueil</a></p>

</main>

<footer class="bloc footer"></footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
