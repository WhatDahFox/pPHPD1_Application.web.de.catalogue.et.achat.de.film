<?php

session_start();

//Verifie si l'utilisateur est connecté
if (!isset($_SESSION["utilisateur"])){

     //Redirige vers le profil
    header("Location: login.php");
    exit();
}

if (!isset($_SESSION["panier"])){
    $_SESSION["panier"]=[];
}

$films = [
    1=> ["titre"=>"Film Action", "prix" => 12.99],
    2=> ["titre"=>"Film Drame", "prix" => 9.99]
];

if($_SERVER ["REQUEST_METHOD"] == "POST"){

    //Récupère l'id du film 
    $id = (int) ($_POST["id"]?? 0);

    //Ajout du Film au panier 
    if (isset($_POST["ajouter"])&& isset($films[$id])) {
        $_SESSION["panier"][$id]=
        ($_SESSION["panier"][$id]?? 0) + 1;
    }

    //Supprime le film du panier 
    if (isset($_POST["supprimer"])){
        unset($_SESSION["panier"][$id]);
    }

    //F5 de la page 
    header("Location: cart.php");
    exit();
}

//Calcul du panier 
$total = 0;

foreach ($_SESSION["panier"]as $id=> $quantite){
    if(isset($films[$id])){
        $total += $films[$id]["prix"] * $quantite;
    }
}

?>


<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Panier | Bob'ines </title>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="conteneur">

    <header class="bloc header">
        <!-- Insertion header en JS -->
    </header>

    <main>

    <h1>Mon panier </h1>

    <h2>Films disponibles (test)</h2>

    <?php foreach ($films as $id => $film): ?>

    <p>
        <?= htmlspecialchars($film["titre"]) ?>
        -
        <?= number_format($film["prix"],2,",","") ?> €
    </p>
 
    <form method="POST" action="cart.php">
        <input type="hidden" name="id" value="<?= $id ?>">
        <button type="submit" name="ajouter">
            Ajouter au panier 
        </button>

    </form>

    <?php endforeach; ?>

    <h2>Contenu du panier</h2>
    
    <?php if (empty($_SESSION["panier"])): ?>
        <p>Votre panier est vide.</p>

        <?php else : ?>
            <?php foreach ($_SESSION["panier"]as $id => $quantite): ?>
                <?php if (isset($films[$id])): ?>

                    <p>
                        <?= htmlspecialchars($films[$id]["titre"]) ?>
                        -
                        Quantité : <?= $quantite ?>
                        -
                        <?= number_format(
                            $films[$id]["prix"]* $quantite,
                            2, ",",""
                        ) ?>€
                    </p>

                    <form method="POST" action="cart.php">
                           <input type="hidden" name="id" value="<?= $id ?>">
                             <button type="submit" name="supprimer">
                               Supprimer 
                                </button>
                    </form>
                
                <?php endif; ?>

            <?php endforeach; ?>

            <?php endif; ?>

        <h2>
            Total : <?= number_format ($total, 2,","," ") ?>€
        </h2>

    </main>

    <footer class="bloc footer">
        <!-- Insertion footer en JS -->
    </footer>

    <script type="module" src="./js/layout.js"></script>

</body>
</html>