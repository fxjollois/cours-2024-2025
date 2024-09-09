# Premiers éléments de collecte de données sur le web

## Lecture du fichier de départ

Pour lire le fichier `StockEtablissement`, nous utilisons la librarie `pandas`

- Notez l'argument `nrows = 10` pour lire uniquement les 10 premières lignes
- *A savoir* pour plus tard : 
    - L'argument `skiprows = range(1, 6)` permet de ne pas prendre en considération les lignes 1 à 5 (et donc de garder la ligne d'en-têtes - noms de colonnes)

```python
import pandas

sirene = pandas.read_csv("StockEtablissement_utf8_1000.csv", nrows = 10)
sirene
```

Le dataframe étant trop large, toutes les colonnes ne sont pas affichées. Pour avoir les colonnes contenant l'adresse, nous pouvons sélectionner celles-ci directement, comme ci-dessous par exemple

```python
sirene[["siren", "siret", "numeroVoieEtablissement", "indiceRepetitionEtablissement",
       "typeVoieEtablissement", "libelleVoieEtablissement",
       "codePostalEtablissement", "libelleCommuneEtablissement",
       "libelleCommuneEtrangerEtablissement"]]
```

Pour stocker le résultat, il faut écrire dans un fichier (nous allons garder le format `csv`).

- Le paramètre `index = False` permet de ne pas avoir l'index des lignes (inutile dans notre cas)
- *A savoir* pour plus tard : 
    - Le paramètre `header = False` permet de ne pas ajouter les noms des colonnes
    - Le paramètre `mode = "a"` (pour *append*) permet d'ajouter des lignes à un fichier, sans écraser ce qu'il y a déjà dedans

```python
sirene.to_csv("export.csv", index = False)
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

Dans notre cas, il y a plusieurs résultats. Généralement, le premier est celui avec le `score` le plus élevé.
