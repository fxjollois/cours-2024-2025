# Interrogation de l'API Adresse par fichier `CSV`

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

### A NOTER

Le fichier envoyé doit faire **moins de 50 Mo** !
