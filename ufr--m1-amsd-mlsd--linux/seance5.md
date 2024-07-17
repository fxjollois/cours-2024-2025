---
layout: slides
---

class: middle, center, inverse, title
# Système pour la Data Science

## Master AMSD/MLSD

### Introduction à MongoDB

---
## Présentation de MongoDB

> Base de données **NoSQL** de type *Document Store* (orienté document)

--
#### Objectifs

- Gestion possible de gros volumes de données
- Facilité de déploiement et d'utilisation
- Possibilité de faire de choses assez complexes

Plus d'informations sur [leur site](http://www.mongodb.com/)

---
## Modèle des données

Principe de base : les données sont des `documents`

- Stocké en *Binary JSON* (`BSON`)
- Documents similaires rassemblés dans des `collections`
    - plusieurs collections possibles dans une base de données
- Pas de schéma des documents définis en amont
	- contrairement à un BD relationnel ou NoSQL de type *Column Store*
- Les documents peuvent n'avoir aucun point commun entre eux
- Un document contient (généralement) l'ensemble des informations
	- pas (ou très peu) de jointure à faire idéalement
- BD respectant **CP** (dans le théorème *CAP*)
	- propriétés ACID au niveau d'un document

---
## Format `JSON`

- `JavaScript Object Notation`, créé en 2005
- Format léger d'échange de données structurées (**littéral**)
- Schéma des données non connu (contenu dans les données)
- Basé sur deux notions :
	- collection de couples clé/valeur
	- liste de valeurs ordonnées
- Structures possibles :
	- objet (couples clé/valeur) : `{ "nom": "jollois", "prenom": "fx" }`
	- tableau (collection de valeurs) : `[ 1, 5, 10]`
	- une valeur dans un objet ou dans un tableau peut être elle-même un littéral
- Deux types atomiques (`string` et `number`) et trois constantes (`true`, `false`, `null`)

