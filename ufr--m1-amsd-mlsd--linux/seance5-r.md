# Système pour la Data Science

## Master AMSD/MLSD

### Introduction à MongoDB

## Intéragir avec MongoDB dans R

Le but de ce document est de découvrir l'utilisation des commandes MongoDB dans R.

## Accès à MongoDB dans R

Nous allons utiliser la librairie `mongolite`. Pour l'utiliser (après l'avoir installée), on l'importe classiquement comme ci-dessous.

```r
library(mongolite)
```

### Connexion vers la collection

La première opération est de créer une connexion entre R et MongoDB en utilisant la fonction `mongo()`. Celle-ci prend en paramètre la base et la collection, plus si besoin l'adresse du serveur. Si elle n'y est pas, elle se connecte en local (ce qui est notre cas ici). Pour se connecter, on utilise le code :

```r
m = mongo(collection = "restaurants", db = "test")
```

Par le biais de l'objet ainsi créé (`m`), on a accès aux différentes fonctions que l'on a vu dans Mongo (précisemment `count()`, `distinct()`, `find()` et `aggregate()`).

### Type des objets retournés

R ne gérant pas nativement les données `JSON`, les documents sont traduits, pour la librairie `mongolite`, en `data.frame`. Pour récupérer le premier document, nous utilisons la fonction `find()` de l'objet créé `m`.

```r
d = m$find(limit = 1)
d
class(d)
```

Les objets `address` et `grades` sont particuliers, comme on peut le voir dans le `JSON`. Le premier est une liste, et le deuxième est un tableau. Voila leur classe en R.

```r
class(d$address)
d$address
class(d$grades)
d$grades
```

### Dénombrement

Il existe la fonction `count()`, qui compte directement le nombre de document. Dans le cas où l'on veut compter les documents qui respectent une certaine condition, nous utilisons le paramètre `query`. Comme vous pouvez le voir dans les exemples ci-dessous, il est nécessaire de passer la requête en `JSON`, dans une chaîne de caractères.

- Tous les restaurants (aucune contrainte sur les documents)

```r
m$count()
```

Pour sélectionner les documents, nous allons utiliser le paramètre dans la fonction `count()` (ainsi que dans les fonctions `distinct()` et `find()` que nous verrons plus tard).

- rien : tous les documents
- `{ "champs": valeur }` : documents ayant cette valeur pour ce champs
- `{ condition1, condition2 }` : documents remplissant la condition 1 **ET** la condition 2
- `"champs.sous_champs"` : permet d'accéder donc à un sous-champs d'un champs (que celui-ci soit un littéral ou un tableau)
- `{ "champs": { "$opérateur": expression }}` : utilisation d'opérateurs dans la recherche
    - `$in` : comparaison à un ensemble de valeurs
    - `$gt`, `$gte`, `$lt`, `$lte`, `$ne` : comparaison (resp. *greater than*, *greater than or equal*, *less than*, *less than or equal*, *not equal*)


