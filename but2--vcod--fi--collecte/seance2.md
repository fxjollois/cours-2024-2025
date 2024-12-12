# Séance 2 : compléments sur API

**Open Data Soft** a développé un outil de gestion des données ouvertes, qui est de plus en plus utilisé, en particulier par la mairie de Paris. Vous pouvez trouver l'aide en ligne à cette adresse : 

<https://help.opendatasoft.com/apis/ods-explore-v2/explore_v2.1.html>

L'intérêt d'interroger l'API directement est que les opérations sur la base seront faites par le serveur, et non pas sur votre machine. Ce qui est très intéressant, en particulier dans le cas de travail en temps réel (création d'une appli mobile sur la base d'une API par exemple ou d'un tableau de bord temps réel) ou de travail sur des données très importantes (plusieurs giga octets, voire plus).

**ATTENTION** : Comme vous pourrez le voir, les requêtes sont envoyées sous la forme d'une chaîne de caractères. Il faut donc faire usage des `""` pour la chaîne globale, et des `''` pour les chaînes passées en paramètre dans cette chaîne globale (ou l'inverse).

## API Vélib

Nous allons voir l'utilisation de cet outil en interrogeant l'API Velib, proposée par la mairie de Paris. Toutes les informations sont disponibles à cette adresse :

<https://opendata.paris.fr/explore/dataset/velib-disponibilite-en-temps-reel/api/>

Comme vous le verrez, on utilise les mêmes concepts qu'en SQL.

### Premier essai

L'interrogation se fait, sous Python, avec la fonction `get()` de la librairie `requests` (normalement déjà présente). Le résultat peut être transformé en `JSON` (puis en dictionnaire sous Python) grâce à la fonction `json()` sur celui-ci.

On obtient un objet ayant deux composantes (si tout va bien) :

- `total_counts` : le nombre d'éléments correspondant à la requête (ici, le nombre de stations) ;
- `results` : un tableau contenant une partie des résultats.

Par défaut, la limite est de 10 éléments.


