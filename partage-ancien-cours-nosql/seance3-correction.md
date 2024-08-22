# NoSQL - Séance 3 - *correction*


```python
import pymongo
import pandas

USER = "user"
PASS = "user"
HOST = "cluster0.ougec.mongodb.net"

URI = "mongodb+srv://%s:%s@%s/" % (USER, PASS, HOST)

client = pymongo.MongoClient(URI) # enlever le paramètre URI si connexion locale
db = client.test
```

## Données Restaurants

### Quelles sont les 10 plus grandes chaînes de restaurants (nom identique) ?

TOP 10 classique (2 façons de faire donc)


```python
c = db.restaurants.aggregate([
    { "$match": { "name": { "$ne": "" }}},
    { "$project": { "name": { "$cond": {
        "if": { "$eq": [ "$name", "Dunkin' Donuts" ]},
        "then": "Dunkin Donuts",
        "else": "$name"
    }}}},
    { "$sortByCount": "$name"},
    { "$limit": 10}
])
pandas.DataFrame(list(c))
```

### Donner le Top 5 et le Flop 5 des types de cuisine, en terme de nombre de restaurants

idem, avec le tri qui change entre les 2 demandes


```python
c = db.restaurants.aggregate([
    { "$group": { "_id": "$cuisine", "nb": { "$sum": 1 }}},
    { "$sort": { "nb": -1 }},
    { "$limit": 5}
])
pandas.DataFrame(list(c))
```


```python
c = db.restaurants.aggregate([
    { "$group": { "_id": "$cuisine", "nb": { "$sum": 1 }}},
    { "$sort": { "nb": 1 }},
    { "$limit": 5}
])
pandas.DataFrame(list(c))
```


### Quelles sont les 10 rues avec le plus de restaurants ?

TOP 10 aussi


```python
c = db.restaurants.aggregate([
    { "$sortByCount": "$address.street" },
    { "$limit": 10 }
])
pandas.DataFrame(list(c))
```



```python
c = db.restaurants.aggregate([
    { "$group": {
        "_id": { 
            "rue": "$address.street", 
            "quartier": "$borough"
        },
        "nb": { "$sum": 1 }
    }},
    { "$project": {
        "_id": 0, "rue": "$_id.rue", 
        "quartier": "$_id.quartier", "nb": 1
    }},
    { "$sort": { "nb": -1 }},
    { "$limit": 10 }
])
pandas.DataFrame(list(c))
```



### Quelles sont les rues situées sur strictement plus de 2 quartiers ?

- Essayez d’ajouter le nom des quartiers de chaque rue (cf `addToSet`)


```python
c = db.restaurants.aggregate([
    { "$group": {
        "_id": "$address.street",
        "quartiers": { "$addToSet": "$borough" }
    }},
    { "$addFields": { "nbq": { "$size": "$quartiers"}}},
    { "$sort": { "nbq": -1 }},
    { "$match": { "nbq": { "$gt": 2 }}}
])
pandas.DataFrame(list(c))
```



### Lister par quartier le nombre de restaurants et le score moyen

- Attention à bien découper le tableau `grades`


```python
# Version simple -> score moyen de la dernière visite
c = db.restaurants.aggregate([
    { "$addFields": {
        "eval": { "$first": "$grades" }
    }},
    { "$group": {
        "_id": "$borough",
        "nb_restaurants": { "$sum": 1 },
        "score_moyen": { "$avg": "$eval.score" }
    }},
    { "$sort": { "score_moyen": 1 }}
])
pandas.DataFrame(list(c)).round(2)
```




```python
# Version complexe -> score moyen de toutes les visites
c = db.restaurants.aggregate([
    { "$unwind": "$grades" },
    { "$group": {
        "_id": { "id_resto": "$_id", "br": "$borough" },
        "nb_visites": { "$sum": 1 }, 
        "score_tot": { "$sum": "$grades.score" }
    }},
    { "$group": {
        "_id": "$_id.br",
        "nb_restaurants": { "$sum": 1 },
        "nb_visites": { "$sum": "$nb_visites" },
        "score_total": { "$sum": "$score_tot" }
    }},
    { "$addFields": {
        "score_moyen": { 
            "$divide": [ "$score_total", "$nb_visites" ]
                       }
    }},
    { "$sort": { "score_moyen": 1 }}
])
pandas.DataFrame(list(c)).round(2)
```




