<?php 

session_start();

$connecte = isset($_SESSION["utilisateur"]);

if (!isset($_SESSION["utilisateur"])){
    header("Location: login.php");
    exit();
    }
 
$utilisateur = $_SESSION["utilisateur"];

//Message afficher 
$message = "";

//Verifie si le formulaire est envoyé
if ($_SERVER["REQUEST_METHOD"] == "POST"){

    $nouveauPassword = $_POST["nouveau_password"]?? "";
    $confirmation = $_POST["confirmation"] ?? "";

    if(strlen($nouveauPassword)<8){
        $message = "Le mot de passe doit contenir au moins 8 caractères.";

    }

    elseif ($nouveauPassword !==$confirmation){
        $message = "Les mots de passe sont différents.";
    }

    else{
        //Modif a faire avec MySQL
        $message = "Formulaire valide ! Modification en attente de MySQL.";
    }
}

?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Mon profil| Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

<header class="bloc header">
    <!-- Insertion header en JS -->
</header>

<main>

    <h1>Mon profil</h1>

        <h2>Mes informations </h2>
        <p>
            Nom : 
            <?= htmlspecialchars($utilisateur["nom"]) ?>
        </p>

        <p>
            Email : 
            <?= htmlspecialchars($utilisateur["email"]) ?>
        </p>

        <h2>Historique des achats</h2>

        <p>Aucun achat enregistré pour le moment</p>

        <h2>Modifier le mot de passe </h2>

        <p><?= htmlspecialchars($message) ?></p>

        <form method="POST" action="profile.php">

            <label>Nouveau mot de passe </label>
            <input 
                type="password"
                name="nouveau_password"
                minlength="8"
                required >

            
            <label>Confirmer le mot de passe </label>
            <input 
                type="password"
                name="confirmation"
                minlength="8"
                required >

            <button type="submit">
                Modifier le mot de passe 
            </button>

        </form>

        <h2>Déconnexion</h2>

            <form method="POST" action="logout.php">
            <button type="submit">
                Se déconnecter
            </button>
            </form>
</main>

<footer class="bloc footer">
    <!-- Insertion footer en JS -->
</footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>
