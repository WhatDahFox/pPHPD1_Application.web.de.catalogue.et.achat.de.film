
<?php
require_once __DIR__ . '/../config/database.php';

// Récupération des films depuis la base de données
$requete = $pdo->query("
    SELECT
        f.id_film,
        f.titre,
        f.affiche,
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
    GROUP BY f.id_film
    ORDER BY f.id_film
");

$films = $requete->fetchAll(PDO::FETCH_ASSOC);
?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <section class="section_page section_presentation">
            <h1 id="titre_accueil">Bienvenue chez Bob'ines !</h1>
            <p>
                Découvrez des films, ajoutez vos favoris au panier
                et créez votre collection personnelle.
            </p>
        </section>

        <!-- Films en tendance -->
        <section class="section_page section_tendance">
            <h2 class="titre_section" id="titre_tendance">
                Films tendances
            </h2>

            <div class="liste_films">

                <?php foreach ($films as $film): ?>

                    <?php
                    $affiche = !empty($film['affiche'])
                        ? $film['affiche']
                        : 'images/affiche_indisponible.png';

                    $categorie = $film['categories'] ?? 'Catégorie non renseignée';
                    $realisateur = $film['realisateur'] ?? 'Réalisateur inconnu';
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
                                <?= htmlspecialchars($categorie) ?>
                                <?= htmlspecialchars((string) $film['annee_de_sortie']) ?>
                                <?= htmlspecialchars($realisateur) ?>
                            </p>

                            <p class="prix_film">
                                <?= number_format((float) $film['prix'], 2, ',', ' ') ?> €
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

                <?php if (empty($films)): ?>
                    <p>Aucun film n'est disponible pour le moment.</p>
                <?php endif; ?>

            </div>
        </section>

        <!-- Recherche de films ou réalisateurs -->
        <section class="section_page section_recherche">

            <form
                class="formulaire_recherche"
                action="search.php"
                method="get"
                role="search"
            >
                <label for="recherche_film">
                    Rechercher un film ou un réalisateur
                </label>

                <div class="champ_recherche">

                    <input
                        id="recherche_film"
                        name="recherche"
                        type="search"
                        placeholder="Titre ou réalisateur..."
                        required
                    >

                    <button type="submit" class="bouton_recherche">
                        Rechercher
                    </button>

                </div>
            </form>

        </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>
