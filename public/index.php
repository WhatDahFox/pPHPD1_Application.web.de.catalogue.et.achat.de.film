<?php
require_once __DIR__ . '/../includes/films.php';

?>


<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Accueil | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <section class="section_page section_presentation">
            <h1 id="titre_accueil"> Bienvenue chez Bob'ines ! </h1>
            <p>
                Découvrez des films, ajoutez vos favoris au panier
                et créez votre collection personnelle.
            </p>
        </section>
        <!-- =================================
        1. Films en tendance
        ===================================== -->

        <section class="section_page section_tendance">
            <h2 class="titre_section" id="titre_tendance"> Films tendances </h2>
            <div class="liste_films">
                <?php foreach ($films as $id => $film): ?>
              
                <article class="carte_film">

                    <img 
                    class="affiche_film" 
                    src="images/affiche_indisponible.png" 
                    alt="affiche du film">
                    <div class="contenu_carte_film">
                        <h3 class="titre_film">
                             <?= htmlspecialchars($film['titre']) ?>
                            </h3>
                        <p class="description_film">
                           <?= htmlspecialchars($film['categorie']) ?>
                           <?= htmlspecialchars($film['annee']) ?>
                           <?= htmlspecialchars($film['realisateur']) ?>
                        </p>

                        <p class="prix_film"> 
                            <?= number_format($film['prix'],2,',','') ?>€
                        </p>
                        <a class="lien_details_film" href="movie.php?id=<?= $id ?>">
                            Voir les détails du film
                        </a>
                        <form method="POST" action="cart.php">
                            <input type="hidden" name="id" value="<?= $id ?>">
                        
                            <button class="bouton_panier"
                                    type= "submit"
                                    name="ajouter">
                                    Ajouter au Panier

                            </button>
                        </form>
                        
                    </div>
                </article>
                <?php endforeach; ?>
                
            </div>
        </section>

        <!-- =================================
        2. Recherche de films ou réalisateurs
        ===================================== -->
        <section class="section_page section_recherche">
            <form class="formulaire_recherche" action="/search.php" method="get" role="search">
                <label for="recherche_film"> Rechercher un film ou un réalisateur </label>
                <div class="champ_recherche">
                    <input
                        id="recherche_film"
                        name="recherche"
                        type="search"
                        placeholder="Titre ou réalisateur"
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