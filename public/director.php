<?php

    // Connexion PDO
    require_once __DIR__ . "/../config/database.php";

    // Récupération de l'identifiant du réalisateur via l'URL
    $idRealisateur = filter_input(INPUT_GET, "id", FILTER_VALIDATE_INT);

    if ($idRealisateur === false || $idRealisateur === null || $idRealisateur <= 0) {
        $idRealisateur = null;
    }

    // Récupération du réalisateur
    $requeteRealisateur = $pdo->prepare(
            "SELECT *
                        FROM realisateur
                        WHERE id_realisateur = :id_realisateur");

    $requeteRealisateur->execute(["id_realisateur" => $idRealisateur]);
    $ficheRealisateur = $requeteRealisateur->fetch(PDO::FETCH_ASSOC);

    if (!$ficheRealisateur) {
        http_response_code(404);        // Gestion d'une absence de réalisateur
    }

    // Récupération de la filmographie du réalisateur

    $requeteFilmographie = $pdo->prepare(
            "SELECT *
                    FROM realisateur
                    INNER JOIN film
                        ON realisateur.id_realisateur = film.id_realisateur
                    WHERE film.id_realisateur = :id_realisateur
                    ORDER BY annee_de_sortie DESC, id_film DESC");

    $requeteFilmographie->execute(["id_realisateur" => $idRealisateur]);

    $films = $requeteFilmographie -> fetchAll(PDO::FETCH_ASSOC);


?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <?= $ficheRealisateur
                ? htmlspecialchars(
                        $ficheRealisateur["prenom"] . " " . $ficheRealisateur["nom"],
                        ENT_QUOTES,
                        'UTF-8'
                )
                : "Réalisateur introuvable" ?> | Bob'ines
    </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/director.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>

        <?php if ($ficheRealisateur === false): ?>
            <section class="section_page section_introuvable">
                <h1> Réalisateur introuvable </h1>
                <img
                        class="image_introuvable"
                        src="./images/realisateur_introuvable.png"
                        alt="Réalisateur introuvable"
                >
                <p> <a class="lien_retour" href="index.php"> Retour au catalogue </a></p>
            </section>
        <?php else: ?>

        <h1> Fiche du réalisateur </h1>

        <!-- =================================
        1. Présentation du réalisateur
        ===================================== -->

        <section class="section_page section_realisateur">
            <h2 class="titre_section"> Présentation </h2>
            <article class="details_realisateur">
                <div class="conteneur_portrait">
                    <img
                            class="portrait_realisateur"
                            src="<?= htmlspecialchars(!empty($ficheRealisateur["portrait"]) ? $ficheRealisateur["portrait"] : "images/portrait_indisponible.png", ENT_QUOTES, 'UTF-8')?>"
                            alt="Portrait de <?= htmlspecialchars($ficheRealisateur["prenom"] . " " . $ficheRealisateur["nom"], ENT_QUOTES, 'UTF-8') ?>"
                    >
                </div>
                <div class="informations_realisateur">
                    <h3 class="nom_realisateur"> <?= htmlspecialchars($ficheRealisateur["prenom"] . " " . $ficheRealisateur["nom"], ENT_QUOTES, 'UTF-8') ?> </h3>
                    <div class="donnees_realisateur">
                        <p><strong> Nationalité : </strong> <?= htmlspecialchars($ficheRealisateur["nationalite"], ENT_QUOTES, 'UTF-8') ?> </p>
                        <p>
                            <strong> Date de naissance : </strong>
                            <?= !empty($ficheRealisateur["date_de_naissance"])
                                    ? date("d/m/Y", strtotime($ficheRealisateur["date_de_naissance"]))
                                    : "Non renseignée" ?>
                        </p>
                    </div>
                    <div class="biographie_realisateur">
                        <h4> Biographie </h4>
                        <p>
                            <?= !empty($ficheRealisateur["biographie"])
                                    ? htmlspecialchars($ficheRealisateur["biographie"], ENT_QUOTES, 'UTF-8')
                                    : "Biographie non disponible." ?>
                        </p>
                    </div>
                </div>
            </article>
        </section>

        <!-- =================================
        2. Les films du réalisateur
        ===================================== -->

        <section class="section_page section_films_realisateur">
            <h2 class="titre_section"> Filmographie </h2>
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
                            <button class="bouton_panier" type="button" disabled>
                                Ajouter au panier
                            </button>
                        </div>
                    </article>

                <?php endforeach; ?>
                <!-- ----------------------------------------- -->
            </div>
        </section>
        <?php endif; ?>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>