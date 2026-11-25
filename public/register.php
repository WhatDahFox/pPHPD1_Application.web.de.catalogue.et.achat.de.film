<?php

    // Démarrage de la session PHP
    session_start();

    // Création du jeton CSRF
    if (empty($_SESSION["csrf_token"])) {
        $_SESSION["csrf_token"] = bin2hex(random_bytes(32));
    }

    // Initialisation du message de validation
    $message = "";

    // Traitement du formulaire
    if ($_SERVER["REQUEST_METHOD"] === "POST") {

        // Vérification du jeton CSRF
        $csrf_token = $_POST["csrf_token"] ?? "";

        if (
                !is_string($csrf_token) ||
                $csrf_token === "" ||
                empty($_SESSION["csrf_token"]) ||
                !hash_equals($_SESSION["csrf_token"], $csrf_token)
        ) {
            http_response_code(403);
            exit("Requête invalide.");
        }

        // Récupération des données
        $nom = $_POST["nom"] ?? "";
        $email = $_POST["email"] ?? "";
        $password = $_POST["mdp"] ?? "";
        $confirmation = $_POST["confirmation_mdp"] ?? "";

        // Validation des données
        if (
                !is_string($nom) ||
                !is_string($email) ||
                !is_string($password) ||
                !is_string($confirmation)
        ) {
            $message = "Les données envoyées sont invalides.";

        } elseif (
                mb_strlen(trim($nom)) > 50 ||
                strlen(trim($email)) > 254 ||
                strlen($password) > 72 ||
                strlen($confirmation) > 72
        ) {
            $message = "Certaines informations sont trop longues.";

        } elseif (trim($nom) === "" || trim($email) === "" || $password === "" || $confirmation === "") {
            $message = "Veuillez remplir tous les champs.";

        } elseif (!filter_var(trim($email), FILTER_VALIDATE_EMAIL)) {
            $message = "Adresse email invalide.";

        } elseif (strlen($password) < 8) {
            $message = "Le mot de passe doit contenir 8 caractères minimum.";

        } elseif ($password !== $confirmation) {
            $message = "Les mots de passe sont différents.";

        } else {

            $nom = trim($nom);
            $email = trim($email);

            try {
                // Connexion PDO
                require_once __DIR__ . "/../config/database.php";

                // Vérifier si l'adresse email existe déjà
                $sql = "SELECT id_utilisateur
                        FROM utilisateur
                        WHERE adresse_mail = ?";

                $requete = $pdo->prepare($sql);
                $requete->execute([$email]);

                if ($requete->fetch()) {
                    $message = "Cette adresse email est déjà utilisée.";

                } else {

                    // Sécuriser le mot de passe
                    $hash = password_hash($password, PASSWORD_DEFAULT);

                    // Enregistrer le nouvel utilisateur
                    $sql = "INSERT INTO utilisateur (nom, adresse_mail, mdp)
                            VALUES (?, ?, ?)";

                    $requete = $pdo->prepare($sql);
                    $requete->execute([$nom, $email, $hash]);

                    // Renouvellement du jeton CSRF
                    $_SESSION["csrf_token"] = bin2hex(random_bytes(32));

                    header("Location: login.php");
                    exit();
                }

            } catch (PDOException $e) {
                error_log($e->getMessage());
                $message = "Une erreur est survenue lors de l'inscription.";
            }
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
                <input
                        type="hidden"
                        name="csrf_token"
                        value="<?= htmlspecialchars($_SESSION["csrf_token"], ENT_QUOTES, 'UTF-8') ?>"
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