Validation possible du JSON sur [jsonlint.com/](http://jsonlint.com/)

---
#### Exemple de `JSON`

```json
{
    "address": {
        "building": "469",
        "coord": [
            -73.9617,
            40.6629
        ],
        "street": "Flatbush Avenue",
        "zipcode": "11225"
    },
    "borough": "Brooklyn",
    "cuisine": "Hamburgers",
    "grades": [
        {
            "date": "2014-12-30 01:00:00",
            "grade": "A",
            "score": 8
        },
        {
            "date": "2014-07-01 02:00:00",
            "grade": "B",
            "score": 23
        }
    ],
    "name": "Wendy'S",
    "restaurant_id": "30112340"
}
```

---
## Compléments

`BSON` : extension de `JSON`

--
- Quelques types supplémentaires (identifiant spécifique, binaire, date, ...)
- Distinction entier et réel

--
#### Schéma dynamique

--
- Documents variant très fortement entre eux, même dans une même collection
- On parle de **self-describing documents**
- Ajout très facile d'un nouvel élément pour un document, même si cet élément est inexistant pour les autres
- Pas de `ALTER TABLE` ou de redesign de la base

---
## Langage d'interrogation

- Pas de SQL (bien évidemment), ni de langage proche

--

- Définition d'un langage propre
    - `find()` : pour tout ce qui est restriction et projection
    - `aggregate()` : pour tout ce qui est calcul de variable, d'aggrégats et de manipulations diverses
    - ...

--

- Langage JavaScript dans la console, permettant plus que les accès aux données
	- définition de variables
	- boucles
	- ...

---
class: middle, center, section
# Premiers éléments

---
## Utilisation dans le shell

- Lancer le shell mongo
```bash
$ mongosh
```

--
- Lister les bases de données présentes
```js
> show dbs
```

--
- Se connecter à une base de données
```js
> use test
```

--
- Lister les collections de la base de données
```js
> show collections
```


---
## Formalisme usuel

- Formalisme utilisé pour les commandes dans la console Mongo

```js
> db.collection.fonction(paramètres)
```

--
- `db` : mot-clé indiquant qu'on travaille sur la base de données choisie (avec `use` donc)

--
- `collection` : nom de la collection sur laquelle on souhaite exécuter la fonction

--
- `fonction()` : fonction à exécuter, avec les paramètres passés (éventuellement)

---
## Compléments sur le shell mongo

- Usage possible du langage Javascript
    - Création de variables
    - Création de fonctions
    - Sourcing de scripts...
    
--
## Importation d'un fichier JSON

Dans un shell classique

```bash
$ mongoimport --db base --collection col fichier.json
```

--
- `base` : nom de la base de données
    - créée si elle n'existe pas
- `col` : nom de la collection
    - créée si elle n'existe pas

---
class: middle, center, section
## Recherche d'information

.footnote[Exemples basés sur la collection `restaurants`]

---
## Dénombrements

- `countDocuments()` : Nombre de documents présents dans la collection

```js
> db.restaurants.countDocuments()
```

--

- Dénombrement sur une restriction : critères de recherche passés en paramètre sous forme de *littéral* `JSON`
    
```js
> db.restaurants.countDocuments({ borough: "Brooklyn" })
```

--

> Formalisme identique à la fonction `find()` vue juste après


---
## Recherche de documents

- `findOne()` : récupération du premier document (de toute la colleciton ou le premier respectant une certaine condition)
    - Utile car pas de structure définie
    - Possibilité d'explorer les documents

```js
> db.restaurants.findOne()
```

--

- `find()` : récupération de tous les documents (ou ceux respectant une condition)
    - Possiblement beaucoup de résultats et donc pas tous affichables
    - Seulement 20 sont affichés. Pour les 20 suivants, tapez `it` (pour *iterate*)
    - Notez que l'affichage est moins *lisible* (pas de passage à la ligne, ni de tabulation).

```js
db.restaurants.find()
```

.foonote[Les exemples suivants fonctionnent tout aussi bien avec la fonction `find()`]

---
## Restriction

- Critère simple d'égalité d'un champs à une valeur

```js
db.restaurants.findOne({borough: "Brooklyn"})
```

--
- Combinaison de plusieurs critères (**ET** entre les deux)

```js
db.restaurants.findOne({borough: "Brooklyn", cuisine: "French"})
```

--
- Pour recherche sur un littéral (bien mettre les `""`)

```js
db.restaurants.findOne({"address.street": "Franklin Street"})
```

--
- Recherche dans un tableau
    - Notez qu'il renvoie tous les scores

```js
db.restaurants.findOne({"grades.score": 0})
```

---
## Projection

- Utile de ne récupérer que certains éléments (et donc de faire une projection)
    - Champs que l'on souhaite garder (`1`) ou ne pas garder (`0`)
    - Notez ici que pour ne pas faire de restriction, littéral vide (`{}`) comme premier paramètre
    - Notez que l'identifiant `_id` est présent par défaut

```js
db.restaurants.findOne({}, { name: 1, borough: 1 })
```

--

- Pour ne pas avoir `_id`, il'indiquer précisemment
    - Seule possibilité de mélanger un choix d'attributs à afficher et à ne pas afficher

```js
db.restaurants.findOne({}, { _id: 0, name: 1, borough: 1 })
```

---
## Projection

- Pour n'afficher que certains éléments des champs complexes (littéral ou tableau)

```js
db.restaurants.findOne(
    {}, 
    { 
        _id: 0, name: 1, borough: 1, 
        "address.street": 1, "grades.grade": 1 
    }
)
```

--

- Pour ne pas afficher certains éléments, utilisation de ce formalisme

```js
db.restaurants.findOne({}, {address: 0, grades: 0})
```

---
## Restrictions complexes

- Pas possible d'utiliser les opérateurs classiques (type `>`, `<`, ...)
- Utilisation d'opérateurs spécifiques
    - `$lt`: less than, `$lte`: less than or equal, `$gt`: greater than, `$gte`: greater than or equal, `$ne`: not equal

```js
db.restaurants.findOne(
    { "grades.score": { $lt: 5 }},
    { _id: 0, name: 1, borough: 1}
)
```

--

- Pour tester si un champs a une valeur dans un ensemble donné, opérateur `$in`

```js
db.restaurants.findOne(
    { "cuisine": { $in: [ "French", "Italian" ]} },
    { _id: 0, name: 1, borough: 1, cuisine: 1}
)
```

---
## Compléments

- Limitation du nombre de résultat avec l'option `limit`

```js
db.restaurants.find({ }, { _id: 0, name: 1 }, { limit: 5 })
```

--

- Tri du résultat avec l'option `sort`
    - Ascendant avec la valeur 1 et descendant avec la valeur -1

```js
db.restaurants.find({ }, { _id: 0, name: 1 }, { sort: { name: -1 }})
```

--
- Les 2 en même temps

```js
db.restaurants.find({ }, { _id: 0, name: 1 }, { limit: 5, sort: { name: -1 }})
```

---
## Valeurs distinctes

- Pour connaître les valeurs possibles prises par un champs dans les documents

```js
db.restaurants.distinct("borough")
```

--

- Idem pour les documents respectant une condition

```js
db.restaurants.distinct("borough"), { cuisine: "Vegetarian" })
```

---
class: middle, center, section
# Agrégats et calculs plus complexes

---
## Principe

- `aggregate()` : calcul d'agrégat et de beaucoup d'autres opérations.

--

- Paramètre : tableau (nommé `pipeline`) composé d'une suite d'opérations

--

- Chaque opération faite après la précédente
    - Importance cruciale de l'ordre des opérations
    - Opérateur pouvant apparaître plusieurs fois

---
## Fonctions possibles

Voici quelques unes des opérations possibles :

| Fonction       | Opération |
|-|-|
| `$limit`       | restriction à un petit nombre de documents (très utiles pour tester son calcul) |
| `$sort`        | tri sur les documents |
| `$match`       | restriction sur les documents à utiliser |
| `$unwind`      | séparation d'un document en plusieurs sur la base d'un tableau |
| `$addFields`   | ajout d'un champs dans les documents |
| `$project`     | redéfinition des documents |
| `$group`       | regroupements et calculs d'aggégrats |
| `$sortByCount` | agrégat + tri |
| `$lookup`      | jointure avec une autre collection |
| ...            | |

---
## `$limit` 

- Entier indiquant le nombre de document que l'on veut récupérer

```js
db.restaurants.aggregate([
    { $limit: 10 }
])
```

--
## `$sort` 

- Tri, similaire à la fonction `find()`

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $sort: { name: 1 }}
])
```

---
## `$match` 

- Similaire au paramètre de restriction dans `find()`
    - Notez que nous obtenons uniquement 5 restaurants au final
    
```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $match: { borough: "Brooklyn" }}
])
```

--
- Mêmes opérations mais avec la restriction en amont de la limite
    - Nous avons ici les 10 premiers restaurants de *Brooklyn* donc

```js
db.restaurants.aggregate([
    { $match: { borough: "Brooklyn" }},
    { $limit: 10 }
])
```

---
## `$unwind` 

- **Division** du tableau passé en paramètre (précédé d'un `$`)
    - Transformation d'un document avec un tableau à *n* éléments en *n* documents avec chacun un des éléments du tableau en lieu et place de celui-ci
    - Chaque ligne correspond maintenant a une évaluation pour un restaurant

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $unwind: "$grades" }
])
```

