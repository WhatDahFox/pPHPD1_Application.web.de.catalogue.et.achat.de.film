
<?php
session_start();

require_once __DIR__ . '/../config/database.php';

// Création du jeton CSRF
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

// Récupération et validation de l'identifiant du film
$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

$film = null;
$acteursFilm = [];

if ($id !== false && $id !== null && $id > 0) {

    // Récupération des informations du film, du réalisateur et des catégories
    $requete = $pdo->prepare("
        SELECT
            f.id_film,
            f.titre,
            f.affiche,
            f.resume,
            f.annee_de_sortie,
            f.prix,
            r.id_realisateur,
            CONCAT(r.prenom, ' ', r.nom) AS realisateur,
            (
                SELECT GROUP_CONCAT(DISTINCT c.nom SEPARATOR ', ')
                FROM fait_partie_de fp
                INNER JOIN categorie c
                    ON fp.id_categorie = c.id_categorie
                WHERE fp.id_film = f.id_film
            ) AS categories
        FROM film f
        LEFT JOIN realisateur r
            ON f.id_realisateur = r.id_realisateur
        WHERE f.id_film = :id
    ");

    $requete->execute(['id' => $id]);
    $film = $requete->fetch(PDO::FETCH_ASSOC);

    // Récupération des acteurs du film
    if ($film) {
        $requeteActeurs = $pdo->prepare("
            SELECT a.nom, a.prenom
            FROM acteur a
            INNER JOIN ont_joue_dans o
                ON a.id_acteur = o.id_acteur
            WHERE o.id_film = :id
            ORDER BY a.nom, a.prenom
        ");

        $requeteActeurs->execute(['id' => $id]);
        $acteursFilm = $requeteActeurs->fetchAll(PDO::FETCH_ASSOC);
    }
}

// Réponse 404 si le film n'existe pas
if (!$film) {
    http_response_code(404);
}
?>

<!doctype html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <?= $film
            ? htmlspecialchars($film['titre'], ENT_QUOTES, 'UTF-8')
            : 'Film introuvable'
        ?> | Bob'ines
    </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/movie.css">
</head>

<body class="conteneur">

<header class="bloc header"></header>

<main>

    <?php if (!$film): ?>

        <section class="section_page section_introuvable">

            <h1>Film introuvable</h1>

            <img
                class="image_introuvable"
                src="./images/film_introuvable.png"
                alt="Film introuvable"
            >

            <p>
                <a class="lien_retour" href="index.php">
                    Retour au catalogue
                </a>
            </p>

        </section>

    <?php else: ?>

        <?php
        $affiche = !empty($film['affiche'])
            ? $film['affiche']
            : './images/affiche_indisponible.png';

        $categorie = $film['categories'] ?? 'Catégorie non renseignée';
        $realisateur = $film['realisateur'] ?? 'Réalisateur inconnu';
        ?>

        <h1>Fiche du film</h1>

        <!-- Détails du film -->
        <section class="section_page section_film">

            <h2 class="titre_section">Détails du film</h2>

            <article class="details_film">

                <!-- Affiche du film -->
                <div class="conteneur_affiche">

                    <img
                        class="affiche_details"
                        src="<?= htmlspecialchars($affiche, ENT_QUOTES, 'UTF-8') ?>"
                        onerror="this.onerror=null; this.src='./images/affiche_indisponible.png';"
                        alt="Affiche de <?= htmlspecialchars($film['titre'], ENT_QUOTES, 'UTF-8') ?>"
                    >

                </div>

                <!-- Informations du film -->
                <div class="informations_film">

                    <h3 class="titre_details_film">
                        <?= htmlspecialchars($film['titre'], ENT_QUOTES, 'UTF-8') ?>
                    </h3>

                    <div class="donnees_film">

                        <p>
                            <strong>Année de sortie :</strong>
                            <?= htmlspecialchars(
                                (string) $film['annee_de_sortie'],
                                ENT_QUOTES,
                                'UTF-8'
                            ) ?>
                        </p>

                        <p>
                            <strong>Catégorie :</strong>
                            <?= htmlspecialchars($categorie, ENT_QUOTES, 'UTF-8') ?>
                        </p>

                        <p>
                            <strong>Réalisateur :</strong>

                            <?php if (!empty($film['id_realisateur'])): ?>

                                <a
                                    class="lien_realisateur"
                                    href="director.php?id=<?= (int) $film['id_realisateur'] ?>"
                                >
                                    <?= htmlspecialchars($realisateur, ENT_QUOTES, 'UTF-8') ?>
                                </a>

                            <?php else: ?>

                                <?= htmlspecialchars($realisateur, ENT_QUOTES, 'UTF-8') ?>

                            <?php endif; ?>
                        </p>

                        <p>
                            <strong>Acteurs :</strong>

                            <?= !empty($acteursFilm)
                                ? htmlspecialchars(
                                    implode(' | ', array_map(
                                        fn($acteur) => $acteur['prenom'] . ' ' . $acteur['nom'],
                                        $acteursFilm
                                    )),
                                    ENT_QUOTES,
                                    'UTF-8'
                                )
                                : 'Aucun acteur renseigné.'
                            ?>
                        </p>

                    </div>

                    <!-- Synopsis -->
                    <div class="synopsis_film">

                        <h4>Synopsis</h4>

                        <p>
                            <?= !empty($film['resume'])
                                ? nl2br(htmlspecialchars(
                                    $film['resume'],
                                    ENT_QUOTES,
                                    'UTF-8'
                                ))
                                : 'Aucun résumé disponible pour ce film.'
                            ?>
                        </p>

                    </div>

                    <!-- Achat -->
                    <div class="achat_film">

                        <p class="prix_details_film">
                            <?= number_format(
                                (float) $film['prix'],
                                2,
                                ',',
                                ' '
                            ) ?> €
                        </p>

                        <form method="POST" action="cart.php">

                            <input
                                type="hidden"
                                name="csrf_token"
                                value="<?= htmlspecialchars(
                                    $_SESSION['csrf_token'],
                                    ENT_QUOTES,
                                    'UTF-8'
                                ) ?>"
                            >

                            <input
                                type="hidden"
                                name="id"
                                value="<?= (int) $film['id_film'] ?>"
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

                </div>

            </article>

        </section>

    <?php endif; ?>

    <p><a href="index.php">Retour au catalogue</a></p>

</main>

<footer class="bloc footer"></footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
