---
layout: slides
---

class: middle, center, inverse, title
# Système pour la Data Science

## Master AMSD/MLSD

### Langage système de base

---
class: section, middle, center
## Linux

---

## Présention

- Issu de *Unix*, conçu dans les années 1960

- Débuté comme un projet étudiant par *Linus Torvald* (1991)

- Maintenant, système d'exploitation le plus répandu sur les serveurs
    - multi-utilisateurs
    - multi-tâches
    - gratuit

- Système d'exploitation regroupant 
    - Gestion mémoire et entrées-sorties
    - Interpréteur de langage de commandes (dont `bash` vu ici)
    - Système de messagerie
    - Nombreux utilitaires (compilateurs, éditeurs, ...)

---

## Caractéristiques

- Fiable et pas (ou très peu) de *plantage*
    - Moins de *bugs* que les concurrents comme *Windows*
    - Virus très rares car moins facile à déployer (pas d'exécutable type *Windows*)

- Fonctionne sur tout type de machine

- Gratuit et surtout *open source*

- Pas de support technique autre que la communauté (forums, sites web dédiés, ...)

- Possibilité de fonctionner sans interface graphique (utile pour les serveurs)


---

## Pourquoi un cours orienté Système est intéressant ?

Data Science principalement sur des outils fonctionnant sous Linux

- R et Python en particulier
- Tout ce qui est autour du Big Data
- Tout ce qui est autour du Deep Learning

## Comment mettre en pratique ?

Utilisation d'une machine virtuelle *Ubuntu Server*

- A créer (cf suite de la séance)

---

## Ce qu'on verra ? (dans le désordre)

- Commandes de base

- Ecritures de scripts `shell`
    - Automatisation et ests

- Déploiement autour de R
    - sur notre serveur propre
    - d'applications Shiny

- Déploiement autour de Python
    - sur notre serveur propre
    - d'applications Streamlit

- Installation d'outils (RStudio Server, Shiny Server, JupyterHub...)

---

## Comment lire ce document ?

- Présentation sommaire de différentes commandes et des paramètres usuels de celles-si

- Liens disponibles vers l'[aide Ubuntu](https://manpages.ubuntu.com/)

> **A FAIRE** : tester les commandes sur votre serveur (une fois celui-ci créé, dans la seconde partie de la séance)

> *Idéalement* : tester des variantes des commandes pour comprendre son fonctionnement

- Quelques liens intéressants en plus de l'aide Ubuntu :
    - [developpez.com](https://www.developpez.com/) : plusieurs sections très utiles
    - [stackoverflow](https://stackoverflow.com/) : forum de référence
    - [google](https://www.google.com/), [bing](https://www.bing.com/?cc=fr), [qwant](https://www.qwant.com/?l=fr) et consorts sont aussi vos amis
    
---
class: section, middle, center
## Commandes de base

---

## Interface de commande en ligne

- Commande à écrire, suivie des arguments si besoin
    - Après le *prompt* (**$** ou **>>** ou *%* ou ...)

- Exécution direct après appui sur *Entrée*
    - Langage dit interprété donc

- Interprétation si c'est possible
    - Sinon attente de la suite à la ligne suivante
    - Tant que le *prompt* n'apparaît pas, la commande n'est pas connsidérée comme interprétable

- Résultats affichés dans la console

- Navigation dans les anciennes commandes avec les flèches haut et bas

---

## Commande la plus utile (ou presque)

- [`man`](https://manpages.ubuntu.com/manpages/jammy/en/man1/man.1.html) : aide sur une commande en particulier
    - nom de la commande à mettre en paramètre
    - Navigation avec les flèches (ou les flèches *page précédente* et *page suivante*)
    - Quitter en tapant `q`
    
```bash
man man
```

---

## Commandes de base

- [`echo`](https://manpages.ubuntu.com/manpages/jammy/fr/man1/echo.1.html) : affichage d'une chaîne de caractères
    - Quotes (simples ou doubles) non utiles

```bash
$ echo "Bonjour à vous"
$ echo Bonjour à vous
```

- [`date`](https://manpages.ubuntu.com/manpages/jammy/en/man1/date.1.html) : date du jour (avec formatage possible)

```bash
$ date
```

- [`who`](https://manpages.ubuntu.com/manpages/jammy/en/man1/who.1.html) : qui est connecté sur le système ?
    - la deuxième permet de savoir qui on est et sur quel terminal ou fenêtre on est

```bash
$ who
$ who am i
```

---

## Navigation dans l'arborescence des fichiers

- [`pwd`](https://manpages.ubuntu.com/manpages/jammy/en/man1/pwd.1.html) : nom du répertoire de travail 

```bash
$ pwd
```

- [`cd`](https://manpages.ubuntu.com/manpages/kinetic/en/man1/cd.1posix.html) : changement du répertoire de travail
    - sans paramètre, répertoire *home* de l'utilisateur
    - adressage relatif ou absolu à utiliser
        - relatif : chemin par rapport à la position actuelle
        - absolu : chemin depuis la racine `/`
    - `..`, répertoire parent du répertoire actuel
    
```bash
$ cd Documents
$ cd 
```

.footnote[.small[L'auto-complétion fonctionne sur les commandes ET sur les chemins et fichiers.]]

---

## Contenu d'un répertoire

- [`ls`](https://manpages.ubuntu.com/manpages/jammy/en/man1/ls.1.html) : liste le contenu du répertoire courant
    - si nom de répertoire passé en paramètre, en liste le contenu
    - `*` permet de remplacer toute chaîne de caractères

```bash
$ ls
$ ls *.txt
```

- Options avec `-` puis une ou plusieurs lettres parmi
    - `l` : informations
        - type de fichier et droits d'accès
        - nombre de liens (1 si fichier, depend du contenu si répertoire)
        - propriétaire et groupe
        - taille,  date de dernire modification et nom
    - `h` : formatage de l'affichage de l'espace mémoire plus lisible
    - `a` : tous les fichiers (même cachés - *i.e* commençant par `.`)

```bash
$ ls -lh
$ ls -a
```

---

## Création d'un fichier

- Opérateur `>` envoie le résultat d'une commande dans un fichier texte

```bash
$ echo Ceci est un test > test.txt
$ date > test_date.txt
```

- [`touch`](https://manpages.ubuntu.com/manpages/jammy/en/man1/touch.1.html) : créé un fichier vide

```bash
$ touch test_vide.txt
```

- [`nano`](https://manpages.ubuntu.com/manpages/jammy/en/man1/nano.1.html) : éditeur de texte simple
    - `Ctrl+X` pour quitter
    - `Ctrl+O` pour écrire
    - Commandes indiquées en bas de l'écran

```bash
$ nano test_vide.txt
```


---

## Suppression d'un fichier

- [`rm`](https://manpages.ubuntu.com/manpages/jammy/en/man1/rm.1.html) : suppression d'un fichier (ou de plusieurs si utilisation de `*`)
    - Deuxième ligne : suppression de tous les fichiers finissant par `.txt`
    - Troisième ligne : suppression de tous les fichiers
    - Ne fonctionne pas pour un répertoire

```bash
$ rm test_date.txt
$ rm *.txt
$ rm *
```

---

## Création/Suppression d'un répertoire

- [`mkdir`](https://manpages.ubuntu.com/manpages/jammy/en/man1/mkdir.1.html) : créé un répertoire avec le nom passé en paramètre
    - Si espace(s) voulu(s), soit mettre entre quotes, soit utiliser `"\ "`

```bash
$ mkdir dir_test
$ mkdir "dir test2"
$ mkdir dir\ test3
```

- [`rmdir`](https://manpages.ubuntu.com/manpages/jammy/en/man1/rmdir.1.html) : supprime le répertoire passé en paramètre
    - Ne fonctionne que si le répertoire est vide
    - Deuxième et troisième lignes : utilisation possible de `*`
    
```bash
$ rmdir "dir test2"
$ rmdir dir*
$ rmdir *
```

---

## Informations, contenu et recherche d'un fichier

- [`file`](https://manpages.ubuntu.com/manpages/jammy/en/man1/file.1.html) : type de fichier
- [`wc`](https://manpages.ubuntu.com/manpages/jammy/fr/man1/wc.1.html) : nombre de caractères, de lignes et d'octets

```bash
$ echo "Ceci est encore un test" > test.txt
$ file test.txt
$ wc test.txt
```

- [`cat`](https://manpages.ubuntu.com/manpages/jammy/en/man1/cat.1.html) : affiche le contenu du fichier, quelqu'il soit (texte ou binaire)

```bash
$ cat test.txt
```

- [`find`](https://manpages.ubuntu.com/manpages/jammy/en/man1/find.1.html) : recherche un (ou plusieurs) fichiers dans le répertoire courant

```bash
$ find t*
```

---

## Complément sur la lecture d'un fichier texte

- [`head`](https://manpages.ubuntu.com/manpages/jammy/en/man1/head.1.html) : ne lit que le début du fichier
- [`tail`](https://manpages.ubuntu.com/manpages/jammy/en/man1/tail.1.html) : ne lit que les dernières lignes
    - Option `-n 5` : détermine le nombre de lignes à lire (10 par défaut)

```bash
$ head .profile # fichier caché
$ head .profile -n 1
$ tail .profile
$ tail .profile -n 5
```

- [`more`](https://manpages.ubuntu.com/manpages/jammy/en/man1/more.1.html) : affichage par pages
- [`less`](https://manpages.ubuntu.com/manpages/jammy/en/man1/less.1.html) : affichage par lignes
    - Interactifs tous les 2 : possibilité de choisir comment faire défiler les lignes

```bash
$ more .profile # peu utile ici car fichier assez court
$ less .profile
```

---

## Manipulation d'un fichier


- [`cp`](https://manpages.ubuntu.com/manpages/jammy/en/man1/cp.1.html) : permet de copier le fichier (premier paramètre) en fonction du 2ème
    - Si nom de fichier : copie avec le nouveau nom
    - Si répertoire : copie dans ce répertoire avec le même nom
    - Si répertoire + nom de fichier : idem mais avec nouveau nom

```bash
$ cp test.txt test2.txt
$ mkdir dir_test
$ cp test.txt dir_test
$ cp test.txt dir_test/test3.txt
```

- [`mv`](https://manpages.ubuntu.com/manpages/jammy/en/man1/mv.1.html) : déplace un fichier dans un répertoire 

```bash
$ mv test2.txt dir_test 
```

---

## Gestion des processus

- [`ps`](https://manpages.ubuntu.com/manpages/jammy/en/man1/ps.1.html) : liste les processus en cours
    - Informations de base dont
        - `PID`: numéro d'identification du processus
        - `TIME` : temps CPU utilisé depuis le début
    - `u` : informations complémentaires
    - `a` : ajout des processus des autres utilisateurs
    - `x` : chemin complet du programme lancé

```bash
$ ps
$ ps aux
```

- [`top`](https://manpages.ubuntu.com/manpages/jammy/en/man1/top.1.html) : affichage amélioré des processus
    - Choix possible du tri

```bash
$ top
```


---

## Redirection des sorties de commandes

- Comme on l'a déjà vu, opérateur `>` pour rediriger la sortie d'une commande dans un fichier

```bash
$ echo Encore un test > test4.txt
$ cat test4.txt
```

- `>>` : redirige la sortie d'une commande à la suite du fichier texte
    - Pas d'écrasement du contenu existant
    
```bash
$ echo Une deuxième ligne >> test4.txt
$ cat text4.txt
```

---

## Recherche dans un fichier

- [`grep`](https://manpages.ubuntu.com/manpages/jammy/en/man1/grep.1.html) : renvoie les lignes correspondant à une recherche textuelle

```bash
$ grep "un" test4.txt
```

- Utilisation des [expressions régulières](https://fr.wikipedia.org/wiki/Expression_r%C3%A9guli%C3%A8re)
    - `.` : un caractère quelqu'il soit
    - `exp+` : expression présente au moins une fois
    - `exp*` : expression présente zéro, une ou plusieurs fois
    - `[liste]` : un des caractères de la liste
    - `[^liste]` : un caractère qui n'est pas dans la liste
    -  `^` : caractère suivant `^` se trouvant en début de ligne
    -  `$` : caractère précédent `$` se trouvant en fin de ligne
    - ...

```bash
$ grep "un" test4.txt
$ grep "[eE]" test4.txt
```

---

## Processus multiples

- [`sleep`](https://manpages.ubuntu.com/manpages/jammy/en/man1/sleep.1.html) : pause du nombre de secondes passées en paramètres
    - `Ctrl+C` : tue le processus (valable pour tous les processus)

```bash
$ sleep 1
```

- Possibilité de lancer en une ligne plusieurs commandes, séparées par `;`
    - Exécution séquentielle (attente de la fin d'une pour faire l'autre)

```bash
$ date; sleep 1; who
```

- `&` : opérateur permettant de lancer un processus en arrière plan
    - Dans la liste des processus, vous devriez voir `sleep`

```bash
$ sleep 100&
$ ps
```


---

## Pipes

- `|` : opérateur *pipe* envoyant les résultats de la première commande (à gauche) dans la commande de droite

```bash
$ sleep 100&
$ ps | grep "sleep"
```

## Interruption d'un processus en cours

- [`kill`](https://manpages.ubuntu.com/manpages/jammy/en/man1/kill.1.html) : tue le processus dont le `PID` est passé en paramètre

```bash
$ sleep 100&
$ ps | grep "sleep"
$ kill <PID_sleep>
```

.footnote[.small[`pgrep` cherche un processus avec le nom passé en paramètre et ne renvoie que le `PID`.]]

---

## Usage de la mémoire

- [`free`](https://manpages.ubuntu.com/manpages/jammy/en/man1/free.1.html) : espace mémoire vive utilisé et disponible
    - On parle ici de la RAM
    - `-h` : option permettant un affichage plus concis des valeurs

```bash
$ free -h
```

- [`df`](https://manpages.ubuntu.com/manpages/jammy/en/man1/df.1.html) : espace mémoire morte utilisé et disponible
    - On parle ici des disques durs
    - idem pour `-h`

```bash
$ df -h
```

---

## Téléchargement d'un fichier via une URL

- [`wget`](https://manpages.ubuntu.com/manpages/jammy/en/man1/wget.1.html) : permet de télécharger un fichier dont l'URL est spécifiée

```bash
$ wget https://fxjollois.github.io/donnees/adult.data
```


---

## Compression : `.gz` ou `.zip`

Souvent nécessaire car fichiers trop volumineux

- `gz` : de base dans l'environnement Linux
- `zip` : archives (souvent) de l'environnement Windows

## Archivage : `.tar`

Opération permettant de regrouper ensemble des fichiers
## Les deux

Souvent les deux vont de paires, et produisent des fichiers avec l'extension `.tar.gz`

---

## Compression via `gzip`

- [`gzip`](https://manpages.ubuntu.com/manpages/jammy/en/man1/gzip.1.html) : compresse le fichier passé en paramètre (extension `.gz`)
    - Supprime par défaut le fichier compressé
    - `-k` : pour garder le fichier original

- [`gunzip`](https://manpages.ubuntu.com/manpages/jammy/en/man1/gunzip.1.html) : décompresse le fichier passé en paramètre
    - Supprime par défaut l'archive une fois celle-ci décompressé
    - `-k` : pour garder l'archive

```bash
$ gzip adult.data
$ gunzip adult.data
$ gzip -k adult.data
$ rm adult.data
$ gunzip -k adult.data
```

.footnote[.small[Exécutez `ls` entre chaque commande pour voir leur effet, voir avec `-h` pour voir l'effet de la compression.]]

---

## Compression via `zip`

- Installation du package 
    - Mot de passe requis (celui de la création de votre VM)

```bash
$ sudo apt install zip
```

- [`zip`](https://manpages.ubuntu.com/manpages/jammy/en/man1/zip.1.html) : compression du (ou des) fichier(s) dans l'archive (nom à fournir)

```bash
$ zip adult.zip adult.data
```

- [`unzip`](https://manpages.ubuntu.com/manpages/jammy/en/man1/unzip.1.html) : décompression du fichier

```bash
$ unzip adult.zip
```

.footnote[.small[Exécutez `ls` entre chaque commande pour voir leur effet, voir avec `-h` pour voir l'effet de la compression.]]

---

## Archivage dans un fichier via `tar`

- A faire pour tester

```bash
$ wget https://fxjollois.github.io/donnees/sakila/sakila_csv.zip
$ unzip sakila_csv.zip
```

- [`tar`](https://manpages.ubuntu.com/manpages/jammy/en/man1/tar.1.html) : archive les fichiers passés en paramètre dans un seul fichier
    - `c` : création d'une archive
    - `x` : extraction des fichiers de l'archive
    - `v` : détaille le fonctionnement
    - `f`: nomme le fichier à créer
    - `z` : effectue une compression en plus (ajout extension `.gz`)

```bash
$ tar -zcvf sakila.tar csv/
$ tar -zxvf sakila.tar
```

.footnote[.small[supprimer le répertoire `csv` entre les 2 commandes pour voir le fonctionnement.]]

---

## Recherche avancée dans un fichier texte

- [`sed`](https://manpages.ubuntu.com/manpages/jammy/en/man1/sed.1.html) : extraction de lignes d'un fichier texte
    - Format de type `sed option commande`
        - Options principales
            - `-n` : n'affiche pas toutes les lignes
            - `-e` : indique la commande à exécuter (on peut en enchaîner plusieurs)
        - Commandes principales
            - `p` : affichage des lignes sélectionnées
            - `$a` : ajoute une ligne à la fin
            - `s` : remplace une chaîne par une autre
        - Utilisation des expressions régulières

```bash
$ wget https://fxjollois.github.io/donnees/heart.txt
$ sed -n '5,10p' heart.txt # Affiche les lignes 5 à 10
$ sed -n -e '/femi/p' heart.txt # Affiche les lignes contenant la chaîne "femi"
$ sed -n -e '/femi.*absence/p' heart.txt # Affiche les lignes contenant "femi" puis plus loin "absence"
$ sed 's/feminin/Femme/g' heart.txt # Remplace "feminin" par "Femme"
$ sed 's/feminin/Femme/g' heart.txt | sed 's/masculin/Homme/g' # A deviner
```

