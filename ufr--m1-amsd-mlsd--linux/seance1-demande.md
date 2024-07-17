# Système pour la Data Science

## Master AMSD/MLSD

### Langage système de base

#### Demande à réaliser


## Création d'une machine virtuelle Ubuntu Server 

Vous pouvez utiliser ce [tutoriel](seance1-creation-vm) pour vous guider dans la création de la machine virtuelle, que l'on utilisera dans tous les cours par la suite

## Répondre aux questions suivantes

Nous allons utiliser des données réelles sur l'[usage de smartphones](http://archive.ics.uci.edu/ml/datasets/UbiqLog+%28smartphone+lifelogging%29)

1. Créer un répertoire dédié au cours (`sysds` exemple)
1. Créer un répertoire dédié à la séance (`seance1` par exemple)
1. Créer un fichier texte vide (nommé `notes.txt`)
2. Ecrire dans ce fichier les deux commandes que vous avez utilisé précédemment, pour rappel plus tard
    - Puisque c'est un langage interprété, les commandes ne sont pas stockées dans un fichier
    - Si vous souhaitez prendre des notes sur ce que vous avez fait, vous pouvez donc utiliser ce fichier
    - La commande `history` permet de récupérer l'historiques des 500 dernières commandes (`history 10` pour n'avoir que les 10 dernières)
4. Télécharger le fichier [`UbiqLog4UCI.zip`](http://archive.ics.uci.edu/ml/machine-learning-databases/00369/UbiqLog4UCI.zip) dans ce nouveau répertoire
    - URL = `http://archive.ics.uci.edu/ml/machine-learning-databases/00369/UbiqLog4UCI.zip`
5. Le décompresser dans le répertoire de la séance
6. (re)Compresser le répertoire au format `gz`, puis comparer leur taille 
    - En stockant le résultat dans un fichier texte nommé `compress_compare.txt`
8. Sans changer de répertoire, lister les sous-répertoires du nouveau dossier
    - Stocker cette liste de répertoire (avec toutes les informations possibles) dans un fichier texte (à la racine de la séance) nommé `UbiqLog4UCI_list_dir.txt`
9. Afficher les premières lignes du fichier `log_11-1-2014.txt` présent dans le sous-répertoire `1_M`
9. Afficher les informations de ce même fichier `log_11-1-2014.txt`
    - Type
    - Nombre de caractères, de lignes et d'octets
11. En utilisant `grep`, chercher les lignes contenant `Application` dans le même fichier 
12. Toujours avec `grep`, chercher les lignes contenant `Application` et `outlook` dans le même fichier
    - Stocker ce résultat dans un fichier texte à la racine de la séance, nommé `res_grep.txt`
13. Ajouter à ce fichier les lignes contenant `Application`, puis `google` puis `email`
14. Faire les 3 dernières demandes avec la commande `sed` (en remplacant `grep` par `sed` dans le nom de fichier)
15. Ecrire les numéros des individus (première partie du nom du répertoire) correspondant aux hommes (`M`) dans un fichier nommé `idM.txt`

