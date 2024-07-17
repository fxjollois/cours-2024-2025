---
layout: slides
---

class: middle, center, inverse, title
# Système pour la Data Science

## Master AMSD/MLSD

### Correction et commentaires sur les scripts `shell`

<!-- librement inspiré de cette page : https://linux.goffinet.org/administration/scripts-shell/ -->

---
class: middle, center, section 

# Scripts simples

---
## Somme d'entiers

### Demande

- Ecrire un script prenant des entiers en paramètres et affichant la somme de ceux-ci
    - Gérer le cas aucun paramètre fourni
    - Gérer le cas paramètre non entier

---
## Somme d'entiers

### Première version

#### Script (nommé `s1-entiers.sh` ici)

```bash
#!/bin/bash
let res=0
for v in $@ ; do
    let res=$res+$v
done
echo "Somme = $res"
exit
```

#### Appel

```bash
$ ./s1-entiers.sh 12 1 5
Somme = 18
```

---
## Somme d'entiers

### Gestion du cas : aucun paramètre fourni

```bash
#!/bin/bash
if [ $# = 0 ]; then
	echo "Merci de fournir des entiers en paramètres !"
	exit
fi
let res=0
for v in $@ ; do
	let res=$res+$v
done
echo "Somme = $res"
exit
```

#### Appel

```bash
$ ./s1-entier.sh           
Merci de fournir des entiers en paramètres !
```

---
## Somme d'entiers

### Gestion du cas : chaîne de caractères autre qu'un entier

```bash
#!/bin/bash
if [ $# = 0 ]; then
	echo "Merci de fournir des entiers en paramètres !"
	exit
fi
let res=0
for v in $@ ; do
	if ! [[ "$v" =~ ^-?[0-9]+$ ]] ; then
		echo "Que des entiers ! $v n'en est pas un..."
		exit
	fi
	let res=$res+$v
done
echo "Somme = $res"
exit
```

---
## Somme d'entiers

### Gestion du cas : chaîne de caractères autre qu'un entier

#### Appel

```bash
$ ./s1-entier.sh 0 12 14 
```
```
Somme = 26
```

```bash
$ ./s1-entier.sh 0 12 14 a
```
```
Que des entiers ! a n'en est pas un...
```

```bash
$ ./s1-entier.sh 0 12 14a 
```
```
Que des entiers ! 14a n'en est pas un...
```

---
## "Avez-vous compris ?"

### Demande

- Ecrire un script qui demande "Avez-vous compris le cours (Oui/Non/Exit) ?"
    - Qui répond 
        - "Bravo" si l'utlisateur répond "Oui"
        - "N'hésitez pas à poser des questions à l'enseignant" si l'utilisateur répond "Non"
        - "Au revoir" si l'utilisateur répond "Exit"
        - "Merci de lire les consignes..." sinon
    - Gérer les variations à la réponse
        - "Oui" peut être écrit aussi "oui", "OUI", "o", "O"
        - "Non" peut être écrit aussi "non", "NON", "n", "N"
        - "Exit" peut êter écrit aussi "exit", "EXIT", "e", "E"

---
## "Avez-vous compris ?"

### Première version

```bash
#!/bin/bash
read -p "Avez-vous compris (Oui/Non/Exit) ? " rep
case $rep in
	"Oui") echo "Bravo";;
	"Non") echo "N'hésitez pas à poser des questions à l'enseignant !";;
	"Exit") echo "Au revoir";;
	*) echo "Merci de lire les consignes"
esac
exit
```

---
## "Avez-vous compris ?"

### Gestion des variations

Avec boucle tant que la réponse n'est pas valide

```bash
#!/bin/bash
let stop=0
until [ $stop == 1 ] ; do
	read -p "Avez-vous compris (Oui/Non/Exit) ? " rep
	case $rep in
		"Oui" | "OUI" | "oui" | "o" | "O") 
			echo "Bravo";;
		"Non" | "NON" | "non" | "n" | "N") 
			echo "N'hésitez pas à poser des questions à l'enseignant !";;
		"Exit" | "EXIT" | "exit" | "e" | "E") 
			echo "Au revoir"; let stop=1;;
		*) 
			echo "Merci de lire les consignes"
	esac
done
exit
```

---
## "Avez-vous compris ?"

### Gestion des variations

Version améliorée car `case` ne prend pas en compte les expressions régulières

```bash
#!/bin/bash
let stop=0
until [ $stop == 1 ] ; do
	read -p "Avez-vous compris (Oui/Non/Exit) ? " rep
	if [[ $rep =~ ^[oO][uU]?[iI]?$ ]] ; then
		echo "Bravo"
	elif [[ $rep =~ ^[nN][oO]?[nN]?$ ]] ; then
		echo "N'hésitez pas à poser des questions à l'enseignant !"
	elif [[ $rep =~ ^[eE][xX]?[iI]?[tT]?$ ]] ; then
		echo "Au revoir"; let stop=1
	else
		echo "Merci de lire les consignes"
	fi
done
exit
```


---
class: middle, center, section 

# Script de recherche d'informations

