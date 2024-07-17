# Système pour la Data Science

## Master AMSD/MLSD

### Introduction à MongoDB

## Intéragir avec MongoDB dans Python

Nous allons ici utiliser le module [`pymongo`](https://docs.mongodb.com/drivers/pymongo/), que l'on importe classiquement

```python
import pymongo
```

### Connexion à un serveur distant

Il faut utiliser l'adresse du serveur dans la fonction `pymongo.MongoClient()`, si celui-ci est distant. Sinon, on peut le faire directement, comme c'est notre cas ici.

```python
client = pymongo.MongoClient()
```

L'objet `client` permet ainsi de se connecter à toutes les bases existantes. Pour simplifier la suite des opérations, nous allons pointer vers notre base `test`. 

```python
db = client.test
```

### Document dans `python`

Les données `JSON` sont similaires à un dictionnaire `python`. Pour récupérer le premier document, nous utilisons la fonction `find()` de l'objet créé `m`.

```python
d = db.restaurants.find(limit = 1)
d
```

L'objet retourné est un **curseur**, et non le résultat. Nous avons celui-ci lorsque nous utilisons `d` dans une commande telle qu'une transformation en `list` par exemple. 

```python
list(d)
```

Une fois le résultat retourné (un seul élément ici), le curseur ne renvoie plus rien (à tester pour bien intégrer ce comportement).

```python
list(d)
```


### Dénombrement

Ici, nous avons accès à deux fonctions pour dénombrer les documents. La première est `count_documents({})`, dont le paramètre `{}` est à mettre obligatoirement (il sert à spécifier le filtre de restriction sur les documents, mais doit être spécifier tout de même s'il n'y a aucune restriction). La deuxième fonction (`estimated_document_count()`) sert à estimer le nombre de documents, à utiliser de préférence en cas de multiples serveurs et de données massives.

- Tous les restaurants

```python
db.restaurants.count_documents({})
db.restaurants.estimated_document_count()
```

Pour sélectionner les documents, nous allons utiliser le paramètre dans la fonction `count_documents()` (ainsi que dans les fonctions `distinct()` et `find()` que nous verrons plus tard).

- `{}` : tous les documents
- `{ "champs": valeur }` : documents ayant cette valeur pour ce champs
- `{ condition1, condition2 }` : documents remplissant la condition 1 **ET** la condition 2
- `"champs.sous_champs"` : permet d'accéder donc à un sous-champs d'un champs (que celui-ci soit un littéral ou un tableau)
- `{ "champs": { "$opérateur": expression }}` : utilisation d'opérateurs dans la recherche
    - `$in` : comparaison à un ensemble de valeurs
    - `$gt`, `$gte`, `$lt`, `$lte`, `$ne` : comparaison (resp. *greater than*, *greater than or equal*, *less than*, *less than or equal*, *not equal*)

- Restaurants de *Brooklyn*

```python
db.restaurants.count_documents({ "borough": "Brooklyn" })
```

- Restaurants de *Brooklyn* proposant de la cuisine française

```python
db.restaurants.count_documents({ "borough": "Brooklyn", "cuisine": "French" })
```

- Restaurants de *Brooklyn* proposant de la cuisine française ou italienne

```python
db.restaurants.count_documents({ "borough": "Brooklyn", "cuisine": { "$in": ["French", "Italian"]} })
```

- Idem mais écrit plus lisiblement

```python
db.restaurants.count_documents(
  { 
    "borough": "Brooklyn", 
    "cuisine": { "$in": ["French", "Italian"]}
  }
)
```

- Restaurants situés sur *Franklin Street*
    - Notez l'accès au champs `street` du champs `address`
    
```python
db.restaurants.count_documents(
  { 
    "address.street": "Franklin Street"
  }
)
```

- Restaurants ayant eu un score de 0

```python
db.restaurants.count_documents(
  { 
    "grades.score": 0
  }
)
```

- Restaurants ayant eu un score inférieur à 5

```python
db.restaurants.count_documents(
  { 
    "grades.score": { "$lte": 5 }
  }
)
```

### Valeurs distinctes

Il existe la même fonction `distinct()`, avec les mêmes possibilités. Le paramètre `key` indique pour quel champs nous souhaitons avoir les valeurs distinctes. On peut aussi se restreindre à un sous-ensemble de documents respectant une contrainte particulière indiquée dans le paramètre `query` (syntaxe identique à `count()`). 

- Quartier (`borough`), pour tous les restaurants

```python
db.restaurants.distinct(key = "borough")
```

- Cuisine pour les restaurants de *Brooklyn*

```python
db.restaurants.distinct(
  key = "cuisine",
  query = { "borough": "Brooklyn" }
)
```

- Grade des restaurants de *Brooklyn*

```python
db.restaurants.distinct(
  key = "grades.grade",
  query = { "borough": "Brooklyn" }
)
```


### Récupération de données avec `find()`

Cette fonction est similaire à celle de Mongo, et permet donc de récupérer tout ou partie des documents, selon éventuellement un critère de restriction (dans le paramètre `query`) et un critère de projection (dans le paramètre `fields`). Le paramètre `query` se gère comme pour le dénombrement. Pour sélectionner les champs à afficher ou non, on utilise donc le deuxième paramètre, permettant ainsi de faire une projection, avec les critères suivants :

- sans précision, l'identifiant interne est toujours affiché (`_id`)
- `{ "champs": 1 }` : champs à afficher
- `{ "champs": 0 }` : champs à ne pas afficher
- Pas de mélange des 2 sauf pour l'identifiant interne à Mongo (`_id`)
    - `{ "_id": 0, "champs": 1, ...}`

Cette fonction renvoie un curseur, qu'il faut donc gérer pour avoir le résultat. Une possibilité est de le transformer en `DataFrame` (du module `pandas`) (ce format pas forcément idéal pour certains champs).

Dans cette fonction `find()`, il est aussi possible de faire le tri des documents, avec le paramètre `sort` qui prend un tuple composé de 1 ou plusieurs tuples indiquant les critères de tri

- `( "champs", 1 )` : tri croissant
- `( "champs", -1 )` : tri décroissant
- plusieurs critères de tri possibles (dans les 2 sens)

Pour n'avoir que le premier document, on utilise le paramètre `limit` (pas de fonction type `findOne()` donc). On peut limiter l'exploration à une partie, avec les paramètres suivant :

- `limit` : restreint le nombre de résultats fournis
- `skip` : ne considère pas les *n* premiers documents


#### Exemples

- Récupération des 5 premiers documents
    - Notez le contenu des colonnes `address` et `grades`.
    
```python
import pandas
pandas.DataFrame(db.restaurants.find(limit = 5))
```

- Restaurants *Shake Shack* (uniquement les attributs `"street"` et `"borough"`)

```python
c = db.restaurants.find({ "name": "Shake Shack" }, { "address.street": 1, "borough": 1 })
pandas.DataFrame(c)
```

- Idem sans l'identifiant interne

```python
c = db.restaurants.find(
    { "name": "Shake Shack" }, 
    { "_id": 0, "address.street": 1, "borough": 1 }
)
pandas.DataFrame(c)
```

- 5 premiers restaurants du quartier *Queens*, avec une note A et un score supérieur à 50 (on affiche le nom et la rue du restaurant

```python
c = db.restaurants.find(
    {"borough": "Queens", "grades.score": { "$gte":  50}},
    {"_id": 0, "name": 1, "grades.score": 1, "address.street": 1},
    limit = 5
)
pandas.DataFrame(c)
```

- Restaurants *Shake Shack* dans différents quartiers (*Queens* et *Brooklyn*)

```python
c = db.restaurants.find(
    {"name": "Shake Shack", "borough": {"$in": ["Queens", "Brooklyn"]}}, 
    {"_id": 0, "address.street": 1, "borough": 1}
)
pandas.DataFrame(c)
```

- Restaurants du Queens ayant une note supérieure à 50, mais trié par ordre décroissant de noms de rue, et ordre croissant de noms de restaurants

```python
c = db.restaurants.find(
    {"borough": "Queens", "grades.score": { "$gt":  50}},
    {"_id": 0, "name": 1, "address.street": 1},
    sort = (("address.street", -1), ("name", 1))
)
pandas.DataFrame(c)
```

### Aggrégation

Cette fonction va prendre en paramètre un `pipeline` : tableau composé d'une suite d'opérations

| Fonction       | Opération |
|:-|:-|
| `$limit`       | restriction à un petit nombre de documents (très utiles pour tester son calcul) |
| `$sort`        | tri sur les documents |
| `$match`       | restriction sur les documents à utiliser |
| `$unwind`      | séparation d'un document en plusieurs sur la base d'un tableau |
| `$addFields`   | ajout d'un champs dans les documents |
| `$project`     | redéfinition des documents |
| `$group`       | regroupements et calculs d'aggégrats |
| `$sortByCount` | regroupement, calcul de dénombrement et tri déccroissant en une opération |
| `$lookup`      | jointure avec une autre collection |
| ...            | | |

Les opérations se font dans l'ordre d'écriture, et le même opérateur peut donc apparaître plusieurs fois. Voici quelques éléments indiquant ce qu'on passer en paramètre à ces fonctions.

- `$limit` : un entier
- `$sort` : identique à celle du paramètre `sort` de la fonction `find()`
- `$match` : identique à celle du paramètre `query` des autres fonctions
- `$unwind` : nom du tableau servant de base pour le découpage (précédé d'un `$`)
    - un document avec un tableau à *n* éléments deviendra *n* documents avec chacun un des éléments du tableau en lieu et place de celui-ci
- `$sortByCount` : nom du champs sur lequel on veut le dénombrement et le tri décroissant selon le résultat

Les opérateurs `$project` et `$addFields` servent à redéfinir les documents. 

- `{ "champs" : 1 }` : conservation du champs (0 si suppression - idem que dans `fields`, pas de mélange sauf pour `_id`)
- `{ "champs": { "$opérateur" : expression }}` : permet de définir un nouveau champs
- `{ "nouveau_champs": "$ancien_champs" }` : renommage d'un champs
    
Voici quelques opérateurs utiles pour la projection (plus d'info [ici](https://docs.mongodb.com/manual/reference/operator/aggregation/))

- `$arrayElemAt` : élément d'un tableau
- `$first` et `$last` : premier ou dernier élément du tableau
- `$size` : taille d'un tableau
- `$substr` : sous-chaîne de caractères
- `$cond` : permet de faire une condition (genre de *if then else*)
- ...

Le calcul d'agrégats (tel que celui fait en SQL par exemple) se fait avec la fonction `$group`, dans laquelle on doit définir un identifiant critère de regroupement (`id`) et un ou plusieurs calculs.

- `_id` : déclaration du critère de regroupement
    - chaîne de caractères : pas de regroupement (tous les documents)
    - `$champs` : regroupement selon ce champs
    - `{ "a1": "$champs1", ... }` : regroupement multiple (avec modification des valeurs possible)
- Calculs d'agrégats à faire :
    - `$sum` : somme (soit de valeur fixe - 1 pour faire un décompte donc, soit d'un champs spécifique)
    - `$avg, $min, $max`
    - `$addToSet` : regroupement des valeurs distinctes d'un champs dans un tableau 
    - `$push` : aggrégation de champs dans un tableau


#### Exemples

- Limite aux 5 premiers restaurants

```python
c = db.restaurants.aggregate(
    [
        {"$limit": 10 }
    ]
)
pandas.DataFrame(c)
```

- Idem avec tri sur le nom du restaurant

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$sort": { "name": 1 }}
    ]
)
pandas.DataFrame(c)
```

- Idem en se restreignant à *Brooklyn*
    - Notez que nous obtenons uniquement 5 restaurants au final
    
```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$sort": { "name": 1 }},
        { "$match": { "borough": "Brooklyn" }}
    ]
)
pandas.DataFrame(c)
```

- Mêmes opérations mais avec la restriction en amont de la limite
    - Nous avons ici les 10 premiers restaurants de *Brooklyn* donc
    
```python
c = db.restaurants.aggregate(
    [
        { "$match": { "borough": "Brooklyn" }},
        { "$limit": 10 },
        { "$sort": { "name": 1 }}
    ]
)
pandas.DataFrame(c)
```

- Séparation des 5 premiers restaurants sur la base des évaluations (`grades`)
    - Chaque ligne correspond maintenant a une évaluation pour un restaurant
    
```python
c = db.restaurants.aggregate(
    [
        { "$limit": 5 },
        { "$unwind": "$grades" }
    ]
)
pandas.DataFrame(c)
```

- Idem précédemment, en se restreignant à celle ayant eu *B*

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$unwind": "$grades" },
        { "$match": { "grades.grade": "B" }}
    ]
)
pandas.DataFrame(c)
```

- Si on inverse les opérations `$unwind` et `$match`, le résultat est clairement différent

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$match": { "grades.grade": "B" }},
        { "$unwind": "$grades" }
    ]
)
pandas.DataFrame(c)
```

- On souhaite ici ne garder que le nom et le quartier des 10 premiers restaurants
    - Notez l'ordre (alphabétique) des variables, et pas celui de la déclaration
    
```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1 } }
    ]
)
pandas.DataFrame(c)
```

- Ici, on supprime l'adresse et les évaluations 

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$project": { "address": 0, "grades": 0 } }
    ]
)
pandas.DataFrame(c)
```

