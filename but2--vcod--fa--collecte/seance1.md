# Premiers éléments de collecte de données sur le web

Nous allons voir ici comment utiliser une API simple pour récupérer des données.

## Idée principale

A partir des données de la [base SIRENE](https://www.data.gouv.fr/fr/datasets/base-sirene-des-entreprises-et-de-leurs-etablissements-siren-siret/) (et plus particulièrement le fichier `StockEtablissement`), nous voulons compléter les informations par les coordonnées géographiques via l'[API Adresse](https://adresse.data.gouv.fr/api-doc/adresse) ([guide](https://guides.etalab.gouv.fr/apis-geo/1-api-adresse.html#les-donnees-d-adresses)).

### A noter

- Fichier de départ très lourd (**6,84 Go**) donc à ne pas charger en une fois dans Python
- Développer le code sur 500 ou 1000 lignes (pas forcément les premières)
- [Fichier avec les 1000 premières lignes](StockEtablissement_utf8_1000.csv)
- Appel à l'API Adresse à modérer (limite de 50 requêtes par seconde)
- Utilisation de `time.sleep(1)` par exemple (ne pas oublier `import time`) pour retarder d'une seconde ce qui suit

## Lecture du fichier de départ

Pour lire le fichier `StockEtablissement`, nous utilisons la librarie `pandas`

- Notez l'argument `nrows = 10` pour lire uniquement les 10 premières lignes
- *A savoir* pour plus tard : 
    - L'argument `skiprows = range(1, 6)` permet de ne pas prendre en considération les lignes 1 à 5 (et donc de garder la ligne d'en-têtes - noms de colonnes)

```python
import pandas

sirene = pandas.read_csv("StockEtablissement_utf8_1000.csv", nrows = 1000)
sirene
```

Le dataframe étant trop large, toutes les colonnes ne sont pas affichées. Pour avoir les colonnes contenant l'adresse, nous pouvons sélectionner celles-ci directement, comme ci-dessous par exemple

```python
sirene[["siren", "siret", "numeroVoieEtablissement", "indiceRepetitionEtablissement",
       "typeVoieEtablissement", "libelleVoieEtablissement",
       "codePostalEtablissement", "libelleCommuneEtablissement"]]
```

> Noter la présence de `NaN` dans les numéros de voie. Pour le prendre en compte, vous pouvez utiliser la fonction `isna()` de la librairie `pandas`, permettant de tester si une valeur est `NaN`.

<!--
# siren,siret,adresse,postcode,city
def f(n, i, t, l):
    if not(pandas.isna(n)):
        res = str(int(n))
    else:
        res = ""
    if not(pandas.isna(i)):
        res += " " + i
    if not(pandas.isna(t)):
        res += " " + t
    if not(pandas.isna(l)):
        res += " " + l
    return res

adresse = [f(sirene["numeroVoieEtablissement"][i], sirene["indiceRepetitionEtablissement"][i], sirene["typeVoieEtablissement"][i], sirene["libelleVoieEtablissement"][i]) for i in range(sirene.shape[0])]

dataframe = pandas.DataFrame({
    "siren": sirene["siren"],
    "siret": sirene["siret"],
    "adresse": adresse,
    "postcode": sirene["codePostalEtablissement"],
    "city": sirene["libelleCommuneEtablissement"]
})
-->

Pour stocker le résultat, il faut écrire dans un fichier (nous allons garder le format `csv`).

- Le paramètre `index = False` permet de ne pas avoir l'index des lignes (inutile dans notre cas)
- *A savoir* pour plus tard : 
    - Le paramètre `header = False` permet de ne pas ajouter les noms des colonnes
    - Le paramètre `mode = "a"` (pour *append*) permet d'ajouter des lignes à un fichier, sans écraser ce qu'il y a déjà dedans

```python
dataframe.to_csv("export_for_search.csv", index = False)
```

## Récupération de données de l'API Adresse

### D'une adresse vers des coordonnées géographiques

A partir d'une adresse (par exemple, le *143 Avenue de Versailles, Paris*), nous allons chercher les coordonnées géographiques de ce lieu. 

Pour cela, nous avons besoin du package `requests` (généralement déjà présent).

```python
import requests

adresse = "143+avenue+Versailles+paris"
url = "https://api-adresse.data.gouv.fr/search/"
recherche = url + "?q=" + adresse

reponse = requests.get(recherche)
reponse
```

Si le résultat est `<Response [200]>`, c'est que tout est OK. Sinon, se reporter à la [liste des erreurs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

On peut ensuite récupérer les résultats au format `JSON` 

```python
reponse.json()
```

Dans notre cas, il y a plusieurs résultats (dans le champs `features`). Généralement, le premier est celui avec le `score` le plus élevé.

### Interrogation de l'API Adresse par fichier `CSV`

Comme indiqué sur la [page de l'API](https://adresse.data.gouv.fr/api-doc/adresse), il est possible de requêter sur plusieurs adresses, via un fichier `CSV`. 

Pour faire cela en Python, voici comment on peut faire, en partant d'un fichier `CSV` créé en amont à partir des données SIRENE (voir par exemple [`export_for_search.csv`](export_for_search.csv))

```python
import requests

url = "https://api-adresse.data.gouv.fr/search/csv/"
fichier = open("export_for_search.csv", "rb") # ouverture en lecture ("r") binaire ("b")

r = requests.post(url, files = {"data": fichier})
r.text # contenu du résultat dans un format CSV
```

Une fois le résultat obtenu, on peut le sauvegarder dans un fichier texte, avec l'extension `csv` par exemple. Le paramètre `encoding` permet de gérer l'encodage (UTF-8 est souvent à préférer, pour information).

```python
fichier_resultat = open("export_for_search_results.csv", "w", encoding = "utf-8")
fichier_resultat.write(r.text)
fichier_resultat.close()
```

Une fois cela fait, on peut importer le résulat dans un DataFrame.

```python
pandas.read_csv("export_for_search_results.csv")
```

> Il ne reste plus qu'à faire **correctement** la jointure avec le premier fichier pour compléter les informations.

#### A NOTER

- Le fichier envoyé doit faire **moins de 50 Mo** !
- Il faut donc procéder par blocs d'entreprises (on ne pourra pas envoyer toutes les adresses en une fois).
- Le format de celui-ci est imposé, en particulier le nom des colonnes et probablement l'ordre de celles-ci.

## A FAIRE

Ecrire le programme permettant de compléter le fichier complet de la base SIRENE. En sortie, on feut un fichier `csv` avec l'ensemble des informations présentes dans le fichier original, avec en plus les coordonnées (latitude et longitude).

<div style="margin: 0 auto;">
<img src="https://docs.google.com/drawings/d/e/2PACX-1vQ8w8RBK_hPrfGlrYncI9SkreCQUxWx6OMZkeWuX-tGpRGGU3sItjdJMa3350BJ7248evxh6-g8ZQd3/pub?w=1308&amp;h=717">
</div>
