<?php

$message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST"){


 $nom = trim($_POST["nom"]??"");
 $email = trim($_POST["email"]??"");
 $password = $_POST["password"]??"";
 $confirmation = $_POST["confirmation"]??"";



 if (empty($nom)|| empty($email)|| empty($password)||empty($confirmation)){
    $message = "Veuillez remplir tous les champs.";
 }

 elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)){
    $message = "Adresse email invalide.";
 }

 elseif (strlen($password)< 8){
    $message = "Le mot de passe doit contenir 8 caractères minimum.";
 }

 elseif($password !== $confirmation){
    $message = "Les mots de passe sont différents.";
 }
 else{
    // Partie MYSQL valide 
     /*
        require_once __DIR__ . "/../config/database.php";

        // Vérifier si l'email existe déjà
        $sql = "SELECT id FROM users WHERE email = ?";
        $requete = $pdo->prepare($sql);
        $requete->execute([$email]);

        if ($requete->fetch()) {
            $message = "Cet email est déjà utilisé.";
        }
        else {
            // Sécuriser le mot de passe
            $hash = password_hash($password, PASSWORD_DEFAULT);

            // Ajouter l'utilisateur
            $sql = "INSERT INTO users (nom, email, password_hash)
                    VALUES (?, ?, ?)";

            $requete = $pdo->prepare($sql);
            $requete->execute([$nom, $email, $hash]);

            header("Location: login.php");
            exit();
        }
        */
        $message = "Formulaire valide ! Enregistrement en attente de MySQL.";

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
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

<header class="bloc header">
    <!-- Insertion header en JS -->
</header>

<main>
<h1>Créer un compte </h1>

<p><?= htmlspecialchars($message)?></p>

<form method="POST" action="register.php">

<label>Nom :</label>
<input type="text" name="nom" required>

<label>Email :</label>
<input type="email" name="email" required>

<label>Mot de passe :</label>
<input type="password" name="password" minlength="8" required>

<label>Confirmer le mot de passe :</label>
<input type="password" name="confirmation" minlength="8" required>

<button type="submit">S'inscrire</button>

</form>

<p>
    Déjà inscrit ?
    <a href="login.php">Se connecter</a>
</p>

</main>

<footer class="bloc footer">
    <!-- Insertion footer en JS -->
</footer>

<script type="module" src="./js/layout.js"></script>

</body>
</html>