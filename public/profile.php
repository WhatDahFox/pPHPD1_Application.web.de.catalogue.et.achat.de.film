
<?php
session_start();

// Vérifier que l'utilisateur est connecté
if (!isset($_SESSION["utilisateur"]["id_utilisateur"])) {
    header("Location: login.php");
    exit();
}

$utilisateur = $_SESSION["utilisateur"];
$message = "";
$messageType = "";

// Connexion à la base de données
require_once __DIR__ . "/../config/database.php";

// Modification du mot de passe
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $ancienPassword = $_POST["mdp_actuel"] ?? "";
    $nouveauPassword = $_POST["nouveau_mdp"] ?? "";
    $confirmation = $_POST["confirmation_mdp"] ?? "";

    if (empty($ancienPassword) || empty($nouveauPassword) || empty($confirmation)) {
        $message = "Veuillez remplir tous les champs.";
    } elseif (strlen($nouveauPassword) < 8) {
        $message = "Le nouveau mot de passe doit contenir 8 caractères minimum.";
    } elseif ($nouveauPassword !== $confirmation) {
        $message = "Les nouveaux mots de passe sont différents.";
    } else {
        try {
            // Récupérer le mot de passe actuel
            $sql = "SELECT mdp FROM utilisateur WHERE id_utilisateur = ?";
            $requete = $pdo->prepare($sql);
            $requete->execute([$utilisateur["id_utilisateur"]]);
            $compte = $requete->fetch(PDO::FETCH_ASSOC);

            if (!$compte || !password_verify($ancienPassword, $compte["mdp"])) {
                $message = "Le mot de passe actuel est incorrect.";
            } else {
                // Enregistrer le nouveau mot de passe sécurisé
                $hash = password_hash($nouveauPassword, PASSWORD_DEFAULT);

                $sql = "UPDATE utilisateur SET mdp = ? WHERE id_utilisateur = ?";
                $requete = $pdo->prepare($sql);
                $requete->execute([$hash, $utilisateur["id_utilisateur"]]);

                $message = "Votre mot de passe a été modifié.";
                $messageType = "succes";
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

// Récupérer les films achetés
try {
    $sql = "SELECT
                f.id_film,
                f.titre,
                f.affiche,
                c.date_commande,
                co.prix_achat,
                co.quantite
            FROM commande c
            INNER JOIN contenant co ON c.id_commande = co.id_commande
            INNER JOIN film f ON co.id_film = f.id_film
            WHERE c.id_utilisateur = ?
            ORDER BY c.date_commande DESC";

    $requete = $pdo->prepare($sql);
    $requete->execute([$utilisateur["id_utilisateur"]]);
    $achats = $requete->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    error_log($e->getMessage());
    $achats = [];
    $erreurAchats = true;
}
?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon profil | Bob'ines</title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/profile.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>
        <h1>Mon profil</h1>

        <!-- Informations du compte -->
        <section class="section_page section_profil">
            <h2 class="titre_section">Mes informations</h2>

            <div class="contenu_profil">
                <p>
                    <strong>Nom :</strong>
                    <?= htmlspecialchars($utilisateur["nom"]) ?>
                </p>

                <p>
                    <strong>Adresse mail :</strong>
                    <?= htmlspecialchars($utilisateur["email"]) ?>
                </p>
            </div>
        </section>

        <!-- Historique des achats -->
        <section class="section_page section_achats">
            <h2 class="titre_section">Ma collection</h2>

            <div class="liste_films">

                <?php if (isset($erreurAchats)): ?>

                    <p>Impossible de récupérer votre collection pour le moment.</p>

                <?php elseif (empty($achats)): ?>

                    <p>Vous n'avez encore acheté aucun film.</p>

                <?php else: ?>

                    <?php foreach ($achats as $achat): ?>

                        <?php
                        $affiche = !empty($achat["affiche"])
                            ? $achat["affiche"]
                            : "./images/affiche_indisponible.png";
                        ?>

                        <article class="ligne_achat">

                            <img
                                class="affiche_achat"
                                src="<?= htmlspecialchars($affiche) ?>"
                                alt="Affiche de <?= htmlspecialchars($achat["titre"]) ?>"
                                onerror="this.onerror=null;this.src='./images/affiche_indisponible.png';"
                            >

                            <div class="informations_achat">

                                <h3 class="titre_film">
                                    <?= htmlspecialchars($achat["titre"]) ?>
                                </h3>

                                <p>
                                    Date d'achat :
                                    <?= date("d/m/Y", strtotime($achat["date_commande"])) ?>
                                </p>

                                <p>
                                    Quantité : <?= (int) $achat["quantite"] ?>
                                </p>

                                <p>
                                    Prix payé :
                                    <?= number_format($achat["prix_achat"] * $achat["quantite"], 2, ',', ' ') ?> €
                                </p>

                                <a href="movie.php?id=<?= (int) $achat["id_film"] ?>">
                                    Voir les détails du film
                                </a>

                            </div>
                        </article>

                    <?php endforeach; ?>

                <?php endif; ?>

            </div>
        </section>

        <!-- Modification du mot de passe -->
        <section class="section_page section_mdp">
            <h2 class="titre_section">Modifier mon mot de passe</h2>

            <?php if ($message !== ""): ?>
                <p><?= htmlspecialchars($message) ?></p>
            <?php endif; ?>

            <form class="formulaire_mdp" action="profile.php" method="post">

                <div class="champ_profil">
                    <label for="mdp_actuel">Mot de passe actuel</label>
                    <input
                        id="mdp_actuel"
                        name="mdp_actuel"
                        type="password"
                        autocomplete="current-password"
                        required
                    >
                </div>

                <div class="champ_profil">
                    <label for="nouveau_mdp">Nouveau mot de passe</label>
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
                    <label for="confirmation_mdp">Confirmer le nouveau mot de passe</label>
                    <input
                        id="confirmation_mdp"
                        name="confirmation_mdp"
                        type="password"
                        autocomplete="new-password"
                        minlength="8"
                        required
                    >
                </div>

                <button class="bouton_modifier_mdp" type="submit">
                    Modifier le mot de passe
                </button>

            </form>
        </section>

        <!-- Déconnexion -->
        <section class="section_page section_deconnexion">
            <h2 class="titre_section">Déconnexion</h2>

            <form action="logout.php" method="post">
                <button class="bouton_deconnexion" type="submit">
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
