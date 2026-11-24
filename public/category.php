<?php
require_once __DIR__ . '/../includes/films.php';

$categorie = trim ($_GET['categorie'] ?? '');
$resultats = [];
$categories = [];

foreach ($films as $id => $film){
$categories [$film['categorie']] = true;

if (
$categorie !== '' && 
strcasecmp($film['categorie'], $categorie)===0
){
    $resultats[$id]= $film;
}

}

?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Catégories | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

<header class="bloc header">
    <!-- Insertion header en JS -->
</header>

<main>
    <section class="section_page">
        <h1>Catégories de films </h1>

        <?php foreach (array_keys($categories) as $nomCategorie): ?>
         <p>
             <a href="category.php?categorie=<?= urlencode($nomCategorie) ?>">
                <?=  htmlspecialchars($nomCategorie) ?>
            </a>
        </p>

        <?php endforeach; ?>

        <?php if ($categorie === ''): ?>

            <p>Choisissez une categorie pour découvrir les films. </p>

            <?php elseif (empty($resultats)): ?>

                <p>Aucun film trouvé dans cette catégorie.</p>

            <?php else: ?>

                <h2>Films de la catégorie : 
                    <?= htmlspecialchars($categorie) ?>
                </h2>

                     <div class="liste_films">
                <?php foreach ($resultats as $id => $film): ?>
                    <article class="carte_film">
                        <img class="affiche_film"
                             src="images/affiche_indisponible.png"
                             alt="Affiche indisponible">

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
                               href="movie.php?id=<?= $id ?>">
                                Voir les détails du film
                            </a>
                        </div>
                    </article>
                <?php endforeach; ?>
            </div>

        <?php endif; ?>

        <p><a href="index.php">Retour à l'accueil</a></p>
    </section>
    </section>

</main>

<footer class="bloc footer">
    <!-- Insertion footer en JS -->
</footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>