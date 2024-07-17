# Système pour la Data Science

## Master AMSD/MLSD

### Introduction à MongoDB

#### Demande à réaliser


## Installation de Mongo DB

> **Attention** : un peu complexe

Nous nous basons sur le tutoriel officielle disponible sur [cette page](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/), avec quelques modifications pour que cela fonctionne sur la VM. N'hésitez pas à tester d'autres choses si cela ne fonctionne pas chez vous.

- Importer la clé publique 
```bash
$ curl https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
```

- Créer un fichier spécifique pour MongoDB
```bash
$ echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
```

- Mettre à jour la VM
```bash
$ sudo apt update
```

- Installer de `libssl 1.1` (je n'ai pas pu faire sans cette étape)
```bash
$ curl http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb --output libssl.deb
$ sudo dpkg -i libssl.deb
```

- Installer mongo 
```bash
$ sudo apt-get install -y mongodb-org
```

- Redémarrer la machine
- Pour lancer Mongo, vous devrez (à chaque lancement de machine a priori) faire 
```bash
$ sudo systemctl start mongod
```

- Pour vérifier si le serveur Mongo fonctionne, vous pouvez faire
```bash
$ sudo systemctl status mongod
```

- Pour lancer le shell mongo, vous devez faire
```bash
$ mongosh
```

### Importation des données des restaurants new-yorkais

- Télécharger le fichier `restaurants.json`
```bash
$ curl https://fxjollois.github.io/donnees/restaurants.json --output restaurants.json
```

- Importer les données dans Mongo (base `test` et collection `restaurants`)
```bash
$ mongoimport --db test --collection restaurants restaurants.json
```

- Vérifier que tout est OK :
    - Lancer le shle mongo
```bash
$ mongosh
```
    - Aller dans la base `test` (celle apr défaut) pour voir si la collection est bien présente
```js
> show dbs
> use test
> show collections
> db.restaurants.findOne()
```

#### Noter la structure du document

- Quelques champs *simples* : `_id` (clé primaire interne toujours présente), `borough`, `cuisine`, `name` et `restaurant_id`
- Un champs de type littéral (`address`), contenant des champs simples (`building`, `street` et `zipcode`) et un tableau à 2 valeurs `coord`)
- Un tableau `grades` (de 5 éléments ici - la taille n'est pas la même pour chaque restaurant)
    - chaque élément du tableau comprenant 3 champs simples (`date`,  `grade` et `score`)
    - un élément du tableau = un contrôle sanitaire
        - `score` : nombre d'infractions sanitaires
        - `grade` : sorte de note du restaurant en fonction du score (A si peu, B si plus, C si encore plus)



## Utilisation dans R

- Potentiellement, vous devrez installer les packages `libssl-dev` et `libsasl2-dev` sur le serveur (je n'ai pas pu faire sans encore une fois)
```bash
$ sudo apt install libssl-dev libsasl2-dev
```

- Installer [`mongolite`](https://jeroen.github.io/mongolite/)
```r
> install.packages("mongolite")
```

- Suivre le [tutoriel R et Mongo](seance5-r)

## Utilisation dans Python

- Installer [`pymongo`](https://docs.mongodb.com/drivers/pymongo/) (dans le shell de la VM)
```bash
$ pip3 install pymongo
```

- Suivre le [tutoriel Python et Mongo](seance5-python)

--
## Questions sur les restaurants new-yorkais

A faire dans R et dans Python 

1. Lister les informations du restaurant “Cafe Henri”
1. Lister tous les restaurants de la chaîne “Bareburger” (rue, quartier)
1. Lister les restaurants n’ayant pas de quartier connu (“Missing”)
1. Lister les restaurants ayant eu un score de 0
1. Lister les restaurants ayant eu un score entre 0 et 10 (inclus)
1. Lister les restaurants qui ont le terme “Cafe” dans leur nom
1. Lister les restaurants faisant de la cuisine de type “Pizza” dans “Brooklyn”
1. Quelles sont les 10 plus grandes chaines de restaurants (nom identique) ?
1. Lister par quartier le nombre de restaurants et le score moyen
1. Donner le Top 5 et le Flop 5 des types de cuisine, en terme de nombre de restaurants
1. Donner les dates de début et de fin des évaluations
1. Quels sont les 10 restaurants (nom, quartier, addresse et score) avec le plus petit score moyen ?
1. Quels sont les restaurants (nom, quartier et addresse) avec uniquement des grades “A” ?
1. Compter le nombre d’évaluation par jour de la semaine




