<?php
session_start();

//Verifie si l'utilisateur est connecté
if (isset($_SESSION["utilisateur"])){

     //Redirige vers le profil
    header("Location: login.php");
    exit();
}
$message ="";

if ($_SERVER ["REQUEST_METHOD"] == "POST"){

$email = trim($_POST["email"]?? "");
$password = $_POST["password"]?? "";


if (empty($email)|| empty($password)){
    $message = "Veuillez remplir tous les champs.";

}

elseif (!filter_var($email,FILTER_VALIDATE_EMAIL)){
    $message = "Adresse email invalide.";
}

elseif (
    $email == "test@bobines.fr" &&
    $password == "Test1234!"
){
    session_regenerate_id(true);

    $_SESSION["utilisateur"] = [
        "nom" => "Utilisateur Test",
        "email" => $email
    ];

    //Redirige vers le profil
    header("Location: profile.php");
    exit();
}

else{
    $message="Email ou mot de passe incorect.";
    }
}
?> 


<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Accueil | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

<header class="bloc header">
    <!-- Insertion header en JS -->
</header>

<main>

    <h1>Se connecter</h1>

    <p><?= htmlspecialchars($message) ?></p>

    <form method="POST" action="login.php">

    <label>Email :</label>
    <input type="email" name="email" required>

    <label>Mot de passe :</label>
    <input type="password" name="password" required>
    
    <button type="submit">Se connecter </button>

    </form>

    <p>
        Pas encore inscrit ?
        <a href="register.php">Crée un compte</a>
    </p>
</main>

<footer class="bloc footer">
    <!-- Insertion footer en JS -->
</footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>