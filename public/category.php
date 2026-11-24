<?php
    //Connexion PDO
    require_once __DIR__ . "/../config/database.php";

    // Récupération de toutes les catégories
    $requeteCategories = $pdo->query(
            "SELECT id_categorie, nom
                    FROM categorie
                    ORDER BY nom");

    $categories = $requeteCategories->fetchAll(PDO::FETCH_ASSOC);

    // Récupération de la catégorie sélectionnée (action par défaut)
    $categorieSelectionnee = $_GET["categorie"] ?? "action";

    // Récupération des films de la catégorie
    $requete = $pdo->prepare(
            "SELECT id_film, titre, affiche, `resume`, prix
                    FROM film
                    WHERE id_film IN (
                            SELECT id_film
                            FROM fait_partie_de
                            WHERE id_categorie = (
                                SELECT id_categorie
                                FROM categorie
                                WHERE nom = :categorie
                                )
                            )
                    ORDER BY annee_de_sortie DESC, id_film DESC");

    $requete->execute(["categorie" => $categorieSelectionnee]);

    $films = $requete -> fetchAll(PDO::FETCH_ASSOC);
?>


<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Catégories | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/category.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Nos catégories de films </h1>

        <!-- =================================
        1. Navigation entre les catégories
        ===================================== -->

        <nav class="navigation_categories">
            <?php foreach ($categories as $categorie): ?>
                <a class="lien_categorie" href="category.php?categorie=<?= urlencode($categorie["nom"]) ?>">
                    <?= htmlspecialchars($categorie["nom"], ENT_QUOTES, 'UTF-8') ?>
                </a>
            <?php endforeach; ?>
        </nav>

        <!-- =================================
        2. Films de la catégorie
        ===================================== -->

        <section class="section_page section_categorie">
            <h2 class="titre_section"> Films de la catégorie <?php echo htmlspecialchars($categorieSelectionnee, ENT_QUOTES, 'UTF-8') ?> </h2>
            <div class="liste_films">
                <!-- Cartes de films générées dynamiquement -->
                <?php foreach ($films as $film) : ?>

                    <article class="carte_film">
                        <img
                            class="affiche_film"
                            src="<?= htmlspecialchars(
                                    !empty($film["affiche"]) ? $film["affiche"] : "images/affiche_indisponible.png",
                                    ENT_QUOTES,
                                    'UTF-8'
                            ) ?>"
                            onerror="this.onerror=null; this.src='images/affiche_indisponible.png';"
                            alt="affiche du film <?php echo htmlspecialchars($film["titre"], ENT_QUOTES, 'UTF-8') ?>"
                        >
                        <div class="contenu_carte_film">
                            <h3 class="titre_film"> <?php echo htmlspecialchars($film["titre"]) ?> </h3>
                            <p class="description_film"> <?php echo htmlspecialchars($film["resume"]) ?> </p>
                            <p class="prix_film"> <?php echo number_format((float) $film["prix"], 2, ",", " ") ?> € </p>
                            <a
                                    class="lien_details_film"
                                    href="movie.php?id=<?php echo $film["id_film"] ?>"
                            >
                                Voir les détails du film
                            </a>
                            <form action="cart.php" method="post">
                                <input type="hidden" name="id" value="<?= (int) $film["id_film"] ?>">
                                <button class="bouton_panier" type="submit" name="ajouter"> Ajouter au panier </button>
                            </form>
                        </div>
                    </article>

                <?php endforeach; ?>
                <!-- ----------------------------------------- -->
            </div>
        </section>

    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>