# Séance 7 - Génération de cate avec `leaflet` dans `streamlit`

Nous allons voir ici l'utilisation de la librairie [`folium`](https://python-visualization.github.io/folium/latest/), qui permet de générer en python des cartes [`leaflet`](https://leafletjs.com), librairie Javascript probablement la plus utilisée pour créer des cartes dans une application web.

Pour mettre en place notre application, nous devons déjà suivre les opérations suivantes, comme dans la séance 6 :

- Créer un répertoire dédiée à l'application
- Lancer *Visual Studio Code*
- Ouvrir le répertoire créé
- Créer un fichier `app.py`
- Créer un environnement virtuel
- Activer l'environnement virtuel
- Installer les packages : `streamlit` et `streamlit-folium`

## Affichage d'une carte simple

Pour créer une carte simple nous, voici le début de code à placer dans le fichier `app.py`. Notez qu'il faut créer la carte (avec la fonction `Map()` de lalibrairie `folium`), puis l'ajouter à l'application avec la fonction `st_folium()` de `streamlit_folium`

```python
import folium
from streamlit_folium import st_folium

centre = [48.866667, 2.333333]
m = folium.Map(location = centre, zoom_start = 12)
st_folium(m)
```

Ici, nous affichons une carte, avec les tuiles classiques fournies par `OpenStreetMap`, centrée sur Paris (la liste `centre` contient respectivement la latitude et la longitude du centre de Paris). Le zoom de départ est fixé à 12, ce qui correspond à l'affichage de l'ensemble de la ville de Paris dans notre cas.

## Changement des tuiles de fond

Il existe beaucoup de différents fournisseurs de tuiles, qu'il est possible de tester sur [cette page](http://leaflet-extras.github.io/leaflet-providers/preview/index.html). Dans la suite, nous allons utiliser les tuiles de *CartoDB*, et particulièrement le modèle *Positron*. Pour cela, il faut juste préciser dans la création de la carte le fournisseur choisi.

```python
m = folium.Map(location = centre, zoom_start = 12, tiles = "cartodbpositron")
```

## Récupération de la position de clic

Si on veut savoir où clique l'utilisateur, on a juste à récupérer le contenu de `st_folium()` dans une variable. Celle-ci contient la position de clic, et d'autres informations qui peuvent donc servir pour gérer les interactions.

```python
info_clic = st_folium(m)
info_clic
```

## Ajout de marqueurs

On a tous déjà vu une carte avec des marqueurs, qu'il est donc possible d'ajouter un par un, s'il y en a peu. On ajoute ici un marqueur au centre de Paris. Et un autre marqueur sur l'IUT.

```python
folium.Marker(centre, popup = "Centre de Paris", tooltip = "Paris centre").add_to(m)
folium.Marker([48.841983, 2.267919], popup = "IUT Paris-Rives de Seine", tooltip = "IUT").add_to(m)
```

## Ajout de beaucoup de marqueurs