- Restaurants de *Brooklyn* (contrainte dans une chaîne de caractères - **attention** donc à l'usage des `"`)

```r
m$count(query = '{ "borough": "Brooklyn" }')
```

- Restaurants de *Brooklyn* proposant de la cuisine française

```r
m$count(query = '{ "borough": "Brooklyn", "cuisine": "French" }')
```

- Restaurants de *Brooklyn* proposant de la cuisine française ou italienne

```r
m$count(query = '{ "borough": "Brooklyn", "cuisine": { "$in": ["French", "Italian"]} }')
```

- Idem mais écrit plus lisiblement

```r
m$count(query = '
  { 
    "borough": "Brooklyn", 
    "cuisine": { "$in": ["French", "Italian"]}
  }
')
```

- Restaurants situés sur *Franklin Street*
    - Notez l'accès au champs `street` du champs `address`
    
```r
m$count(query = '
  { 
    "address.street": "Franklin Street"
  }
')
```

- Restaurants ayant eu un score de 0

```r
m$count(query = '
  { 
    "grades.score": 0
  }
')
```

- Restaurants ayant eu un score inférieur à 5

```r
m$count(query = '
  { 
    "grades.score": { "$lte": 5 }
  }
')
```

### Valeurs distinctes 

Il existe la même fonction `distinct()`, avec les mêmes possibilités. Le paramètre `key` indique pour quel champs nous souhaitons avoir les valeurs distinctes. On peut aussi se restreindre à un sous-ensemble de documents respectant une contrainte particulière indiquée dans le paramètre `query` (syntaxe identique à `count()`). 

- Quartier (`borough`), pour tous les restaurants

```r
m$distinct(key = "borough")
```

- Cuisine pour les restaurants de *Brooklyn*

```r
m$distinct(
  key = "cuisine",
  query = '{ "borough": "Brooklyn" }'
)
```

- Grade des restaurants de *Brooklyn*

```r
m$distinct(
  key = "grades.grade",
  query = '{ "borough": "Brooklyn" }'
)
```

### Récupération de données avec `find()`

Cette fonction est similaire à celle de Mongo, et permet donc de récupérer tout ou partie des documents, selon éventuellement un critère de restriction (dans le paramètre `query`) et un critère de projection (dans le paramètre `fields`). Le paramètre `query` se gère comme pour le dénombrement. Pour sélectionner les champs à afficher ou non, on utilise donc le deuxième paramètre, permettant ainsi de faire une projection, avec les critères suivants :

- sans précision, l'identifiant interne est toujours affiché (`_id`)
- `{ "champs": 1 }` : champs à afficher
- `{ "champs": 0 }` : champs à ne pas afficher
- Pas de mélange des 2 sauf pour l'identifiant interne à Mongo (`_id`)
    - `{ "_id": 0, "champs": 1, ...}`

Cette fonction renvoie un `data.frame`, ce qui n'est pas toujours idéal pour certains champs.

Dans cette fonction `find()`, il est aussi possible de faire le tri des documents, avec le paramètre `sort` qui prend un littéral indiquant 1 ou plusieurs critères de tri

- `{"champs": 1}` : tri croissant
- `{"champs": -1}` : tri décroissant
- plusieurs critères de tri possibles (dans les 2 sens)

Pour n'avoir que le premier document, on utilise le paramètre `limit` (pas de fonction type `findOne()` donc). On peut limiter l'exploration à une partie, avec les paramètres suivant :

- `limit` : restreint le nombre de résultats fournis
- `skip` : ne considère pas les *n* premiers documents


#### Exemples

- Récupération des 5 premiers documents
    - Notez le contenu des colonnes `address` (décomposé en plusieurs colonnes) et `grades` (format peu compréhensible).
    
```r
m$find(limit = 5)
```

- Restaurants *Shake Shack* (uniquement les attributs `"street"` et `"borough"`)

```r
m$find(
    '{ "name": "Shake Shack" }', 
    '{ "address.street": 1, "borough": 1 }'
)
```

- Idem sans l'identifiant interne

```r
m$find(
    '{ "name": "Shake Shack" }', 
    '{ "_id": 0, "address.street": 1, "borough": 1 }'
)
```

- 5 premiers restaurants du quartier *Queens*, avec une note A et un score supérieur à 50 (on affiche le nom et la rue du restaurant

```r
m$find(
    '{"borough": "Queens", "grades.score": { "$gte":  50}}',
    '{"_id": 0, "name": 1, "grades.score": 1, "address.street": 1}',
    limit = 5
)
```

- Restaurants *Shake Shack* dans différents quartiers (*Queens* et *Brooklyn*)

```r
m$find(
    '{"name": "Shake Shack", "borough": {"$in": ["Queens", "Brooklyn"]}}', 
    '{"_id": 0, "address.street": 1, "borough": 1}'
)
```

- Restaurants du Queens ayant une note supérieure à 50, mais trié par ordre décroissant de noms de rue, et ordre croissant de noms de restaurants (uniquement les 10 premiers).

```r
m$find(
    '{"borough": "Queens", "grades.score": { "$gt":  50}}',
    '{"_id": 0, "name": 1, "address.street": 1}',
    sort = '{"address.street": -1, "name": 1}',
    limit = 10
)
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

```r
m$aggregate('
    [
        {"$limit": 10 }
    ]
')
```

- Idem avec tri sur le nom du restaurant

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$sort": { "name": 1 }}
    ]
')
```

- Idem en se restreignant à *Brooklyn*
    - Notez que nous obtenons uniquement 5 restaurants au final

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$sort": { "name": 1 }},
        { "$match": { "borough": "Brooklyn" }}
    ]
')
```

- Mêmes opérations mais avec la restriction en amont de la limite
    - Nous avons ici les 10 premiers restaurants de *Brooklyn* donc

```r
m$aggregate('
    [
        { "$match": { "borough": "Brooklyn" }},
        { "$limit": 10 },
        { "$sort": { "name": 1 }}
    ]
')
```

- Séparation des 5 premiers restaurants sur la base des évaluations (`grades`)
    - Chaque ligne correspond maintenant a une évaluation pour un restaurant

```r
m$aggregate('
    [
        { "$limit": 5 },
        { "$unwind": "$grades" }
    ]
')
```

- Idem précédemment, en se restreignant à celle ayant eu *B*

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$unwind": "$grades" },
        { "$match": { "grades.grade": "B" }}
    ]
')
```

- Si on inverse les opérations `$unwind` et `$match`, le résultat est clairement différent

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$match": { "grades.grade": "B" }},
        { "$unwind": "$grades" }
    ]
')
```

- On souhaite ici ne garder que le nom et le quartier des 10 premiers restaurants
    - Notez l'ordre (alphabétique) des variables, et pas celui de la déclaration

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1 } }
    ]
')
```

- Ici, on supprime l'adresse et les évaluations 

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$project": { "address": 0, "grades": 0 } }
    ]
')
```

- En plus du nom et du quartier, on récupère l'adresse mais dans un nouveau champs 

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1 , "street": "$address.street"} }
    ]
')
```

- On ajoute le nombre de visites pour chaque restaurant (donc la taille du tableau `grades`)

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1, "nb_grades": { "$size": "$grades" } } }
    ]
