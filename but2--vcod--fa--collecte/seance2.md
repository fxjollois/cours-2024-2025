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




    {'total_count': 1473,
     'results': [{'stationcode': '44015',
       'name': "Rouget de L'isle - Watteau",
       'is_installed': 'OUI',
       'capacity': 20,
       'numdocksavailable': 20,
       'numbikesavailable': 0,
       'mechanical': 0,
       'ebike': 0,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:33:29+00:00',
       'coordonnees_geo': {'lon': 2.3963020229163, 'lat': 48.778192750803},
       'nom_arrondissement_communes': 'Vitry-sur-Seine',
       'code_insee_commune': '94081'},
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
       'duedate': '2025-01-23T14:30:53+00:00',
       'coordonnees_geo': {'lon': 2.3925706744194, 'lat': 48.855907555969},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '13007',
       'name': 'Le Brun - Gobelins',
       'is_installed': 'OUI',
       'capacity': 48,
       'numdocksavailable': 44,
       'numbikesavailable': 4,
       'mechanical': 3,
       'ebike': 1,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:35:55+00:00',
       'coordonnees_geo': {'lon': 2.3534681351338, 'lat': 48.835092787824},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '7002',
       'name': 'Vaneau - Sèvres',
       'is_installed': 'OUI',
       'capacity': 35,
       'numdocksavailable': 1,
       'numbikesavailable': 34,
       'mechanical': 24,
       'ebike': 10,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:37:46+00:00',
       'coordonnees_geo': {'lon': 2.3204218259346, 'lat': 48.848563233059},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '5110',
       'name': 'Lacépède - Monge',
       'is_installed': 'OUI',
       'capacity': 23,
       'numdocksavailable': 2,
       'numbikesavailable': 21,
       'mechanical': 12,
       'ebike': 9,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:37:25+00:00',
       'coordonnees_geo': {'lon': 2.3519663885235786, 'lat': 48.84389286531899},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '6108',
       'name': 'Saint-Romain - Cherche-Midi',
       'is_installed': 'OUI',
       'capacity': 17,
       'numdocksavailable': 0,
       'numbikesavailable': 17,
       'mechanical': 6,
       'ebike': 11,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:36:59+00:00',
       'coordonnees_geo': {'lon': 2.321374788880348, 'lat': 48.84708159081946},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '33006',
       'name': 'André Karman - République',
       'is_installed': 'OUI',
       'capacity': 31,
       'numdocksavailable': 25,
       'numbikesavailable': 5,
       'mechanical': 1,
       'ebike': 4,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:30:00+00:00',
       'coordonnees_geo': {'lon': 2.3851355910301213, 'lat': 48.91039875761846},
       'nom_arrondissement_communes': 'Aubervilliers',
       'code_insee_commune': '93001'},
      {'stationcode': '42016',
       'name': 'Pierre et Marie Curie - Maurice Thorez',
       'is_installed': 'OUI',
       'capacity': 27,
       'numdocksavailable': 25,
       'numbikesavailable': 2,
       'mechanical': 0,
       'ebike': 2,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:34:39+00:00',
       'coordonnees_geo': {'lon': 2.376804985105991, 'lat': 48.81580226360801},
       'nom_arrondissement_communes': 'Ivry-sur-Seine',
       'code_insee_commune': '94041'},
      {'stationcode': '40011',
       'name': 'Bas du Mont-Mesly',
       'is_installed': 'OUI',
       'capacity': 27,
       'numdocksavailable': 4,
       'numbikesavailable': 23,
       'mechanical': 22,
       'ebike': 1,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:36:01+00:00',
       'coordonnees_geo': {'lon': 2.4609763908985, 'lat': 48.779035118572},
       'nom_arrondissement_communes': 'Créteil',
       'code_insee_commune': '94028'},
      {'stationcode': '7003',
       'name': 'Square Boucicaut',
       'is_installed': 'OUI',
       'capacity': 60,
       'numdocksavailable': 3,
       'numbikesavailable': 57,
       'mechanical': 35,
       'ebike': 22,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2025-01-23T14:38:16+00:00',
       'coordonnees_geo': {'lon': 2.325061820447445, 'lat': 48.851296433665276},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'}]}



#### Et si on essaie de tout récupérer

La première idée est de mettre le paramètre `limit` au maximum de ce qu'on doit obtenir comme résultat, pour tout récupérer d'un coup.

Comme vous pouvez le voir ci-dessous, il n'est pas possible de demander plus de 100 élèments en une fois (sauf certaines opérations que l'on verra plus loin).


```python
requests.get(url_base + "?limit=" + str(resultat["total_count"])).json()
```




    {'error_code': 'InvalidRESTParameterError',
     'message': 'Invalid value for limit API parameter: 1473 was found but -1 <= limit <= 100 is expected.'}



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




    1473



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
      <td>32</td>
      <td>3</td>
      <td>0</td>
      <td>3</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:31:28+00:00</td>
      <td>{'lon': 2.275725, 'lat': 48.865983}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1</th>
      <td>44015</td>
      <td>Rouget de L'isle - Watteau</td>
      <td>OUI</td>
      <td>20</td>
      <td>20</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:33:29+00:00</td>
      <td>{'lon': 2.3963020229163, 'lat': 48.778192750803}</td>
      <td>Vitry-sur-Seine</td>
      <td>94081</td>
    </tr>
    <tr>
      <th>2</th>
      <td>14111</td>
      <td>Cassini - Denfert-Rochereau</td>
      <td>OUI</td>
      <td>25</td>
      <td>22</td>
      <td>3</td>
      <td>0</td>
      <td>3</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:38:14+00:00</td>
      <td>{'lon': 2.3360354080796, 'lat': 48.837525839067}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>3</th>
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
      <td>2025-01-23T14:30:53+00:00</td>
      <td>{'lon': 2.3925706744194, 'lat': 48.855907555969}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>4</th>
      <td>7002</td>
      <td>Vaneau - Sèvres</td>
      <td>OUI</td>
      <td>35</td>
      <td>0</td>
      <td>35</td>
      <td>24</td>
      <td>11</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:37:46+00:00</td>
      <td>{'lon': 2.3204218259346, 'lat': 48.848563233059}</td>
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
      <th>1468</th>
      <td>12127</td>
      <td>Tremblay - Lac des Minimes</td>
      <td>OUI</td>
      <td>48</td>
      <td>4</td>
      <td>78</td>
      <td>24</td>
      <td>54</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:37:29+00:00</td>
      <td>{'lon': 2.4547516554594, 'lat': 48.834131261494}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1469</th>
      <td>21021</td>
      <td>Enfants du Paradis - Peupliers</td>
      <td>OUI</td>
      <td>40</td>
      <td>0</td>
      <td>69</td>
      <td>23</td>
      <td>46</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:37:30+00:00</td>
      <td>{'lon': 2.2571459412575, 'lat': 48.833122686454}</td>
      <td>Boulogne-Billancourt</td>
      <td>92012</td>
    </tr>
    <tr>
      <th>1470</th>
      <td>4010</td>
      <td>Saint-Antoine Sévigné</td>
      <td>OUI</td>
      <td>26</td>
      <td>2</td>
      <td>37</td>
      <td>22</td>
      <td>15</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:37:41+00:00</td>
      <td>{'lon': 2.3612322, 'lat': 48.8550222}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1471</th>
      <td>9104</td>
      <td>Caumartin - Provence</td>
      <td>OUI</td>
      <td>22</td>
      <td>1</td>
      <td>25</td>
      <td>13</td>
      <td>12</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:34:41+00:00</td>
      <td>{'lon': 2.3284685611724854, 'lat': 48.87442277...</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1472</th>
      <td>8004</td>
      <td>Malesherbes - Place de la Madeleine</td>
      <td>OUI</td>
      <td>67</td>
      <td>3</td>
      <td>69</td>
      <td>33</td>
      <td>36</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2025-01-23T14:37:39+00:00</td>
      <td>{'lon': 2.323243509808, 'lat': 48.870406028483}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
  </tbody>
</table>
<p>1473 rows × 14 columns</p>
</div>



En analysant ce résultat, on peut déjà voir qu'on a des stations en double, voire en triple.


```python
data.groupby("stationcode").size().sort_values(ascending=False)
```




    stationcode
    14023    3
    24006    3
    19111    3
    1102     3
    45002    2
            ..
    17108    1
    17107    1
    17106    1
    17105    1
    92008    1
    Length: 1292, dtype: int64



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




    {'total_count': 1473,
     'results': [{'stationcode': '44015', 'name': "Rouget de L'isle - Watteau"},
      {'stationcode': '11104', 'name': 'Charonne - Robert et Sonia Delaunay'},
      {'stationcode': '13007', 'name': 'Le Brun - Gobelins'},
      {'stationcode': '7002', 'name': 'Vaneau - Sèvres'},
      {'stationcode': '5110', 'name': 'Lacépède - Monge'},
      {'stationcode': '6108', 'name': 'Saint-Romain - Cherche-Midi'},
      {'stationcode': '33006', 'name': 'André Karman - République'},
      {'stationcode': '42016', 'name': 'Pierre et Marie Curie - Maurice Thorez'},
      {'stationcode': '40011', 'name': 'Bas du Mont-Mesly'},
      {'stationcode': '7003', 'name': 'Square Boucicaut'}]}



#### Restriction

On peut donc aussi faire une restriction avec la clause `where` (on voit qu'on est très proche du langage SQL).

On cherche ici les stations avec une capacité d'accueil supérieure à 30.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30").json()
```




    {'total_count': 634,
     'results': [{'stationcode': '13007', 'capacity': 48},
      {'stationcode': '7002', 'capacity': 35},
      {'stationcode': '33006', 'capacity': 31},
      {'stationcode': '7003', 'capacity': 60},
      {'stationcode': '8050', 'capacity': 45},
      {'stationcode': '13101', 'capacity': 34},
      {'stationcode': '17044', 'capacity': 42},
      {'stationcode': '17025', 'capacity': 35},
      {'stationcode': '2017', 'capacity': 40},
      {'stationcode': '13118', 'capacity': 63}]}



#### Avec tri du résultat

Toujours dans la même idée de faire les mêmes opérations qu'en SQL, on peut trier le résultat avec la clause `order_by`.

Même résultat que précédemment, mais trié par ordre croissant de la capacité.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30&order_by=capacity").json()
```




    {'total_count': 634,
     'results': [{'stationcode': '33006', 'capacity': 31},
      {'stationcode': '21323', 'capacity': 31},
      {'stationcode': '8055', 'capacity': 31},
      {'stationcode': '42503', 'capacity': 31},
      {'stationcode': '9117', 'capacity': 31},
      {'stationcode': '20202', 'capacity': 31},
      {'stationcode': '19124', 'capacity': 31},
      {'stationcode': '22013', 'capacity': 31},
      {'stationcode': '10110', 'capacity': 31},
      {'stationcode': '21307', 'capacity': 31}]}



Et ce tri peut bien évidemment être décroissant en ajoutant `DESC` après le critère de tri.

Toujours même résultat, mais trié par ordre décroissant de la capacité.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30&order_by=capacity DESC").json()
```




    {'total_count': 634,
     'results': [{'stationcode': '7009', 'capacity': 76},
      {'stationcode': '15030', 'capacity': 74},
      {'stationcode': '15028', 'capacity': 71},
      {'stationcode': '5034', 'capacity': 69},
      {'stationcode': '16025', 'capacity': 68},
      {'stationcode': '12106', 'capacity': 68},
      {'stationcode': '12157', 'capacity': 68},
      {'stationcode': '32012', 'capacity': 68},
      {'stationcode': '1013', 'capacity': 67},
      {'stationcode': '15012', 'capacity': 67}]}



#### Combinaisons de conditions

On peut bien évidemment combiner plusieurs conditions avec les différents opérateurs logiques : `AND`, `OR` et `NOT`.

Nous avons ici les stations avec une capacité supérieure à 20, qui ne sont pas en état de laisser la possibilité de louer les vélos.


```python
requests.get(url_base + "?select=stationcode,capacity,is_renting&where=capacity>20 AND is_renting='NON'&limit=100").json()
```




    {'total_count': 11,
     'results': [{'stationcode': '44010', 'capacity': 30, 'is_renting': 'NON'},
      {'stationcode': '15063', 'capacity': 23, 'is_renting': 'NON'},
      {'stationcode': '8116', 'capacity': 25, 'is_renting': 'NON'},
      {'stationcode': '13025', 'capacity': 32, 'is_renting': 'NON'},
      {'stationcode': '18010', 'capacity': 26, 'is_renting': 'NON'},
      {'stationcode': '18203', 'capacity': 40, 'is_renting': 'NON'},
      {'stationcode': '43003', 'capacity': 26, 'is_renting': 'NON'},
      {'stationcode': '13048', 'capacity': 28, 'is_renting': 'NON'},
      {'stationcode': '3005', 'capacity': 33, 'is_renting': 'NON'},
      {'stationcode': '13205', 'capacity': 24, 'is_renting': 'NON'},
      {'stationcode': '40014', 'capacity': 28, 'is_renting': 'NON'}]}



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
     'results': [{'stationcode': '27002',
       'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '27005', 'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '27001', 'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '27006', 'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '27004', 'nom_arrondissement_communes': 'Colombes'},
      {'stationcode': '21105', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21108', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21120', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21119', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21104', 'nom_arrondissement_communes': 'Clichy'}]}



#### Distance à un objet géométrique

Un des points cruciaux actuellement est la géo-localisation, en particulier dans le cadre d'une appli mobile. On peut ainsi requêter la base de données en cherchant, dans ce premier exemple, les éléments pour lesquels la distance entre un point géographique (stocké dans un champs) et un objet géométrique est inférieure à une certaine distance passée en paramètre.

Ici, nous cherchons les stations à moins de 800m de l'IUT Paris-Rives de Seine. Il faut noter que l'ordre des coordonnées (ici longitude et latitude) dépend de la façon dont elles sont stockées dans le champs. 


```python
requests.get(url_base + "?select=stationcode,name&where=within_distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)', 800m)").json()
```




    {'total_count': 15,
     'results': [{'stationcode': '16118', 'name': 'Michel-Ange - Parent de Rosan'},
      {'stationcode': '15104', 'name': 'Hôpital Européen Georges Pompidou'},
      {'stationcode': '15059', 'name': 'Parc André Citroën'},
      {'stationcode': '16037', 'name': 'Molitor - Michel-Ange'},
      {'stationcode': '16033', 'name': "Marché d'Auteuil"},
      {'stationcode': '15068',
       'name': 'Général Martial Valin - Pont du Garigliano'},
      {'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '16038', 'name': 'Molitor - Chardon-Lagache'},
      {'stationcode': '16040', 'name': 'Exelmans - Michel-Ange'},
      {'stationcode': '16032', 'name': "Eglise d'Auteuil"}]}



En complément, on peut en plus récupérer la distance calculée entre ces coordonnées et un objet géométrique.


```python
requests.get(url_base + "?select=stationcode,name,distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)') as distance&where=within_distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)', 800m)").json()
```




    {'total_count': 15,
     'results': [{'stationcode': '16118',
       'name': 'Michel-Ange - Parent de Rosan',
       'distance': 710.8022353937183},
      {'stationcode': '15104',
       'name': 'Hôpital Européen Georges Pompidou',
       'distance': 725.9808199551429},
      {'stationcode': '15059',
       'name': 'Parc André Citroën',
       'distance': 759.235801861452},
      {'stationcode': '16037',
       'name': 'Molitor - Michel-Ange',
       'distance': 552.7017995780018},
      {'stationcode': '16033',
       'name': "Marché d'Auteuil",
       'distance': 742.4598347058223},
      {'stationcode': '15068',
       'name': 'Général Martial Valin - Pont du Garigliano',
       'distance': 458.73543527109746},
      {'stationcode': '16039',
       'name': 'Exelmans - Versailles',
       'distance': 279.35537451504047},
      {'stationcode': '16038',
       'name': 'Molitor - Chardon-Lagache',
       'distance': 393.6530345752737},
      {'stationcode': '16040',
       'name': 'Exelmans - Michel-Ange',
       'distance': 606.4513544801562},
      {'stationcode': '16032',
       'name': "Eglise d'Auteuil",
       'distance': 615.2029327979726}]}



#### Comparaison à une zone géographique

La fonction `in_bbox()` teste si un champs est inclus dans une zone géographique rectangulaire, délimitée par deux points.

Ici, on récupère les stations dans un rectangle contenant l'IUT.


```python
requests.get(url_base + "?select=stationcode,name&where=in_bbox(coordonnees_geo,48.84,2.26,48.85,2.27)").json()
```




    {'total_count': 8,
     'results': [{'stationcode': '16037', 'name': 'Molitor - Michel-Ange'},
      {'stationcode': '16116', 'name': 'George Sand - Jean de La Fontaine'},
      {'stationcode': '16033', 'name': "Marché d'Auteuil"},
      {'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '16038', 'name': 'Molitor - Chardon-Lagache'},
      {'stationcode': '16034', 'name': "Porte d'Auteuil"},
      {'stationcode': '16032', 'name': "Eglise d'Auteuil"},
      {'stationcode': '16041', 'name': 'Versailles - Claude Terrasse'}]}



Et ici, celles qui n'y sont pas donc.


```python
requests.get(url_base + "?select=stationcode,name&where=not(in_bbox(coordonnees_geo,48.84,2.26,48.85,2.27))").json()
```




    {'total_count': 1465,
     'results': [{'stationcode': '44015', 'name': "Rouget de L'isle - Watteau"},
      {'stationcode': '11104', 'name': 'Charonne - Robert et Sonia Delaunay'},
      {'stationcode': '13007', 'name': 'Le Brun - Gobelins'},
      {'stationcode': '7002', 'name': 'Vaneau - Sèvres'},
      {'stationcode': '5110', 'name': 'Lacépède - Monge'},
      {'stationcode': '6108', 'name': 'Saint-Romain - Cherche-Midi'},
      {'stationcode': '33006', 'name': 'André Karman - République'},
      {'stationcode': '42016', 'name': 'Pierre et Marie Curie - Maurice Thorez'},
      {'stationcode': '40011', 'name': 'Bas du Mont-Mesly'},
      {'stationcode': '7003', 'name': 'Square Boucicaut'}]}



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
       'nb_stations': 986,
       'sum(capacity)': 31867},
      {'nom_arrondissement_communes': 'Boulogne-Billancourt',
       'nb_stations': 29,
       'sum(capacity)': 877},
      {'nom_arrondissement_communes': 'Issy-les-Moulineaux',
       'nb_stations': 22,
       'sum(capacity)': 728},
      {'nom_arrondissement_communes': 'Montreuil',
       'nb_stations': 22,
       'sum(capacity)': 730},
      {'nom_arrondissement_communes': 'Pantin',
       'nb_stations': 20,
       'sum(capacity)': 547},
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
       'sum(capacity)': 343},
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




    {'results': [{'RANGE(capacity,15)': '[0, 14]', 'count(*)': 32},
      {'RANGE(capacity,15)': '[15, 29]', 'count(*)': 715},
      {'RANGE(capacity,15)': '[30, 44]', 'count(*)': 510},
      {'RANGE(capacity,15)': '[45, 59]', 'count(*)': 166},
      {'RANGE(capacity,15)': '[60, 74]', 'count(*)': 49},
      {'RANGE(capacity,15)': '[75, 89]', 'count(*)': 1}]}



Ici, on créé nous-même les intervalles (du minimum -- avec `*` -- à 14, de 15 à 19, de 20 à 25, de 25 à 30, de 30 à 40, et de 40 au maximum -- avec `*` encore). On renomme aussi le résultat avec la clause `as`.


```python
requests.get(url_base + "?select=count(*)&group_by=RANGE(capacity,*,15,20,25,30,40,*) as capacity").json()
```




    {'results': [{'capacity': '[*, 14]', 'count(*)': 32},
      {'capacity': '[15, 19]', 'count(*)': 131},
      {'capacity': '[20, 24]', 'count(*)': 305},
      {'capacity': '[25, 29]', 'count(*)': 279},
      {'capacity': '[30, 39]', 'count(*)': 407},
      {'capacity': '[40, *]', 'count(*)': 319}]}



Il faut noter que ce découpage peut aussi se faire sur une date, en se basant sur une unité pour le découpage (chaque jour, chaque année, chaque heure...).

#### Découpage selon un niveau de zoom

La fonction `GEO_CLUSTER()` permet de répartir les éléments, géo-localisés par un champs spécifié, en fonction d'un niveau de zoom défini (entre 1 et 25).

Nous découpons ici les stations sur la base d'un niveau de zoom égal à 10, ce qui créé 14 clusters de stations. On récupère de plus les centres de ces clusters.


```python
requests.get(url_base + "?select=count(*)&group_by=GEO_CLUSTER(coordonnees_geo,10)").json()
```




    {'results': [{'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.87063300675193,
         'lon': 2.36413216025665}},
       'count(*)': 609},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.83892494957722,
         'lon': 2.4140827173128905}},
       'count(*)': 172},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.89006752466283,
         'lon': 2.3088779350878994}},
       'count(*)': 205},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.912563064897604,
         'lon': 2.260820768265561}},
       'count(*)': 33},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.842428119490194,
         'lon': 2.2572682122699916}},
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
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.78825508774473,
         'lon': 2.4285970119616165}},
       'count(*)': 39},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.828151360360074,
         'lon': 2.321474271540964}},
       'count(*)': 199},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.85244716051966,
         'lon': 2.2959138276055455}},
       'count(*)': 10},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.7896168934038,
         'lon': 2.343214224450864}},
       'count(*)': 26},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.791836445219815,
         'lon': 2.2678864868357778}},
       'count(*)': 10},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.821074264124036,
         'lon': 2.1926969289779663}},
       'count(*)': 9}]}



## TRAVAIL A FAIRE

### Données

A partir de l'API **Observation météorologique historiques France (SYNOP)**, vous devez répondre aux demandes qui suivent. Vous trouverez des informations sur cette base à cette adresse :

<https://public.opendatasoft.com/explore/dataset/donnees-synop-essentielles-omm/information/?sort=date>

Le code ci-dessous permet de récupérer les premiers éléments.


```python
url_base = "https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/donnees-synop-essentielles-omm/records?limit=1"
requests.get(url_base).json()

```




    {'total_count': 2555563,
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
