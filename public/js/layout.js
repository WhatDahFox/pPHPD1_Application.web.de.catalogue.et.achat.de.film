/* ==============================================
1. Création du header
============================================== */

const header = document.querySelector(".header");

header.innerHTML = `
        <a id="logo" href="/index.php">
            <img class="logo" src="/images/logo.png" alt="Bob'ines - Accueil">
        </a>
        <nav class="menu_header">
            <a href="/index.php"> Accueil </a>
            <a href="/category.php"> Catégories </a>
            <a href="/search.php"> Recherche </a>
            <a href="/cart.php"> Panier </a>
            <a href="/profile.php"> Mon profil </a>
            <a href="/login.php"> Connexion </a>
        </nav>
`;

/* ==============================================
2. Création du footer
============================================== */

const footer = document.querySelector("footer");

footer.innerHTML = `
        <nav class="menu_footer_navigation">
            <h2> Navigation </h2>
            <a href="/index.php"> Accueil </a>
            <a href="/category.php"> Catégories </a>
            <a href="/search.php"> Recherche </a>
        </nav>
        <div class="informations">
            <h2> Bob'ines </h2>
            <p> Votre cinéma à la maison.</p>
            <p> © Site réalisé par Nathan RENARD & Romain DECUSSY.
                <br> Tous droits réservés. </p>
        </div>
        <nav class="menu_footer_utilisateur">
            <h2> Utilisateur </h2>
            <a href="/login.php"> Connexion </a>
            <a href="/profile.php"> Mon profil </a>
            <a href="/cart.php"> Panier </a>
        </nav>
`;