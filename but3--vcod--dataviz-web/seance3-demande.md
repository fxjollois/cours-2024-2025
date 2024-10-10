# Séance 3

> Rendu des fichiers sur cet espace : <https://moodle.u-paris.fr/mod/assign/view.php?id=1222039>

Nous allons travailler sur une liste de 23530 films sorties en salle, et notés sur les sites [*Rotten Tomatoes*](https://www.rottentomatoes.com/) et [*IMDB*](https://www.imdb.com/). Nous utiliserons 4 fichiers javascript, contenant chacun la déclaration d'une variable JSON :

- [top_genres.js](seance3/top_genres.js) : Nombre de films par genre, ordonné
- [evol_genres.js](seance3/evol_genres.js) : Nombre de films par genre et par année
- [top_films_Rotten.js](seance3/top_films_Rotten.js) : Liste des films avec les notes, et leur genre (jusqu'à 3 genres possibles)
- [top_films_IMDB.js](seance3/top_films_IMDB.js) : Liste des films avec les notes, et leur genre (jusqu'à 3 genres possibles)

A partir de ces données, on veut produire un tableau de bord ressemblant à la page ci-dessous, avec 4 graphiques  :

1. Nombre de films par genre 
    - Diagramme en barres
    - Même couleur de départ pour toutes les barres (à définir et choisir)
    - Lors d'un clic souris sur une barre, passage à une couleur spécifique pour le genre sélectionné et une couleur moins intense pour les autres (à votre guise)
    - Déselection lors d'un double-clic
2. Evolution du nombre de films pour chaque genre
    - Ensemble de séries temporelles
    - Même couleur de départ pour toutes les séries
    - Lors de la sélection d'un genre dans le graphique 1, passage à une couleur spécifique (idéalement la même qu'au-dessus) pour le genre sélectionné (et les autres moins intenses)
    - Si désélection, retour aux couleurs d'origine
3. (et 4.) TOP 15 des films les mieux notés (sur *Rotten Tomatoes* à gauche et sur *IMDB* à droite)
    - Diagramme en barres
    - Affichage du titre et de l'année de sortie du film lors du passage de la souris au-dessus d'une barre
    - Lors de la sélection d'un genre dans le graphique 1, affichage des meilleurs films de ce genre
    - Si désélection, retour aux couleurs d'origine


**BONUS** : Ajout d'un bouton permettant d'avoir des FLOP 15 (films les moins bien notés)

<iframe src="seance3/resultat_voulu.html" style="width: 100%;min-width: 800px;min-height: 600px"></iframe>

