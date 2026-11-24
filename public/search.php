<?php

    // Connexion PDO
    require_once __DIR__ . "/../config/database.php";

    // Récupération de la recherche via l'URL
    $termeRecherche = trim($_GET["recherche"] ?? "");
    $filmsRecherches = [];

    if ($termeRecherche !== "") {
        $rechercheSQL = "%" . $termeRecherche . "%";        // Permet l'approximation dans la recherche

        // Récupération des films de la recherche
        $recherche = $pdo->prepare(
                "SELECT *
                    FROM film
                    INNER JOIN realisateur
                        ON film.id_realisateur = realisateur.id_realisateur
                    WHERE titre LIKE :titre
                        OR nom LIKE :nom
                        OR prenom LIKE :prenom
                    ORDER BY annee_de_sortie DESC, id_film DESC;");

        $recherche->execute([
                "titre" => $rechercheSQL,
                "nom" => $rechercheSQL,
                "prenom" => $rechercheSQL
        ]);

        $filmsRecherches = $recherche->fetchAll(PDO::FETCH_ASSOC);
    }

?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Recherche | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/search.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Recherche de films </h1>

        <!-- =================================
        1. Formulaire de recherche
        ===================================== -->

        <section class="section_page section_recherche">
            <form class="formulaire_recherche" action="search.php" method="get" role="search">
                <label for="recherche_film"> Rechercher un film ou un réalisateur </label>
                <div class="champ_recherche">
                    <input
                        id="recherche_film"
                        name="recherche"
                        type="search"
                        placeholder="Titre ou réalisateur..."
                        value="<?= htmlspecialchars($termeRecherche, ENT_QUOTES, 'UTF-8') ?>"
                        required
                    >
                    <button class="bouton_recherche" type="submit"> Rechercher </button>
                </div>
            </form>
        </section>

        <!-- =================================
        2. Résultats de la recherche
        ===================================== -->

        <section class="section_page section_resultats">
            <?php if ($termeRecherche === ""): ?>
                <h2 class="titre_section"> Résultats de la recherche </h2>
                <p> Veuillez saisir un terme de recherche. </p>
            <?php elseif (empty($filmsRecherches)): ?>
                <h2 class="titre_section"> Aucun résultat </h2>
                <p>
                    Aucun film trouvé pour :
                    <?= htmlspecialchars($termeRecherche, ENT_QUOTES, 'UTF-8') ?>
                </p>
            <?php else: ?>
                <h2 class="titre_section">
                    <?= count($filmsRecherches) ?>
                    résultat<?= count($filmsRecherches) > 1 ? "s" : "" ?>
                    pour :
                    <?= htmlspecialchars($termeRecherche, ENT_QUOTES, 'UTF-8') ?>
                </h2>
            <div class="liste_films">
                <!-- Cartes de film générées dynamiquement -->
                <?php foreach ($filmsRecherches as $film): ?>

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
                        <button class="bouton_panier" type="button" disabled>
                            Ajouter au panier
                        </button>
                    </div>
                </article>

                <?php endforeach; ?>
                <!-- ----------------------------------------- -->
            </div>
            <?php endif; ?>
        </section>

    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>