- En plus du nom et du quartier, on récupère l'adresse mais dans un nouveau champs 

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1 , "street": "$address.street"} }
    ]
)
pandas.DataFrame(c)
```

- On ajoute le nombre de visites pour chaque restaurant (donc la taille du tableau `grades`)

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1, "nb_grades": { "$size": "$grades" } } }
    ]
)
pandas.DataFrame(c)
```

- On trie ce résultat par nombre décroissant de visites, et on affiche les 10 premiers

```python
c = db.restaurants.aggregate(
    [
        { "$project": { "name": 1, "borough": 1, "nb_grades": { "$size": "$grades" } } },
        { "$sort": { "nb_grades": -1 }},
        { "$limit": 10 }
    ]
)
pandas.DataFrame(c)
```

- On ne garde maintenant que le premier élément du tableau `grades` (indicé 0)

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1, "grade": { "$arrayElemAt": [ "$grades", 0 ]} } }
    ]
)
pandas.DataFrame(c)
```

- `$first` permet aussi de garder uniquement le premier élément du tableau `grades` de façon explicite (`$last` pour le dernier)

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1, "grade": { "$first": "$grades" } } }
    ]
)
pandas.DataFrame(c)
```

- On peut aussi faire des opérations sur les chaînes, tel que la mise en majuscule du nom

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$project": { "nom": { "$toUpper": "$name" }, "borough": 1 } }
    ]
)
pandas.DataFrame(c)
```

- On peut aussi vouloir ajouter un champs, comme ici le nombre d'évaluations

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$addFields": { "nb_grades": { "$size": "$grades" } } }
    ]
)
pandas.DataFrame(c)
```