')
```

- On trie ce résultat par nombre décroissant de visites, et on affiche les 10 premiers

```r
m$aggregate('
    [
        { "$project": { "name": 1, "borough": 1, "nb_grades": { "$size": "$grades" } } },
        { "$sort": { "nb_grades": -1 }},
        { "$limit": 10 }
    ]
')
```

- On ne garde maintenant que le premier élément du tableau `grades` (indicé 0)

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1, "grade": { "$arrayElemAt": [ "$grades", 0 ]} } }
    ]
')
```

- `$first` permet aussi de garder uniquement le premier élément du tableau `grades` de façon explicite (`$last` pour le dernier)

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$project": { "name": 1, "borough": 1, "grade": { "$first": "$grades" } } }
    ]
')
```

- On peut aussi faire des opérations sur les chaînes, tel que la mise en majuscule du nom

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$project": { "nom": { "$toUpper": "$name" }, "borough": 1 } }
    ]
')
```

- On peut aussi vouloir ajouter un champs, comme ici le nombre d'évaluations

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$addFields": { "nb_grades": { "$size": "$grades" } } }
    ]
')
```

- On extrait ici les trois premières lettres du quartier

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$project": { 
            "nom": { "$toUpper": "$name" }, 
            "quartier": { "$substr": [ "$borough", 0, 3 ] } 
        } }
    ]
')
```

- On fait de même, mais on met en majuscule et on note *BRX* pour le *Bronx*
    - on garde le quartier d'origine pour vérification ici

```r
m$aggregate('
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
')
```

- On calcule ici le nombre total de restaurants

```r
m$aggregate('
    [
        {"$group": {"_id": "Total", "NbRestos": {"$sum": 1}}}
    ]
')
```

- On fait de même, mais par quartier

```r
m$aggregate('
    [
        {"$group": {"_id": "$borough", "NbRestos": {"$sum": 1}}}
    ]
')
```

- Une fois le dénombrement fait, on peut aussi trié le résultat

```r
m$aggregate('
    [
        {"$group": {"_id": "$borough", "NbRestos": {"$sum": 1}}},
        {"$sort": { "NbRestos": -1}}
    ]
')
```

- La même opération est réalisable directement avec `$sortByCount`

```r
m$aggregate('
    [
        {"$sortByCount": "$borough"}
    ]
')
```

- Pour faire le calcul des notes moyennes des restaurants du *Queens*, on exécute le code suivant

```r
m$aggregate('
    [
        { "$match": { "borough": "Queens" }},
        { "$unwind": "$grades" },
        { "$group": { "_id": "null", "score": { "$avg": "$grades.score" }}}
    ]
')
```

