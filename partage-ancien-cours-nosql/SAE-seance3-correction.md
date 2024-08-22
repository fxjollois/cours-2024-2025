# SAE - Séance 3 - *correction*

## SQL vers NoSQL

Dans cet exemple, nous allons utiliser la petite base de données `Gymnase2000`, disponible au format SQLite [sur ce lien](https://fxjollois.github.io/donnees/Gymnase2000/Gymnase2000.sqlite). Voici son schéma relationnel

![Schéma ER de World.sqlite](https://fxjollois.github.io/donnees/Gymnase2000/Gymnase2000.png)

Dans ce schéma, après analyse, on décide de créer **2 collections** :

- **Sportifs** : chaque document concernera un seul *sportif*, dans lequel on notera en plus les sports qu'il *joue*, qu'il *entraîne* et qu'il *arbitre*, sous la forme d'une chaîne de caractère. On devra aussi ajouter l'identifiant du *sportif conseiller* ;
- **Gymnases** : ici, chaque document concernant un seul *gymnase*, dans lequel on ajoutera les informations de toutes les *séances* prévues, dans un tableau

### Extraction des données


```python
import sqlite3
import pandas

conn = sqlite3.connect("Gymnase2000.sqlite")
```


```python
gymnases = pandas.read_sql_query(
    "SELECT * FROM Gymnases;", 
    conn
)
seances = pandas.read_sql_query(
    "SELECT * FROM Seances INNER JOIN Sports USING (IdSport);", 
    conn
)
```


```python
sportifs = pandas.read_sql_query(
    "SELECT * FROM Sportifs;", 
    conn
)
jouer = pandas.read_sql_query(
    "SELECT * FROM Jouer NATURAL JOIN Sports;", 
    conn
)
arbitrer = pandas.read_sql_query(
    "SELECT * FROM Arbitrer NATURAL JOIN Sports;", 
    conn
)
entrainer = pandas.read_sql_query(
    "SELECT * FROM Entrainer NATURAL JOIN Sports;", 
    conn
)
```

### Transformation


```python
liste = [seances.query('IdGymnase == @id').drop(columns=["IdGymnase", "IdSport"]).to_dict(orient = "records") for id in gymnases.IdGymnase]
gymnases = gymnases.assign(Seances = liste)
```


```python
sportifs2 = sportifs.assign(
    Jouer = [list(jouer.query("IdSportif == @id").Libelle) if id in list(jouer.IdSportif) else None for id in sportifs.IdSportif],
    Arbitrer = [list(arbitrer.query("IdSportif == @id").Libelle) if id in list(arbitrer.IdSportif) else None for id in sportifs.IdSportif],
    Entrainer = [list(entrainer.query("IdSportifEntraineur == @id").Libelle)  if id in list(entrainer.IdSportifEntraineur) else None for id in sportifs.IdSportif]
)
```

### Chargement dans Mongo


```python
import pymongo

client = pymongo.MongoClient()
db = client.SAE

db.Gymnases.insert_many(gymnases.to_dict(orient = "records"))
db.Sportifs.insert_many(sportifs2.to_dict(orient = "records"))
```




    <pymongo.results.InsertManyResult at 0x188c4d681d0>



### Exemple de jointure entre les deux collections

On va récupérer le nom des entraîneurs qui ont une séance prévue à *SARCELLES*, ainsi que la liste des gymnases dans lequel ils ont une séance.


```python
c = db.Gymnases.aggregate([
    { "$match": { "Ville": "SARCELLES" }},
    { "$unwind": "$Seances" },
    { "$group": {
        "_id": "$Seances.IdSportifEntraineur",
        "liste": { "$addToSet": "$NomGymnase" }
    }},
    { "$lookup": {
        "from": "Sportifs",
        "localField": "_id",
        "foreignField": "IdSportif",
        "as": "Entraineur"
    }},
    { "$addFields": { "Entraineur": { "$first": "$Entraineur" }}},
    { "$project": {
        "_id": 0,
        "Nom": "$Entraineur.Nom",
        "Prénom": "$Entraineur.Prenom",
        "Gymnases": "$liste"
    }}
])
pandas.DataFrame(list(c))
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
      <th>Gymnases</th>
      <th>Nom</th>
      <th>Prénom</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>[SAMOURAI]</td>
      <td>TIZEGHAT</td>
      <td>Benamar</td>
    </tr>
    <tr>
      <th>1</th>
      <td>[LUMIERES, BRASSENS, PAUL ELUARD, SAMOURAI, CA...</td>
      <td>RETALDI</td>
      <td>Sophie</td>
    </tr>
    <tr>
      <th>2</th>
      <td>[BRASSENS, SAMOURAI]</td>
      <td>BOISSEAU</td>
      <td>Eric</td>
    </tr>
    <tr>
      <th>3</th>
      <td>[PAUL ELUARD]</td>
      <td>BELZ</td>
      <td>Sylvianne</td>
    </tr>
  </tbody>
</table>
</div>



## SQL vers NoSQL


```python
movies = sqlite3.connect("Movies.sqlite")
```

```python
corresp = pandas.DataFrame(list(db.movies.find({}, { "_id": 1 })))
corresp = corresp.assign(id_film = range(1, len(corresp) + 1))
```

## fonction de gestion d'une liste vers 2 tables


```python
def gestion_liste(champs, nom):
    liste = db.movies.distinct(champs)
    entite = pandas.DataFrame({
        "id": range(1, len(liste)+1),
        "v": liste
    })
    entite.columns = ["id_" + nom, nom]
    entite.to_sql(nom, movies, index = False, if_exists = "replace")
    
    df = pandas.DataFrame(list(db.movies.find({}, { champs: 1 }))) \
        .dropna() \
        .merge(corresp) \
        .drop(columns = ["_id"])
    df2 = pandas.concat([pandas.DataFrame(g).assign(id_film = i) for (i, g) in zip(df.id_film, df[champs]) if g])
    df2.columns = [nom, "id_film"]
    entre = pandas.merge(df2, entite).drop(columns = nom).sort_values(by = "id_film")
    entre.to_sql("film_" + nom, movies, index = False, if_exists = "replace")
```


```python
gestion_liste("genres", "genre")
gestion_liste("cast", "acteur")
gestion_liste("languages", "langue")
gestion_liste("countries", "pays")
gestion_liste("directors", "directeur")
gestion_liste("writers", "scenariste")
```

## fonction de gestion champs vers une table


```python
def gestion_champs(champs, nom): 
    liste = db.movies.distinct(champs)
    entite = pandas.DataFrame({
        "id": range(1, len(liste)+1),
        "v": liste
    })
    entite.columns = ["id_" + nom, nom]
    entite.to_sql(nom, movies, index = False, if_exists = "replace")
    return entite
```


```python
classement = gestion_champs("rated", "classement")
```


```python
type = gestion_champs("type", "type")
```

## Création table Film


```python
liste_rejets = {
    "genres": 0, "cast": 0, "languages": 0,
    "countries": 0, "directors": 0, "writers": 0,
    "imdb": 0, "tomatoes": 0
}
film = pandas.DataFrame(list(db.movies.find({}, liste_rejets)))
```


```python
film = corresp.merge(film) \
    .merge(classement, left_on = "rated", right_on = "classement") \
    .drop(columns = ["rated", "classement"]) \
    .merge(type) \
    .drop(columns = ["type"]) \
    .drop(columns = ["_id"])
```

## Award


```python
film = pandas.concat([film, pandas.DataFrame([e for e in film.awards])], axis = 1) \
    .drop(columns = ["awards"])
```


```python
film.to_sql("film", movies, index = False, if_exists = "replace")
```

## IMDB


```python
imdb = pandas.DataFrame(list(db.movies.find({}, {"imdb": 1}))) \
    .merge(corresp) \
    .drop(columns = ["_id"])
imdb = pandas.concat([
    imdb.drop(columns = "imdb"),
    pandas.DataFrame([e for e in imdb.imdb])
], axis = 1)
```


```python
imdb.to_sql("imdb", movies, index = False, if_exists = "replace")
```

### Tomatoes

en trois tables

#### Table générale


```python
rt = pandas.DataFrame(list(db.movies.aggregate([
    { "$match": { "tomatoes": { "$exists": True } }},
    { "$project": { "tomatoes": 1 }},
    { "$project": { "tomatoes.viewer": 0, "tomatoes.critic": 0 }}
]))) \
    .merge(corresp) \
    .drop(columns = ["_id"])
rt = pandas.concat([
    rt.drop("tomatoes", axis = 1),
    pandas.DataFrame([e for e in rt.tomatoes])
], axis = 1)
```


```python
rt.to_sql("rt", movies, index = False, if_exists = "replace")
```

#### Table viewer


```python
rt_viewer = pandas.DataFrame(list(db.movies.aggregate([
    { "$match": { "tomatoes.viewer": { "$exists": True }}},
    { "$project": {
        "viewer": "$tomatoes.viewer"
    }}
]))) \
    .merge(corresp) \
    .drop(columns = ["_id"])
rt_viewer = pandas.concat([
    rt_viewer.drop("viewer", axis = 1),
    pandas.DataFrame([e for e in rt_viewer.viewer])
], axis = 1)
```


```python
rt_viewer.to_sql("rt_viewer", movies, index = False, if_exists = "replace")
```


```python
rt_critic = pandas.DataFrame(list(db.movies.aggregate([
    { "$match": { "tomatoes.critic": { "$exists": True }}},
    { "$project": {
        "critic": "$tomatoes.critic"
    }}
]))) \
    .merge(corresp) \
    .drop(columns = ["_id"])
rt_critic = pandas.concat([
    rt_critic.drop("critic", axis = 1),
    pandas.DataFrame([e for e in rt_critic.critic])
], axis = 1)
```


```python
rt_critic.to_sql("rt_critic", movies, index = False, if_exists = "replace")
```

## Déconnexion des liens vers les bases


```python
movies.close()
```


```python
conn.close()
```


```python
client.close()
```