- On extrait ici les trois premières lettres du quartier

```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$project": { 
            "nom": { "$toUpper": "$name" }, 
            "quartier": { "$substr": [ "$borough", 0, 3 ] } 
        } }
    ]
)
pandas.DataFrame(c)
```

- On fait de même, mais on met en majuscule et on note *BRX* pour le *Bronx*
    - on garde le quartier d'origine pour vérification ici
    
```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$addFields": { "quartier": { "$toUpper": { "$substr": [ "$borough", 0, 3 ] } } }},
        { "$project": { 
            "nom": { "$toUpper": "$name" }, 
            "quartier": { "$cond": { 
                "if": { "$eq": ["$borough", "Bronx"] }, 
                "then": "BRX", 
                "else": "$quartier" 
            } },
            "borough": 1
        } }
    ]
)
pandas.DataFrame(c)
```

- On calcule ici le nombre total de restaurants

```python
c = db.restaurants.aggregate(
    [
        {"$group": {"_id": "Total", "NbRestos": {"$sum": 1}}}
    ]
)
pandas.DataFrame(c)
```

- On fait de même, mais par quartier

```python
c = db.restaurants.aggregate(
    [
        {"$group": {"_id": "$borough", "NbRestos": {"$sum": 1}}}
    ]
)
pandas.DataFrame(c)
```

