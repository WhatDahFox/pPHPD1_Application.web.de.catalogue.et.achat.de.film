
<?php
require_once __DIR__ . '/../includes/films.php';

$categorie = trim($_GET['categorie'] ?? '');
$resultats = [];
$categories = [];

foreach ($films as $id => $film) {
    $categories[$film['categorie']] = true;

    if (
        $categorie !== '' &&
        strcasecmp($film['categorie'], $categorie) === 0
    ) {
        $resultats[$id] = $film;
    }
}
?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catégories | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/category.css">
</head>

<body class="conteneur">

    <header class="bloc header"></header>

    <main>
        <h1>Nos catégories de films</h1>

        <nav class="navigation_categories">
            <?php foreach (array_keys($categories) as $nomCategorie): ?>
                <a class="lien_categorie"
                   href="category.php?categorie=<?= urlencode($nomCategorie) ?>">
                    <?= htmlspecialchars($nomCategorie) ?>
                </a>
            <?php endforeach; ?>
        </nav>

        <section class="section_page section_categorie">

            <?php if ($categorie === ''): ?>

                <h2 class="titre_section">Choisissez une catégorie</h2>
                <p>Choisissez une catégorie pour découvrir les films.</p>

            <?php elseif (empty($resultats)): ?>

                <h2 class="titre_section">Catégorie introuvable</h2>
                <p>Aucun film trouvé dans cette catégorie.</p>

            <?php else: ?>

                <h2 class="titre_section">
                    Films de la catégorie :
                    <?= htmlspecialchars($categorie) ?>
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
