# Séance 7 : demande

## Données

Nous allons travailler sur les données AirBnB de la ville de Paris. Le site [InsideAirBnB](http://insideairbnb.com/get-the-data) permet de récupérer l'ensemble des logements proposés sur AirBnB sur certaines villes du monde entier. Ce sont des snapshots pris sur une journée spécifique (indiquée), et l'ensemble des variables sont expliquées sur [cette page](https://docs.google.com/spreadsheets/d/1iWCNJcSutYqpULSQHlNyGInUvHg2BoUGoNRIGa6Szc4/edit#gid=1938308660).

Le fichier de base est celui sur Paris, datant du 6 septembre 2024, disponible à l'adresse suivante :

<https://data.insideairbnb.com/france/ile-de-france/paris/2024-09-06/visualisations/listings.csv>

Les contours des arrondissements parisiens, fournis aussi par InsideAirBnB, sont eux disponibles à cette adresse :

<https://data.insideairbnb.com/france/ile-de-france/paris/2024-09-06/visualisations/neighbourhoods.geojson>

## Demande

A partir de ces deux fichiers, vous devez créer une application web sur les logements AirBnB à Paris. Pour cela, vous devez suivre les contraintes suivantes :

- un premier onglet avec un ensemble de graphiques et d'informations sur les variables suivantes :
    - type de logement (`room_type`)
    - prix (`price`)
    - carte globale de Paris avec un (petit) point pour chaque logement (cf [`CircleMarker()`](https://python-visualization.github.io/folium/latest/user_guide/vector_layers/circle_and_circle_marker.html) dans folium)
- un deuxième onglet avec une carte choroplèthe, pour laquelle on peut choisir la statistique représentée :
    - nombre de logements
    - prix moyen
    - part de logement entier
- un troisième onglet, représentant les parts de type de logement par arrondissement
    - de type [small mutiples](http://www.juiceanalytics.com/writing/better-know-visualization-small-multiples)


### Rendu

A faire sur Moodle :

<https://moodle.u-paris.fr/mod/assign/view.php?id=1303975>