On va travailler sur les fichiers présents dans le répertoire `UbiqLog4UCI`.

---
## Vérification d'un identifiant

### Demande

- Faire un script qui demande à l'utilisateur un numéro d'individu (de 1 à ?) et qui vérifie que celui-ci existe bien dans la liste des répertoires
    - De plus, le script nous indiquera si cet individu est un homme (`M` dans le nom) ou une femme (`F`)

---
## Vérification d'un identifiant

```bash
#!/bin/bash
read -p "Numéro d'identifiant : " id
r=$(ls -d 'UbiqLog4UCI/'$id'_'* 2>/dev/null)
s=${r#*_}
if [ $r ] ; then
	echo -e "\nIdentifiant existant"
else
	echo -e "\nIdentifiant non présent\n"
	exit
fi
case $s in
	"M") echo -e "\tSexe : Homme";;
	"F") echo -e "\tSexe : Femme";;
	*) echo "Erreur"
esac
echo -e "\tRépertoire :" $r "\n"
exit
```

---
## Ajout de la date

### Demande

- Compléter ce script pour demander une date à l'utilisateur
    - Le script indiquera s'il y a bien un fichier de log pour ce jour la et cette personne

> Ici, on on considère que la date est rentrée correctement (*i.e* comme dans les fichiers)

---
## Ajout de la date

```bash
#!/bin/bash
read -p "Numéro d'identifiant : " id
r=$(ls -d 'UbiqLog4UCI/'$id'_'* 2>/dev/null)
s=${r#*_}
if [ $r ] ; then
	echo -e "\nIdentifiant existant"
else
	echo -e "\nIdentifiant non présent\n"
	exit
fi
case $s in
	"M") echo -e "\tSexe : Homme";;
	"F") echo -e "\tSexe : Femme";;
	*) echo "Erreur"
esac
echo -e "\tRépertoire :" $r "\n"
read -p "Date (jj-mm-aaaa) : " d
if [ -f 'UbiqLog4UCI/'$id'_'$s'/log_'$d'.txt' ] ; then
	echo -e "\nLog existant pour cette date"
	echo -e "\tFichier :" 'UbiqLog4UCI/'$id'_'$s'/log_'$d'.txt'"\n"
fi
exit
```

---
## Utilisation de paramètres sur le script

### Demande

- Compléter encore le script pour pouvoir passer en paramètre les deux informations, avec le formalisme suivant :
    - `-i 12` : pour tester si l'individu 12 existe
    - `-d 2014-01-11` : pour tester si la date existe pour cet individu
        - si l'option `-i` n'est pas utilisée, alors message d'erreur

> **Attention** : la date dans les fichiers est du format `mm-dd-yyyy`

---
## Utilisation de paramètres sur le script

```bash
#!/bin/bash
id=$2
r=$(ls -d 'UbiqLog4UCI/'$id'_'* 2>/dev/null)
s=${r#*_}
if [ $r ] ; then
	echo -e "\nIdentifiant existant"
else
	echo -e "\nIdentifiant non présent\n"
	exit
fi
case $s in
	"M") echo -e "\tSexe : Homme";;
	"F") echo -e "\tSexe : Femme";;
	*) echo "Erreur"
esac
echo -e "\tRépertoire :" $r "\n"
d=$4
dd=(${d//-/ })
ddd=${dd[1]}-${dd[2]}-${dd[0]}
if [ -f 'UbiqLog4UCI/'$id'_'$s'/log_'$ddd'.txt' ] ; then
	echo -e "Log existant pour cette date"
	echo -e "\tFichier :" 'UbiqLog4UCI/'$id'_'$s'/log_'$ddd'.txt'"\n"
fi
exit
```

---
## Gestion des appels et erreurs

### Demande

- Gérer les appels 
    - si pas de paramètre : demande de l'utilisateur puis de la date
    - si juste utilisateur (`-i`) : affichage pour dire si c'est un homme ou une femme, puis demande de la date
    - si utilisateur (`-i`) et date (`-d`) : affichage pour dire si c'est un homme ou une femme, et dire si la date existe

---
## Gestion des appels et erreurs

```bash
#!/bin/bash

# Gestion du paramètre identifiant
if [ $# = 0 ] ; then 
    read -p "Numéro d'identifiant : " id
elif [ $1 != "-i" ] ; then 
    echo "Paramètre -i en premier"
    exit
elif ! [ $2 ] ; then 
    echo "Identifiant à passer en paramètre"
    exit
else 
    id=$2
fi
r=$(ls -d 'UbiqLog4UCI/'$id'_'* 2>/dev/null)
s=${r#*_}
if [ $r ] ; then
	echo -e "\nIdentifiant existant"
else
	echo -e "\nIdentifiant non présent\n"
	exit
fi
case $s in
	"M") echo -e "\tSexe : Homme";;
	"F") echo -e "\tSexe : Femme";;
	*) echo "Erreur"
esac
echo -e "\tRépertoire :" $r "\n"
```

---
## Gestion des appels et erreurs

(suite)

