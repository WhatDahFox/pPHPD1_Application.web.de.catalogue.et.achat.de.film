
<?php
require_once __DIR__ . '/../config/database.php';

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

$realisateur = null;
$films = [];

if ($id !== false && $id !== null && $id > 0) {

    // Récupération du réalisateur
    $requete = $pdo->prepare("
        SELECT
            id_realisateur,
            nom,
            prenom,
            nationalite,
            date_de_naissance,
            biographie,
            portrait
        FROM realisateur
        WHERE id_realisateur = ?
    ");

    $requete->execute([$id]);
    $realisateur = $requete->fetch(PDO::FETCH_ASSOC);

    // Récupération de ses films
    if ($realisateur) {

        $requeteFilms = $pdo->prepare("
            SELECT
                id_film,
                titre,
                affiche,
                resume,
                annee_de_sortie,
                prix
            FROM film
            WHERE id_realisateur = ?
            ORDER BY annee_de_sortie DESC
        ");

        $requeteFilms->execute([$id]);
        $films = $requeteFilms->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>

<!doctype html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réalisateur | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/director.css">
</head>

<body class="conteneur">

<header class="bloc header"></header>

<main>

    <?php if (!$realisateur): ?>

        <h1>Réalisateur introuvable</h1>
        <a href="index.php">Retour au catalogue</a>

    <?php else: ?>

        <?php
        $nomComplet = $realisateur['prenom'] . ' ' . $realisateur['nom'];

        $portrait = !empty($realisateur['portrait'])
            ? $realisateur['portrait']
            : './images/portrait_indisponible.png';
        ?>

        <h1>Fiche du réalisateur</h1>

        <!-- Présentation du réalisateur -->
        <section class="section_page section_realisateur">

            <h2 class="titre_section">Présentation</h2>

            <article class="details_realisateur">

                <div class="conteneur_portrait">
                    <img
                        class="portrait_realisateur"
                        src="<?= htmlspecialchars($portrait) ?>"
                        alt="Portrait de <?= htmlspecialchars($nomComplet) ?>"
                    >
                </div>

                <div class="informations_realisateur">

                    <h3 class="nom_realisateur">
                        <?= htmlspecialchars($nomComplet) ?>
                    </h3>

                    <div class="donnees_realisateur">

                        <p>
                            <strong>Nationalité :</strong>
                            <?= htmlspecialchars($realisateur['nationalite'] ?? 'Non renseignée') ?>
                        </p>

                        <p>
                            <strong>Date de naissance :</strong>

                            <?php if (!empty($realisateur['date_de_naissance'])): ?>
                                <?= date(
                                    'd/m/Y',
                                    strtotime($realisateur['date_de_naissance'])
                                ) ?>
                            <?php else: ?>
                                Non renseignée
                            <?php endif; ?>
                        </p>

                    </div>

                    <div class="biographie_realisateur">

                        <h4>Biographie</h4>

                        <p>
                            <?= !empty($realisateur['biographie'])
                                ? nl2br(htmlspecialchars($realisateur['biographie']))
                                : 'Aucune biographie disponible.' ?>
                        </p>

                    </div>

                </div>

            </article>

        </section>

        <!-- Filmographie -->
        <section class="section_page section_films_realisateur">

            <h2 class="titre_section">Filmographie</h2>

            <div class="liste_films">

                <?php if (empty($films)): ?>

                    <p>Aucun film associé à ce réalisateur.</p>

                <?php else: ?>

                    <?php foreach ($films as $film): ?>

                        <?php
                        $affiche = !empty($film['affiche'])
                            ? $film['affiche']
                            : './images/affiche_indisponible.png';
                        ?>

                        <article class="carte_film">

                            <img
                                class="affiche_film"
                                src="<?= htmlspecialchars($affiche) ?>"
                                alt="Affiche de <?= htmlspecialchars($film['titre']) ?>"
                            >

                            <div class="contenu_carte_film">

                                <h3 class="titre_film">
                                    <?= htmlspecialchars($film['titre']) ?>
                                </h3>

                                <p class="description_film">
                                    <?= htmlspecialchars(
                                        (string) $film['annee_de_sortie']
                                    ) ?>
                                </p>

                                <p class="description_film">
                                    <?= !empty($film['resume'])
                                        ? htmlspecialchars($film['resume'])
                                        : 'Aucun résumé disponible.' ?>
                                </p>

                                <p class="prix_film">
                                    <?= number_format(
                                        (float) $film['prix'],
                                        2,
                                        ',',
                                        ' '
                                    ) ?> €
                                </p>

                                <a
                                    class="lien_details_film"
                                    href="movie.php?id=<?= (int) $film['id_film'] ?>"
                                >
                                    Voir les détails du film
                                </a>

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

                        </article>

                    <?php endforeach; ?>

                <?php endif; ?>

            </div>

        </section>

    <?php endif; ?>

    <p><a href="index.php">Retour au catalogue</a></p>

</main>

<footer class="bloc footer"></footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
