<?php

    // Démarrage de la session PHP
    session_start();

    // Redirection si l'utilisateur est déjà connecté
    if (isset($_SESSION["utilisateur"])) {
        header("Location: profile.php");
        exit();
    }

?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Connexion | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/login.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Connexion </h1>

        <!-- =================================
        1. Formulaire de connexion
        ===================================== -->

        <section class="section_page section_connexion">
            <form class="formulaire_connexion" action="login.php" method="post">
                <h2> Se connecter </h2>
                <!-- Adresse e-mail -->
                <div class="champ_connexion">
                    <label for="email_connexion"> Adresse e-mail </label>
                    <input
                            id="email_connexion"
                            name="email"
                            type="email"
                            placeholder="exemple@gmail.com"
                            autocomplete="email"
                            required
                    >
                </div>
                <!-- ------------ -->
                <!-- Mot de passe -->
                <div class="champ_connexion">
                    <label for="mdp_connexion"> Mot de passe </label>
                    <input
                        id="mdp_connexion"
                        name="password"
                        type="password"
                        placeholder="Votre mot de passe"
                        autocomplete="current-password"
                        required
                    >
                </div>
                <!-- ----------- -->
                <button class="bouton_connexion" type="submit" disabled> Se connecter </button>
                <!-- Inscription -->
                <p class="lien_inscription">
                    Pas encore de compte ?
                    <a href="register.php"> S'inscrire </a>
                </p>
                <!-- ----------- -->
            </form>
        </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>