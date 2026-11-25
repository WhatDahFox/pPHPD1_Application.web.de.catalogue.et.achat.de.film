<?php

/* ========================================
   1. Chargement du fichier .env
========================================= */

$envPath = dirname(__DIR__) . '/.env';

try {
    if (!is_readable($envPath)) {
        throw new RuntimeException("Fichier .env introuvable.");
    }

    $lignes = file($envPath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

    foreach ($lignes as $ligne) {
        $ligne = trim($ligne);

        if ($ligne === '' || str_starts_with($ligne, '#')) {
            continue;
        }

        $parties = explode('=', $ligne, 2);

        if (count($parties) !== 2) {
            continue;
        }

        $cle = trim($parties[0]);
        $valeur = trim($parties[1]);

        if (preg_match('/^[A-Z_]+$/', $cle)) {
            putenv("$cle=$valeur");
        }
    }

    /* ========================================
       2. Paramètres de connexion
    ========================================= */

    $host = getenv('DB_HOST');
    $dbname = getenv('DB_NAME');
    $username = getenv('DB_USER');
    $password = getenv('DB_PASSWORD');

    if (!$host || !$dbname || !$username || $password === false) {
        throw new RuntimeException("Configuration de base de données incomplète.");
    }

	$dsn = "mysql:host=$host;port=3306;dbname=$dbname;charset=utf8mb4";

    /* ========================================
       3. Connexion PDO sécurisée
    ========================================= */

    $pdo = new PDO($dsn, $username, $password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false
    ]);

} catch (Throwable $e) {
    error_log($e->getMessage());
    http_response_code(500);
    exit("Connexion à la base de données impossible.");
}

?>
