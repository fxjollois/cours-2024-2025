# Système pour la Data Science

## Master AMSD/MLSD

### Langage système de base

#### *Correction*


## Répondre aux questions suivantes

Nous allons utiliser des données réelles sur l'[usage de smartphones](http://archive.ics.uci.edu/ml/datasets/UbiqLog+%28smartphone+lifelogging%29)

#### 1. Créer un répertoire dédié au cours (`sysds` exemple)

```bash
$ mkdir sysds
$ cd sysds
```

#### 2. Créer un répertoire dédié à la séance (`seance1` par exemple)

```bash
$ mkdir seance1
$ cd seance1
```

#### 3. Créer un fichier texte vide (nommé `notes.txt`)

```bash
$ touch notes.txt
```

#### 4. Ecrire dans ce fichier les deux commandes que vous avez utilisé précédemment, pour rappel plus tard

- Puisque c'est un langage interprété, les commandes ne sont pas stockées dans un fichier
- Si vous souhaitez prendre des notes sur ce que vous avez fait, vous pouvez donc utiliser ce fichier
- La commande `history` permet de récupérer l'historiques des 500 dernières commandes (`history 10` pour n'avoir que les 10 dernières)

##### Avec `nano`

```bash
$ nano notes.txt
```

##### Avec `history`

```bash
$ history 5 >> notes.txt # 5 si vous avez faire nano, 4 sinon
```

> N'hésitez pas à faire un `nano` pour commenter le fichier

#### 5. Télécharger le fichier [`UbiqLog4UCI.zip`](http://archive.ics.uci.edu/ml/machine-learning-databases/00369/UbiqLog4UCI.zip) dans ce nouveau répertoire

- URL = `http://archive.ics.uci.edu/ml/machine-learning-databases/00369/UbiqLog4UCI.zip`

```bash
$ wget http://archive.ics.uci.edu/ml/machine-learning-databases/00369/UbiqLog4UCI.zip
```

#### 6. Le décompresser dans le répertoire de la séance

```bash
$ sudo apt install zip
$ unzip UbiqLog4UCI.zip
```

> Pour supprimer le répertoire `__MACOSX` (présent car archive faite sous Mac)

```bash
$ rm -r __MACOSX
```

#### 7. (re)Compresser le répertoire au format `gz`, puis comparer leur taille 

```bash
$ tar -zcvf UbiqLog4UCI.tar.gz UbiqLog4UCI/
$ ls -lh
```
- En stockant le résultat dans un fichier texte nommé `compress_compare.txt`

```bash
$ ls -lh UbiqLog4UCI.* > compress_compare.txt
$ cat compress_compare.txt
```

#### 8. Sans changer de répertoire, lister les sous-répertoires du nouveau dossier

- Stocker cette liste de répertoire (avec toutes les informations possibles) dans un fichier texte (à la racine de la séance) nommé `UbiqLog4UCI_list_dir.txt`

```bash
$ ls -lh UbiqLog4UCI/ > UbiqLog4UCI_list_dir.txt
$ cat UbiqLog4UCI_list_dir.txt
```

#### 9. Afficher les premières lignes du fichier `log_11-1-2014.txt` présent dans le sous-répertoire `1_M`

```bash
$ head UbiqLog4UCI/1_M/log_11-1-2014.txt
```

#### 10. Afficher les informations de ce même fichier `log_11-1-2014.txt`

- Type

```bash
$ file UbiqLog4UCI/1_M/log_11-1-2014.txt
```

- Nombre de caractères, de lignes et d'octets

```bash
$ wc UbiqLog4UCI/1_M/log_11-1-2014.txt 
```

#### 11. En utilisant `grep`, chercher les lignes contenant `Application` dans le même fichier 

```bash
$ grep "Application" UbiqLog4UCI/1_M/log_11-1-2014.txt 
```

#### 12. Toujours avec `grep`, chercher les lignes contenant `Application` et `outlook` dans le même fichier

- Stocker ce résultat dans un fichier texte à la racine de la séance, nommé `res_grep.txt`

```bash
$ grep "Application.*outlook" UbiqLog4UCI/1_M/log_11-1-2014.txt > res_grep.txt
$ cat res_grep.txt
```

#### 13. Ajouter à ce fichier les lignes contenant `Application`, puis `google` puis `email`

```bash
$ grep "Application.*google.*email" UbiqLog4UCI/1_M/log_11-1-2014.txt >> res_grep.txt
$ cat res_grep.txt # Doit avoir aussi les résultats de la question 12
```

#### 14. Faire les 3 dernières demandes avec la commande `sed` (en remplacant `grep` par `sed` dans le nom de fichier)

```bash
$ sed -n -e "/Application/p" UbiqLog4UCI/1_M/log_11-1-2014.txt 
$ sed -n -e "/Application.*outlook/p" UbiqLog4UCI/1_M/log_11-1-2014.txt > res_sed.txt
$ sed -n -e "/Application.*google.*email/p" UbiqLog4UCI/1_M/log_11-1-2014.txt >> res_sed.txt
```

#### 15. Ecrire les numéros des individus (première partie du nom du répertoire) correspondant aux hommes (`M`) dans un fichier nommé `idM.txt`

```bash
$ ls UbiqLog4CI | grep "_M" | sed 's/_M//g' > idM.txt
$ cat idM.txt
```

