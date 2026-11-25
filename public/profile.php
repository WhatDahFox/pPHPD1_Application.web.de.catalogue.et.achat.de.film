<?php

    // Démarrage de la session PHP
    session_start();

    // Création du jeton CSRF
    if (empty($_SESSION["csrf_token"])) {
        $_SESSION["csrf_token"] = bin2hex(random_bytes(32));
    }

    // Vérification de la connexion
    if (!isset($_SESSION["utilisateur"]["id_utilisateur"])) {
        header("Location: login.php");
        exit();
    }

    // Récupération des informations de l'utilisateur connecté
    $utilisateur = $_SESSION["utilisateur"] ?? null;

    // Initialisation du message
    $message = "";
    $messageType = "";

    // Connexion PDO
    require_once __DIR__ . "/../config/database.php";


    // Récupération des films achetés par l'utilisateur
    $filmsAchetes = [];

    try {
        $sql = "SELECT film.id_film, film.titre, film.affiche,
                           contenant.quantite, contenant.prix_achat,
                           commande.date_commande
                    FROM contenant
                    INNER JOIN commande
                        ON contenant.id_commande = commande.id_commande
                    INNER JOIN film
                        ON contenant.id_film = film.id_film
                    WHERE commande.id_utilisateur = ?
                    ORDER BY commande.date_commande DESC, commande.id_commande DESC";

        $requete = $pdo->prepare($sql);
        $requete->execute([$utilisateur["id_utilisateur"]]);

        $filmsAchetes = $requete->fetchAll(PDO::FETCH_ASSOC);

    } catch (PDOException $e) {
        error_log($e->getMessage());
    }


    // Modification du mot de passe
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

        $ancienPassword = $_POST["mdp_actuel"] ?? "";
        $nouveauPassword = $_POST["nouveau_mdp"] ?? "";
        $confirmation = $_POST["confirmation_mdp"] ?? "";

        // Validation des données
        if (
                !is_string($ancienPassword) ||
                !is_string($nouveauPassword) ||
                !is_string($confirmation)
        ) {
            $message = "Informations invalides.";

        } elseif (
                strlen($ancienPassword) > 72 ||
                strlen($nouveauPassword) > 72 ||
                strlen($confirmation) > 72
        ) {
            $message = "Un des mots de passe est trop long.";

        } elseif (empty($ancienPassword) || empty($nouveauPassword) || empty($confirmation)) {
            $message = "Veuillez remplir tous les champs.";

        } elseif (strlen($nouveauPassword) < 8) {
            $message = "Le nouveau mot de passe doit contenir 8 caractères minimum.";

        } elseif ($nouveauPassword !== $confirmation) {
            $message = "Les nouveaux mots de passe sont différents.";

        } else {
            try {
                // Récupération du mot de passe actuel
                $sql = "SELECT mdp FROM utilisateur WHERE id_utilisateur = ?";
                $requete = $pdo->prepare($sql);
                $requete->execute([$utilisateur["id_utilisateur"]]);
                $compte = $requete->fetch(PDO::FETCH_ASSOC);

                if (!$compte || !password_verify($ancienPassword, $compte["mdp"])) {
                    $message = "Le mot de passe actuel est incorrect.";

                } else {
                    // Hachage et enregistrement du nouveau mot de passe
                    $hash = password_hash($nouveauPassword, PASSWORD_DEFAULT);

                    $sql = "UPDATE utilisateur SET mdp = ? WHERE id_utilisateur = ?";
                    $requete = $pdo->prepare($sql);
                    $requete->execute([$hash, $utilisateur["id_utilisateur"]]);

                    $message = "Votre mot de passe a été modifié.";
                    $messageType = "succes";

                    // Renouvellement du jeton CSRF
                    $_SESSION["csrf_token"] = bin2hex(random_bytes(32));
                }

            } catch (PDOException $e) {
                error_log($e->getMessage());
                $message = "Impossible de modifier le mot de passe.";
            }
        }

        if ($messageType === "") {
            $messageType = "erreur";
        }
    }
?>

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
                <p>
                    <strong> Nom : </strong>
                    <?= htmlspecialchars($utilisateur["nom"] ?? "", ENT_QUOTES, 'UTF-8') ?>
                </p>
                <p>
                    <strong> Adresse mail : </strong>
                    <?= htmlspecialchars($utilisateur["email"] ?? "", ENT_QUOTES, 'UTF-8') ?>
                </p>
            </div>
        </section>

        <!-- =================================
        2. Collection de films achetés
        ===================================== -->

        <section class="section_page section_achats">
            <h2 class="titre_section"> Ma collection </h2>
            <div class="liste_films">
                <?php if (empty($filmsAchetes)): ?>
                    <p>Vous n'avez encore acheté aucun film.</p>
                <?php else: ?>
                    <?php foreach ($filmsAchetes as $film): ?>
                        <article class="ligne_achat">
                            <img
                                    class="affiche_achat"
                                    src="<?= htmlspecialchars(
                                            !empty($film["affiche"])
                                                    ? $film["affiche"]
                                                    : "images/affiche_indisponible.png",
                                            ENT_QUOTES,
                                            'UTF-8'
                                    ) ?>"
                                    alt="Affiche de <?= htmlspecialchars($film["titre"], ENT_QUOTES, 'UTF-8') ?>"
                            >
                            <div class="informations_achat">
                                <h3 class="titre_film"> <?= htmlspecialchars($film["titre"], ENT_QUOTES, 'UTF-8') ?> </h3>
                                <p> Date d'achat : <?= date("d/m/Y", strtotime($film["date_commande"])) ?> </p>
                                <p> Quantité : <?= (int) $film["quantite"] ?> </p>
                                <p> Prix payé : <?= number_format((float) $film["prix_achat"], 2, ",", " ") ?> €  / unité </p>
                                <a href="movie.php?id=<?= (int) $film["id_film"] ?>"> Voir les détails du film </a>
                            </div>
                        </article>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
        </section>

        <!-- =================================
        3. Modification du mot de passe
        ===================================== -->

        <section class="section_page section_mdp">
            <h2 class="titre_section"> Modifier mon mot de passe </h2>
            <?php if ($message !== ""): ?>
                <p><?= htmlspecialchars($message, ENT_QUOTES, 'UTF-8') ?></p>
            <?php endif; ?>
            <form class="formulaire_mdp"
                  action="profile.php"
                  method="post">
                <input
                        type="hidden"
                        name="csrf_token"
                        value="<?= htmlspecialchars($_SESSION["csrf_token"], ENT_QUOTES, 'UTF-8') ?>"
                >
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
                <input
                        type="hidden"
                        name="csrf_token"
                        value="<?= htmlspecialchars($_SESSION["csrf_token"], ENT_QUOTES, 'UTF-8') ?>"
                >
                <button
                    class="bouton_deconnexion"
                    type="submit"
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