- Une fois le dénombrement fait, on peut aussi trié le résultat

```python
c = db.restaurants.aggregate(
    [
        {"$group": {"_id": "$borough", "NbRestos": {"$sum": 1}}},
        {"$sort": { "NbRestos": -1}}
    ]
)
pandas.DataFrame(c)
```

- La même opération est réalisable directement avec `$sortByCount`

```python
c = db.restaurants.aggregate(
    [
        {"$sortByCount": "$borough"}
    ]
)
pandas.DataFrame(c)
```

- Pour faire le calcul des notes moyennes des restaurants du *Queens*, on exécute le code suivant

```python
c = db.restaurants.aggregate(
    [
        { "$match": { "borough": "Queens" }},
        { "$unwind": "$grades" },
        { "$group": { "_id": "null", "score": { "$avg": "$grades.score" }}}
    ]
)
pandas.DataFrame(c)
```

-  Il est bien évidemment possible de faire ce calcul par quartier et de les trier selon les notes obtenues (dans l'ordre décroissant)

```python
c = db.restaurants.aggregate(
    [
        { "$unwind": "$grades" },
        { "$group": { "_id": "$borough", "score": { "$avg": "$grades.score" }}},
        { "$sort": { "score": -1 }}
    ]
)
pandas.DataFrame(c)
```

- On peut aussi faire un regroupement par quartier et par rue (en ne prenant que la première évaluation - qui est la dernière en date a priori), pour afficher les 10 rues où on mange le plus sainement
    - Notez que le `$match` permet de supprimer les restaurants sans évaluations (ce qui engendrerait des moyennes = `None`)
    
```python
c = db.restaurants.aggregate(
    [
        { "$project": {
            "borough": 1, "street": "$address.street", 
            "eval": { "$arrayElemAt": [ "$grades", 0 ]} 
        } },
        { "$match": { "eval": { "$exists": True } } },
        { "$group": { 
            "_id": { "quartier": "$borough", "rue": "$street" }, 
            "score": { "$avg": "$eval.score" }
        }},
        { "$sort": { "score": 1 }},
        { "$limit": 10 }
    ]
)
pandas.DataFrame(c)
```

- Pour comprendre la différence entre `$addToSet` et `$push`, on les applique sur les grades obtenus pour les 10 premiers restaurants
    - `$addToSet` : valeurs distinctes
    - `$push` : toutes les valeurs présentes
    
```python
c = db.restaurants.aggregate(
    [
        { "$limit": 10 },
        { "$unwind": "$grades" },
        { "$group": { 
            "_id": "$name", 
            "avec_addToSet": { "$addToSet": "$grades.grade" },
            "avec_push": { "$push": "$grades.grade" }
        }}
    ]
)
pandas.DataFrame(c)
```


## Difficultés potentielles liées à Python

Une fois importées dans un `DataFrame`, les champs complexes (comme `address` et `grades`) sont des variables d'un type un peu particulier :

- `address` est un ensemble de dictionnaires
- `grades` est un ensemble de tableaux

Nous devons donc les traiter spécifiquement pour manipulare dans Python les informations contenues dedans.

### Variables ayant des dictionnaires comme valeurs

Le champs `address` est une liste de dictionnaires, ayant chacun plusieurs champs (ici tous les mêmes). On peut déjà le manipuler avec l'utilisation de *list comprehension*. Par exemple, si on souhaite avoir le nom du bâtiment et la rue concaténés dans une nouvelle variable de `df`, on peut le faire comme ci-dessous :

```python
df = df.assign(info = [e["building"] + ", " + e["street"] for e in df.address])
```

On peut aussi directement transformer la liste en un `DataFrame` (car les champs sont tous les mêmes).

```python
pandas.DataFrame([e for e in df.address])
```

Puisqu'on a fait cela, on peut concaténer les deux `DataFrames` (l'original, sans le champs `address`) et le nouveau contenant toutes les informationds de `address`, en faisant comme suit :

