
<?php

require_once __DIR__ . "/../config/database.php";

// Récupération du jeton CSRF pour les formulaires
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (empty($_SESSION["csrf_token"])) {
    $_SESSION["csrf_token"] = bin2hex(random_bytes(32));
}

$csrfToken = $_SESSION["csrf_token"];

// Récupération de la catégorie sélectionnée
$categorie = $_GET["categorie"] ?? "";

if (!is_string($categorie)) {
    $categorie = "";
}

$categorie = trim($categorie);

// Limitation de la longueur de la catégorie
$categorie = mb_substr($categorie, 0, 100, "UTF-8");
$categories = [];
$resultats = [];

// Récupération de toutes les catégories
$requeteCategories = $pdo->query(
    "SELECT id_categorie, nom
     FROM categorie
     ORDER BY nom"
);

$categories = $requeteCategories->fetchAll(PDO::FETCH_ASSOC);

// Récupération des films de la catégorie sélectionnée
if ($categorie !== "") {

    $requeteFilms = $pdo->prepare(
        "SELECT
            f.id_film,
            f.titre,
            f.affiche,
            f.annee_de_sortie,
            f.prix,
            f.resume,
            CONCAT(r.prenom, ' ', r.nom) AS realisateur,
            c.nom AS categorie
         FROM film f
         INNER JOIN fait_partie_de fp
            ON f.id_film = fp.id_film
         INNER JOIN categorie c
            ON fp.id_categorie = c.id_categorie
         LEFT JOIN realisateur r
            ON f.id_realisateur = r.id_realisateur
         WHERE c.nom = ?
         ORDER BY f.annee_de_sortie DESC, f.id_film DESC"
    );

    $requeteFilms->execute([$categorie]);
    $resultats = $requeteFilms->fetchAll(PDO::FETCH_ASSOC);
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

<header class="bloc header">
    <!-- Insertion header en JS -->
</header>

<main>

    <h1>Nos catégories de films</h1>

    <nav class="navigation_categories">

        <?php foreach ($categories as $nomCategorie): ?>

            <a
                class="lien_categorie"
                href="category.php?categorie=<?= urlencode($nomCategorie["nom"]) ?>"
            >
                <?= htmlspecialchars(
                    $nomCategorie["nom"],
                    ENT_QUOTES,
                    "UTF-8"
                ) ?>
            </a>

        <?php endforeach; ?>

    </nav>

    <section class="section_page section_categorie">

        <?php if ($categorie === ""): ?>

            <h2 class="titre_section">Choisissez une catégorie</h2>

            <p>
                Choisissez une catégorie pour découvrir les films.
            </p>

        <?php elseif (empty($resultats)): ?>

            <h2 class="titre_section">Catégorie introuvable</h2>

            <p>
                Aucun film trouvé dans cette catégorie.
            </p>

        <?php else: ?>

            <h2 class="titre_section">
                Films de la catégorie :
                <?= htmlspecialchars($categorie, ENT_QUOTES, "UTF-8") ?>
            </h2>

            <div class="liste_films">

                <?php foreach ($resultats as $film): ?>

                    <?php
                    $affiche = !empty($film["affiche"])
                        ? $film["affiche"]
                        : "./images/affiche_indisponible.png";

                    $realisateur = $film["realisateur"]
                        ?? "Réalisateur inconnu";
                    ?>

                    <article class="carte_film">

                        <img
                            class="affiche_film"
                            src="<?= htmlspecialchars(
                                $affiche,
                                ENT_QUOTES,
                                "UTF-8"
                            ) ?>"
                            onerror="this.onerror=null; this.src='images/affiche_indisponible.png';"
                            alt="Affiche de <?= htmlspecialchars(
                                $film["titre"],
                                ENT_QUOTES,
                                "UTF-8"
                            ) ?>"
                        >

                        <div class="contenu_carte_film">

                            <h3 class="titre_film">
                                <?= htmlspecialchars(
                                    $film["titre"],
                                    ENT_QUOTES,
                                    "UTF-8"
                                ) ?>
                            </h3>

                            <p class="description_film">
                                <?= htmlspecialchars(
                                    (string) $film["annee_de_sortie"],
                                    ENT_QUOTES,
                                    "UTF-8"
                                ) ?>
                                -
                                <?= htmlspecialchars(
                                    $realisateur,
                                    ENT_QUOTES,
                                    "UTF-8"
                                ) ?>
                            </p>

                            <p>
                                <?= htmlspecialchars(
                                    (string) $film["resume"],
                                    ENT_QUOTES,
                                    "UTF-8"
                                ) ?>
                            </p>

                            <p class="prix_film">
                                <?= number_format(
                                    (float) $film["prix"],
                                    2,
                                    ",",
                                    " "
                                ) ?> €
                            </p>

                            <a
                                class="lien_details_film"
                                href="movie.php?id=<?= (int) $film["id_film"] ?>"
                            >
                                Voir les détails du film
                            </a>

                            <form method="POST" action="cart.php">

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
                                    class="bouton_panier"
                                    type="submit"
                                    name="ajouter"
                                >
                                    Ajouter au panier
                                </button>

                            </form>

                        </div>

                    </article>

                <?php endforeach; ?>

            </div>

        <?php endif; ?>

    </section>

    <p>
        <a href="index.php">Retour à l'accueil</a>
    </p>

</main>

<footer class="bloc footer">
    <!-- Insertion footer en JS -->
</footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