---
## `$unwind` 

- Idem précédemment, en se restreignant à celle ayant eu *B*

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $unwind: "$grades" },
    { $match: { "grades.grade": "B" }}
])
```

--
- Si on inverse les opérations `$unwind` et `$match`, le résultat est clairement différent

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $match: { "grades.grade": "B" }},
    { $unwind: "$grades" }
])
```

---
## `$addFields` et  `$project` 

- Redéfiniton des documents en ajoutant des éléments (`$addFields`) ou en se restreignant à certains éléments
(`$project`)

--
- Syntaxe 
    - `{ "champs" : 1 }` : conservation du champs dans `$project`
        - 0 si suppression - idem que dans `find()`
    - `{ "champs": { "$opérateur" : expression }}` : nouveau champs
    - `{ "nouveau_champs": "$ancien_champs" }` : renommage d'un champs
--
- Quelques opérateurs utiles pour la projection (plus d'info [ici](https://docs.mongodb.com/manual/reference/operator/aggregation/))
    - `$arrayElemAt` : élément d'un tableau
    - `$first` et `$last` : premier ou dernier élément du tableau
    - `$size` : taille d'un tableau
    - `$substr` : sous-chaîne de caractères
    - `$cond` : permet de faire une condition (genre de *if then else*)
    - ...

---
## `$addFields` et  `$project` 

- Ajout d'un champs

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $addFields: { nb_grades: { $size: "$grades" } } }
])
```

--
- Conservation de quelques champs
    - Notez l'ordre (alphabétique) des variables, et pas celui de la déclaration
    
```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $project: { name: 1, borough: 1 } }
])
```

---
## `$addFields` et  `$project` 

- Suppression de champs

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $project: { address: 0, grades: 0 } }
])
```

--
- Mélange entre conservation et nouveau champs 

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $project: { name: 1, borough: 1 , street: "$address.street"} }
])
```

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $project: { name: 1, borough: 1, nb_grades: { $size: "$grades" } } }
])
```

---
## `$addFields` et  `$project` 

- Encore quelques exemples

```js
db.restaurants.aggregate([
    { $project: { name: 1, borough: 1, nb_grades: { $size: "$grades" } } },
    { $sort: { nb_grades: 1 }},
    { $limit: 10 }
])
```

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $project: { name: 1, borough: 1, grade: { $arrayElemAt: [ "$grades", 0 ]} } }
])
```

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $project: { nom: { $toUpper: "$name" }, borough: 1 } }
])
```

