<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Mon profil | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/profile.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Mon profil </h1>

        <!-- =================================
        1. Informations du compte
        ===================================== -->

        <section class="section_page section_profil">
            <h2 class="titre_section"> Mes informations </h2>
            <div class="contenu_profil">
                <p><strong> Nom : </strong> Utilisateur exemple </p>
                <p><strong> Adresse mail : </strong> exemple@gmail.com </p>
            </div>
        </section>

        <!-- =================================
        2. Collection de films achetés
        ===================================== -->

        <section class="section_page section_achats">
            <h2 class="titre_section"> Ma collection </h2>
            <div class="liste_films">
                <!-- Film acheté provisoire -->
                <article class="ligne_achat">
                    <img class="affiche_achat" src="images/affiche_indisponible.png" alt="Affiche du film">
                    <div class="informations_achat">
                        <h3 class="titre_film">Film exemple</h3>
                        <p>Date d'achat : 18/11/2026</p>
                        <p>Prix payé : 9,90 €</p>
                        <a href="movie.php">Voir les détails du film</a>
                    </div>
                </article>
                <!-- ---------------------- -->
                <!-- Film acheté provisoire -->
                <article class="ligne_achat">
                    <img class="affiche_achat" src="images/affiche_indisponible.png" alt="Affiche du film">
                    <div class="informations_achat">
                        <h3 class="titre_film">Film exemple</h3>
                        <p>Date d'achat : 18/11/2026</p>
                        <p>Prix payé : 9,90 €</p>
                        <a href="movie.php">Voir les détails du film</a>
                    </div>
                </article>
                <!-- ---------------------- -->
                <!-- Film acheté provisoire -->
                <article class="ligne_achat">
                    <img class="affiche_achat" src="images/affiche_indisponible.png" alt="Affiche du film">
                    <div class="informations_achat">
                        <h3 class="titre_film">Film exemple</h3>
                        <p>Date d'achat : 18/11/2026</p>
                        <p>Prix payé : 9,90 €</p>
                        <a href="movie.php">Voir les détails du film</a>
                    </div>
                </article>
                <!-- ---------------------- -->
            </div>
        </section>

        <!-- =================================
        3. Modification du mot de passe
        ===================================== -->

        <section class="section_page section_mdp">
            <h2 class="titre_section"> Modifier mon mot de passe </h2>
            <form class="formulaire_mdp"
                  action="profile.php"
                  method="post">
                <div class="champ_profil">
                    <label for="mdp_actuel"> Mot de passe actuel </label>
                    <input
                        id="mdp_actuel"
                        name="mdp_actuel"
                        type="password"
                        autocomplete="current-password"
                        required
                    >
                </div>
                <div class="champ_profil">
                    <label for="nouveau_mdp"> Nouveau mot de passe </label>
                    <input
                            id="nouveau_mdp"
                            name="nouveau_mdp"
                            type="password"
                            autocomplete="new-password"
                            minlength="8"
                            required
                    >
                </div>
                <div class="champ_profil">
                    <label for="confirmation_mdp"> Confirmer le nouveau mot de passe </label>
                    <input
                            id="confirmation_mdp"
                            name="confirmation_mdp"
                            type="password"
                            autocomplete="new-password"
                            minlength="8"
                            required
                    >
                </div>
                <button
                     class="bouton_modifier_mdp"
                     type="submit"
                     disabled
                >
                    Modifier le mot de passe
                </button>
            </form>
        </section>

        <!-- =================================
        4. Déconnexion
        ===================================== -->

        <section class="section_page section_deconnexion">
            <h2 class="titre_section"> Déconnexion </h2>

            <form action="logout.php" method="post">
                <button
                    class="bouton_deconnexion"
                    type="submit"
                    disabled
                >
                    Se déconnecter
                </button>
            </form>
        </section>

    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>