-  Il est bien évidemment possible de faire ce calcul par quartier et de les trier selon les notes obtenues (dans l'ordre décroissant)

```r
m$aggregate('
    [
        { "$unwind": "$grades" },
        { "$group": { "_id": "$borough", "score": { "$avg": "$grades.score" }}},
        { "$sort": { "score": -1 }}
    ]
')
```

- On peut aussi faire un regroupement par quartier et par rue (en ne prenant que la première évaluation - qui est la dernière en date a priori), pour afficher les 10 rues où on mange le plus sainement
    - Notez que le `$match` permet de supprimer les restaurants sans évaluations (ce qui engendrerait des moyennes = `None`)

```r
m$aggregate('
    [
        { "$project": {
            "borough": 1, "street": "$address.street", 
            "eval": { "$arrayElemAt": [ "$grades", 0 ]} 
        } },
        { "$match": { "eval": { "$exists": true } } },
        { "$group": { 
            "_id": { "quartier": "$borough", "rue": "$street" }, 
            "score": { "$avg": "$eval.score" }
        }},
        { "$sort": { "score": 1 }},
        { "$limit": 10 }
    ]
')
```

- Pour comprendre la différence entre `$addToSet` et `$push`, on les applique sur les grades obtenus pour les 10 premiers restaurants
    - `$addToSet` : valeurs distinctes
    - `$push` : toutes les valeurs présentes

```r
m$aggregate('
    [
        { "$limit": 10 },
        { "$unwind": "$grades" },
        { "$group": { 
            "_id": "$name", 
            "avec_addToSet": { "$addToSet": "$grades.grade" },
            "avec_push": { "$push": "$grades.grade" }
        }}
    ]
')
```


## Difficultés potentielles liées à R

Lorsqu'on travaille avec MongoDB dans R, nous pouvons rencontrer des problèmes sur 2 points particuliers :

- La création de la chaîne de caractères contenant le JSON pour les paramètres comme `query` ou `pipeline` ;
- La récupération des données JSON dans un `data.frame`

### Création de JSON

Comme indiqué dans ci-dessus, les paramètres doivent être des chaînes de caractères contenant le JSON. On peut donc soit les écrire comme précédemment, directement. Mais lorsqu'on veut intégrer dedans une variable (comme par exemple un `input` d'une application Shiny), il faut créer automatiquement la chaîne de caractères.

Prenons l'exemple de la recherche du nombre de restaurants dans le Bronx :

```r
m$count(query = '{ "borough": "Bronx" }')
```

Imaginons maintenant que notre quartier est dans une variable `q` (on a donc `q = "Bronx"`). Il faut donc créer la chaîne passée en paramètre ci-dessus. Pour cela, nous avons plusieurs possibilités. Mais il faut surtout faire attention à bien avoir les guillemets (`"`) dans la chaîne.

#### Avec la fonction `paste()` (ou mieux `paste0()`)

Cette solution est la plus basique. Elle peut facilement être illisible si l'on doit intégrer beaucoup de variables dans la chaîne.

```r
c = paste0('{ "borough": "', q, '" }')
m$count(query = c)
```

#### Avec la fonction `sprintf()`

Cette fonction a l'avantage de rendre plus lisible la chaîne que l'on va construire. Elle prend 2 paramètres (ou plus) :

1. La chaîne à construire, avec des emplacements où intégrer les variables indiqués par `%x` (le `x` désignant le format)
    - `%s` : chaîne de caractères (`s` pour `string`) 
    - `%f` : nombre réel (`f` pour `float` - `%.2f` pour un arrondi à 2 décimales)
2. La ou les variables à intégrer dans la chaîne

Dans notre exemple, nous ferions comme ci-dessous.

```r
c = sprintf('{ "borough": "%s" }', q)
m$count(query = c)
```

#### Avec la fonction `toJSON()`

Cette fonction est fournie par la librairie `jsonlite`, et permet de construire un objet JSON à partir d'un objet R (très souvent une liste). Par défaut, les valeurs simples sont rangées dans un vecteur. On peut modifier ce comportement en mettant à `TRUE` le paramètre `auto_unbox` (ce qu'on va faire ici).

```r
l = list(borough = q)
c = toJSON(l, auto_unbox = T)
m$count(query = c)
```

Cette option est la plus versatile, car elle permet de gérer des créations de JSON très complexes, ce que ne permettent pas les autres options.

### Récupération des données

Comme indiqué plus haut, les fonctions de `mongolite` transforment automatiquement le JSON renvoyé en `data.frame`. Cela est globalement très pratique mais engendre des soucis lorsque les données sont complexes (*i.e.* dans des sous-champs et autres). 

Prenons les 5 premiers restaurants.

```r
df = m$find(limit = 5)
df
```

La colonne `grades` est une liste de `data.frames`.

```r
df$grades
```

La colonne `address` est elle un `data.frame` (presque) simple.

```r
df$address
```

En effet, la colonne `coord` de `address` est une liste de vecteurs.

```r
df$address$coord
```

En l'état, il n'est pas possible d'utiliser ces attributs directement.

#### Récupération des coordonnées

