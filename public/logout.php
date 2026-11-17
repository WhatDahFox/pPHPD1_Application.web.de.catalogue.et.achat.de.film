<?php

//Démarre la session 
session_start();

//Supprime les infos de connexion
unset($_SESSION["utilisateur"]);

//Redirige vers la page de connexion
header("Location: login.php");
exit();

?>