```python
# Version complexe 2 -> score moyen de la dernière visite
c = db.restaurants.aggregate([
    { "$unwind": "$grades" },
    { "$group": {
        "_id": "$borough",
        "liste_restaurants": { "$addToSet": "$_id" },
        "score_moyen": { "$avg": "$grades.score" }
    }},
    { "$addFields": { 
        "nb_resto": { "$size": "$liste_restaurants" }
    }},
    { "$sort": { "score_moyen": 1 }}
])
pandas.DataFrame(list(c)).round(2)
```




### Donner les dates de début et de fin des évaluations

- min et max sont dans un bateau



```python
c = db.restaurants.aggregate([
    { "$unwind": "$grades" },
    { "$group": {
        "_id": "Tous",
        "deb": { "$min": "$grades.date" },
        "fin": { "$max": "$grades.date" }
    }}
])
pandas.DataFrame(list(c))
```




### Quels sont les 10 restaurants (nom, quartier, addresse et score) avec le plus petit score moyen ?

- découpage, regroupement par restaurant, tri et limite


```python
# Version à partir des éléments vus en cours
c = db.restaurants.aggregate([
    { "$unwind": "$grades" },
    { "$match": { "grades.score": { "$gte": 0 }}},
    { "$group": {
        "_id": { "n": "$name", "b": "$borough", "a": "$address" },
        "score": { "$avg": "$grades.score" },
        "nb_grades": { "$sum": 1 }
    }},
    { "$sort": { "score": 1, "nb_grades": -1 }},
    { "$limit": 10 },
    { "$project": {
        "Nom": "$_id.n", "Quartier": "$_id.q",
        "Adresse": "$_id.a", "score": 1, "_id": 0,
        "nb_grades": 1
    }}
])
pandas.DataFrame(list(c))
```



### Quels sont les restaurants (nom, quartier et addresse) avec uniquement des grades “A” ?

- restriction à ceux qui ont A, découpage, suppression des autres grades que “A” et affichage des infos
- on peut envisager d’autres choses (découpage, addToSet, et restriction à ceux pour lequel le tableau créé = [“A”] - par exemple)


```python
c = db.restaurants.aggregate([
    { "$unwind": "$grades" },
    { "$group": {
        "_id": { "n": "$name", "b": "$borough", "a": "$address" },
        "grades": { "$addToSet": "$grades.grade" },
        "liste": { "$push": "$grades.grade" }
    }},
    { "$match": { "grades": [ "A" ] }},
    { "$project": {
        "Nom": "$_id.n", "Quartier": "$_id.q",
        "Adresse": "$_id.a", "grades": 1, "_id": 0, "liste": 1
    }}
])
pandas.DataFrame(list(c))
```



### Compter le nombre d’évaluation par jour de la semaine

- petite recherche sur l’extraction du jour de la semaine à partir d’une date à faire



```python
c = db.restaurants.aggregate([
    { "$unwind": "$grades" },
    { "$addFields": { "jourSem": { "$dayOfWeek": "$grades.date" } }},
    { "$group": { "_id": "$jourSem", "nb": { "$sum": 1 }}},
    { "$sort": { "_id": 1 }}
])
pandas.DataFrame(list(c))
```




### Donner les 3 types de cuisine les plus présents par quartier

- simple à dire, compliqué à faire
- une piste
    - double regroupement à prévoir
    - tri à prévoir
    - regroupement avec push
    - slice pour prendre une partie d’un tableau


```python
c = db.restaurants.aggregate([
    { "$group": { 
        "_id": { "q": "$borough", "c": "$cuisine" },
        "nb": { "$sum": 1}
    }},
    { "$project": {
        "quartier": "$_id.q", "cuisine": "$_id.c", "nb": 1, "_id": 0
    }},
    { "$sort": { "quartier": 1, "nb": -1 }},
    { "$group": {
        "_id": "$quartier",
        "cuisines": { "$push": "$cuisine"}
    }},
    { "$project": {
        "quartier": "$_id", "_id": 0, "cuisines": { "$slice": [ "$cuisines", 3 ]}
    }}
])
pandas.DataFrame(list(c))
```