Pour obtenir ces coordonnées, nous pouvons faire de deux façons : séparément ou simultanément.

##### Récupération séparée 

On utilise la fonction `sapply()`, qui applique une fonction passée en deuxième paramètre à chaque élément de la liste passée en premier paramètre. Chaque fonction est ici définit directement (on parle alors de fonction anonyme). Celles-ci ne font que retourner le premier (ou le deuxième) élément du vecteur. L'intérêt de `sapply()` ici est qu'elle simplifie le résultat en une matrice, que l'on transpose ensuite (avec `t()`).

```r
lng = sapply(df$address$coord, function(c) { return (c[1]) })
lat = sapply(df$address$coord, function(c) { return (c[2]) })
plot(lng, lat)
```

On pourrait bien évidemment garder ces retours dans le `data.frame` plutôt que dans une variable.

```r
df$lng = sapply(df$address$coord, function(c) { return (c[1]) })
df$lat = sapply(df$address$coord, function(c) { return (c[2]) })
```

##### Récupération simultanée

```r
mat = t(sapply(df$address$coord, function(c) { return(list(lng = c[1], lat = c[2]))}))
plot(mat)
```

On peut aussi ajouter ces 2 colonnes au `data.frame`.

```r
df = cbind(df, mat)
```

#### Travail sur les grades

Pour travailler sur les grades, nous devons pouvoir récupérer pour chaque évaluation, toutes les informations du restaurant évalué. Ceci est assez complexe à faire en R. On va le faire en deux étapes :

1. Joindre les informations du restaurant à chaque évaluation
2. Regrouper les informations des différents restaurants dans un seul `data.frame`

##### Jointure entre grades et les autres informations du restaurant

On utilise ici la fonction `lapply()`, similaire à `sapply()` qui applique une fonction passée en deuxième paramètre à chaque élément de la liste passée en premier paramètre. Nous utilisons ici la liste `1, 2, 3, ...` (jusqu'au nombre de lignes du `data.frame` `df`).  La fonction passée en paramètre prend donc comme paramètre la position de l'élément qui nous intéressé. On récupère les évaluations (`df$grades[[i]]`) et les informations du restaurant (normalement juste `df[i,]`). Comme nous voulons joindre les deux (avec `cbind()`), il faut avoir le même nombre de lignes. Nous dupliquons donc la *i*ème ligne autant de fois qu'il y a de lignes dans `grades`. On supprime ensuite les évaluations (`grades`) dans `infos`. Et enfin, on les *colle* ensemble.

```r
liste = lapply(1:nrow(df), function (i) {
  grades = df$grades[[i]]
  infos = df[rep(i, nrow(grades)),]
  infos$grades = NULL
  cbind(infos, grades)
})
liste
```

##### Regroupement dans un seul `data.frame`

Nous utilisons ici la fonction `Reduce()`. Celle-ci prend en premier paramètre (**attention** changement par rapport à `lapply()`) une fonction indiquant comment regrouper 2 éléments entre eux, et en deuxième paramètre la liste à traiter. La fonction applique la fonction sur les deux premiers éléments, puis sur le résultat et le troisième élément, et ainsi de suite jusqu'à épuisement de la liste. A la fin, nous obtenons donc un seul élément. La fonction passée en paramètre ici est `rbind()`, qui *colle* deux `data.frames` l'un au-dessus de l'autre. Au final, nous avons bien un seul `data.frame`.

```r
df_grades = Reduce(rbind, liste)
df_grades
```

#### Conclusion sur la récupération des données

Nous avons vu ici qu'on pouvait traiter dans R les données obtenues, quelque soit le format. Pour autant, c'est fastidieux et parfois beaucoup plus compliqué. L'idéal est donc de penser à ce qu'on veut faire ensuite pour savoir comment récupérer les données. Et donc, **de faire des pré-traitements directement dans MongoDB**.

Pour récupérer proprement les coordonnées, on aurait pu faire comme ci-dessous.

```r
df_coord = m$aggregate('
[
  { "$limit": 5 }, 
  { "$addFields" : { 
    "lng": { "$arrayElemAt" : [ "$address.coord", 0 ] },
    "lat": { "$arrayElemAt" : [ "$address.coord", 1 ] } 
  } }
]')
df_coord
```

Par exemple, pour le travail sur les grades, nous aurions pu faire directement (avec toutefois le même comportement pour `grades` que pour `address`).

```r
df_grades = m$aggregate('[ {"$limit": 5}, {"$unwind": "$grades" }]')
df_grades
```


