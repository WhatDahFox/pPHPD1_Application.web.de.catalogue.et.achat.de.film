<?php

    // Connexion PDO
    require_once __DIR__ . "/../config/database.php";

    // Récupération de l'identifiant du film via l'URL
    $idFilm = $_GET["id"] ?? null;

    // Récupération des informations du film
    $requeteIdFilm = $pdo->prepare(
            "SELECT *
                    FROM film
                    WHERE id_film = :id_film");

    $requeteIdFilm->execute(["id_film" => $idFilm]);
    $ficheFilm = $requeteIdFilm->fetch(PDO::FETCH_ASSOC);

    // Récupération des catégories du film

    $requeteCategorie = $pdo->prepare(
            "SELECT categorie.nom
            FROM categorie
            INNER JOIN fait_partie_de
                ON categorie.id_categorie = fait_partie_de.id_categorie
            WHERE fait_partie_de.id_film = :id_film");

    $requeteCategorie->execute(["id_film" => $idFilm]);
    $categoriesFilm = $requeteCategorie -> fetchAll(PDO::FETCH_ASSOC);

    // Récupération des acteurs du film

    $requeteActeur = $pdo->prepare(
            "SELECT acteur.nom, acteur.prenom
                    FROM acteur
                    INNER JOIN ont_joue_dans
                        ON acteur.id_acteur = ont_joue_dans.id_acteur
                    WHERE ont_joue_dans.id_film = :id_film");

    $requeteActeur->execute(["id_film" => $idFilm]);
    $acteursFilm = $requeteActeur->fetchAll(PDO::FETCH_ASSOC);

    //Récupération du réalisateur du film

    $requeteRealisateur = $pdo->prepare(
                    "SELECT realisateur.nom, realisateur.prenom
                    FROM realisateur
                    INNER JOIN film
                        ON realisateur.id_realisateur = film.id_realisateur
                    WHERE film.id_film = :id_film");

    $requeteRealisateur->execute(["id_film" => $idFilm]);
    $realisateurFilm = $requeteRealisateur->fetch(PDO::FETCH_ASSOC);

?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> <?= htmlspecialchars($ficheFilm["titre"], ENT_QUOTES, 'UTF-8') ?> | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/movie.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Fiche du film </h1>

        <!-- =================================
        1. Détails du film
        ===================================== -->

        <section class="section_page section_film">
            <h2 class="titre_section"> Détails du film </h2>
            <article class="details_film">

                <!-- Affiche du film -->
                <div class="conteneur_affiche">
                    <img
                            class="affiche_details"
                            src="<?= htmlspecialchars(
                                    !empty($ficheFilm["affiche"]) ? $ficheFilm["affiche"] : "images/affiche_indisponible.png",
                                    ENT_QUOTES,
                                    'UTF-8'
                            ) ?>"
                    onerror="this.onerror=null; this.src='images/affiche_indisponible.png';"
                    alt="affiche du film <?php echo htmlspecialchars($ficheFilm["titre"], ENT_QUOTES, 'UTF-8') ?>"
                    >
                </div>
                <!-- -------------------- -->
                <!-- Informations du film -->
                <div class="informations_film">
                    <h3 class="titre_details_film">
                        <?php echo htmlspecialchars($ficheFilm["titre"], ENT_QUOTES, 'UTF-8') ?>
                    </h3>
                    <div class="donnees_film">
                        <p>
                            <strong> Année de sortie : </strong>
                            <span> <?php echo $ficheFilm["annee_de_sortie"] ?> </span>
                        </p>
                        <p>
                            <strong> Catégorie : </strong>
                            <span>
                                <?php echo htmlspecialchars(implode(" | ", array_column($categoriesFilm, "nom")), ENT_QUOTES, 'UTF-8') ?>
                            </span> <!-- implode : créer une chaine des noms -->
                        </p>
                        <p>
                            <strong> Réalisateur : </strong>
                            <a class="lien_realisateur" href="director.php?id=<?php echo $ficheFilm["id_realisateur"] ?>">
                                <?php echo htmlspecialchars($realisateurFilm["prenom"] . " " . $realisateurFilm["nom"]) ?>
                            </a>
                        </p>
                        <p>
                            <strong> Acteurs : </strong>
                            <span>
                                <?php echo htmlspecialchars(implode(" | ", array_map(fn($acteur) => $acteur["prenom"] . " " . $acteur["nom"], $acteursFilm)) ,ENT_QUOTES, 'UTF-8') ?>
                            </span> <!-- array_map parcourt le tableau. --> <!-- fn : syntaxe d'une fonction PHP -->
                        </p>
                    </div>
                    <!-- -------------------- -->
                    <!-- Synopsis -->
                    <div class="synopsis_film">
                        <h4> Synopsis </h4>
                        <p>
                            <?php echo htmlspecialchars($ficheFilm["resume"] ?? "", ENT_QUOTES, 'UTF-8') ?>
                        </p>
                    </div>
                    <!-- -------------------- -->
                    <!-- Achat -->
                    <div class="achat_film">
                        <p class="prix_details_film"> <?php echo number_format((float) $ficheFilm["prix"], 2, ",", " ") ?> € </p>
                        <button class="bouton_panier"
                                type="button"
                                disabled>
                            Ajouter au panier
                        </button>
                    </div>
                    <!-- -------------------- -->

                </div>
            </article>
        </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>