```python
import requests

url_base = "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/velib-disponibilite-en-temps-reel/records"
resultat = requests.get(url_base).json()
resultat
```




    {'total_count': 1486,
     'results': [{'stationcode': '16107',
       'name': 'Benjamin Godard - Victor Hugo',
       'is_installed': 'OUI',
       'capacity': 35,
       'numdocksavailable': 28,
       'numbikesavailable': 7,
       'mechanical': 6,
       'ebike': 1,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:27:18+00:00',
       'coordonnees_geo': {'lon': 2.275725, 'lat': 48.865983},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '11104',
       'name': 'Charonne - Robert et Sonia Delaunay',
       'is_installed': 'OUI',
       'capacity': 20,
       'numdocksavailable': 20,
       'numbikesavailable': 0,
       'mechanical': 0,
       'ebike': 0,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:23:20+00:00',
       'coordonnees_geo': {'lon': 2.3925706744194, 'lat': 48.855907555969},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '7002',
       'name': 'Vaneau - Sèvres',
       'is_installed': 'OUI',
       'capacity': 35,
       'numdocksavailable': 3,
       'numbikesavailable': 26,
       'mechanical': 17,
       'ebike': 9,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:28:01+00:00',
       'coordonnees_geo': {'lon': 2.3204218259346, 'lat': 48.848563233059},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '5110',
       'name': 'Lacépède - Monge',
       'is_installed': 'OUI',
       'capacity': 23,
       'numdocksavailable': 20,
       'numbikesavailable': 3,
       'mechanical': 2,
       'ebike': 1,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:26:08+00:00',
       'coordonnees_geo': {'lon': 2.3519663885235786, 'lat': 48.84389286531899},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '6108',
       'name': 'Saint-Romain - Cherche-Midi',
       'is_installed': 'OUI',
       'capacity': 17,
       'numdocksavailable': 2,
       'numbikesavailable': 14,
       'mechanical': 12,
       'ebike': 2,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:27:23+00:00',
       'coordonnees_geo': {'lon': 2.321374788880348, 'lat': 48.84708159081946},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '33006',
       'name': 'André Karman - République',
       'is_installed': 'OUI',
       'capacity': 31,
       'numdocksavailable': 22,
       'numbikesavailable': 6,
       'mechanical': 3,
       'ebike': 3,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:20:15+00:00',
       'coordonnees_geo': {'lon': 2.3851355910301213, 'lat': 48.91039875761846},
       'nom_arrondissement_communes': 'Aubervilliers',
       'code_insee_commune': '93001'},
      {'stationcode': '42016',
       'name': 'Pierre et Marie Curie - Maurice Thorez',
       'is_installed': 'OUI',
       'capacity': 27,
       'numdocksavailable': 25,
       'numbikesavailable': 2,
       'mechanical': 1,
       'ebike': 1,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:23:32+00:00',
       'coordonnees_geo': {'lon': 2.376804985105991, 'lat': 48.81580226360801},
       'nom_arrondissement_communes': 'Ivry-sur-Seine',
       'code_insee_commune': '94041'},
      {'stationcode': '40011',
       'name': 'Bas du Mont-Mesly',
       'is_installed': 'NON',
       'capacity': 1,
       'numdocksavailable': 1,
       'numbikesavailable': 0,
       'mechanical': 0,
       'ebike': 0,
       'is_renting': 'NON',
       'is_returning': 'NON',
       'duedate': '2024-08-29T11:13:08+00:00',
       'coordonnees_geo': {'lon': 2.4609763908985, 'lat': 48.779035118572},
       'nom_arrondissement_communes': 'Créteil',
       'code_insee_commune': '94028'},
      {'stationcode': '21010',
       'name': 'Silly - Galliéni',
       'is_installed': 'OUI',
       'capacity': 25,
       'numdocksavailable': 15,
       'numbikesavailable': 10,
       'mechanical': 7,
       'ebike': 3,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:24:30+00:00',
       'coordonnees_geo': {'lon': 2.2325500845909, 'lat': 48.835583838706},
       'nom_arrondissement_communes': 'Boulogne-Billancourt',
       'code_insee_commune': '92012'},
      {'stationcode': '17041',
       'name': 'Guersant - Gouvion-Saint-Cyr',
       'is_installed': 'OUI',
       'capacity': 36,
       'numdocksavailable': 30,
       'numbikesavailable': 6,
       'mechanical': 4,
       'ebike': 2,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-12T10:27:24+00:00',
       'coordonnees_geo': {'lon': 2.287667370814871, 'lat': 48.88287775178599},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'}]}



#### Et si on essaie de tout récupérer

La première idée est de mettre le paramètre `limit` au maximum de ce qu'on doit obtenir comme résultat, pour tout récupérer d'un coup.

Comme vous pouvez le voir ci-dessous, il n'est pas possible de demander plus de 100 élèments en une fois (sauf certaines opérations que l'on verra plus loin).


```python
requests.get(url_base + "?limit=" + str(resultat["total_count"])).json()
```




    {'error_code': 'InvalidRESTParameterError',
     'message': 'Invalid value for limit API parameter: 1486 was found but -1 <= limit <= 100 is expected.'}



#### Comment tout obtenir alors ?

Pour récupérer tous les éléments dans un tel cas, il est nécessaire de faire une boucle et d'utiliser le paramètre `offset` qui permet de passer les premiers résultats.

Le code ci-dessous permet donc de récupérer toutes les stations dans la liste `resultat_final`.


```python
resultat_final = []
for i in range(0, resultat["total_count"], 100):
    temp = requests.get(url_base + "?limit=100&offset=" + str(i)).json()
    resultat_final += temp["results"]

# on trouve bien nos 1484 résultats
len(resultat_final)
```




    1486



#### Que faire des résultats ?

Pour nos besoins ultérieurs (en analyse, calculs, graphiques...), il est intéressant de voir qu'on peut transformer ce résultat `JSON` en un dataframe `pandas` très facilement (cf ci-dessous).


```python
import pandas

data = pandas.DataFrame(resultat_final)
data
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>stationcode</th>
      <th>name</th>
      <th>is_installed</th>
      <th>capacity</th>
      <th>numdocksavailable</th>
      <th>numbikesavailable</th>
      <th>mechanical</th>
      <th>ebike</th>
      <th>is_renting</th>
      <th>is_returning</th>
      <th>duedate</th>
      <th>coordonnees_geo</th>
      <th>nom_arrondissement_communes</th>
      <th>code_insee_commune</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>16107</td>
      <td>Benjamin Godard - Victor Hugo</td>
      <td>OUI</td>
      <td>35</td>
      <td>28</td>
      <td>7</td>
      <td>6</td>
      <td>1</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:27:18+00:00</td>
      <td>{'lon': 2.275725, 'lat': 48.865983}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1</th>
      <td>11104</td>
      <td>Charonne - Robert et Sonia Delaunay</td>
      <td>OUI</td>
      <td>20</td>
      <td>20</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:23:20+00:00</td>
      <td>{'lon': 2.3925706744194, 'lat': 48.855907555969}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>2</th>
      <td>7002</td>
      <td>Vaneau - Sèvres</td>
      <td>OUI</td>
      <td>35</td>
      <td>3</td>
      <td>26</td>
      <td>17</td>
      <td>9</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:28:01+00:00</td>
      <td>{'lon': 2.3204218259346, 'lat': 48.848563233059}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>3</th>
      <td>5110</td>
      <td>Lacépède - Monge</td>
      <td>OUI</td>
      <td>23</td>
      <td>20</td>
      <td>3</td>
      <td>2</td>
      <td>1</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:26:08+00:00</td>
      <td>{'lon': 2.3519663885235786, 'lat': 48.84389286...</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>4</th>
      <td>6108</td>
      <td>Saint-Romain - Cherche-Midi</td>
      <td>OUI</td>
      <td>17</td>
      <td>2</td>
      <td>14</td>
      <td>12</td>
      <td>2</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:27:23+00:00</td>
      <td>{'lon': 2.321374788880348, 'lat': 48.847081590...</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1481</th>
      <td>40002</td>
      <td>Bleuets - Bordières</td>
      <td>NON</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>NON</td>
      <td>NON</td>
      <td>2024-12-12T10:26:30+00:00</td>
      <td>{'lon': 2.4543687905029, 'lat': 48.802117531472}</td>
      <td>Créteil</td>
      <td>94028</td>
    </tr>
    <tr>
      <th>1482</th>
      <td>21302</td>
      <td>Aristide Briand - Place de la Résistance</td>
      <td>OUI</td>
      <td>25</td>
      <td>9</td>
      <td>18</td>
      <td>16</td>
      <td>2</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:28:45+00:00</td>
      <td>{'lon': 2.2511002421379094, 'lat': 48.82124248...</td>
      <td>Issy-les-Moulineaux</td>
      <td>92040</td>
    </tr>
    <tr>
      <th>1483</th>
      <td>8002</td>
      <td>Gare Saint-Lazare - Cour du Havre</td>
      <td>OUI</td>
      <td>45</td>
      <td>13</td>
      <td>29</td>
      <td>23</td>
      <td>6</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:28:34+00:00</td>
      <td>{'lon': 2.3265598341823, 'lat': 48.875674400851}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1484</th>
      <td>12127</td>
      <td>Tremblay - Lac des Minimes</td>
      <td>OUI</td>
      <td>48</td>
      <td>1</td>
      <td>68</td>
      <td>31</td>
      <td>37</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:28:18+00:00</td>
      <td>{'lon': 2.4547516554594, 'lat': 48.834131261494}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1485</th>
      <td>4005</td>
      <td>Quai des Célestins - Henri IV</td>
      <td>OUI</td>
      <td>14</td>
      <td>1</td>
      <td>11</td>
      <td>7</td>
      <td>4</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-12T10:27:16+00:00</td>
      <td>{'lon': 2.3624535, 'lat': 48.8512971}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
  </tbody>
</table>
<p>1486 rows × 14 columns</p>
</div>



En analysant ce résultat, on peut déjà voir qu'on a des stations en double, voire en triple.


```python
data.groupby("stationcode").size().sort_values(ascending=False)
```




    stationcode
    10001    1
    30005    1
    3008     1
    3007     1
    3006     1
            ..
    17017    1
    17016    1
    17015    1
    17013    1
    92008    1
    Length: 1486, dtype: int64



Voici les différentes variables récupérées pour chaque station.


```python
data.columns
```




    Index(['stationcode', 'name', 'is_installed', 'capacity', 'numdocksavailable',
           'numbikesavailable', 'mechanical', 'ebike', 'is_renting',
           'is_returning', 'duedate', 'coordonnees_geo',
           'nom_arrondissement_communes', 'code_insee_commune'],
          dtype='object')



### Restriction et projection

Premières étapes classiques de l'interrogation d'une base de données, quelque soit son format (relationnel, NoSQL, autre), la *restriction* (sélection d'élèments sur la base d'une condition) et la *projection* (sélection de certaines variables) sont bien évidemment possibles avec cet outil.


#### Projection 
Ici, on ne sélectionne que les codes des stations (`stationcode`) et le nom de celles-ci (`name`).


```python
requests.get(url_base + "?select=stationcode,name").json()
```




    {'total_count': 1486,
     'results': [{'stationcode': '16107', 'name': 'Benjamin Godard - Victor Hugo'},
      {'stationcode': '11104', 'name': 'Charonne - Robert et Sonia Delaunay'},
      {'stationcode': '7002', 'name': 'Vaneau - Sèvres'},
      {'stationcode': '5110', 'name': 'Lacépède - Monge'},
      {'stationcode': '6108', 'name': 'Saint-Romain - Cherche-Midi'},
      {'stationcode': '33006', 'name': 'André Karman - République'},
      {'stationcode': '42016', 'name': 'Pierre et Marie Curie - Maurice Thorez'},
      {'stationcode': '40011', 'name': 'Bas du Mont-Mesly'},
      {'stationcode': '21010', 'name': 'Silly - Galliéni'},
      {'stationcode': '17041', 'name': 'Guersant - Gouvion-Saint-Cyr'}]}



#### Restriction

On peut donc aussi faire une restriction avec la clause `where` (on voit qu'on est très proche du langage SQL).

On cherche ici les stations avec une capacité d'accueil supérieure à 30.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30").json()
```




    {'total_count': 633,
     'results': [{'stationcode': '16107', 'capacity': 35},
      {'stationcode': '7002', 'capacity': 35},
      {'stationcode': '33006', 'capacity': 31},
      {'stationcode': '17041', 'capacity': 36},
      {'stationcode': '17026', 'capacity': 40},
      {'stationcode': '13101', 'capacity': 34},
      {'stationcode': '31024', 'capacity': 38},
      {'stationcode': '20143', 'capacity': 44},
      {'stationcode': '17040', 'capacity': 48},
      {'stationcode': '9022', 'capacity': 33}]}



#### Avec tri du résultat

Toujours dans la même idée de faire les mêmes opérations qu'en SQL, on peut trier le résultat avec la clause `order_by`.

Même résultat que précédemment, mais trié par ordre croissant de la capacité.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30&order_by=capacity").json()
```




    {'total_count': 633,
     'results': [{'stationcode': '33006', 'capacity': 31},
      {'stationcode': '5123', 'capacity': 31},
      {'stationcode': '8055', 'capacity': 31},
      {'stationcode': '42503', 'capacity': 31},
      {'stationcode': '22101', 'capacity': 31},
      {'stationcode': '8105', 'capacity': 31},
      {'stationcode': '20117', 'capacity': 31},
      {'stationcode': '19124', 'capacity': 31},
      {'stationcode': '22013', 'capacity': 31},
      {'stationcode': '10110', 'capacity': 31}]}



Et ce tri peut bien évidemment être décroissant en ajoutant `DESC` après le critère de tri.

Toujours même résultat, mais trié par ordre décroissant de la capacité.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30&order_by=capacity DESC").json()
```




    {'total_count': 633,
     'results': [{'stationcode': '7009', 'capacity': 76},
      {'stationcode': '15030', 'capacity': 74},
      {'stationcode': '15028', 'capacity': 71},
      {'stationcode': '5034', 'capacity': 69},
      {'stationcode': '16025', 'capacity': 68},
      {'stationcode': '12106', 'capacity': 68},
      {'stationcode': '12157', 'capacity': 68},
      {'stationcode': '32012', 'capacity': 68},
      {'stationcode': '8004', 'capacity': 67},
      {'stationcode': '1013', 'capacity': 67}]}



#### Combinaisons de conditions

On peut bien évidemment combiner plusieurs conditions avec les différents opérateurs logiques : `AND`, `OR` et `NOT`.

Nous avons ici les stations avec une capacité supérieure à 20, qui ne sont pas en état de laisser la possibilité de louer les vélos.


```python
requests.get(url_base + "?select=stationcode,capacity,is_renting&where=capacity>20 AND is_renting='NON'&limit=100").json()
```




    {'total_count': 18,
     'results': [{'stationcode': '18027', 'capacity': 30, 'is_renting': 'NON'},
      {'stationcode': '3005', 'capacity': 33, 'is_renting': 'NON'},
      {'stationcode': '18010', 'capacity': 26, 'is_renting': 'NON'},
      {'stationcode': '10038', 'capacity': 27, 'is_renting': 'NON'},
      {'stationcode': '40014', 'capacity': 28, 'is_renting': 'NON'},
      {'stationcode': '40015', 'capacity': 24, 'is_renting': 'NON'},
      {'stationcode': '40004', 'capacity': 25, 'is_renting': 'NON'},
      {'stationcode': '34014', 'capacity': 32, 'is_renting': 'NON'},
      {'stationcode': '40001', 'capacity': 28, 'is_renting': 'NON'},
      {'stationcode': '18203', 'capacity': 40, 'is_renting': 'NON'},
      {'stationcode': '44010', 'capacity': 30, 'is_renting': 'NON'},
      {'stationcode': '43003', 'capacity': 26, 'is_renting': 'NON'},
      {'stationcode': '42207', 'capacity': 37, 'is_renting': 'NON'},
      {'stationcode': '15063', 'capacity': 23, 'is_renting': 'NON'},
      {'stationcode': '13048', 'capacity': 28, 'is_renting': 'NON'},
      {'stationcode': '40009', 'capacity': 30, 'is_renting': 'NON'},
      {'stationcode': '8116', 'capacity': 25, 'is_renting': 'NON'},
      {'stationcode': '40008', 'capacity': 44, 'is_renting': 'NON'}]}



#### Recherche dans une chaîne de caractères

On a trois fonctions qui permettent de chercher un chaîne (ou sous-chaîne) de caractères dans une variable (ou même globalement en indiquant `*`), ces premières étant sensibles à la casse :

- `startswidth(champs, 'chaîne')` : cherche les éléments pour lesquels le champs cité débute par la chaîne
- `suggest(champs, 'chaîne')`: cherche les éléments pour lesquels le champs cité contient la chaîne
- `search(champs, 'chaîne')` : cherche les éléments pour lesquels le champs cité est exactement égal à la chaîne

On veut toutes les stations dont le nom commence par "Exelmans".


```python
requests.get(url_base + "?select=stationcode,name&where=startswith(name,'Exelmans')").json()
```




    {'total_count': 2,
     'results': [{'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '16040', 'name': 'Exelmans - Michel-Ange'}]}



On veut toutes les stations dont le nom contient "Versailles".


```python
requests.get(url_base + "?select=stationcode,name&where=suggest(name,'Versailles')").json()
```




    {'total_count': 3,
     'results': [{'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '15203', 'name': 'Porte de Versailles'},
      {'stationcode': '16041', 'name': 'Versailles - Claude Terrasse'}]}



On cherche précisément la station "Exelmans - Versailles".


```python
requests.get(url_base + "?select=stationcode,name&where=search(name,'Exelmans - Versailles')").json()
```




    {'total_count': 1,
     'results': [{'stationcode': '16039', 'name': 'Exelmans - Versailles'}]}



#### Recherche dans une liste

On dispose de l'opérateur `IN (val1, val2, ...)` permettant de tester si un champs a une valeur comprise dans la liste passée à la suite.

On souhaite obtenir les stations dans les villes de Clichy et Colombes.


```python
# clause IN
requests.get(url_base + "?select=stationcode,nom_arrondissement_communes&where=nom_arrondissement_communes IN ('Clichy','Colombes')").json()
```




    {'total_count': 18,
     'results': [{'stationcode': '27005',
       'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '27001', 'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '27002', 'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '27006', 'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '27004', 'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '21114', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21120', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21107', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21104', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21109', 'nom_arrondissement_communes': 'Clichy'}]}



#### Distance à un objet géométrique

Un des points cruciaux actuellement est la géo-localisation, en particulier dans le cadre d'une appli mobile. On peut ainsi requêter la base de données en cherchant, dans ce premier exemple, les éléments pour lesquels la distance entre un point géographique (stocké dans un champs) et un objet géométrique est inférieure à une certaine distance passée en paramètre.

Ici, nous cherchons les stations à moins de 800m de l'IUT Paris-Rives de Seine. Il faut noter que l'ordre des coordonnées (ici longitude et latitude) dépend de la façon dont elles sont stockées dans le champs. 


```python
requests.get(url_base + "?select=stationcode,name&where=within_distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)', 800m)").json()
```




    {'total_count': 15,
     'results': [{'stationcode': '15068',
       'name': 'Général Martial Valin - Pont du Garigliano'},
      {'stationcode': '16032', 'name': "Eglise d'Auteuil"},
      {'stationcode': '15059', 'name': 'Parc André Citroën'},
      {'stationcode': '15057',
       'name': 'Lucien Bossoutrot - Général Martial Vallin'},
      {'stationcode': '16037', 'name': 'Molitor - Michel-Ange'},
      {'stationcode': '16033', 'name': "Marché d'Auteuil"},
      {'stationcode': '16118', 'name': 'Michel-Ange - Parent de Rosan'},
      {'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '15104', 'name': 'Hôpital Européen Georges Pompidou'},
      {'stationcode': '16038', 'name': 'Molitor - Chardon-Lagache'}]}



En complément, on peut en plus récupérer la distance calculée entre ces coordonnées et un objet géométrique.


```python
requests.get(url_base + "?select=stationcode,name,distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)') as distance&where=within_distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)', 800m)").json()
```




    {'total_count': 15,
     'results': [{'stationcode': '15068',
       'name': 'Général Martial Valin - Pont du Garigliano',
       'distance': 458.73543527109746},
      {'stationcode': '16032',
       'name': "Eglise d'Auteuil",
       'distance': 615.2029327979726},
      {'stationcode': '15059',
       'name': 'Parc André Citroën',
       'distance': 759.235801861452},
      {'stationcode': '15057',
       'name': 'Lucien Bossoutrot - Général Martial Vallin',
       'distance': 720.5126894948061},
      {'stationcode': '16037',
       'name': 'Molitor - Michel-Ange',
       'distance': 552.7017995780018},
      {'stationcode': '16033',
       'name': "Marché d'Auteuil",
       'distance': 742.4598347058223},
      {'stationcode': '16118',
       'name': 'Michel-Ange - Parent de Rosan',
       'distance': 710.8022353937183},
      {'stationcode': '16039',
       'name': 'Exelmans - Versailles',
       'distance': 279.35537451504047},
      {'stationcode': '15104',
       'name': 'Hôpital Européen Georges Pompidou',
       'distance': 725.9808199551429},
      {'stationcode': '16038',
       'name': 'Molitor - Chardon-Lagache',
       'distance': 393.6530345752737}]}



#### Comparaison à une zone géographique

La fonction `in_bbox()` teste si un champs est inclus dans une zone géographique rectangulaire, délimitée par deux points.

Ici, on récupère les stations dans un rectangle contenant l'IUT.


```python
requests.get(url_base + "?select=stationcode,name&where=in_bbox(coordonnees_geo,48.84,2.26,48.85,2.27)").json()
```




    {'total_count': 8,
     'results': [{'stationcode': '16034', 'name': "Porte d'Auteuil"},
      {'stationcode': '16032', 'name': "Eglise d'Auteuil"},
      {'stationcode': '16037', 'name': 'Molitor - Michel-Ange'},
      {'stationcode': '16116', 'name': 'George Sand - Jean de La Fontaine'},
      {'stationcode': '16033', 'name': "Marché d'Auteuil"},
      {'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '16038', 'name': 'Molitor - Chardon-Lagache'},
      {'stationcode': '16041', 'name': 'Versailles - Claude Terrasse'}]}



Et ici, celles qui n'y sont pas donc.


```python
requests.get(url_base + "?select=stationcode,name&where=not(in_bbox(coordonnees_geo,48.84,2.26,48.85,2.27))").json()
```




    {'total_count': 1478,
     'results': [{'stationcode': '16107', 'name': 'Benjamin Godard - Victor Hugo'},
      {'stationcode': '11104', 'name': 'Charonne - Robert et Sonia Delaunay'},
      {'stationcode': '7002', 'name': 'Vaneau - Sèvres'},
      {'stationcode': '5110', 'name': 'Lacépède - Monge'},
      {'stationcode': '6108', 'name': 'Saint-Romain - Cherche-Midi'},
      {'stationcode': '33006', 'name': 'André Karman - République'},
      {'stationcode': '42016', 'name': 'Pierre et Marie Curie - Maurice Thorez'},
      {'stationcode': '40011', 'name': 'Bas du Mont-Mesly'},
      {'stationcode': '21010', 'name': 'Silly - Galliéni'},
      {'stationcode': '17041', 'name': 'Guersant - Gouvion-Saint-Cyr'}]}



A noter qu'il existe une fonction permettant de chercher si un point appartient à une zone géographique de type polygone.

### Calcul d'agrégat

On peut aussi demander à l'API de faire un certain nombre de claculs en amont, en particulier des calculs d'agrégats, avec en plus la clause `group_by` qui permet de faire ce cacul pour chaque modalité d'un champs.

Ici, on a le nombre de stations par ville et la capacité totale de celles-ci (10 villes seulement affichées pour raison de place).


```python
requests.get(url_base + "?select=nom_arrondissement_communes,count(*),sum(capacity)&group_by=nom_arrondissement_communes&limit=10").json()
```




    {'results': [{'nom_arrondissement_communes': 'Alfortville',
       'count(*)': 5,
       'sum(capacity)': 122},
      {'nom_arrondissement_communes': 'Arcueil',
       'count(*)': 4,
       'sum(capacity)': 118},
      {'nom_arrondissement_communes': 'Argenteuil',
       'count(*)': 7,
       'sum(capacity)': 225},
      {'nom_arrondissement_communes': 'Asnières-sur-Seine',
       'count(*)': 13,
       'sum(capacity)': 329},
      {'nom_arrondissement_communes': 'Aubervilliers',
       'count(*)': 13,
       'sum(capacity)': 404},
      {'nom_arrondissement_communes': 'Bagneux',
       'count(*)': 6,
       'sum(capacity)': 155},
      {'nom_arrondissement_communes': 'Bagnolet',
       'count(*)': 8,
       'sum(capacity)': 249},
      {'nom_arrondissement_communes': 'Bobigny',
       'count(*)': 5,
       'sum(capacity)': 132},
      {'nom_arrondissement_communes': 'Bois-Colombes',
       'count(*)': 2,
       'sum(capacity)': 60},
      {'nom_arrondissement_communes': 'Boulogne-Billancourt',
       'count(*)': 29,
       'sum(capacity)': 877}]}



On peut bien évidemment ordonner ce résultat pour avoir les villes ayant le plus de stations en premier.


```python
requests.get(url_base + "?select=nom_arrondissement_communes,count(*) as nb_stations,sum(capacity)&group_by=nom_arrondissement_communes&order_by=nb_stations DESC&limit=10").json()
```




    {'results': [{'nom_arrondissement_communes': 'Paris',
       'nb_stations': 993,
       'sum(capacity)': 31896},
      {'nom_arrondissement_communes': 'Boulogne-Billancourt',
       'nb_stations': 29,
       'sum(capacity)': 877},
      {'nom_arrondissement_communes': 'Montreuil',
       'nb_stations': 23,
       'sum(capacity)': 787},
      {'nom_arrondissement_communes': 'Issy-les-Moulineaux',
       'nb_stations': 22,
       'sum(capacity)': 728},
      {'nom_arrondissement_communes': 'Pantin',
       'nb_stations': 21,
       'sum(capacity)': 565},
      {'nom_arrondissement_communes': 'Saint-Denis',
       'nb_stations': 19,
       'sum(capacity)': 666},
      {'nom_arrondissement_communes': 'Ivry-sur-Seine',
       'nb_stations': 18,
       'sum(capacity)': 590},
      {'nom_arrondissement_communes': 'Vitry-sur-Seine',
       'nb_stations': 16,
       'sum(capacity)': 425},
      {'nom_arrondissement_communes': 'Créteil',
       'nb_stations': 14,
       'sum(capacity)': 218},
      {'nom_arrondissement_communes': 'Asnières-sur-Seine',
       'nb_stations': 13,
       'sum(capacity)': 329}]}



### Fonctions spéciales de découpage

#### Découpage d'un champs en intervalles

La fonction `RANGE()` permet de transformer un champs contenant une valeur quantitative en plusieurs modalités, en créant des intervalles sur ces valeurs.

Elle a deux fonctionnement possible :

- par intervalles de même taille, en passant en paramètre un seul entier, qui sera la taille des intervalles créés
- par intervalles définies explicitement, en passant en paramètre la liste des bornes des intervalles

On répartit ici les stations sur la base de leur capacité, en créant des intervalles de taille 15.


```python
requests.get(url_base + "?select=count(*)&group_by=RANGE(capacity,15)").json()
```




    {'results': [{'RANGE(capacity,15)': '[0, 14]', 'count(*)': 44},
      {'RANGE(capacity,15)': '[15, 29]', 'count(*)': 716},
      {'RANGE(capacity,15)': '[30, 44]', 'count(*)': 510},
      {'RANGE(capacity,15)': '[45, 59]', 'count(*)': 166},
      {'RANGE(capacity,15)': '[60, 74]', 'count(*)': 49},
      {'RANGE(capacity,15)': '[75, 89]', 'count(*)': 1}]}



Ici, on créé nous-même les intervalles (du minimum -- avec `*` -- à 14, de 15 à 19, de 20 à 25, de 25 à 30, de 30 à 40, et de 40 au maximum -- avec `*` encore). On renomme aussi le résultat avec la clause `as`.


```python
requests.get(url_base + "?select=count(*)&group_by=RANGE(capacity,*,15,20,25,30,40,*) as capacity").json()
```




    {'results': [{'capacity': '[*, 14]', 'count(*)': 44},
      {'capacity': '[15, 19]', 'count(*)': 135},
      {'capacity': '[20, 24]', 'count(*)': 303},
      {'capacity': '[25, 29]', 'count(*)': 278},
      {'capacity': '[30, 39]', 'count(*)': 408},
      {'capacity': '[40, *]', 'count(*)': 318}]}



Il faut noter que ce découpage peut aussi se faire sur une date, en se basant sur une unité pour le découpage (chaque jour, chaque année, chaque heure...).

#### Découpage selon un niveau de zoom

La fonction `GEO_CLUSTER()` permet de répartir les éléments, géo-localisés par un champs spécifié, en fonction d'un niveau de zoom défini (entre 1 et 25).

Nous découpons ici les stations sur la base d'un niveau de zoom égal à 10, ce qui créé 14 clusters de stations. On récupère de plus les centres de ces clusters.


```python
requests.get(url_base + "?select=count(*)&group_by=GEO_CLUSTER(coordonnees_geo,10)").json()
```




    {'results': [{'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.87069219275126,
         'lon': 2.364101540979836}},
       'count(*)': 614},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.83896064189873,
         'lon': 2.414170870204167}},
       'count(*)': 174},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.89005639590323,
         'lon': 2.3087780007525627}},
       'count(*)': 207},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.912563064897604,
         'lon': 2.26082076318562}},
       'count(*)': 33},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.842625450137454,
         'lon': 2.2577943024225533}},
       'count(*)': 136},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.947931905942305,
         'lon': 2.243483570803489}},
       'count(*)': 7},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.87852969300002,
         'lon': 2.194462900981307}},
       'count(*)': 15},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.81541839335114,
         'lon': 2.519368138164282}},
       'count(*)': 3},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.78870210818652,
         'lon': 2.4318400143008483}},
       'count(*)': 38},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.82751251107558,
         'lon': 2.322490131248481}},
       'count(*)': 199},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.85151231267418,
         'lon': 2.295304355569757}},
       'count(*)': 13},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.788782463774886,
         'lon': 2.3395724095670247}},
       'count(*)': 28},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.793271952308714,
         'lon': 2.265569856390357}},
       'count(*)': 9},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.82140319375321,
         'lon': 2.194737710058689}},
       'count(*)': 10}]}



