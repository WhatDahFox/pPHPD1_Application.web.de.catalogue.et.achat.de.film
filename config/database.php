<?php

/* ========================================
1. Paramètre de connexion à la BDD
========================================= */

    $host="127.0.0.1";
    $dbname="bobines";
    $charset="utf8mb4";

    $username="bobines";
    $password="P@ssw0rd!"; // Se trouverais dans .env si projet officiel.

/* ========================================
2. Connexion à la base de données
========================================= */
    $dsn="mysql:host=$host;dbname=$dbname;charset=$charset";

    try {
        $pdo = new PDO($dsn, $username, $password);

        $pdo->setAttribute(
            PDO::ATTR_ERRMODE,
            PDO::ERRMODE_EXCEPTION
        );
    } catch (PDOException $e) {
        error_log($e->getMessage());
        http_response_code(500);
        exit("Connexion à la base de données impossible.");
    }

?>