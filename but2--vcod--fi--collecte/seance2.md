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




    {'total_count': 1484,
     'results': [{'stationcode': '44015',
       'name': "Rouget de L'isle - Watteau",
       'is_installed': 'OUI',
       'capacity': 20,
       'numdocksavailable': 8,
       'numbikesavailable': 11,
       'mechanical': 0,
       'ebike': 11,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:18:53+00:00',
       'coordonnees_geo': {'lon': 2.3963020229163, 'lat': 48.778192750803},
       'nom_arrondissement_communes': 'Vitry-sur-Seine',
       'code_insee_commune': '94081'},
      {'stationcode': '32017',
       'name': 'Basilique',
       'is_installed': 'OUI',
       'capacity': 22,
       'numdocksavailable': 5,
       'numbikesavailable': 16,
       'mechanical': 14,
       'ebike': 2,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:19:50+00:00',
       'coordonnees_geo': {'lon': 2.3588666820200914, 'lat': 48.93626891059109},
       'nom_arrondissement_communes': 'Saint-Denis',
       'code_insee_commune': '93066'},
      {'stationcode': '13007',
       'name': 'Le Brun - Gobelins',
       'is_installed': 'OUI',
       'capacity': 48,
       'numdocksavailable': 41,
       'numbikesavailable': 7,
       'mechanical': 3,
       'ebike': 4,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:14:31+00:00',
       'coordonnees_geo': {'lon': 2.3534681351338, 'lat': 48.835092787824},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '6003',
       'name': 'Saint-Sulpice',
       'is_installed': 'OUI',
       'capacity': 21,
       'numdocksavailable': 0,
       'numbikesavailable': 20,
       'mechanical': 16,
       'ebike': 4,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:20:32+00:00',
       'coordonnees_geo': {'lon': 2.3308077827095985, 'lat': 48.85165383178419},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '5110',
       'name': 'Lacépède - Monge',
       'is_installed': 'OUI',
       'capacity': 23,
       'numdocksavailable': 5,
       'numbikesavailable': 17,
       'mechanical': 4,
       'ebike': 13,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:19:16+00:00',
       'coordonnees_geo': {'lon': 2.3519663885235786, 'lat': 48.84389286531899},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
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
       'numdocksavailable': 8,
       'numbikesavailable': 17,
       'mechanical': 14,
       'ebike': 3,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:20:13+00:00',
       'coordonnees_geo': {'lon': 2.2325500845909, 'lat': 48.835583838706},
       'nom_arrondissement_communes': 'Boulogne-Billancourt',
       'code_insee_commune': '92012'},
      {'stationcode': '30002',
       'name': 'Jean Rostand - Paul Vaillant Couturier',
       'is_installed': 'OUI',
       'capacity': 40,
       'numdocksavailable': 21,
       'numbikesavailable': 18,
       'mechanical': 11,
       'ebike': 7,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:20:04+00:00',
       'coordonnees_geo': {'lon': 2.4530601033354, 'lat': 48.908168131015},
       'nom_arrondissement_communes': 'Bobigny',
       'code_insee_commune': '93008'},
      {'stationcode': '7003',
       'name': 'Square Boucicaut',
       'is_installed': 'OUI',
       'capacity': 60,
       'numdocksavailable': 0,
       'numbikesavailable': 59,
       'mechanical': 30,
       'ebike': 29,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:20:23+00:00',
       'coordonnees_geo': {'lon': 2.325061820447445, 'lat': 48.851296433665276},
       'nom_arrondissement_communes': 'Paris',
       'code_insee_commune': '75056'},
      {'stationcode': '17041',
       'name': 'Guersant - Gouvion-Saint-Cyr',
       'is_installed': 'OUI',
       'capacity': 36,
       'numdocksavailable': 23,
       'numbikesavailable': 11,
       'mechanical': 2,
       'ebike': 9,
       'is_renting': 'OUI',
       'is_returning': 'OUI',
       'duedate': '2024-12-04T13:19:20+00:00',
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
     'message': 'Invalid value for limit API parameter: 1484 was found but -1 <= limit <= 100 is expected.'}



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




    1484



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
      <td>44015</td>
      <td>Rouget de L'isle - Watteau</td>
      <td>OUI</td>
      <td>20</td>
      <td>8</td>
      <td>11</td>
      <td>0</td>
      <td>11</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:18:53+00:00</td>
      <td>{'lon': 2.3963020229163, 'lat': 48.778192750803}</td>
      <td>Vitry-sur-Seine</td>
      <td>94081</td>
    </tr>
    <tr>
      <th>1</th>
      <td>32017</td>
      <td>Basilique</td>
      <td>OUI</td>
      <td>22</td>
      <td>5</td>
      <td>16</td>
      <td>14</td>
      <td>2</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:19:50+00:00</td>
      <td>{'lon': 2.3588666820200914, 'lat': 48.93626891...</td>
      <td>Saint-Denis</td>
      <td>93066</td>
    </tr>
    <tr>
      <th>2</th>
      <td>13007</td>
      <td>Le Brun - Gobelins</td>
      <td>OUI</td>
      <td>48</td>
      <td>41</td>
      <td>7</td>
      <td>3</td>
      <td>4</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:14:31+00:00</td>
      <td>{'lon': 2.3534681351338, 'lat': 48.835092787824}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>3</th>
      <td>6003</td>
      <td>Saint-Sulpice</td>
      <td>OUI</td>
      <td>21</td>
      <td>0</td>
      <td>20</td>
      <td>16</td>
      <td>4</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:20:32+00:00</td>
      <td>{'lon': 2.3308077827095985, 'lat': 48.85165383...</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>4</th>
      <td>7002</td>
      <td>Vaneau - Sèvres</td>
      <td>OUI</td>
      <td>35</td>
      <td>9</td>
      <td>25</td>
      <td>14</td>
      <td>11</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:19:52+00:00</td>
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
      <th>1479</th>
      <td>15056</td>
      <td>Place Balard</td>
      <td>OUI</td>
      <td>22</td>
      <td>2</td>
      <td>32</td>
      <td>26</td>
      <td>6</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:18:50+00:00</td>
      <td>{'lon': 2.2784192115068, 'lat': 48.836395736424}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1480</th>
      <td>8052</td>
      <td>Balzac - Champs Elysées</td>
      <td>OUI</td>
      <td>30</td>
      <td>11</td>
      <td>19</td>
      <td>11</td>
      <td>8</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:20:07+00:00</td>
      <td>{'lon': 2.3001953959465, 'lat': 48.872699639621}</td>
      <td>Paris</td>
      <td>75056</td>
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
      <td>2024-08-27T09:20:23+00:00</td>
      <td>{'lon': 2.4543687905029, 'lat': 48.802117531472}</td>
      <td>Créteil</td>
      <td>94028</td>
    </tr>
    <tr>
      <th>1482</th>
      <td>4005</td>
      <td>Quai des Célestins - Henri IV</td>
      <td>OUI</td>
      <td>14</td>
      <td>3</td>
      <td>10</td>
      <td>6</td>
      <td>4</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:17:19+00:00</td>
      <td>{'lon': 2.3624535, 'lat': 48.8512971}</td>
      <td>Paris</td>
      <td>75056</td>
    </tr>
    <tr>
      <th>1483</th>
      <td>21302</td>
      <td>Aristide Briand - Place de la Résistance</td>
      <td>OUI</td>
      <td>25</td>
      <td>9</td>
      <td>23</td>
      <td>19</td>
      <td>4</td>
      <td>OUI</td>
      <td>OUI</td>
      <td>2024-12-04T13:20:25+00:00</td>
      <td>{'lon': 2.2511002421379094, 'lat': 48.82124248...</td>
      <td>Issy-les-Moulineaux</td>
      <td>92040</td>
    </tr>
  </tbody>
</table>
<p>1484 rows × 14 columns</p>
</div>



En analysant ce résultat, on peut déjà voir qu'on a des stations en double, voire en triple.


```python
data.groupby("stationcode").size().sort_values(ascending=False)
```




    stationcode
    20201    2
    15029    2
    48006    2
    14002    2
    14010    2
            ..
    17126    1
    17125    1
    17124    1
    17123    1
    92007    1
    Length: 1320, dtype: int64



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




    {'total_count': 1484,
     'results': [{'stationcode': '44015', 'name': "Rouget de L'isle - Watteau"},
      {'stationcode': '32017', 'name': 'Basilique'},
      {'stationcode': '13007', 'name': 'Le Brun - Gobelins'},
      {'stationcode': '6003', 'name': 'Saint-Sulpice'},
      {'stationcode': '5110', 'name': 'Lacépède - Monge'},
      {'stationcode': '40011', 'name': 'Bas du Mont-Mesly'},
      {'stationcode': '21010', 'name': 'Silly - Galliéni'},
      {'stationcode': '30002', 'name': 'Jean Rostand - Paul Vaillant Couturier'},
      {'stationcode': '7003', 'name': 'Square Boucicaut'},
      {'stationcode': '17041', 'name': 'Guersant - Gouvion-Saint-Cyr'}]}



#### Restriction

On peut donc aussi faire une restriction avec la clause `where` (on voit qu'on est très proche du langage SQL).

On cherche ici les stations avec une capacité d'accueil supérieure à 30.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30").json()
```




    {'total_count': 632,
     'results': [{'stationcode': '13007', 'capacity': 48},
      {'stationcode': '30002', 'capacity': 40},
      {'stationcode': '7003', 'capacity': 60},
      {'stationcode': '17041', 'capacity': 36},
      {'stationcode': '11025', 'capacity': 43},
      {'stationcode': '15047', 'capacity': 52},
      {'stationcode': '17026', 'capacity': 40},
      {'stationcode': '8050', 'capacity': 45},
      {'stationcode': '13101', 'capacity': 34},
      {'stationcode': '31024', 'capacity': 38}]}



#### Avec tri du résultat

Toujours dans la même idée de faire les mêmes opérations qu'en SQL, on peut trier le résultat avec la clause `order_by`.

Même résultat que précédemment, mais trié par ordre croissant de la capacité.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30&order_by=capacity").json()
```




    {'total_count': 632,
     'results': [{'stationcode': '21323', 'capacity': 31},
      {'stationcode': '5123', 'capacity': 31},
      {'stationcode': '8055', 'capacity': 31},
      {'stationcode': '20019', 'capacity': 31},
      {'stationcode': '17016', 'capacity': 31},
      {'stationcode': '8105', 'capacity': 31},
      {'stationcode': '21004', 'capacity': 31},
      {'stationcode': '20117', 'capacity': 31},
      {'stationcode': '19124', 'capacity': 31},
      {'stationcode': '7024', 'capacity': 31}]}



Et ce tri peut bien évidemment être décroissant en ajoutant `DESC` après le critère de tri.

Toujours même résultat, mais trié par ordre décroissant de la capacité.


```python
requests.get(url_base + "?select=stationcode,capacity&where=capacity>30&order_by=capacity DESC").json()
```




    {'total_count': 632,
     'results': [{'stationcode': '7009', 'capacity': 76},
      {'stationcode': '15030', 'capacity': 74},
      {'stationcode': '15028', 'capacity': 71},
      {'stationcode': '5034', 'capacity': 69},
      {'stationcode': '16025', 'capacity': 68},
      {'stationcode': '12106', 'capacity': 68},
      {'stationcode': '12157', 'capacity': 68},
      {'stationcode': '32012', 'capacity': 68},
      {'stationcode': '1013', 'capacity': 67},
      {'stationcode': '19045', 'capacity': 67}]}



#### Combinaisons de conditions

On peut bien évidemment combiner plusieurs conditions avec les différents opérateurs logiques : `AND`, `OR` et `NOT`.

Nous avons ici les stations avec une capacité supérieure à 20, qui ne sont pas en état de laisser la possibilité de louer les vélos.


```python
requests.get(url_base + "?select=stationcode,capacity,is_renting&where=capacity>20 AND is_renting='NON'&limit=100").json()
```




    {'total_count': 17,
     'results': [{'stationcode': '18203', 'capacity': 40, 'is_renting': 'NON'},
      {'stationcode': '43003', 'capacity': 26, 'is_renting': 'NON'},
      {'stationcode': '42207', 'capacity': 37, 'is_renting': 'NON'},
      {'stationcode': '10162', 'capacity': 24, 'is_renting': 'NON'},
      {'stationcode': '3005', 'capacity': 33, 'is_renting': 'NON'},
      {'stationcode': '18010', 'capacity': 26, 'is_renting': 'NON'},
      {'stationcode': '40014', 'capacity': 28, 'is_renting': 'NON'},
      {'stationcode': '40015', 'capacity': 24, 'is_renting': 'NON'},
      {'stationcode': '40004', 'capacity': 25, 'is_renting': 'NON'},
      {'stationcode': '40001', 'capacity': 28, 'is_renting': 'NON'},
      {'stationcode': '44010', 'capacity': 30, 'is_renting': 'NON'},
      {'stationcode': '15063', 'capacity': 23, 'is_renting': 'NON'},
      {'stationcode': '13048', 'capacity': 28, 'is_renting': 'NON'},
      {'stationcode': '18027', 'capacity': 30, 'is_renting': 'NON'},
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
     'results': [{'stationcode': '16040', 'name': 'Exelmans - Michel-Ange'},
      {'stationcode': '16039', 'name': 'Exelmans - Versailles'}]}



On veut toutes les stations dont le nom contient "Versailles".


```python
requests.get(url_base + "?select=stationcode,name&where=suggest(name,'Versailles')").json()
```




    {'total_count': 3,
     'results': [{'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '16041', 'name': 'Versailles - Claude Terrasse'},
      {'stationcode': '15203', 'name': 'Porte de Versailles'}]}



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
      {'stationcode': '21104', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21111', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21120', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21118', 'nom_arrondissement_communes': 'Clichy'},
      {'stationcode': '21119', 'nom_arrondissement_communes': 'Clichy'}]}



#### Distance à un objet géométrique

Un des points cruciaux actuellement est la géo-localisation, en particulier dans le cadre d'une appli mobile. On peut ainsi requêter la base de données en cherchant, dans ce premier exemple, les éléments pour lesquels la distance entre un point géographique (stocké dans un champs) et un objet géométrique est inférieure à une certaine distance passée en paramètre.

Ici, nous cherchons les stations à moins de 800m de l'IUT Paris-Rives de Seine. Il faut noter que l'ordre des coordonnées (ici longitude et latitude) dépend de la façon dont elles sont stockées dans le champs. 


```python
requests.get(url_base + "?select=stationcode,name&where=within_distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)', 800m)").json()
```




    {'total_count': 15,
     'results': [{'stationcode': '15068',
       'name': 'Général Martial Valin - Pont du Garigliano'},
      {'stationcode': '16118', 'name': 'Michel-Ange - Parent de Rosan'},
      {'stationcode': '16040', 'name': 'Exelmans - Michel-Ange'},
      {'stationcode': '16041', 'name': 'Versailles - Claude Terrasse'},
      {'stationcode': '16037', 'name': 'Molitor - Michel-Ange'},
      {'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '15104', 'name': 'Hôpital Européen Georges Pompidou'},
      {'stationcode': '16038', 'name': 'Molitor - Chardon-Lagache'},
      {'stationcode': '16032', 'name': "Eglise d'Auteuil"},
      {'stationcode': '15059', 'name': 'Parc André Citroën'}]}



En complément, on peut en plus récupérer la distance calculée entre ces coordonnées et un objet géométrique.


```python
requests.get(url_base + "?select=stationcode,name,distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)') as distance&where=within_distance(coordonnees_geo, geom'POINT(2.267888940737877 48.84197963193564)', 800m)").json()
```




    {'total_count': 15,
     'results': [{'stationcode': '15068',
       'name': 'Général Martial Valin - Pont du Garigliano',
       'distance': 458.73543527109746},
      {'stationcode': '16118',
       'name': 'Michel-Ange - Parent de Rosan',
       'distance': 710.8022353937183},
      {'stationcode': '16040',
       'name': 'Exelmans - Michel-Ange',
       'distance': 606.4513544801562},
      {'stationcode': '16041',
       'name': 'Versailles - Claude Terrasse',
       'distance': 355.48687528576613},
      {'stationcode': '16037',
       'name': 'Molitor - Michel-Ange',
       'distance': 552.7017995780018},
      {'stationcode': '16039',
       'name': 'Exelmans - Versailles',
       'distance': 279.35537451504047},
      {'stationcode': '15104',
       'name': 'Hôpital Européen Georges Pompidou',
       'distance': 725.9808199551429},
      {'stationcode': '16038',
       'name': 'Molitor - Chardon-Lagache',
       'distance': 393.6530345752737},
      {'stationcode': '16032',
       'name': "Eglise d'Auteuil",
       'distance': 615.2029327979726},
      {'stationcode': '15059',
       'name': 'Parc André Citroën',
       'distance': 759.235801861452}]}



#### Comparaison à une zone géographique

La fonction `in_bbox()` teste si un champs est inclus dans une zone géographique rectangulaire, délimitée par deux points.

Ici, on récupère les stations dans un rectangle contenant l'IUT.


```python
requests.get(url_base + "?select=stationcode,name&where=in_bbox(coordonnees_geo,48.84,2.26,48.85,2.27)").json()
```




    {'total_count': 8,
     'results': [{'stationcode': '16041', 'name': 'Versailles - Claude Terrasse'},
      {'stationcode': '16037', 'name': 'Molitor - Michel-Ange'},
      {'stationcode': '16116', 'name': 'George Sand - Jean de La Fontaine'},
      {'stationcode': '16039', 'name': 'Exelmans - Versailles'},
      {'stationcode': '16038', 'name': 'Molitor - Chardon-Lagache'},
      {'stationcode': '16034', 'name': "Porte d'Auteuil"},
      {'stationcode': '16032', 'name': "Eglise d'Auteuil"},
      {'stationcode': '16033', 'name': "Marché d'Auteuil"}]}



Et ici, celles qui n'y sont pas donc.


```python
requests.get(url_base + "?select=stationcode,name&where=not(in_bbox(coordonnees_geo,48.84,2.26,48.85,2.27))").json()
```




    {'total_count': 1476,
     'results': [{'stationcode': '44015', 'name': "Rouget de L'isle - Watteau"},
      {'stationcode': '32017', 'name': 'Basilique'},
      {'stationcode': '13007', 'name': 'Le Brun - Gobelins'},
      {'stationcode': '6003', 'name': 'Saint-Sulpice'},
      {'stationcode': '5110', 'name': 'Lacépède - Monge'},
      {'stationcode': '40011', 'name': 'Bas du Mont-Mesly'},
      {'stationcode': '21010', 'name': 'Silly - Galliéni'},
      {'stationcode': '30002', 'name': 'Jean Rostand - Paul Vaillant Couturier'},
      {'stationcode': '7003', 'name': 'Square Boucicaut'},
      {'stationcode': '17041', 'name': 'Guersant - Gouvion-Saint-Cyr'}]}



A noter qu'il existe une fonction permettant de chercher si un point appartient à une zone géographique de type polygone.

### Calcul d'agrégat

On peut aussi demander à l'API de faire un certain nombre de claculs en amont, en particulier des calculs d'agrégats, avec en plus la clause `group_by` qui permet de faire ce cacul pour chaque modalité d'un champs.

Ici, on a le nombre de stations par ville et la capacité totale de celles-ci.


```python
requests.get(url_base + "?select=nom_arrondissement_communes,count(*),sum(capacity)&group_by=nom_arrondissement_communes").json()
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
       'sum(capacity)': 877},
      {'nom_arrondissement_communes': 'Bourg-la-Reine',
       'count(*)': 3,
       'sum(capacity)': 77},
      {'nom_arrondissement_communes': 'Cachan',
       'count(*)': 4,
       'sum(capacity)': 86},
      {'nom_arrondissement_communes': 'Champigny-sur-Marne',
       'count(*)': 5,
       'sum(capacity)': 147},
      {'nom_arrondissement_communes': 'Charenton-le-Pont',
       'count(*)': 5,
       'sum(capacity)': 147},
      {'nom_arrondissement_communes': 'Chaville',
       'count(*)': 3,
       'sum(capacity)': 62},
      {'nom_arrondissement_communes': 'Choisy-le-Roi',
       'count(*)': 3,
       'sum(capacity)': 79},
      {'nom_arrondissement_communes': 'Châtillon',
       'count(*)': 6,
       'sum(capacity)': 176},
      {'nom_arrondissement_communes': 'Clamart',
       'count(*)': 3,
       'sum(capacity)': 80},
      {'nom_arrondissement_communes': 'Clichy',
       'count(*)': 13,
       'sum(capacity)': 422},
      {'nom_arrondissement_communes': 'Colombes',
       'count(*)': 5,
       'sum(capacity)': 120},
      {'nom_arrondissement_communes': 'Courbevoie',
       'count(*)': 7,
       'sum(capacity)': 220},
      {'nom_arrondissement_communes': 'Créteil',
       'count(*)': 14,
       'sum(capacity)': 218},
      {'nom_arrondissement_communes': 'Fontenay-aux-Roses',
       'count(*)': 4,
       'sum(capacity)': 122},
      {'nom_arrondissement_communes': 'Fontenay-sous-Bois',
       'count(*)': 11,
       'sum(capacity)': 327},
      {'nom_arrondissement_communes': 'Garches',
       'count(*)': 2,
       'sum(capacity)': 43},
      {'nom_arrondissement_communes': 'Gennevilliers',
       'count(*)': 5,
       'sum(capacity)': 145},
      {'nom_arrondissement_communes': 'Gentilly',
       'count(*)': 4,
       'sum(capacity)': 119},
      {'nom_arrondissement_communes': 'Issy-les-Moulineaux',
       'count(*)': 22,
       'sum(capacity)': 728},
      {'nom_arrondissement_communes': 'Ivry-sur-Seine',
       'count(*)': 18,
       'sum(capacity)': 590},
      {'nom_arrondissement_communes': 'Joinville-le-Pont',
       'count(*)': 1,
       'sum(capacity)': 40},
      {'nom_arrondissement_communes': 'La Courneuve',
       'count(*)': 2,
       'sum(capacity)': 62},
      {'nom_arrondissement_communes': 'La Garenne-Colombes',
       'count(*)': 7,
       'sum(capacity)': 128},
      {'nom_arrondissement_communes': 'Le Kremlin-Bicêtre',
       'count(*)': 5,
       'sum(capacity)': 150},
      {'nom_arrondissement_communes': 'Le Pré-Saint-Gervais',
       'count(*)': 2,
       'sum(capacity)': 42},
      {'nom_arrondissement_communes': 'Les Lilas',
       'count(*)': 4,
       'sum(capacity)': 141},
      {'nom_arrondissement_communes': 'Levallois-Perret',
       'count(*)': 11,
       'sum(capacity)': 360},
      {'nom_arrondissement_communes': 'Maisons-Alfort',
       'count(*)': 7,
       'sum(capacity)': 180},
      {'nom_arrondissement_communes': 'Malakoff',
       'count(*)': 8,
       'sum(capacity)': 238},
      {'nom_arrondissement_communes': 'Meudon',
       'count(*)': 5,
       'sum(capacity)': 133},
      {'nom_arrondissement_communes': 'Montreuil',
       'count(*)': 23,
       'sum(capacity)': 787},
      {'nom_arrondissement_communes': 'Montrouge',
       'count(*)': 13,
       'sum(capacity)': 354},
      {'nom_arrondissement_communes': 'Nanterre',
       'count(*)': 8,
       'sum(capacity)': 221},
      {'nom_arrondissement_communes': 'Neuilly-sur-Seine',
       'count(*)': 13,
       'sum(capacity)': 331},
      {'nom_arrondissement_communes': 'Nogent-sur-Marne',
       'count(*)': 4,
       'sum(capacity)': 161},
      {'nom_arrondissement_communes': 'Noisy-le-Sec',
       'count(*)': 2,
       'sum(capacity)': 58},
      {'nom_arrondissement_communes': 'Pantin',
       'count(*)': 21,
       'sum(capacity)': 565},
      {'nom_arrondissement_communes': 'Paris',
       'count(*)': 991,
       'sum(capacity)': 31893},
      {'nom_arrondissement_communes': 'Puteaux',
       'count(*)': 2,
       'sum(capacity)': 58},
      {'nom_arrondissement_communes': 'Romainville',
       'count(*)': 5,
       'sum(capacity)': 125},
      {'nom_arrondissement_communes': 'Rosny-sous-Bois',
       'count(*)': 4,
       'sum(capacity)': 103},
      {'nom_arrondissement_communes': 'Rueil-Malmaison',
       'count(*)': 10,
       'sum(capacity)': 239},
      {'nom_arrondissement_communes': 'Saint-Cloud',
       'count(*)': 3,
       'sum(capacity)': 79},
      {'nom_arrondissement_communes': 'Saint-Denis',
       'count(*)': 19,
       'sum(capacity)': 666},
      {'nom_arrondissement_communes': 'Saint-Mandé',
       'count(*)': 6,
       'sum(capacity)': 190},
      {'nom_arrondissement_communes': 'Saint-Maurice',
       'count(*)': 3,
       'sum(capacity)': 83},
      {'nom_arrondissement_communes': 'Saint-Ouen-sur-Seine',
       'count(*)': 9,
       'sum(capacity)': 248},
      {'nom_arrondissement_communes': 'Sceaux',
       'count(*)': 4,
       'sum(capacity)': 90},
      {'nom_arrondissement_communes': 'Suresnes',
       'count(*)': 10,
       'sum(capacity)': 254},
      {'nom_arrondissement_communes': 'Sèvres',
       'count(*)': 6,
       'sum(capacity)': 160},
      {'nom_arrondissement_communes': 'Vanves',
       'count(*)': 7,
       'sum(capacity)': 234},
      {'nom_arrondissement_communes': "Ville-d'Avray",
       'count(*)': 1,
       'sum(capacity)': 24},
      {'nom_arrondissement_communes': 'Villejuif',
       'count(*)': 11,
       'sum(capacity)': 269},
      {'nom_arrondissement_communes': 'Villeneuve-la-Garenne',
       'count(*)': 2,
       'sum(capacity)': 75},
      {'nom_arrondissement_communes': 'Vincennes',
       'count(*)': 10,
       'sum(capacity)': 306},
      {'nom_arrondissement_communes': 'Vitry-sur-Seine',
       'count(*)': 16,
       'sum(capacity)': 425}]}



On peut bien évidemment ordonner ce résultat pour avoir les villes ayant le plus de stations en premier.


```python
requests.get(url_base + "?select=nom_arrondissement_communes,count(*) as nb_stations,sum(capacity)&group_by=nom_arrondissement_communes&order_by=nb_stations DESC").json()
```




    {'results': [{'nom_arrondissement_communes': 'Paris',
       'nb_stations': 991,
       'sum(capacity)': 31893},
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
       'sum(capacity)': 329},
      {'nom_arrondissement_communes': 'Aubervilliers',
       'nb_stations': 13,
       'sum(capacity)': 404},
      {'nom_arrondissement_communes': 'Clichy',
       'nb_stations': 13,
       'sum(capacity)': 422},
      {'nom_arrondissement_communes': 'Montrouge',
       'nb_stations': 13,
       'sum(capacity)': 354},
      {'nom_arrondissement_communes': 'Neuilly-sur-Seine',
       'nb_stations': 13,
       'sum(capacity)': 331},
      {'nom_arrondissement_communes': 'Fontenay-sous-Bois',
       'nb_stations': 11,
       'sum(capacity)': 327},
      {'nom_arrondissement_communes': 'Levallois-Perret',
       'nb_stations': 11,
       'sum(capacity)': 360},
      {'nom_arrondissement_communes': 'Villejuif',
       'nb_stations': 11,
       'sum(capacity)': 269},
      {'nom_arrondissement_communes': 'Rueil-Malmaison',
       'nb_stations': 10,
       'sum(capacity)': 239},
      {'nom_arrondissement_communes': 'Suresnes',
       'nb_stations': 10,
       'sum(capacity)': 254},
      {'nom_arrondissement_communes': 'Vincennes',
       'nb_stations': 10,
       'sum(capacity)': 306},
      {'nom_arrondissement_communes': 'Saint-Ouen-sur-Seine',
       'nb_stations': 9,
       'sum(capacity)': 248},
      {'nom_arrondissement_communes': 'Bagnolet',
       'nb_stations': 8,
       'sum(capacity)': 249},
      {'nom_arrondissement_communes': 'Malakoff',
       'nb_stations': 8,
       'sum(capacity)': 238},
      {'nom_arrondissement_communes': 'Nanterre',
       'nb_stations': 8,
       'sum(capacity)': 221},
      {'nom_arrondissement_communes': 'Argenteuil',
       'nb_stations': 7,
       'sum(capacity)': 225},
      {'nom_arrondissement_communes': 'Courbevoie',
       'nb_stations': 7,
       'sum(capacity)': 220},
      {'nom_arrondissement_communes': 'La Garenne-Colombes',
       'nb_stations': 7,
       'sum(capacity)': 128},
      {'nom_arrondissement_communes': 'Maisons-Alfort',
       'nb_stations': 7,
       'sum(capacity)': 180},
      {'nom_arrondissement_communes': 'Vanves',
       'nb_stations': 7,
       'sum(capacity)': 234},
      {'nom_arrondissement_communes': 'Bagneux',
       'nb_stations': 6,
       'sum(capacity)': 155},
      {'nom_arrondissement_communes': 'Châtillon',
       'nb_stations': 6,
       'sum(capacity)': 176},
      {'nom_arrondissement_communes': 'Saint-Mandé',
       'nb_stations': 6,
       'sum(capacity)': 190},
      {'nom_arrondissement_communes': 'Sèvres',
       'nb_stations': 6,
       'sum(capacity)': 160},
      {'nom_arrondissement_communes': 'Alfortville',
       'nb_stations': 5,
       'sum(capacity)': 122},
      {'nom_arrondissement_communes': 'Bobigny',
       'nb_stations': 5,
       'sum(capacity)': 132},
      {'nom_arrondissement_communes': 'Champigny-sur-Marne',
       'nb_stations': 5,
       'sum(capacity)': 147},
      {'nom_arrondissement_communes': 'Charenton-le-Pont',
       'nb_stations': 5,
       'sum(capacity)': 147},
      {'nom_arrondissement_communes': 'Colombes',
       'nb_stations': 5,
       'sum(capacity)': 120},
      {'nom_arrondissement_communes': 'Gennevilliers',
       'nb_stations': 5,
       'sum(capacity)': 145},
      {'nom_arrondissement_communes': 'Le Kremlin-Bicêtre',
       'nb_stations': 5,
       'sum(capacity)': 150},
      {'nom_arrondissement_communes': 'Meudon',
       'nb_stations': 5,
       'sum(capacity)': 133},
      {'nom_arrondissement_communes': 'Romainville',
       'nb_stations': 5,
       'sum(capacity)': 125},
      {'nom_arrondissement_communes': 'Arcueil',
       'nb_stations': 4,
       'sum(capacity)': 118},
      {'nom_arrondissement_communes': 'Cachan',
       'nb_stations': 4,
       'sum(capacity)': 86},
      {'nom_arrondissement_communes': 'Fontenay-aux-Roses',
       'nb_stations': 4,
       'sum(capacity)': 122},
      {'nom_arrondissement_communes': 'Gentilly',
       'nb_stations': 4,
       'sum(capacity)': 119},
      {'nom_arrondissement_communes': 'Les Lilas',
       'nb_stations': 4,
       'sum(capacity)': 141},
      {'nom_arrondissement_communes': 'Nogent-sur-Marne',
       'nb_stations': 4,
       'sum(capacity)': 161},
      {'nom_arrondissement_communes': 'Rosny-sous-Bois',
       'nb_stations': 4,
       'sum(capacity)': 103},
      {'nom_arrondissement_communes': 'Sceaux',
       'nb_stations': 4,
       'sum(capacity)': 90},
      {'nom_arrondissement_communes': 'Bourg-la-Reine',
       'nb_stations': 3,
       'sum(capacity)': 77},
      {'nom_arrondissement_communes': 'Chaville',
       'nb_stations': 3,
       'sum(capacity)': 62},
      {'nom_arrondissement_communes': 'Choisy-le-Roi',
       'nb_stations': 3,
       'sum(capacity)': 79},
      {'nom_arrondissement_communes': 'Clamart',
       'nb_stations': 3,
       'sum(capacity)': 80},
      {'nom_arrondissement_communes': 'Saint-Cloud',
       'nb_stations': 3,
       'sum(capacity)': 79},
      {'nom_arrondissement_communes': 'Saint-Maurice',
       'nb_stations': 3,
       'sum(capacity)': 83},
      {'nom_arrondissement_communes': 'Bois-Colombes',
       'nb_stations': 2,
       'sum(capacity)': 60},
      {'nom_arrondissement_communes': 'Garches',
       'nb_stations': 2,
       'sum(capacity)': 43},
      {'nom_arrondissement_communes': 'La Courneuve',
       'nb_stations': 2,
       'sum(capacity)': 62},
      {'nom_arrondissement_communes': 'Le Pré-Saint-Gervais',
       'nb_stations': 2,
       'sum(capacity)': 42},
      {'nom_arrondissement_communes': 'Noisy-le-Sec',
       'nb_stations': 2,
       'sum(capacity)': 58},
      {'nom_arrondissement_communes': 'Puteaux',
       'nb_stations': 2,
       'sum(capacity)': 58},
      {'nom_arrondissement_communes': 'Villeneuve-la-Garenne',
       'nb_stations': 2,
       'sum(capacity)': 75},
      {'nom_arrondissement_communes': 'Joinville-le-Pont',
       'nb_stations': 1,
       'sum(capacity)': 40},
      {'nom_arrondissement_communes': "Ville-d'Avray",
       'nb_stations': 1,
       'sum(capacity)': 24}]}



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




    {'results': [{'RANGE(capacity,15)': '[0, 14]', 'count(*)': 43},
      {'RANGE(capacity,15)': '[15, 29]', 'count(*)': 716},
      {'RANGE(capacity,15)': '[30, 44]', 'count(*)': 509},
      {'RANGE(capacity,15)': '[45, 59]', 'count(*)': 166},
      {'RANGE(capacity,15)': '[60, 74]', 'count(*)': 49},
      {'RANGE(capacity,15)': '[75, 89]', 'count(*)': 1}]}



Ici, on créé nous-même les intervalles (du minimum -- avec `*` -- à 14, de 15 à 19, de 20 à 25, de 25 à 30, de 30 à 40, et de 40 au maximum -- avec `*` encore). On renomme aussi le résultat avec la clause `as`.


```python
requests.get(url_base + "?select=count(*)&group_by=RANGE(capacity,*,15,20,25,30,40,*) as capacity").json()
```




    {'results': [{'capacity': '[*, 14]', 'count(*)': 43},
      {'capacity': '[15, 19]', 'count(*)': 135},
      {'capacity': '[20, 24]', 'count(*)': 303},
      {'capacity': '[25, 29]', 'count(*)': 278},
      {'capacity': '[30, 39]', 'count(*)': 407},
      {'capacity': '[40, *]', 'count(*)': 318}]}



Il faut noter que ce découpage peut aussi se faire sur une date, en se basant sur une unité pour le découpage (chaque jour, chaque année, chaque heure...).

#### Découpage selon un niveau de zoom

La fonction `GEO_CLUSTER()` permet de répartir les éléments, géo-localisés par un champs spécifié, en fonction d'un niveau de zoom défini (entre 1 et 25).

Nous découpons ici les stations sur la base d'un niveau de zoom égal à 10, ce qui créé 14 clusters de stations. On récupère de plus les centres de ces clusters.


```python
requests.get(url_base + "?select=count(*)&group_by=GEO_CLUSTER(coordonnees_geo,10)").json()
```




    {'results': [{'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.87072540889531,
         'lon': 2.3640824202600053}},
       'count(*)': 613},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.8389606385267,
         'lon': 2.414170871167604}},
       'count(*)': 174},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.890181980981694,
         'lon': 2.308858638720178}},
       'count(*)': 205},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.912563062357634,
         'lon': 2.2608207606456503}},
       'count(*)': 33},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.842625451678245,
         'lon': 2.257794298724655}},
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
         'lon': 2.4318400165066127}},
       'count(*)': 38},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.82757096816785,
         'lon': 2.3224820990581065}},
       'count(*)': 200},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.85151230945037,
         'lon': 2.2953043362269034}},
       'count(*)': 13},
      {'GEO_CLUSTER(coordonnees_geo,10)': {'cluster_centroid': {'lat': 48.78878246676842,
         'lon': 2.3395724065734878}},
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
url_base = "https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/donnees-synop-essentielles-omm/records"
requests.get(url_base).json()

```




    {'total_count': 2531637,
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
       'mois_de_l_annee': 4},
      {'numer_sta': '07110',
       'date': '2017-04-06T18:00:00+00:00',
       'pmer': 102910,
       'tend': -40.0,
       'cod_tend': '6',
       'dd': 30,
       'ff': 4.1,
       't': 284.55,
       'td': 279.25,
       'u': 70,
       'vv': 29000.0,
       'ww': '0',
       'w1': None,
       'w2': None,
       'n': None,
       'nbas': '0',
       'hbas': None,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 101710.0,
       'niv_bar': None,
       'geop': None,
       'tend24': -300.0,
       'tn12': 276.45,
       'tn24': None,
       'tx12': 289.45,
       'tx24': None,
       'tminsol': None,
       'sw': None,
       'tw': None,
       'raf10': 6.6,
       'rafper': 9.0,
       'per': -10.0,
       'etat_sol': '0',
       'ht_neige': 0.0,
       'ssfrai': None,
       'perssfrai': None,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': 0.0,
       'rr24': 0.0,
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
       'coordonnees': {'lon': -4.412, 'lat': 48.444167},
       'nom': 'BREST-GUIPAVAS',
       'type_de_tendance_barometrique': 'En baisse, puis stationnaire, ou en baisse, puis en baisse plus lente',
       'temps_passe_1': None,
       'temps_present': 'On n’a pas observé d’évolution des nuages ou on n’a pas pu suivre cette évolution',
       'tc': 11.400000000000034,
       'tn12c': 3.3000000000000114,
       'tn24c': None,
       'tx12c': 16.30000000000001,
       'tx24c': None,
       'tminsolc': None,
       'latitude': 48.444167,
       'longitude': -4.412,
       'altitude': 94,
       'libgeo': 'Guipavas',
       'codegeo': '29075',
       'nom_epci': 'Brest Métropole',
       'code_epci': '242900314',
       'nom_dept': 'Finistère',
       'code_dep': '29',
       'nom_reg': 'Bretagne',
       'code_reg': '53',
       'mois_de_l_annee': 4},
      {'numer_sta': '07481',
       'date': '2017-04-06T18:00:00+00:00',
       'pmer': 102170,
       'tend': 80.0,
       'cod_tend': '3',
       'dd': 340,
       'ff': 6.6,
       't': 285.75,
       'td': 275.55,
       'u': 50,
       'vv': 30000.0,
       'ww': '2',
       'w1': '0',
       'w2': '0',
       'n': 10.0,
       'nbas': '0',
       'hbas': 9000.0,
       'cl': '30',
       'cm': '20',
       'ch': '11',
       'pres': 99300.0,
       'niv_bar': None,
       'geop': None,
       'tend24': 70.0,
       'tn12': 280.45,
       'tn24': None,
       'tx12': 288.35,
       'tx24': None,
       'tminsol': None,
       'sw': None,
       'tw': None,
       'raf10': 9.5,
       'rafper': 14.1,
       'per': -10.0,
       'etat_sol': '0',
       'ht_neige': 0.0,
       'ssfrai': 0.0,
       'perssfrai': -60.0,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': 0.0,
       'rr24': 0.0,
       'phenspe1': None,
       'phenspe2': None,
       'phenspe3': None,
       'phenspe4': None,
       'nnuage1': 1.0,
       'ctype1': '0',
       'hnuage1': 9000.0,
       'nnuage2': None,
       'ctype2': None,
       'hnuage2': None,
       'nnuage3': None,
       'ctype3': None,
       'hnuage3': None,
       'nnuage4': None,
       'ctype4': None,
       'hnuage4': None,
       'coordonnees': {'lon': 5.077833, 'lat': 45.7265},
       'nom': 'LYON-ST EXUPERY',
       'type_de_tendance_barometrique': 'En baisse ou stationnaire, puis en hausse, ou en hausse, puis en hausse plus rapide',
       'temps_passe_1': 'Nuages ne couvrant pas plus de la moitié du ciel pendant toute la période considérée',
       'temps_present': 'État du ciel inchangé dans l’ensemble',
       'tc': 12.600000000000023,
       'tn12c': 7.300000000000011,
       'tn24c': None,
       'tx12c': 15.200000000000045,
       'tx24c': None,
       'tminsolc': None,
       'latitude': 45.7265,
       'longitude': 5.077833,
       'altitude': 235,
       'libgeo': 'Colombier-Saugnieu',
       'codegeo': '69299',
       'nom_epci': "CC de l'Est Lyonnais (CCEL)",
       'code_epci': '246900575',
       'nom_dept': 'Rhône',
       'code_dep': '69',
       'nom_reg': 'Auvergne-Rhône-Alpes',
       'code_reg': '84',
       'mois_de_l_annee': 4},
      {'numer_sta': '07661',
       'date': '2017-04-06T18:00:00+00:00',
       'pmer': 101610,
       'tend': 110.0,
       'cod_tend': '3',
       'dd': 200,
       'ff': 3.2,
       't': 286.85,
       'td': 284.75,
       'u': 87,
       'vv': None,
       'ww': None,
       'w1': '0',
       'w2': None,
       'n': None,
       'nbas': None,
       'hbas': None,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 100010.0,
       'niv_bar': None,
       'geop': None,
       'tend24': -60.0,
       'tn12': 285.15,
       'tn24': None,
       'tx12': 291.25,
       'tx24': None,
       'tminsol': None,
       'sw': None,
       'tw': None,
       'raf10': 3.8,
       'rafper': 4.8,
       'per': -10.0,
       'etat_sol': None,
       'ht_neige': None,
       'ssfrai': None,
       'perssfrai': None,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': 0.0,
       'rr24': 0.0,
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
       'coordonnees': {'lon': 5.940833, 'lat': 43.079333},
       'nom': 'CAP CEPET',
       'type_de_tendance_barometrique': 'En baisse ou stationnaire, puis en hausse, ou en hausse, puis en hausse plus rapide',
       'temps_passe_1': 'Nuages ne couvrant pas plus de la moitié du ciel pendant toute la période considérée',
       'temps_present': None,
       'tc': 13.700000000000045,
       'tn12c': 12.0,
       'tn24c': None,
       'tx12c': 18.100000000000023,
       'tx24c': None,
       'tminsolc': None,
       'latitude': 43.079333,
       'longitude': 5.940833,
       'altitude': 115,
       'libgeo': 'Saint-Mandrier-sur-Mer',
       'codegeo': '83153',
       'nom_epci': 'Métropole Toulon-Provence-Méditerranée',
       'code_epci': '248300543',
       'nom_dept': 'Var',
       'code_dep': '83',
       'nom_reg': "Provence-Alpes-Côte d'Azur",
       'code_reg': '93',
       'mois_de_l_annee': 4},
      {'numer_sta': '07761',
       'date': '2017-04-06T18:00:00+00:00',
       'pmer': 101540,
       'tend': 100.0,
       'cod_tend': '3',
       'dd': 170,
       'ff': 1.2,
       't': 288.65,
       'td': 282.35,
       'u': 66,
       'vv': 34780.0,
       'ww': '0',
       'w1': None,
       'w2': None,
       'n': 90.0,
       'nbas': '7',
       'hbas': 1750.0,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 101430.0,
       'niv_bar': None,
       'geop': None,
       'tend24': 40.0,
       'tn12': 281.95,
       'tn24': None,
       'tx12': 291.05,
       'tx24': None,
       'tminsol': 282.65,
       'sw': None,
       'tw': None,
       'raf10': 1.8,
       'rafper': 3.3,
       'per': -10.0,
       'etat_sol': None,
       'ht_neige': 0.0,
       'ssfrai': None,
       'perssfrai': None,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': 0.0,
       'rr24': 0.0,
       'phenspe1': None,
       'phenspe2': None,
       'phenspe3': None,
       'phenspe4': None,
       'nnuage1': 6.0,
       'ctype1': None,
       'hnuage1': 1800.0,
       'nnuage2': 7.0,
       'ctype2': None,
       'hnuage2': 2160.0,
       'nnuage3': None,
       'ctype3': None,
       'hnuage3': None,
       'nnuage4': None,
       'ctype4': None,
       'hnuage4': None,
       'coordonnees': {'lon': 8.792667, 'lat': 41.918},
       'nom': 'AJACCIO',
       'type_de_tendance_barometrique': 'En baisse ou stationnaire, puis en hausse, ou en hausse, puis en hausse plus rapide',
       'temps_passe_1': None,
       'temps_present': 'On n’a pas observé d’évolution des nuages ou on n’a pas pu suivre cette évolution',
       'tc': 15.5,
       'tn12c': 8.800000000000011,
       'tn24c': None,
       'tx12c': 17.900000000000034,
       'tx24c': None,
       'tminsolc': 9.5,
       'latitude': 41.918,
       'longitude': 8.792667,
       'altitude': 5,
       'libgeo': 'Ajaccio',
       'codegeo': '2a004',
       'nom_epci': 'CA du Pays Ajaccien',
       'code_epci': '242010056',
       'nom_dept': 'Corse-du-Sud',
       'code_dep': '2a',
       'nom_reg': 'Corse',
       'code_reg': '94',
       'mois_de_l_annee': 4},
      {'numer_sta': '07130',
       'date': '2017-04-06T21:00:00+00:00',
       'pmer': 102900,
       'tend': 80.0,
       'cod_tend': '2',
       'dd': 360,
       'ff': 3.5,
       't': 282.25,
       'td': 279.35,
       'u': 82,
       'vv': 16130.0,
       'ww': '0',
       'w1': None,
       'w2': None,
       'n': None,
       'nbas': '0',
       'hbas': None,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 102440.0,
       'niv_bar': None,
       'geop': None,
       'tend24': -200.0,
       'tn12': None,
       'tn24': None,
       'tx12': None,
       'tx24': None,
       'tminsol': 282.95,
       'sw': None,
       'tw': None,
       'raf10': 5.1,
       'rafper': 6.4,
       'per': -10.0,
       'etat_sol': '0',
       'ht_neige': 0.0,
       'ssfrai': None,
       'perssfrai': None,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': None,
       'rr24': None,
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
       'coordonnees': {'lon': -1.734, 'lat': 48.068833},
       'nom': 'RENNES-ST JACQUES',
       'type_de_tendance_barometrique': 'En hausse',
       'temps_passe_1': None,
       'temps_present': 'On n’a pas observé d’évolution des nuages ou on n’a pas pu suivre cette évolution',
       'tc': 9.100000000000023,
       'tn12c': None,
       'tn24c': None,
       'tx12c': None,
       'tx24c': None,
       'tminsolc': 9.800000000000011,
       'latitude': 48.068833,
       'longitude': -1.734,
       'altitude': 36,
       'libgeo': 'Saint-Jacques-de-la-Lande',
       'codegeo': '35281',
       'nom_epci': 'Rennes Métropole',
       'code_epci': '243500139',
       'nom_dept': 'Ille-et-Vilaine',
       'code_dep': '35',
       'nom_reg': 'Bretagne',
       'code_reg': '53',
       'mois_de_l_annee': 4},
      {'numer_sta': '07591',
       'date': '2017-04-06T21:00:00+00:00',
       'pmer': None,
       'tend': 300.0,
       'cod_tend': '1',
       'dd': 360,
       'ff': 0.8,
       't': 281.35,
       'td': 275.15,
       'u': 65,
       'vv': 20000.0,
       'ww': '0',
       'w1': None,
       'w2': None,
       'n': None,
       'nbas': None,
       'hbas': None,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 91830.0,
       'niv_bar': None,
       'geop': '1508',
       'tend24': -70.0,
       'tn12': None,
       'tn24': None,
       'tx12': None,
       'tx24': None,
       'tminsol': 277.45,
       'sw': None,
       'tw': None,
       'raf10': 1.5,
       'rafper': 2.0,
       'per': -10.0,
       'etat_sol': None,
       'ht_neige': 0.0,
       'ssfrai': None,
       'perssfrai': None,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': 0.0,
       'rr24': 0.0,
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
       'coordonnees': {'lon': 6.502333, 'lat': 44.565667},
       'nom': 'EMBRUN',
       'type_de_tendance_barometrique': 'En hausse, puis stationnaire, ou en hausse, puis en hausse plus lente',
       'temps_passe_1': None,
       'temps_present': 'On n’a pas observé d’évolution des nuages ou on n’a pas pu suivre cette évolution',
       'tc': 8.200000000000045,
       'tn12c': None,
       'tn24c': None,
       'tx12c': None,
       'tx24c': None,
       'tminsolc': 4.300000000000011,
       'latitude': 44.565667,
       'longitude': 6.502333,
       'altitude': 871,
       'libgeo': 'Embrun',
       'codegeo': '05046',
       'nom_epci': 'CC Serre-Ponçon',
       'code_epci': '200067742',
       'nom_dept': 'Hautes-Alpes',
       'code_dep': '05',
       'nom_reg': "Provence-Alpes-Côte d'Azur",
       'code_reg': '93',
       'mois_de_l_annee': 4},
      {'numer_sta': '61980',
       'date': '2017-04-06T21:00:00+00:00',
       'pmer': 101620,
       'tend': -50.0,
       'cod_tend': '8',
       'dd': 110,
       'ff': 4.7,
       't': 298.35,
       'td': 292.75,
       'u': 71,
       'vv': 60000.0,
       'ww': None,
       'w1': None,
       'w2': None,
       'n': None,
       'nbas': '1',
       'hbas': 3780.0,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 101470.0,
       'niv_bar': None,
       'geop': None,
       'tend24': -50.0,
       'tn12': None,
       'tn24': None,
       'tx12': None,
       'tx24': None,
       'tminsol': None,
       'sw': None,
       'tw': None,
       'raf10': 6.5,
       'rafper': 8.1,
       'per': -10.0,
       'etat_sol': None,
       'ht_neige': None,
       'ssfrai': None,
       'perssfrai': None,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': 0.0,
       'rr24': 19.2,
       'phenspe1': None,
       'phenspe2': None,
       'phenspe3': None,
       'phenspe4': None,
       'nnuage1': 1.0,
       'ctype1': None,
       'hnuage1': 3780.0,
       'nnuage2': None,
       'ctype2': None,
       'hnuage2': None,
       'nnuage3': None,
       'ctype3': None,
       'hnuage3': None,
       'nnuage4': None,
       'ctype4': None,
       'hnuage4': None,
       'coordonnees': {'lon': 55.528667, 'lat': -20.8925},
       'nom': 'GILLOT-AEROPORT',
       'type_de_tendance_barometrique': 'Stationnaire ou en hausse, puis en baisse, ou en baisse, puis en baisse plus rapide',
       'temps_passe_1': None,
       'temps_present': None,
       'tc': 25.200000000000045,
       'tn12c': None,
       'tn24c': None,
       'tx12c': None,
       'tx24c': None,
       'tminsolc': None,
       'latitude': -20.8925,
       'longitude': 55.528667,
       'altitude': 8,
       'libgeo': 'Sainte-Marie',
       'codegeo': '97418',
       'nom_epci': 'CA Intercommunale du Nord de la Réunion (CINOR)',
       'code_epci': '249740119',
       'nom_dept': 'La Réunion',
       'code_dep': '974',
       'nom_reg': 'La Réunion',
       'code_reg': '04',
       'mois_de_l_annee': 4},
      {'numer_sta': '61976',
       'date': '2017-04-07T00:00:00+00:00',
       'pmer': 101250,
       'tend': 10.0,
       'cod_tend': None,
       'dd': 110,
       'ff': 7.4,
       't': 300.15,
       'td': 295.15,
       'u': 74,
       'vv': None,
       'ww': None,
       'w1': None,
       'w2': None,
       'n': None,
       'nbas': None,
       'hbas': None,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 101170.0,
       'niv_bar': None,
       'geop': None,
       'tend24': -90.0,
       'tn12': None,
       'tn24': 298.95,
       'tx12': None,
       'tx24': 304.15,
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
       'rr12': 1.8,
       'rr24': 3.2,
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
       'coordonnees': {'lon': 54.520667, 'lat': -15.887667},
       'nom': 'TROMELIN',
       'type_de_tendance_barometrique': None,
       'temps_passe_1': None,
       'temps_present': None,
       'tc': 27.0,
       'tn12c': None,
       'tn24c': 25.80000000000001,
       'tx12c': None,
       'tx24c': 31.0,
       'tminsolc': None,
       'latitude': -15.887667,
       'longitude': 54.520667,
       'altitude': 7,
       'libgeo': None,
       'codegeo': None,
       'nom_epci': None,
       'code_epci': None,
       'nom_dept': None,
       'code_dep': None,
       'nom_reg': None,
       'code_reg': None,
       'mois_de_l_annee': 4},
      {'numer_sta': '07280',
       'date': '2017-04-07T03:00:00+00:00',
       'pmer': 102600,
       'tend': -70.0,
       'cod_tend': '6',
       'dd': 360,
       'ff': 3.6,
       't': 277.35,
       'td': 273.65,
       'u': 77,
       'vv': 19890.0,
       'ww': '0',
       'w1': None,
       'w2': None,
       'n': None,
       'nbas': '0',
       'hbas': None,
       'cl': None,
       'cm': None,
       'ch': None,
       'pres': 99790.0,
       'niv_bar': None,
       'geop': None,
       'tend24': 60.0,
       'tn12': None,
       'tn24': None,
       'tx12': None,
       'tx24': None,
       'tminsol': 279.25,
       'sw': None,
       'tw': None,
       'raf10': 4.6,
       'rafper': 4.8,
       'per': -10.0,
       'etat_sol': '0',
       'ht_neige': 0.0,
       'ssfrai': None,
       'perssfrai': None,
       'rr1': 0.0,
       'rr3': 0.0,
       'rr6': 0.0,
       'rr12': 0.0,
       'rr24': 0.0,
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
       'coordonnees': {'lon': 5.088333, 'lat': 47.267833},
       'nom': 'DIJON-LONGVIC',
       'type_de_tendance_barometrique': 'En baisse, puis stationnaire, ou en baisse, puis en baisse plus lente',
       'temps_passe_1': None,
       'temps_present': 'On n’a pas observé d’évolution des nuages ou on n’a pas pu suivre cette évolution',
       'tc': 4.2000000000000455,
       'tn12c': None,
       'tn24c': None,
       'tx12c': None,
       'tx24c': None,
       'tminsolc': 6.100000000000023,
       'latitude': 47.267833,
       'longitude': 5.088333,
       'altitude': 219,
       'libgeo': 'Ouges',
       'codegeo': '21473',
       'nom_epci': 'Dijon Métropole',
       'code_epci': '242100410',
       'nom_dept': "Côte-d'Or",
       'code_dep': '21',
       'nom_reg': 'Bourgogne-Franche-Comté',
       'code_reg': '27',
       'mois_de_l_annee': 4}]}



### Demandes

- Récupérer les 500 premières observations
- Récupérer les observations faites en 2020
- Récupérer les observations à Ajaccio
- Récupérer les observations faites à plus de 200 mètres d'altitude, en 2022



```python
pandas.DataFrame(requests.get(url_base).json()["results"])
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
      <th>numer_sta</th>
      <th>date</th>
      <th>pmer</th>
      <th>tend</th>
      <th>cod_tend</th>
      <th>dd</th>
      <th>ff</th>
      <th>t</th>
      <th>td</th>
      <th>u</th>
      <th>...</th>
      <th>altitude</th>
      <th>libgeo</th>
      <th>codegeo</th>
      <th>nom_epci</th>
      <th>code_epci</th>
      <th>nom_dept</th>
      <th>code_dep</th>
      <th>nom_reg</th>
      <th>code_reg</th>
      <th>mois_de_l_annee</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>78925</td>
      <td>2017-04-06T15:00:00+00:00</td>
      <td>101830.0</td>
      <td>-10.0</td>
      <td>8</td>
      <td>110</td>
      <td>8.3</td>
      <td>303.45</td>
      <td>294.25</td>
      <td>58</td>
      <td>...</td>
      <td>3</td>
      <td>Le Lamentin</td>
      <td>97213</td>
      <td>CA du Centre de la Martinique</td>
      <td>249720061</td>
      <td>Martinique</td>
      <td>972</td>
      <td>Martinique</td>
      <td>02</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>07110</td>
      <td>2017-04-06T18:00:00+00:00</td>
      <td>102910.0</td>
      <td>-40.0</td>
      <td>6</td>
      <td>30</td>
      <td>4.1</td>
      <td>284.55</td>
      <td>279.25</td>
      <td>70</td>
      <td>...</td>
      <td>94</td>
      <td>Guipavas</td>
      <td>29075</td>
      <td>Brest Métropole</td>
      <td>242900314</td>
      <td>Finistère</td>
      <td>29</td>
      <td>Bretagne</td>
      <td>53</td>
      <td>4</td>
    </tr>
    <tr>
      <th>2</th>
      <td>07481</td>
      <td>2017-04-06T18:00:00+00:00</td>
      <td>102170.0</td>
      <td>80.0</td>
      <td>3</td>
      <td>340</td>
      <td>6.6</td>
      <td>285.75</td>
      <td>275.55</td>
      <td>50</td>
      <td>...</td>
      <td>235</td>
      <td>Colombier-Saugnieu</td>
      <td>69299</td>
      <td>CC de l'Est Lyonnais (CCEL)</td>
      <td>246900575</td>
      <td>Rhône</td>
      <td>69</td>
      <td>Auvergne-Rhône-Alpes</td>
      <td>84</td>
      <td>4</td>
    </tr>
    <tr>
      <th>3</th>
      <td>07661</td>
      <td>2017-04-06T18:00:00+00:00</td>
      <td>101610.0</td>
      <td>110.0</td>
      <td>3</td>
      <td>200</td>
      <td>3.2</td>
      <td>286.85</td>
      <td>284.75</td>
      <td>87</td>
      <td>...</td>
      <td>115</td>
      <td>Saint-Mandrier-sur-Mer</td>
      <td>83153</td>
      <td>Métropole Toulon-Provence-Méditerranée</td>
      <td>248300543</td>
      <td>Var</td>
      <td>83</td>
      <td>Provence-Alpes-Côte d'Azur</td>
      <td>93</td>
      <td>4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>07761</td>
      <td>2017-04-06T18:00:00+00:00</td>
      <td>101540.0</td>
      <td>100.0</td>
      <td>3</td>
      <td>170</td>
      <td>1.2</td>
      <td>288.65</td>
      <td>282.35</td>
      <td>66</td>
      <td>...</td>
      <td>5</td>
      <td>Ajaccio</td>
      <td>2a004</td>
      <td>CA du Pays Ajaccien</td>
      <td>242010056</td>
      <td>Corse-du-Sud</td>
      <td>2a</td>
      <td>Corse</td>
      <td>94</td>
      <td>4</td>
    </tr>
    <tr>
      <th>5</th>
      <td>07130</td>
      <td>2017-04-06T21:00:00+00:00</td>
      <td>102900.0</td>
      <td>80.0</td>
      <td>2</td>
      <td>360</td>
      <td>3.5</td>
      <td>282.25</td>
      <td>279.35</td>
      <td>82</td>
      <td>...</td>
      <td>36</td>
      <td>Saint-Jacques-de-la-Lande</td>
      <td>35281</td>
      <td>Rennes Métropole</td>
      <td>243500139</td>
      <td>Ille-et-Vilaine</td>
      <td>35</td>
      <td>Bretagne</td>
      <td>53</td>
      <td>4</td>
    </tr>
    <tr>
      <th>6</th>
      <td>07591</td>
      <td>2017-04-06T21:00:00+00:00</td>
      <td>NaN</td>
      <td>300.0</td>
      <td>1</td>
      <td>360</td>
      <td>0.8</td>
      <td>281.35</td>
      <td>275.15</td>
      <td>65</td>
      <td>...</td>
      <td>871</td>
      <td>Embrun</td>
      <td>05046</td>
      <td>CC Serre-Ponçon</td>
      <td>200067742</td>
      <td>Hautes-Alpes</td>
      <td>05</td>
      <td>Provence-Alpes-Côte d'Azur</td>
      <td>93</td>
      <td>4</td>
    </tr>
    <tr>
      <th>7</th>
      <td>61980</td>
      <td>2017-04-06T21:00:00+00:00</td>
      <td>101620.0</td>
      <td>-50.0</td>
      <td>8</td>
      <td>110</td>
      <td>4.7</td>
      <td>298.35</td>
      <td>292.75</td>
      <td>71</td>
      <td>...</td>
      <td>8</td>
      <td>Sainte-Marie</td>
      <td>97418</td>
      <td>CA Intercommunale du Nord de la Réunion (CINOR)</td>
      <td>249740119</td>
      <td>La Réunion</td>
      <td>974</td>
      <td>La Réunion</td>
      <td>04</td>
      <td>4</td>
    </tr>
    <tr>
      <th>8</th>
      <td>61976</td>
      <td>2017-04-07T00:00:00+00:00</td>
      <td>101250.0</td>
      <td>10.0</td>
      <td>None</td>
      <td>110</td>
      <td>7.4</td>
      <td>300.15</td>
      <td>295.15</td>
      <td>74</td>
      <td>...</td>
      <td>7</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>4</td>
    </tr>
    <tr>
      <th>9</th>
      <td>07280</td>
      <td>2017-04-07T03:00:00+00:00</td>
      <td>102600.0</td>
      <td>-70.0</td>
      <td>6</td>
      <td>360</td>
      <td>3.6</td>
      <td>277.35</td>
      <td>273.65</td>
      <td>77</td>
      <td>...</td>
      <td>219</td>
      <td>Ouges</td>
      <td>21473</td>
      <td>Dijon Métropole</td>
      <td>242100410</td>
      <td>Côte-d'Or</td>
      <td>21</td>
      <td>Bourgogne-Franche-Comté</td>
      <td>27</td>
      <td>4</td>
    </tr>
  </tbody>
</table>
<p>10 rows × 82 columns</p>
</div>




```python
df = requests.get(url_base).json()["results"]
df.columns
```


    ---------------------------------------------------------------------------

    gaierror                                  Traceback (most recent call last)

    File /usr/local/lib/python3.9/site-packages/urllib3/connection.py:169, in HTTPConnection._new_conn(self)
        168 try:
    --> 169     conn = connection.create_connection(
        170         (self._dns_host, self.port), self.timeout, **extra_kw
        171     )
        173 except SocketTimeout:


    File /usr/local/lib/python3.9/site-packages/urllib3/util/connection.py:73, in create_connection(address, timeout, source_address, socket_options)
         69     return six.raise_from(
         70         LocationParseError(u"'%s', label empty or too long" % host), None
         71     )
    ---> 73 for res in socket.getaddrinfo(host, port, family, socket.SOCK_STREAM):
         74     af, socktype, proto, canonname, sa = res


    File /usr/local/Cellar/python@3.9/3.9.9/Frameworks/Python.framework/Versions/3.9/lib/python3.9/socket.py:954, in getaddrinfo(host, port, family, type, proto, flags)
        953 addrlist = []
    --> 954 for res in _socket.getaddrinfo(host, port, family, type, proto, flags):
        955     af, socktype, proto, canonname, sa = res


    gaierror: [Errno 8] nodename nor servname provided, or not known

    
    During handling of the above exception, another exception occurred:


    NewConnectionError                        Traceback (most recent call last)

    File /usr/local/lib/python3.9/site-packages/urllib3/connectionpool.py:699, in HTTPConnectionPool.urlopen(self, method, url, body, headers, retries, redirect, assert_same_host, timeout, pool_timeout, release_conn, chunked, body_pos, **response_kw)
        698 # Make the request on the httplib connection object.
    --> 699 httplib_response = self._make_request(
        700     conn,
        701     method,
        702     url,
        703     timeout=timeout_obj,
        704     body=body,
        705     headers=headers,
        706     chunked=chunked,
        707 )
        709 # If we're going to release the connection in ``finally:``, then
        710 # the response doesn't need to know about the connection. Otherwise
        711 # it will also try to release it and we'll have a double-release
        712 # mess.


    File /usr/local/lib/python3.9/site-packages/urllib3/connectionpool.py:382, in HTTPConnectionPool._make_request(self, conn, method, url, timeout, chunked, **httplib_request_kw)
        381 try:
    --> 382     self._validate_conn(conn)
        383 except (SocketTimeout, BaseSSLError) as e:
        384     # Py2 raises this as a BaseSSLError, Py3 raises it as socket timeout.


    File /usr/local/lib/python3.9/site-packages/urllib3/connectionpool.py:1010, in HTTPSConnectionPool._validate_conn(self, conn)
       1009 if not getattr(conn, "sock", None):  # AppEngine might not have  `.sock`
    -> 1010     conn.connect()
       1012 if not conn.is_verified:


    File /usr/local/lib/python3.9/site-packages/urllib3/connection.py:353, in HTTPSConnection.connect(self)
        351 def connect(self):
        352     # Add certificate verification
    --> 353     conn = self._new_conn()
        354     hostname = self.host


    File /usr/local/lib/python3.9/site-packages/urllib3/connection.py:181, in HTTPConnection._new_conn(self)
        180 except SocketError as e:
    --> 181     raise NewConnectionError(
        182         self, "Failed to establish a new connection: %s" % e
        183     )
        185 return conn


    NewConnectionError: <urllib3.connection.HTTPSConnection object at 0x1224d73d0>: Failed to establish a new connection: [Errno 8] nodename nor servname provided, or not known

    
    During handling of the above exception, another exception occurred:


    MaxRetryError                             Traceback (most recent call last)

    File /usr/local/lib/python3.9/site-packages/requests/adapters.py:667, in HTTPAdapter.send(self, request, stream, timeout, verify, cert, proxies)
        666 try:
    --> 667     resp = conn.urlopen(
        668         method=request.method,
        669         url=url,
        670         body=request.body,
        671         headers=request.headers,
        672         redirect=False,
        673         assert_same_host=False,
        674         preload_content=False,
        675         decode_content=False,
        676         retries=self.max_retries,
        677         timeout=timeout,
        678         chunked=chunked,
        679     )
        681 except (ProtocolError, OSError) as err:


    File /usr/local/lib/python3.9/site-packages/urllib3/connectionpool.py:755, in HTTPConnectionPool.urlopen(self, method, url, body, headers, retries, redirect, assert_same_host, timeout, pool_timeout, release_conn, chunked, body_pos, **response_kw)
        753     e = ProtocolError("Connection aborted.", e)
    --> 755 retries = retries.increment(
        756     method, url, error=e, _pool=self, _stacktrace=sys.exc_info()[2]
        757 )
        758 retries.sleep()


    File /usr/local/lib/python3.9/site-packages/urllib3/util/retry.py:573, in Retry.increment(self, method, url, response, error, _pool, _stacktrace)
        572 if new_retry.is_exhausted():
    --> 573     raise MaxRetryError(_pool, url, error or ResponseError(cause))
        575 log.debug("Incremented Retry for (url='%s'): %r", url, new_retry)


    MaxRetryError: HTTPSConnectionPool(host='public.opendatasoft.com', port=443): Max retries exceeded with url: /api/explore/v2.1/catalog/datasets/donnees-synop-essentielles-omm/records (Caused by NewConnectionError('<urllib3.connection.HTTPSConnection object at 0x1224d73d0>: Failed to establish a new connection: [Errno 8] nodename nor servname provided, or not known'))

    
    During handling of the above exception, another exception occurred:


    ConnectionError                           Traceback (most recent call last)

    Cell In[27], line 1
    ----> 1 df = requests.get(url_base).json()["results"]
          2 df.columns


    File /usr/local/lib/python3.9/site-packages/requests/api.py:73, in get(url, params, **kwargs)
         62 def get(url, params=None, **kwargs):
         63     r"""Sends a GET request.
         64 
         65     :param url: URL for the new :class:`Request` object.
       (...)
         70     :rtype: requests.Response
         71     """
    ---> 73     return request("get", url, params=params, **kwargs)


    File /usr/local/lib/python3.9/site-packages/requests/api.py:59, in request(method, url, **kwargs)
         55 # By using the 'with' statement we are sure the session is closed, thus we
         56 # avoid leaving sockets open which can trigger a ResourceWarning in some
         57 # cases, and look like a memory leak in others.
         58 with sessions.Session() as session:
    ---> 59     return session.request(method=method, url=url, **kwargs)


    File /usr/local/lib/python3.9/site-packages/requests/sessions.py:589, in Session.request(self, method, url, params, data, headers, cookies, files, auth, timeout, allow_redirects, proxies, hooks, stream, verify, cert, json)
        584 send_kwargs = {
        585     "timeout": timeout,
        586     "allow_redirects": allow_redirects,
        587 }
        588 send_kwargs.update(settings)
    --> 589 resp = self.send(prep, **send_kwargs)
        591 return resp


    File /usr/local/lib/python3.9/site-packages/requests/sessions.py:703, in Session.send(self, request, **kwargs)
        700 start = preferred_clock()
        702 # Send the request
    --> 703 r = adapter.send(request, **kwargs)
        705 # Total elapsed time of the request (approximately)
        706 elapsed = preferred_clock() - start


    File /usr/local/lib/python3.9/site-packages/requests/adapters.py:700, in HTTPAdapter.send(self, request, stream, timeout, verify, cert, proxies)
        696     if isinstance(e.reason, _SSLError):
        697         # This branch is for urllib3 v1.22 and later.
        698         raise SSLError(e, request=request)
    --> 700     raise ConnectionError(e, request=request)
        702 except ClosedPoolError as e:
        703     raise ConnectionError(e, request=request)


    ConnectionError: HTTPSConnectionPool(host='public.opendatasoft.com', port=443): Max retries exceeded with url: /api/explore/v2.1/catalog/datasets/donnees-synop-essentielles-omm/records (Caused by NewConnectionError('<urllib3.connection.HTTPSConnection object at 0x1224d73d0>: Failed to establish a new connection: [Errno 8] nodename nor servname provided, or not known'))



```python

```
