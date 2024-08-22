# NoSQL - Séance 2 - *Correction*

```
import pymongo
import pandas

client = pymongo.MongoClient()
db = client.test
```


##### Donner les styles de cuisine présent dans la collection
```
db.restaurants.distinct("cuisine")
```

##### Donner tous les grades possibles dans la base
```
db.restaurants.distinct("grades.grade")
```

##### Compter le nombre de restaurants proposant de la cuisine française (“French”)
```
db.restaurants.count_documents({ "cuisine": "French" })
```

##### Compter le nombre de restaurants situé sur la rue “Central Avenue”
```
db.restaurants.count_documents({ "address.street": "Central Avenue" })
```

##### Compter le nombre de restaurants ayant eu une note supérieure à 50
```
db.restaurants.count_documents({
	"grades.score": { "$gt": 50 }
})
```

##### Lister tous les restaurants, en n’affichant que le nom, l’immeuble et la rue
```
c = db.restaurants.find(
	{},
	{ "_id": 0 , "name": 1, "address.building": 1, "address.street": 1 }
)
pandas.DataFrame(list(c))
```

##### Lister tous les restaurants nommés “Burger King” (nom et quartier uniquement)
```
c = db.restaurants.find(
	{ "name": "Burger King" },
	{ "_id": 0, "name": 1, "borough": 1 }
)
pandas.DataFrame(list(c))
```

##### Lister les restaurants situés sur les rues “Union Street” ou “Union Square”
```
c = db.restaurants.find(
	{ "address.street": { "$in": [ "Union Street", "Union Square" ] }},
	{ "_id": 0, "name": 1, "borough" : 1 }
)
pandas.DataFrame(list(c))
```

##### Lister les restaurants situés au-dessus de la latitude 40.90
```
c = db.restaurants.find(
	{ "address.coord.1": { "$gt": 40.9 }},
	{ "_id": 0, "name": 1, "borough": 1, "address.coord": 1 }
)
pandas.DataFrame(list(c))
```

##### Lister les restaurants ayant eu un score de 0 et un grade “A”
```
c = db.restaurants.find(
	{ "grades.score": 0, "grades.grade": "A" },
	{ "_id": 0, "name": 1, "borough": 1, "grades": 1 }
)
pandas.DataFrame(list(c))
```

## Questions complémentaires

##### Lister les restaurants (nom et rue uniquement) situés sur une rue ayant le terme “Union” dans le nom
```
c = db.restaurants.find(
	{ "address.street": { "$regex" : "union", "$options": "i" } },
	{ "_id": 0, "name": 1, "address.street": 1 }
)
pandas.DataFrame(list(c))
```


##### Lister les restaurants ayant eu une visite le 1er février 2014
```
import datetime

c = db.restaurants.find(
    { "grades.date": datetime.datetime(2014, 2, 1) },
    { "_id": 0, "name": 1, "address.street": 1, "grades.date": 1 }
)
pandas.DataFrame(list(c))
```

##### Lister les restaurants situés entre les longitudes -74.2 et -74.1 et les latitudes 40.5 et 40.6

Il n'y a aucun restaurant entre les latitudes 40.1 et 40.2 ! J'ai donc décalé aux latitudes 40.5 et 40.6.

```
c = db.restaurants.find(
	{
		"address.coord.0": { "$gte": -74.2, "$lte": -74.1 },
		"address.coord.1": { "$gte": 40.5, "$lte": 40.6 }
	},
	{ "_id": 0, "name": 1, "address.coord": 1 }
)
pandas.DataFrame(list(c))
```
