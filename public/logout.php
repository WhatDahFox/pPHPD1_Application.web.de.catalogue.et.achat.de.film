<?php

    // Démarrage de la session PHP
    session_start();

    // Autoriser uniquement les requêtes POST
    if ($_SERVER["REQUEST_METHOD"] !== "POST") {
        header("Location: profile.php");
        exit();
    }

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

    // Suppression des données de session
    $_SESSION = [];

    // Suppression du cookie de session
    if (ini_get("session.use_cookies")) {
        $params = session_get_cookie_params();

        setcookie(session_name(), "", time() - 42000,
            $params["path"], $params["domain"],
            $params["secure"], $params["httponly"]
        );
    }

    // Destruction de la session
    session_destroy();

    // Redirection vers la connexion
    header("Location: login.php");
    exit();

?>