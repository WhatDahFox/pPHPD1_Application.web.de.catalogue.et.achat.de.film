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
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <section class="section_page">

            <h1>Recherche de films</h1>

            <form class="formulaire_recherche" action="search.php" method="get" role="search">
                <label for="recherche_film">Rechercher un film ou un réalisateur</label>

                <div class="champ_recherche">
                    <input
                        id="recherche_film"
                        name="recherche"
                        type="search"
                        placeholder="Titre, réalisateur ou catégorie"
                        value="<?= htmlspecialchars($recherche) ?>"
                        required
                    >

                    <button type="submit" class="bouton_recherche">
                        Rechercher
                    </button>
                </div>
            </form>

            <?php if ($recherche === ''): ?>

                <p>Saisissez un mot pour rechercher dans le catalogue.</p>

            <?php elseif (empty($resultats)): ?>

                <p>
                    Aucun film trouvé pour :
                    <strong><?= htmlspecialchars($recherche) ?></strong>
                </p>

            <?php else: ?>

                <h2>
                    <?= count($resultats) ?> résultat(s) pour
                    « <?= htmlspecialchars($recherche) ?> »
                </h2>

                <div class="liste_films">

                    <?php foreach ($resultats as $id => $film): ?>

                        <article class="carte_film">

                            <img
                                class="affiche_film"
                                src="images/affiche_indisponible.png"
                                alt="Affiche indisponible"
                            >

                            <div class="contenu_carte_film">

                                <h3 class="titre_film">
                                    <?= htmlspecialchars($film['titre']) ?>
                                </h3>

                                <p class="description_film">
                                    <?= htmlspecialchars($film['categorie']) ?>
                                    <?= htmlspecialchars((string) $film['annee']) ?>
                                    <?= htmlspecialchars($film['realisateur']) ?>
                                </p>

                                <p class="prix_film">
                                    <?= number_format($film['prix'], 2, ',', ' ') ?> €
                                </p>

                                <a class="lien_details_film" href="movie.php?id=<?= $id ?>">
                                    Voir les détails du film
                                </a>

                                <form method="POST" action="cart.php">
                                    <input type="hidden" name="id" value="<?= $id ?>">

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

            <p><a href="index.php">Retour à l'accueil</a></p>

        </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>