```bash
# Gestion du paramètre date
if ! [ $3 ] ; then
    read -p "Date (aaaa-mm-jj) : " d
elif [ $3 != -d ] ; then
    echo "Paramètre -d en deuxième"
    exit
elif ! [ $4 ] ; then
    echo "Date à passer en paramètre"
    exit
else
    d=$4
fi
dd=(${d//-/ })
ddd=${dd[1]}-${dd[2]}-${dd[0]}
if [ -f 'UbiqLog4UCI/'$id'_'$s'/log_'$ddd'.txt' ] ; then
	echo -e "Log existant pour cette date"
	echo -e "\tFichier :" 'UbiqLog4UCI/'$id'_'$s'/log_'$ddd'.txt'"\n"
fi
exit
```


---
class: middle, center, section 

# Script d'extraction 


---
## Format voulu `JSON`

Toujours dans le répertoire `UbiqLog4UCI`, on veut faire un script qui va concaténer tous les logs dans un seul fichier JSON, avec le format suivant :

```json
[
    {
        id: 1, // première partie du nom du répertoire
        sexe: "M", // deuxième partie du nom du répertoire
        date: "2014-01-11", // date ré-écrite au format YYYY-MM-DD
        log: [contenu_du_fichier], // contenu du fichier transformé en tableau JSON
    },
    ...
 ]
```

---
## Format d'orgine

Les fichiers log sont formatés avec un litéral JSON par ligne, cf ci-dessous :

```json
{"Wifi": {...}}
{"Wifi": {...}}
...
```

Pour le transformer un tableau JSON, il faut donc encadrer ces lignes par des `[]` et mettre des virgules entre chaque ligne, comme ci-dessous :

```json
[
    {"Wifi": {...}},
    {"Wifi": {...}},
    ...
]
```

---
## Concaténation de toutes les données

### Demande

- Créer un script permettant de concaténer toutes les informations dans un seul fichier avec le formalisme vu ci-dessus
    - nom du fichier par défaut `sortie.json`

> **ATTENTION** : toutes les données `log` ensemble produisent un fichier de presque **_2 Go_**

---

```bash
#!/bin/bash
fichier=sortie.json
echo "[" > $fichier
for d in UbiqLog4UCI/* ; do
	#echo -n $d
	is=${d/UbiqLog4UCI\//}
    is=(${is/_/ })
    i=${is[0]}
    s=${is[1]}
	for f in $d/* ; do
		if [[ $f =~ .*log.*txt ]] ; then
			#echo -n "."
			date=${f##*log_}
            date=${date/.txt/}
            date=(${date//-/ })
            date=${date[2]}-${date[0]}-${date[1]}
			echo "{" >> $fichier
			echo "\"origine_rep\": \"$d\"," >> $fichier
			echo "\"origine_fic\": \"$f\"," >> $fichier
			echo "\"id\": $i," >> $fichier
			echo "\"sexe\": \"$s\"," >> $fichier
			echo "\"date\": \"$date\"," >> $fichier
			echo "\"log\": [" >> $fichier
			cat "$f" | sed "$ ! s/.*/&,/" >> $fichier		
			echo "] }," >> $fichier
		fi
	done
	#echo
done
echo "]" >> $fichier
echo
echo "Fichier $fichier créé"
exit
```

---
## Changement du fichier de sortie

### Demande

- Modifier le script pour pouvoir indiquer le nom du fichier à écrire
    - paramètre `-o` suivi par le nom de fichier à écrire

--

```bash
#!/bin/bash
if [ $1 ] && [ $1 == "-o" ] ; then
	fichier=$2
else
	fichier=sortie.json
fi

# reste identique
```

---
## Ajout de critères de restriction

### Demande

- Etendre ce script à la possibilité de demander de n'extraire que les lignes correspondant à une certainte recherche (similaire à celle faite avec `grep`)
    - l'utilisateur indiquera comme paramètre `-s` suivi du critère de recherche (syntaxe `grep`)

---

```bash
#!/bin/bash
# gestion du nom de fichier
echo "[" > $fichier
for d in UbiqLog4UCI/* ; do
	# recupération de l'identifiant et du sexe
	for f in $d/* ; do
		if [[ $f =~ .*log.*txt ]] ; then
			# affichage des informations
            
            # Gestion de la syntaxe grep
			if [ $3 ] && [ $3 == "-s" ] ; then
				grep $4 "$f" | sed "$ ! s/.*/&,/" >> $fichier
			else
				cat "$f" | sed "$ ! s/.*/&,/" >> $fichier
			fi
            
			echo "] }," >> $fichier
		fi
	done
	#echo
done
echo "]" >> $fichier
echo
echo "Fichier $fichier créé"
exit
```

---
## Quoi en conclure ?

### C'est bien

- Scripts `shell` utiles pour gérer fichier texte (type concaténation)

--

- Ecriture de code simple assez rapide

--

### MAIS

--

- Un langage de plus à apprendre

--

- Développement du code et débogage peu aisé
    - Pas d'outil type RStudio ou Jupyter Notebook malheureusement

--

- Gestion des exceptions peu faciles à mettre en oeuvre