---
## `$addFields` et  `$project` 

- Encore quelques exemples

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $project: { 
        nom: { $toUpper: "$name" }, 
        quartier: { $substr: [ "$borough", 0, 3 ] } 
    } }
])
```

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $addFields: { quartier: { $toUpper: { $substr: [ "$borough", 0, 3 ] } } }},
    { $project: { 
        nom: { $toUpper: "$name" }, 
        quartier: { $cond: { if: { $eq: ["$borough", "Bronx"] }, then: "BRX", else: "$quartier" } },
        borough: 1
    } }
])
```

---
## `$group` 

- Calcul d'agrégats tel qu'on le connaît
    - `_id` : déclaration du critère de regroupement
        - chaîne de caractères : pas de regroupement (tous les documents)
        - `$champs` : regroupement selon ce champs
        - `{ a1: "$champs1", ... }` : regroupement multiple (avec modification des valeurs possible)
    - Calculs d'agrégats à faire :
        - `$sum` : somme (soit de valeur fixe - 1 pour faire un décompte donc, soit d'un champs spécifique)
        - `$avg, $min, $max`
        - `$addToSet` : regroupement des valeurs distinctes d'un champs dans un tableau 
        - `$push` : aggrégation de champs dans un tableau

```js
db.restaurants.aggregate([
    { $group: { _id: "Total", NbRestos: { $sum: 1 }}}
])
```

---
## `$group` 

- Avec un critère d'agrégation en plus

```js
db.restaurants.aggregate([
    { $group: { _id: "$borough", NbRestos: { $sum: 1 }}}
])
```

- En combinant différentes opérations

```js
db.restaurants.aggregate([
    { $match: { borough: "Queens" }},
    { $unwind: "$grades" },
    { $group: { _id: "null", score: { $avg: "$grades.score" }}}
])
```

```js
db.restaurants.aggregate([ 
    { $unwind: "$grades" },
    { $group: { _id: "$borough", score: { $avg: "$grades.score" }}},
    { $sort: { score: -1 }}
])
```

---
## `$group` 

- Exemple complexe

```js
db.restaurants.aggregate([
    { $project: { 
        borough: 1, street: "$address.street", 
        eval: { $arrayElemAt: [ "$grades", 0 ]} 
    } },
    { $match: { eval: { $exists: true } } },
    { $match: { "eval.score": { $gte: 0 } } },
    { $group: { 
        _id: { quartier: "$borough", rue: "$street" }, 
        score: { $avg: "$eval.score" }
    }},
    { $sort: { score: 1 }},
    { $limit: 10 }
])
```

---
## `$group` 

- A tester pour comprendre la différence entre `$addToSet` et `$push`
    - `$addToSet` : valeurs distinctes
    - `$push` : toutes les valeurs présentes

```js
db.restaurants.aggregate([
    { $limit: 10 },
    { $unwind: "$grades" },
    { $group: { 
        _id: "$name", 
        avec_addToSet: { $addToSet: "$grades.grade" },
        avec_push: { $push: "$grades.grade" }
    }}
])
```

---
## `$sortBycount`

- Combinaison de deux opérations (`$group` et `$sort`), très souvent réalisées ensemble
    - Regroupement sur le champs spécifié (précédé d'un `$`)
    - Décompte du nombre de document pour chaque modalité de ce champs
    - Tri décroissant sur le nombre calculé

```js
db.restaurants.aggregate([
    { $sortByCount: "$borough" }
])
```

--
- Equivalent avec les deux fonctions `$group` et `$count`

```js
db.restaurants.aggregate([
    { $group: { _id: "$borough", count: { $sum: 1 } } },
    { $sort: { count: -1 }}
])
```

---
class: middle, center, section
# Et via R et Python

---
## Dans R

- Utilisation de la librairie [`mongolite`](https://jeroen.github.io/mongolite/)

```r
library(mongolite)
```

--
- Connexion vers une collection spécifique (ici en local)

```r
m = mongo(collection = "restaurants", db = "test")
```

--
- Objet retourné par `mongo()` contenant les fonctions d'accès

```r
m$count()
m$find(limit = 1)
```

---
## Dans Python

- Utilisation du module [`pymongo`](https://docs.mongodb.com/drivers/pymongo/)

```python
import pymongo
```

--
- Connexion vers Mongo globalement (ici en local)

```python
client = pymongo.MongoClient()
```

--
- Objet retourné par `MongoClient()` contenant l'accès à la base

```r
db = client.test
db.restaurants.count_documents({})
db.restaurants.find(limit = 1)
```