## TRAVAIL A FAIRE

### Données

A partir de l'API **Observation météorologique historiques France (SYNOP)**, vous devez répondre aux demandes qui suivent. Vous trouverez des informations sur cette base à cette adresse :

<https://public.opendatasoft.com/explore/dataset/donnees-synop-essentielles-omm/information/?sort=date>

Le code ci-dessous permet de récupérer les premiers éléments.


```python
url_base = "https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/donnees-synop-essentielles-omm/records?limit=1"
requests.get(url_base).json()

```




    {'total_count': 2535486,
     'results': [{'numer_sta': '78925',
       'date': '2017-04-06T15:00:00+00:00',
       'pmer': 101830,
       'tend': -10.0,
       'cod_tend': '8',
       'dd': 110,
       'ff': 8.3,
       't': 303.45,
       'td': 294.25,
       'u': 58,
       'vv': 53550.0,
       'ww': None,
       'w1': None,
       'w2': None,
       'n': None,
       'nbas': None,
       'hbas': None,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 101740.0,
       'niv_bar': None,
       'geop': None,
       'tend24': -10.0,
       'tn12': None,
       'tn24': None,
       'tx12': None,
       'tx24': None,
       'tminsol': None,
       'sw': None,
       'tw': None,
       'raf10': None,
       'rafper': None,
       'per': None,
       'etat_sol': None,
       'ht_neige': None,
       'ssfrai': None,
       'perssfrai': None,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': -0.1,
       'rr24': -0.1,
       'phenspe1': None,
       'phenspe2': None,
       'phenspe3': None,
       'phenspe4': None,
       'nnuage1': None,
       'ctype1': None,
       'hnuage1': None,
       'nnuage2': None,
       'ctype2': None,
       'hnuage2': None,
       'nnuage3': None,
       'ctype3': None,
       'hnuage3': None,
       'nnuage4': None,
       'ctype4': None,
       'hnuage4': None,
       'coordonnees': {'lon': -60.995667, 'lat': 14.595333},
       'nom': 'LAMENTIN-AERO',
       'type_de_tendance_barometrique': 'Stationnaire ou en hausse, puis en baisse, ou en baisse, puis en baisse plus rapide',
       'temps_passe_1': None,
       'temps_present': None,
       'tc': 30.30000000000001,
       'tn12c': None,
       'tn24c': None,
       'tx12c': None,
       'tx24c': None,
       'tminsolc': None,
       'latitude': 14.595333,
       'longitude': -60.995667,
       'altitude': 3,
       'libgeo': 'Le Lamentin',
       'codegeo': '97213',
       'nom_epci': 'CA du Centre de la Martinique',
       'code_epci': '249720061',
       'nom_dept': 'Martinique',
       'code_dep': '972',
       'nom_reg': 'Martinique',
       'code_reg': '02',
       'mois_de_l_annee': 4}]}



### Demandes

- Récupérer les 500 premières observations
- Récupérer les observations faites en 2020
- Récupérer les observations à Ajaccio
- Récupérer les observations faites à plus de 200 mètres d'altitude, en 2022
- Récupérer les observations à moins de 100km de Paris (IUT comme point de référence)
- Combien y a t'il d'observations par régions ?
- Combien y a t'il de stations par régions ?


```python

```
