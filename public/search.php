
<?php
session_start();

require_once __DIR__ . '/../config/database.php';

// Création du jeton CSRF
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}


// Récupération et validation du terme de recherche
$recherche = $_GET['recherche'] ?? '';

if (!is_string($recherche)) {
    $recherche = '';
}

$recherche = mb_substr(trim($recherche), 0, 100, 'UTF-8');
$resultats = [];

if ($recherche !== '') {

    $motRecherche = '%' . $recherche . '%';

    // Recherche par titre, réalisateur ou catégorie
    $requete = $pdo->prepare("
        SELECT
            f.id_film,
            f.titre,
            f.affiche,
            f.resume,
            f.annee_de_sortie,
            f.prix,
            CONCAT(r.prenom, ' ', r.nom) AS realisateur,
            GROUP_CONCAT(DISTINCT c.nom SEPARATOR ', ') AS categories
        FROM film f
        LEFT JOIN realisateur r
            ON f.id_realisateur = r.id_realisateur
        LEFT JOIN fait_partie_de fp
            ON f.id_film = fp.id_film
        LEFT JOIN categorie c
            ON fp.id_categorie = c.id_categorie
        WHERE
            f.titre LIKE ?
            OR r.nom LIKE ?
            OR r.prenom LIKE ?
            OR c.nom LIKE ?
        GROUP BY f.id_film
        ORDER BY f.annee_de_sortie DESC, f.id_film DESC
    ");

    $requete->execute([
        $motRecherche,
        $motRecherche,
        $motRecherche,
        $motRecherche
    ]);

    $resultats = $requete->fetchAll(PDO::FETCH_ASSOC);
}
?>

<!doctype html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/search.css">
</head>

<body class="conteneur">

<header class="bloc header"></header>

<main>

    <h1>Recherche de films</h1>

    <!-- Formulaire de recherche -->
    <section class="section_page section_recherche">

        <form
            class="formulaire_recherche"
            action="search.php"
            method="get"
            role="search"
        >

            <label for="recherche_film">
                Rechercher un film, un réalisateur ou une catégorie
            </label>

            <div class="champ_recherche">

                <input
                    id="recherche_film"
                    name="recherche"
                    type="search"
                    placeholder="Titre, réalisateur ou catégorie..."
                    value="<?= htmlspecialchars($recherche, ENT_QUOTES, 'UTF-8') ?>"
                    required
                >

                <button class="bouton_recherche" type="submit">
                    Rechercher
                </button>

            </div>

        </form>

    </section>

    <!-- Résultats de la recherche -->
    <section class="section_page section_resultats">

        <?php if ($recherche === ''): ?>

            <h2 class="titre_section">Résultats de la recherche</h2>

            <p>
                Saisissez un mot pour rechercher dans le catalogue.
            </p>

        <?php elseif (empty($resultats)): ?>

            <h2 class="titre_section">Aucun résultat</h2>

            <p>
                Aucun film trouvé pour :
                <strong>
                    <?= htmlspecialchars($recherche, ENT_QUOTES, 'UTF-8') ?>
                </strong>
            </p>

        <?php else: ?>

            <h2 class="titre_section">
                <?= count($resultats) ?>
                résultat<?= count($resultats) > 1 ? 's' : '' ?>
                pour « <?= htmlspecialchars($recherche, ENT_QUOTES, 'UTF-8') ?> »
            </h2>

            <div class="liste_films">

                <?php foreach ($resultats as $film): ?>

                    <?php
                    $affiche = !empty($film['affiche'])
                        ? $film['affiche']
                        : './images/affiche_indisponible.png';

                    $categorie = $film['categories']
                        ?? 'Catégorie non renseignée';

                    $realisateur = $film['realisateur']
                        ?? 'Réalisateur inconnu';
                    ?>

                    <article class="carte_film">

                        <img
                            class="affiche_film"
                            src="<?= htmlspecialchars($affiche, ENT_QUOTES, 'UTF-8') ?>"
                            onerror="this.onerror=null; this.src='./images/affiche_indisponible.png';"
                            alt="Affiche de <?= htmlspecialchars($film['titre'], ENT_QUOTES, 'UTF-8') ?>"
                        >

                        <div class="contenu_carte_film">

                            <h3 class="titre_film">
                                <?= htmlspecialchars($film['titre'], ENT_QUOTES, 'UTF-8') ?>
                            </h3>

                            <p class="description_film">
                                <?= htmlspecialchars($categorie, ENT_QUOTES, 'UTF-8') ?>
                                -
                                <?= htmlspecialchars(
                                    (string) $film['annee_de_sortie'],
                                    ENT_QUOTES,
                                    'UTF-8'
                                ) ?>
                                -
                                <?= htmlspecialchars($realisateur, ENT_QUOTES, 'UTF-8') ?>
                            </p>

                            <p class="description_film">
                                <?= !empty($film['resume'])
                                    ? htmlspecialchars(
                                        $film['resume'],
                                        ENT_QUOTES,
                                        'UTF-8'
                                    )
                                    : 'Aucun résumé disponible.'
                                ?>
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

                    </article>

                <?php endforeach; ?>

            </div>

        <?php endif; ?>

    </section>

    <p>
        <a href="index.php">Retour à l'accueil</a>
    </p>

</main>

<footer class="bloc footer"></footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