```python
pandas.concat([df.drop("address", axis = 1), pandas.DataFrame([e for e in df.address])], axis = 1)
```


### Variables ayant des tableaux comme valeurs

Le champs `grades` est une liste de tableaux, ayant chacun potentiellement plusieurs valeurs (des dictionnaires de plus). Si on souhaite récupérer un élément particulier du tableau (premier ou dernier), on peut ainsi faire suit (*NB* : la dernière évaluation est la première dans le tableau) :

```python
df.assign(derniere = [e[0] for e in df.grades], premiere = [e[-1] for e in df.grades]).drop("grades", axis = 1)
```

De façon plus complexe, on peut créer un seul `DataFrame`, avec l'ensemble des sous-tableaux. A savoir, `zip()` permet d'itérer sur plusieurs tableaux en même temps et `concat()` permet de concaténer les tableaux entre eux. On a ainsi la commande suivante :

```python
dfgrades = pandas.concat([pandas.DataFrame(g).assign(_id = i) for (i, g) in zip(df._id, df.grades)])
dfgrades
```

Une fois cela réalisé, on peut combiner avec les données originales, en réalisant une jointure entre les deux `DataFrames` avec `merge()` :

```python
pandas.merge(df.drop("grades", axis = 1), dfgrades.reset_index())
```


