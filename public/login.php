<?php

    // Démarrage de la session PHP
    session_start();

    // Création du jeton CSRF
    if (empty($_SESSION["csrf_token"])) {
        $_SESSION["csrf_token"] = bin2hex(random_bytes(32));
    }

    // Redirection si l'utilisateur est déjà connecté
    if (isset($_SESSION["utilisateur"])) {
        header("Location: profile.php");
        exit();
    }

    // Initialisation du message
    $message = "";

    // Traitement du formulaire de connexion
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

        $email = $_POST["email"] ?? "";
        $password = $_POST["password"] ?? "";

        // Validation des données
        if (!is_string($email) || !is_string($password)) {
            $message = "Les données envoyées sont invalides.";

        } elseif (strlen(trim($email)) > 254 || strlen($password) > 72) {
            $message = "Certaines informations sont trop longues.";

        } elseif (empty(trim($email)) || empty($password)) {
            $message = "Veuillez remplir tous les champs.";

        } elseif (!filter_var(trim($email), FILTER_VALIDATE_EMAIL)) {
            $message = "Adresse email invalide.";

        } else {

            $email = trim($email);

            try {
                // Connexion PDO
                require_once __DIR__ . "/../config/database.php";

                // Récupération de l'utilisateur
                $sql = "SELECT id_utilisateur, nom, adresse_mail, mdp
                        FROM utilisateur
                        WHERE adresse_mail = ?";

                $requete = $pdo->prepare($sql);
                $requete->execute([$email]);

                $utilisateur = $requete->fetch(PDO::FETCH_ASSOC);

                // Vérification des identifiants
                if ($utilisateur && password_verify($password, $utilisateur["mdp"])) {

                    session_regenerate_id(true);

                    // Renouvellement du jeton CSRF
                    $_SESSION["csrf_token"] = bin2hex(random_bytes(32));

                    $_SESSION["utilisateur"] = [
                            "id_utilisateur" => $utilisateur["id_utilisateur"],
                            "nom" => $utilisateur["nom"],
                            "email" => $utilisateur["adresse_mail"]
                    ];

                    header("Location: profile.php");
                    exit();

                } else {
                    $message = "Email ou mot de passe incorrect.";
                }

            } catch (PDOException $e) {
                error_log($e->getMessage());
                $message = "Une erreur est survenue lors de la connexion à la base de données.";
            }
        }
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
                <input
                        type="hidden"
                        name="csrf_token"
                        value="<?= htmlspecialchars($_SESSION["csrf_token"], ENT_QUOTES, 'UTF-8') ?>"
                >
                <h2> Se connecter </h2>
                <?php if ($message !== ""): ?>
                    <p><?= htmlspecialchars($message, ENT_QUOTES, 'UTF-8') ?></p>
                <?php endif; ?>
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
                <button class="bouton_connexion" type="submit"> Se connecter </button>
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