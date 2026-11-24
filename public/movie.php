
<?php
require_once __DIR__ . '/../config/database.php';

// Récupération de l'identifiant du film
$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

$film = null;

// Recherche du film dans la base de données
if ($id !== false && $id !== null && $id > 0) {

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
        WHERE f.id_film = ?
    ");

    $requete->execute([$id]);
    $film = $requete->fetch(PDO::FETCH_ASSOC);
}
?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du film | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/movie.css">
</head>

<body class="conteneur">

<header class="bloc header"></header>

<main>

    <?php if (!$film): ?>

        <h1>Film introuvable</h1>
        <a href="index.php">Retour au catalogue</a>

    <?php else: ?>

        <?php
        $affiche = !empty($film['affiche'])
            ? $film['affiche']
            : './images/affiche_indisponible.png';

        $categorie = $film['categories'] ?? 'Catégorie non renseignée';
        $realisateur = $film['realisateur'] ?? 'Réalisateur inconnu';
        ?>

        <h1>Fiche du film</h1>

        <section class="section_page section_film">

            <h2 class="titre_section">Détails du film</h2>

            <article class="details_film">

                <div class="conteneur_affiche">
                    <img
                        class="affiche_details"
                        src="<?= htmlspecialchars($affiche) ?>"
                        alt="Affiche de <?= htmlspecialchars($film['titre']) ?>"
                    >
                </div>

                <div class="informations_film">

                    <h3 class="titre_details_film">
                        <?= htmlspecialchars($film['titre']) ?>
                    </h3>

                    <div class="donnees_film">

                        <p>
                            <strong>Année de sortie :</strong>
                            <?= htmlspecialchars((string) $film['annee_de_sortie']) ?>
                        </p>

                        <p>
                            <strong>Catégorie :</strong>
                            <?= htmlspecialchars($categorie) ?>
                        </p>

                        <p>
                            <strong>Réalisateur :</strong>
                            <?= htmlspecialchars($realisateur) ?>
                        </p>

                    </div>

                    <div class="synopsis_film">

                        <h4>Synopsis</h4>

                        <p>
                            <?= !empty($film['resume'])
                                ? nl2br(htmlspecialchars($film['resume']))
                                : 'Aucun résumé disponible pour ce film.' ?>
                        </p>

                    </div>

                    <div class="achat_film">

                        <p class="prix_details_film">
                            <?= number_format((float) $film['prix'], 2, ',', ' ') ?> €
                        </p>

                        <form method="POST" action="cart.php">

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