## Données AirBnb


```python
db = client.sample_airbnb
```


```python
db.listingsAndReviews.count_documents({})
```


### Lister les différentes types de logements possibles cf (room_type)


```python
db.listingsAndReviews.distinct("room_type")
```


### Lister les différents équipements possibles cf (amenities)


```python
db.listingsAndReviews.distinct("amenities")
```



### Donner le nombre de logements


```python
db.listingsAndReviews.count_documents({})
```


### Donner le nombre de logements de type "Entire home/apt"


```python
db.listingsAndReviews.count_documents({ "room_type": "Entire home/apt"})
```



### Donner le nombre de logements proposant la "TV" et le "Wifi (cf amenities)


```python
db.listingsAndReviews.count_documents({ "amenities": "TV", "amenities": "Wifi"})
```



```python
db.listingsAndReviews.count_documents({ "amenities": { "$in": ["TV", "Wifi"]}})
```


### Donner le nombre de logements n'ayant eu aucun avis

il existe les champs number_of_reviews et reviews (tableau des avis) - vérifiez qu'ils soient cohérents


```python
db.listingsAndReviews.count_documents({ "number_of_reviews": 0})
```



```python
db.listingsAndReviews.count_documents({ "reviews": { "$exists": True}})
```



```python
db.listingsAndReviews.count_documents({ "reviews": []})
```



### Lister les informations du logement "10545725" (cf _id)


```python
list(db.listingsAndReviews.find({ "_id": "10545725" }))
```



### Lister le nom, la rue et le pays des logements dont le prix est supérieur à 10000


```python
c = db.listingsAndReviews.find(
    { "price": { "$gt": 10000 }},
    { "_id": 0, "name": 1, 
      "address.country": 1, "address.street": 1}
)
pandas.DataFrame(list(c))
```



### Donner le nombre de logements par type


```python
c = db.listingsAndReviews.aggregate([
    { "$sortByCount": "$room_type"}
])
pandas.DataFrame(list(c))
```



### Donner le nombre de logements par pays


```python
c = db.listingsAndReviews.aggregate([
    { "$sortByCount": "$address.country"}
])
pandas.DataFrame(list(c))
```


### On veut représenter graphiquement la distribution des prix, il nous faut donc récupérer uniquement les tarifs

- Un tarif qui apparaît plusieurs fois dans la base doit être présent plusieurs fois dans cette liste


```python
c = db.listingsAndReviews.find({}, { "_id": 0, "price": 1})
prix = list(c)
prix
```


```python
import matplotlib.pyplot as plt
# plt.hist(prix)
plt.hist([float(str(e["price"])) for e in prix])
```



```python
plt.hist([a for a in [float(str(e["price"])) for e in prix] if a < 3000])
```



### Calculer pour chaque type de logements (room_type) le prix (price)


```python
c = db.listingsAndReviews.aggregate([
    { "$group": { "_id": "$room_type", 
                  "prix": { "$avg": "$price"}}},
    { "$project": { "_id": 0, "type logements": "$_id",
                    "prix": { "$round": [ "$prix", 2 ] }}}
])
pandas.DataFrame(list(c))
```




### On veut représenter la distribution du nombre d'avis. Il faut donc calculer pour chaque logement le nombre d'avis qu'il a eu (cf reviews)


```python
c = db.listingsAndReviews.aggregate([
    { "$project": { 
        "nb_affiche": "$number_of_reviews",
        "nb_calcule": { "$size": "$reviews" }
    }}
])
temp = pandas.DataFrame(list(c))
temp.query("nb_affiche != nb_calcule")
```




### Compter le nombre de logement pour chaque équipement possible


```python
c = db.listingsAndReviews.aggregate([
    { "$unwind": "$amenities" },
    { "$sortByCount": "$amenities" }
])
pandas.DataFrame(list(c))
```

