---
layout: slides
---

class: middle, center, inverse, title
# Système pour la Data Science

## Master AMSD/MLSD

### Scripts `shell`

<!-- librement inspiré de cette page : https://linux.goffinet.org/administration/scripts-shell/ -->

---

## Scripts

> Pourquoi faire des scripts ?

- Possibilité de faire des opérations simples rapidement (voire moins simples parfois)
- Utile pour du traitement de fichiers de données
- Intéressant dans un cadre de pré-traitement de données ou d'intégration de données

### Liens intéressants :

- [Introduction aux scripts shell](https://doc.ubuntu-fr.org/tutoriel/script_shell) : doc Ubuntu
- [Guide avancé d'écriture des scripts](https://abs.traduc.org/abs-fr/index.html) : date un peu mais toujours d'actualité
- [Présentation de ksh](https://marcg.developpez.com/ksh/) : compatible avec bash

---

## shebang : `#!/bin/bash`

- Suite de caractères (`#!`) déterminant que c'est un fichier de script et avec quel interpréteur le lancer (`bash` ici)

- [`echo`](https://manpages.ubuntu.com/manpages/jammy/fr/man1/echo.1.html) : affichage d'un texte dans la console 

- Déclaration d'une variable sans mot-clé (sans espace autour de `=` et appel à sa valeur utilisant l'opérateur `$`)

- [`exit`](https://manpages.ubuntu.com/manpages/jammy/en/man1/exit.1posix.html) : sortie du script

```bash
#!/bin/bash
VAR="vous"
echo Bonjour $VAR
echo "Bonjour $VAR"
exit
```


---

## Droit sur un fichier

Avec `ls -l script.sh`, on a pour `script.sh` les informations suivantes

```bash
-rw-r--r--  1 fxjollois  staff  61 14 oct 19:08 script.sh
```

- Premier caractère : `-` fichier ou `d` répertoire
- 3 triplets de trois caractères donc :
    - Chaque triplet correspond dans l'ordre à 
        1. Propriétaire
        2. Groupe
        3. Public
    - Chaque caractère d'un triplet correspond à
        - `r` : droit en lecture (`-`sinon - assez rare)
        - `w` : droit en écriture (`-` sinon)
        - `x` : droit d'exécution (`-`sinon)

Traduction : `-rw-r--r--` = fichier non exécutable que tout le monde peut lire, mais que seul le propriétaire peut modifier. 

---

## Modification des droits

- [`chmod`](https://manpages.ubuntu.com/manpages/jammy/en/man1/chmod.1.html) : permet de modifier les droits

De manière spécifique : 

- dans l'ordre
    1. à qui on ajoute (`u` pour utilisateur, `g` groupe, `a` tout le monde)
    2. si on ajoute `+?` ou on enlève `-`
    3. le droit 
- si personne pour `r` ou `x` : pour tout le monde

```bash
$ chmod u+x fichier
$ chmod g-w fichier
```

---

## Modification des droits

- [`chmod`](https://manpages.ubuntu.com/manpages/jammy/en/man1/chmod.1.html) : permet de modifier les droits

De manière globale : 

- Un droit = une valeur (en puissance de 2)
    - `r` = 4, `w` = 2, `x` = 1
- Une configuration = la somme des valeurs
    - `r--` = 4, `r-x` = 5, `rwx` = 7, ...
- Un triplet de valeur (entre 0 et 7) = une liste de droit
    - `600` = lecture/écriture pour le propriétaire, rien pour les autres
    - `755` = lecture/exécution pour tous, avec écriture pour propriétaire
    - ...

```bash
$ chmod 600 fichier
$ chmod 755 fichier
```

---

## Exécution

- Pour exécuter un script, il faut qu'il soit donc **exécutable**

- Première chose à faire, une fois le script créé : ajoutez le droit d'exécution

```bash
$ touch script.sh # fichier vide
$ chmod +x script.sh # par exemple
```

- Faites `nano script.sh` pour écrire dedans les instructions de la slide 3

- Une fois qu'il est exécutable et que le contenu l'est aussi, on exécute ainsi

```bash
$ ./script.sh
```

---

## Interaction avec l'utilisateur

- [`read`](https://manpages.ubuntu.com/manpages/jammy/en/man1/read.1plan9.html) : lit les valeurs entrées au clavier et les stocke dans une variable

```bash
#!/bin/bash
echo "Votre nom :"
read var
echo Bonjour $var
```

- Paramètre `-p` permettant d'afficher le texte

```bash
#!/bin/bash
read -p "Votre nom :" var
echo Bonjour $var
```

---

## Un peu plus loin sur les variables

- Caractères spéciaux : `$`, `*`, `?`, `#`, `|`, `[]` et `{}`
    - `\` : Annulation de leur effet
    - Double quotes `""` : Annulation de l'effet de la plupart des caractères (sauf `$`, `\` et `|`)
    - Simple quotes `''` : Annulation de l'effet de toutes, sauf `\`

```bash
#!/bin/bash
# Ceci est un commentaire
VAR="vous"
echo Bonjour $VAR   # -> Bonjour vous
echo Bonjour \$VAR  # -> Bonjour $VAR
```

- Limitation de la variable avec `{}`

```bash
#!/bin/bash
USER="fxj"
echo "Dossier personnel : /home/${USER}/Documents/"
```

---

## Affectation de valeurs à une variable

- Toute variable est une chaîne de caractères

```bash
a=12
b=$a+2
echo a=$a, b=$b # Affiche a=12, b=12+2
```

- Evaluation d'une expression **entière** avec `((...))` 
    - `++` et `--` possible (incrémentation positive ou négative)

```bash
a=12
(( b=$a+2 ))
echo a=$a, b=$b # Affiche a=12, b=14
```

- `let` permet d'affecter aussi des valeurs (en évaluant si calcul)

```bash
let a=12
let b=$a+2
echo a=$a, b=$b # Affiche a=12, b=14
```

---

## Variables du script

- `$0` : Nom du script
- `$1`, `$2`, ... : premier, deuxième, ... paramètre de la ligne de commande 
- `$*` : Tous les paramètres dans une seule chaîne
- `$@` : Tous les paramètres dans une liste
- `$#` : Nombre de paramètres sur la ligne de commande
- `$-` : Options du shell
- `$?` : Code de retour de la dernière commande
- `$$` : PID du shell
- `$!` : PID du dernier processus lancé en arrière-plan
- `$_` : Dernier argument de la commande précédente

---

## Variables d'environnement

- [Variables](https://doc.ubuntu-fr.org/variables_d_environnement) connues dans `bash` (créées au lancement de la machine ou au lancement d'une application)
    - `$PATH` : liste des chemins où chercher les exécutables
    - `$USER` : nom de l'utilisateur
    - `$HOME` : répertoire de base de l'utilisateur
    - `$LANG` : langue du terminal
    - ...

- [`printenv`](https://manpages.ubuntu.com/manpages/jammy/en/man1/printenv.1.html) : Liste de toutes les variables 

```bash
$ printenv
```

---

## Structures conditionnelles - `if`

- Utilisation des opérateurs `if`, `then`, `else` et `fi` pour terminer
    - Existence de l'opérateur `elif` pour enchaîner plusieurs conditions et expressions à réaliser
    - Conditions à mettre entre `[]`, voire `[[]]`

```bash
if [ condition ]; then
    # lignes de commandes
elif [ condition ]; then
    # lignes de commandes
else
    # lignes de commandes
fi
```

- Plusieurs opérateurs de [`test`](https://manpages.ubuntu.com/manpages/jammy/fr/man1/test.1.html) existant
    - Comparaisons de valeurs : `=`, `!=`, `-eq`, `-ne`, `-ge`, `-gt`, `-le`, `-lt`
    - Opérateurs logique : `-a` (et), `-o` (ou), `!` (non)
    - Existence : `-e` fichier existe, `-d` répertoire existe...
    - Taille : `-n` (ou `-z`) chaîne de taille nulle
    - ...

---

## Structures conditionnelles - `case`

- Utilisation des opérateurs `case`, `in` et `esac` pour finir
    - Finir les commandes avec `;;`
    - Choix possible suivi de `)` puis des lignes à exécuter
        - opérateur `|` pour combiner plusieurs choix possibles sur une ligne
    - Choix par défaut `*)`

```bash
case $var in
    valeur1)
        # lignes de commandes
    valeur2)
        # lignes de commandes
    valeur3)
        # lignes de commandes
    ...
    *)
        # lignes de commandes si rien ne correspond
esac
```

---

## Structures itératives - `for`

- Utilisation des opérateurs `for`, `in`, `do` et `done`

- Possibilité de définir une liste de `a` à `b` avec `{a..b}`
    - ex : `{0..5}` pour aller de 0 à 5

```bash
for variable in liste ; do
    # lignes de commandes
done
```

- Possibilité d'utiliser l'écriture de `ls` pour naviguer dans les fichiers et répertoires
    - Recherche dans le répertoire de lancement du script par défaut

```bash
for f in pattern ; do
    # lignes de commande
    # $f représente chaque fichier
done
```

---

## Structures itératives - `while` et `until`

- Utilisation des opérateurs `while`/`until`, `do` et `done`
    - `while` : continue si la condition est vraie
    - `until` : continue si la condition est fausse

- Opérateurs `break` pour stopper la boucle et `continue` pour la reprendre


```bash
while [ conditon ] ; do
    # lignes de commande
    # modification à faire pour que la condition évolue, sinon boucle infinie
done
```

```bash
until [ conditon ] ; do
    # lignes de commande
    # modification à faire pour que la condition évolue, sinon boucle infinie
done
```

---

## Fonctions

- Bloc d'instructions déclaré avec `function` (ou non)
    - à écrire avant leur appel
    - définissable partout (même dans un sous-bloc de type `for` ou `if`)

```bash
function f(){
    # lignes de commande
}
f() {
    # lignes de commande
}
```

- Déclarable sur une seule ligne, avec `;` après chaque instruction

---

## Paramètres de fonction

- Pas de définition des paramètres dans les `()`
    - Et appel sans `()`

- Utilisation, comme pour le script, des variables `$1`, `$2`, ...
    - `$n` dans une fonction référence le n<sup>ième</sup> paramètre de cette fonction, pas du script
    - sauf `$0` : dans une fonction, reste le nom du script lancé

```bash
f() {
    echo $1
}
f 12            # Affichera 12 donc
```

---

## Manipulation de chaînes (dans une variable)

- Longueur de la chaîne : `${#var}`

```bash
a=Bonjour
echo ${#a}      # Affiche 7
```

- Extraction de caractères d'une chaîne : `${var:deb:lon}`
    - Premier caractère à la position 0
    - `${var:deb}` pour avoir de `deb` jusqu'à la fin
    - `${var::lon}` pour avoir du début sur `lon` caractères

```bash
a=Bonjour
echo ${a:1:3}   # Affiche onj
echo ${a:4}     # Affiche our
echo ${a::4}    # Affiche Bonj
```

---

## Manipulation de chaînes (dans une variable)

- Extraction à partir d'un pattern : `${var#pattern}`
    - Premier élément correspondant pris en compte
        - `##` : pour chercher le dernier élément correspondant
    - `*` : de 0 à n caractères (comme dans `ls`)
    - `?` : un seul caractère (idem)
    - `[]` : plage
    - `{e1,e2,...}` : liste d'éléments

```bash
a=Bonjour
echo ${a#Bon}       # Affiche jour
echo ${a#*n}        # Affiche jour (à partir du premier n)
echo ${a#?o}        # Affiche njour (car seconde lettre = o)
echo ${a#*o}        # Affiche njour (à partir du premier o)
echo ${a##*o}       # Affiche ur (à partir du second o)
```

---

## Manipulation de chaînes (dans une variable)

- Remplacement d'une sous-chaîne par une autre dans une chaîne : `${var/pattern/remp}`
    - `//` à la place du premier `/` pour remplacer toutes les occurences (uniquement la première sinon)
    - `pattern` peut donc avoir les caractères spéciaux `*`, `?`, ...
    - Si pas de remplacement, suppression de la sous-chaîne
    - `#` à mettre en début de pattern pour regarder le début de la chaîne uniquement
    - `%` à mettre en début de pattern pour regarder la fin de la chaîne uniquement

```bash
a=Bonjour
echo ${a/jour/soir}     # Affiche Bonsoir
echo ${a/o/O}           # Affiche BOnjour
echo ${a//o/O}          # Affiche BOnjOur
echo ${a/o}             # Affiche Bnjour
echo ${a//o}            # Affiche Bnjur
```

---

## Boucles sur une chaîne de caractères

- Si espace présent dans la chaîne, boucle sur chaque mot

```bash
a="Bonjour Bonsoir"
for m in $a ; do
    echo m=$m           # Affiche Bonjour puis Bonsoir
done
```

- Si autre séparateur (par exemple `,`), on peut remplacer par un espace

```bash
a=Bonjour,Bonsoir
for m in ${a//,/ } ; do
    echo m=$m           # Affiche Bonjour puis Bonsoir
done
```


---

## Commande `shift`

- Décale les paramètres vers la gauche, en supprimant le premier

```bash
while [ -n "$1" ] ; do
    echo Paramètre : $1
    shift
done
```

- Test possible sur le nombre de paramètres (restant donc) avec `$#`

```bash
while [ $# -ne 0 ] ; do
    echo Paramètre : $1
    shift
done
```

---

## Tableaux

- Déclaration d'un tableau avec `()` (éléments séparés par un espace)

- Indexation avec `[]`
    - `@` : tous les éléments
    - Affectation possible avec indexation (sans consécutivité obligatoire)

```bash
a=( un deux trois 4 )
echo ${a}           # Affiche un
echo ${a[@]}        # Affiche un deux trois 4
echo ${#a[@]}       # Affiche 4 (taille du tableau)
echo ${a[2]}        # Affiche trois (3ème élément)
a[10]=dix
echo ${a[@]}        # Affiche un deux trois 4 dix
echo ${a[10]}       # Affiche dix
echo ${a[5]}        # Affiche ligne vide
```
---

## Codes d'erreur en sortie

- Ajout d'un code de sortie à la fonction `exit`
    - Uniquement entre 0 et 255
    - Codes à définir et indiquer dans la partie commentaires du script

- Très utile lorsqu'on fait un code compliqué

- Par convention : `0` indique une sortie sans erreur

- Codes réservés : `1`, `2`, `126`, `127`, `128`, `130`, `255`


```bash
# lignes de commande
if [ condition_erreur ] ; do
    exit 1  # Dire à quoi cela correspond (mettre un message d'erreur est un plus mais pas toujours bon à faire)
fi
# ...
exit 0
```

---

## Structuration classique d'un script

1. `shebang`
1. Commentaires introductifs au programme
    - Détail du fonctionnement
    - Présentation des paramètres du script
1. Gestion de l'appel
    - Test que tout est ok (sortie avec erreur sinon)
    - Paramètres présents ? bien écrits ? ...
1. Fonction(s) utile(s)
    - Définition des fonctions servant dans le script
1. Corps principal
    - Coeur du script
1. Fin
    - Ecriture de fichiers et/ou affichage dans la console
    - Sortie du programme avec `exit`