**Attention**, dans la suite, nous travaillons sur des [restaurants new-yorkais]("restaurants_ok.csv") (fichier à télécharger et à placer dans le répertoire de l'application). Nous devons changer le centre de la carte, ainsi que le zoom pour voir plus large.

```python
centre = [40.7,-73.95]
m = folium.Map(location = centre, zoom_start = 10, tiles = "cartodbpositron")
```

Mais si le nombre de marqueurs augmente, il n'est pas possible de gérer un par un. Il faut ajouter donc des *clusters* de marqueurs, que l'on peut ajouter comme suit. 

```python
from folium.plugins import MarkerCluster

df = pandas.read_csv("restaurants_ok.csv", nrows = 1000)

marker_cluster = MarkerCluster().add_to(m)
for index, row in df.iterrows() :
    folium.Marker(location = [row["lat"], row["lng"]]).add_to(marker_cluster)
```

> Il faut cependant noter que cette méthode, assez flexible sur le contenu qu'on peut mettre dans le marqueur (pop-up, tooltip, style...), est très lente si le nombre de marqueurs dépasse 1000.

## Idem mais en version rapide

Si on veut juste ajouter des marqueurs, sans utiliser la flexibilité de `MarkerCluster()`, on peut utiliser la version rapide `FastMarkerCluster()`, qui fonctionne très bien, même avec les 25000 restaurants à afficher.

```python
from folium.plugins import FastMarkerCluster

df = pandas.read_csv("restaurants_ok.csv")

FastMarkerCluster(data = list(zip(df.lat, df.lng))).add_to(m)
```

## Ajout de polygones

Pour faire des cartes choroplèthes comme nous allons le voir plus loin, il est nécessaire d'importer les contours des quartiers, présents dans ce [fichier GeoJSON]("new-york-city-boroughs.geojson"). Nous l'importons avec la librairie `json`. L'ajout permet juste de visualiser les polygones.

```python
import json

geojson_data = json.load(open("new-york-city-boroughs.geojson"))

folium.GeoJson(geojson_data, name="hello world").add_to(m)
```

## Carte choroplète

Pour *colorier* chaque polygone, nous devons avoir une statistique à utiliser. Ici, nous calculons pour chaque quartier le nombre de restaurants présents dans celui-ci.

```python
resume = df.filter(["borough", "restaurant_id"]).groupby("borough").count().reset_index()
resume.columns = ["name", "nb_restaurants"]
```

La fonction `Choropleth()` permet donc de créer les cartes voulues. Elle prends en paramètre deux types de données :

- `geo_data` : les polygones à afficher
    - Noter que le nom du quartier est dnas le champs `name` du champs `properties` pour chaque `feature` (polygone)
- `data` : le dataframe contenant une variable de jointure avec la variable précédente et (au moins) une variable contenant une statistique à afficher

```python
choro = folium.Choropleth(
    geo_data = geojson_data,
    name = "choropleth",
    data = resume,
    columns = ["name", "nb_restaurants"],
    key_on = "feature.properties.name",
    fill_color = "YlGn",
    fill_opacity = 0.7,
    line_opacity = 0.2,
    legend_name = "Nombre de restaurants par quartier"
).add_to(m)
```

> Noter que nous sauvons le contenu de la carte dans une variable pour ce qui suit, mais la carte peut s'afficher sans avoir récupérer son résultat.

## Avec ajout d'un `tooltip`

Pour améliorer la carte, il est intéressant d'ajouter un *tooltip* (fenêtre qui s'affiche lorsque la souris passe au-dessus d'un polygone). Pour cela, nous devons déjà ajouter les informations à ajouter au champs `properties` dans les données GeoJSON, ce que fait le code ci-après.

```python
for row in choro.geojson.data['features']:
    q = row['properties']['name']
    nb = resume.query("name == @q")["nb_restaurants"].iloc[0]
    row['properties']['nb'] = int(nb)
```

On peut maintenant ajouter à la carte choroplèthe ce tooltip, en indiquant quelles variables prendre, et quelles chaînes de caractères mettre avant pour la présentation.

```python
folium.GeoJsonTooltip(['name','nb'], aliases = ['Quartier : ','Nombre de restaurants : ']).add_to(choro.geojson)
```

## Code final

```python
import pandas
import json
import folium
from streamlit_folium import st_folium

centre = [40.7,-73.95]
m = folium.Map(location = centre, zoom_start = 10, tiles = "cartodbpositron")

geojson_data = json.load(open("new-york-city-boroughs.geojson"))
df = pandas.read_csv("restaurants_ok.csv")

resume = df.filter(["borough", "restaurant_id"]).groupby("borough").count().reset_index()
resume.columns = ["name", "nb_restaurants"]

choro = folium.Choropleth(
    geo_data = geojson_data,
    name = "choropleth",
    data = resume,
    columns = ["name", "nb_restaurants"],
    key_on = "feature.properties.name",
    fill_color = "YlGn",
    fill_opacity = 0.7,
    line_opacity = 0.2,
    legend_name = "Nombre de restaurants par quartier"
).add_to(m)

for row in choro.geojson.data['features']:
    q = row['properties']['name']
    nb = resume.query("name == @q")["nb_restaurants"].iloc[0]
    row['properties']['nb'] = int(nb)

folium.GeoJsonTooltip(['name','nb'], aliases = ['Quartier : ','Nombre de restaurants : ']).add_to(choro.geojson)

st_folium(m)
```

