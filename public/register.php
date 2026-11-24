<?php

    // Initialisation du message de validation
    $message = "";

    // Traitement du formulaire
    if ($_SERVER["REQUEST_METHOD"] === "POST") {

        // Récupération des données
        $nom = trim($_POST["nom"] ?? "");
        $email = trim($_POST["email"] ?? "");
        $password = $_POST["mdp"] ?? "";
        $confirmation = $_POST["confirmation_mdp"] ?? "";

        // Validation des données
        if ($nom === "" || $email === "" || $password === "" || $confirmation === "") {
            $message = "Veuillez remplir tous les champs.";

        } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $message = "Adresse email invalide.";

        } elseif (strlen($password) < 8) {
            $message = "Le mot de passe doit contenir 8 caractères minimum.";

        } elseif ($password !== $confirmation) {
            $message = "Les mots de passe sont différents.";

        } else {
            $message = "Formulaire valide.";
        }
    }

?>


<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Inscription | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/register.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1> Inscription </h1>

        <!-- =================================
        1. Formulaire d'inscription
        ===================================== -->

        <section class="section_page section_inscription">
            <form class="formulaire_inscription"
                action="register.php"
                method="post"
            >
                <h2> Créer un compte </h2>
                <?php if ($message !== ""): ?>
                    <p><?= htmlspecialchars($message, ENT_QUOTES, 'UTF-8') ?></p>
                <?php endif; ?>
                <div class="champ_inscription">
                    <label for="nom_inscription"> Nom </label>
                    <input
                        id="nom_inscription"
                        name="nom"
                        type="text"
                        placeholder="Votre nom"
                        autocomplete="name"
                        required
                    >
                </div>
                <div class="champ_inscription">
                    <label for="email_inscription"> Adresse e-mail </label>
                    <input
                           id="email_inscription"
                           name="email"
                           type="email"
                           placeholder="exemple@gmail.com"
                           autocomplete="email"
                            required
                    >
                </div>
                <div class="champ_inscription">
                    <label for="mdp_inscription"> Mot de passe </label>
                    <input
                            id="mdp_inscription"
                            name="mdp"
                            type="password"
                            placeholder="8 caractères minimum"
                            autocomplete="new-password"
                            minlength="8"
                            required
                    >
                </div>
                <div class="champ_inscription">
                    <label for="confirmation_mdp_inscription"> Confirmer le mot de passe </label>
                    <input
                            id="confirmation_mdp_inscription"
                            name="confirmation_mdp"
                            type="password"
                            placeholder="Confirmez votre mot de passe"
                            autocomplete="new-password"
                            minlength="8"
                            required
                    >
                </div>
                <button class="bouton_inscription"
                        type="submit"
                >
                    S'inscrire
                </button>
                <p class="lien_connexion">
                    Déjà inscrit ?
                    <a href="login.php"> Se connecter </a>
                </p>
            </form>
        </section>
    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>