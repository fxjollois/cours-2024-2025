---
layout: slides
---

class: middle, center, inverse, title
# Système pour la Data Science

## Master AMSD/MLSD

### Gestion des scripts R et Python en `shell`

---
## Lancement de scripts

> Tout programme R ou Python est un script exécutable directement via le `shell`

--

### Pourquoi c'est intéressant ?

--

- Lancement de programmes sans la nécessité de lancer R ou Python et de sourcer le code

--

- Automatisation possible
    - Lancement programmé
    - Triggering pour déclencher un script après certaines opérations

---
class: section, middle, center

# Avec R

---
## Lancement


### 2 possibilités offertes par R

- **`Rscript`** : `$ Rscript chemin/vers/script.R`

- **`R CMD BATCH`** : `$ R CMD BATCH chemin/vers/script.R`

--

### A noter

- Chemin relatif ou absolu

- Passage de paramètres possibles

- Quelques différences de comportement entre les deux (vue dans la suit)

---
## Script (très) simple 

### Affichage de la date de jour

```r
cat("Date du jour : ", as.character(Sys.Date()), "\n")
```
--
### Résultat de `Rscript`

```bash
$ Rscript test01-simple.R 
Date du jour :  2022-11-06 
```

--
### Résultat de `R CMD BATCH`

```bash
$ R CMD BATCH test01-simple.R 
$
```

Ne fait rien, mais créé un fichier `test01-simple.Rout` (nom par défaut)

---

Fichier `test01-simple.Rout`

```r

R version 4.2.2 (2022-10-31) -- "Innocent and Trusting"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin17.0 (64-bit)

R est un logiciel libre livré sans AUCUNE GARANTIE.
Vous pouvez le redistribuer sous certaines conditions.
Tapez 'license()' ou 'licence()' pour plus de détails.

R est un projet collaboratif avec de nombreux contributeurs.
Tapez 'contributors()' pour plus d'information et
'citation()' pour la façon de le citer dans les publications.

Tapez 'demo()' pour des démonstrations, 'help()' pour l'aide
en ligne ou 'help.start()' pour obtenir l'aide au format HTML.
Tapez 'q()' pour quitter R.

[Sauvegarde de la session précédente restaurée]

> cat("Date du jour : ", as.character(Sys.Date()), "\n")
Date du jour :  2022-11-06 
> 
> 
> proc.time()
utilisateur     système      écoulé 
      0.129       0.041       0.169 
```

---
## Stockage du résultat dans un fichier

Si on veut stocker le résultat dans un fichier avec `Rscript`

```bash
$ Rscript test01-simple.R > test01-simple.txt
```

Fichier résultat `test01-simple.txt` :

```plaintext
Date du jour :  2022-11-06 
```


---
## Gestion des arguments

### Utilisation de la fonction `commandArgs()`

```r
args = commandArgs(trailingOnly = FALSE)
cat("Tous les arguments\n")
print(args)
cat("\n\n")
args = commandArgs(trailingOnly = TRUE)
cat("Uniquement les arguments après le nom du script\n")
print(args)
```

--
`commandArgs()` renvoie les arguments passés en paramètre 

--

- Absolument tous avec `trailingOnly = FALSE` (cf résultat ci-après)
- Uniquement ceux avec le nom du script avec `trailingOnly = TRUE`
    - `R CMD BATCH` **nécessite** de placer `--args` au début (cf ci-après)

---
## Gestion des arguments - avec `Rscript`

```bash
$ Rscript test02-arguments.R truc bidule chose --args 12
Tous les arguments
 [1] "/Library/Frameworks/R.framework/Resources/bin/exec/R"
 [2] "--no-echo"                                           
 [3] "--no-restore"                                        
 [4] "--file=test02-arguments.R"                           
 [5] "--args"                                              
 [6] "truc"                                                
 [7] "bidule"                                              
 [8] "chose"                                               
 [9] "--args"                                              
[10] "12"                                                  


Uniquement les arguments après le nom du script
[1] "truc"   "bidule" "chose"  "--args" "12"  
```

---
## Gestion des arguments - avec `R CMD BATCH`

Résultat identique (cf fichier produit), mais **attention à l'appel**

```bash
$ R CMD BATCH "--args truc bidule chose --args 12" test02-arguments.R
```

--

### A noter

L'argument après le nom du script R est le nom du fichier de sortie

```bash
$ R CMD BATCH "--args truc bidule chose --args 12" test02-arguments.R test02-sortie.txt
```

> Produit le fichier `test02-sortie.txt` par exemple


---
## Restauration de la dernière sauvegarde (ou non)

- Sauvegarde de l'environnement dans le fichier `.RData` lorsqu'on quitte R

--

- Comportement différent des deux commandes pour la prise en compte ou non de ce fichier

--

- Par défaut :
    - `Rscript` ne restaure pas l'environnement
        - *i.e* aucune variable n'existe en début de script
    - `R CMD BATCH` restaure l'environnement    
        - *i.e.* si fichier `.RData` existe, alors son contenu est chargé 
        - donc potentielle existence de variables en début de script

--

- Options `--restore` et `--no-restore` permettant de gérant ce comportement

---
## Quelques autres options de `R CMD BATCH`

A placer entre `R CMD BATCH` et le nom du script à lancer

```bash
$ R CMD BATCH options chemin/vers/script.R fichier_sortie
```

--

- `--no-echo` : commandes exécutées non affichées dans le fichier de sortie (ainsi que le texte initial)

- `--no-timing` : durée d'exécution non affichée à la fin du fichier de sortie

- `--no-save` : ne sauvegarde pas l'environnement dans le fichier `.RData` à la fin de l'exécution

- `--quiet` (ou `--silent`) : n'affiche pas le copyright de R en début de fichier

---
## En créant un fichier exécutable (type script `shell`)

- Contenu du fichier `test04-shell.R`
    - `/usr/bin/env` : chemin vers `Rscript`

```r
#! /usr/bin/env Rscript
cat("Test avec lancement dans le shell directement\n")
```

--

- Obligation de rendre le fichier exécutable
- Lancement identique à un script `shell` dans le terminal de commande

```bash
$ chmod +x test04-shell.R
$ ./test04-shell.R
Test avec lancement dans le shell directement
```

--

- Pas d'option possible à passer dans `Rscript`
- Mais arguments pouvant être passés

---
class: section, middle, center

# Avec Python

---
## Lancement

--

### Une possibilité classique

- `python3` (ou `python` si vous voulez utiliser la version 2, si elle est installée)
    - Chemin absolu ou relatif

```bash
$ python3 chemin/vers/script.py
```

--

### Avec fichier exécutable comme vu avec `R`

```python
#! /usr/bin/env python3
print("Test avec lancement dans le shell directement")
```

```bash
$ chmod +x test04-shell.py
$ ./test04-shell.py
Test avec lancement dans le shell directement
```

---
## Script (très) simple 

### Affichage de la date de jour

```python
from datetime import date

print("Date du jour : ", date.today())
```

### Résultat de `python3`

```bash
$ python3 test01-simple.py
Date du jour :  2022-11-06
```

---
## Stockage du résultat dans un fichier

De même que pour `Rscript`, si on veut stocker le résultat dans un fichier

```bash
$ python3 test01-simple.py > test01-simple.txt
```

Fichier résultat `test01-simple.txt` :

```plaintext
Date du jour :  2022-11-06
```

---
## Gestion des arguments

### Utilisation du module `sys`

```python
import sys

print("Nombre d'arguments : ", len(sys.argv))
print(sys.argv) 
```

--

- `sys.argv` contient les arguments + le nom du script lancé en premier

--

```bash
$ python3 test02-arguments.py truc bidule chose --args 12
Nombre d'arguments :  6
['test02-arguments.py', 'truc', 'bidule', 'chose', '--args', '12']
```



---
class: middle, center, section

# Et pour lancer un script `shell` ou une commande système ?

---
## Dans R

Avec la commande `system()`

```r
system("ls")
system("./test01-simple.sh")
```

--
Quelques options intéressantes :

- `intern` : si `FALSE`, affiche le résultat mais capte celui-ci si `TRUE` (pour le stocker dans une variable par exemple)

- `ignore.stdout` et `ingnore.stderr` : si `TRUE`, n'affiche pas les messages de sorties ou d'erreurs

- `wait`: permet d'attendre (ou non) la fin de la commande pour continuer l'exécution du code R

---
## Dans Python

Avec le module `os`

```python
import os
os.system("ls")
```

- Commande exécutée mais on ne voit pas le résultat

- Utile uniquement pour les commandes ne renvoyant pas de sorties donc

--

- Pour capturer la sortie, il faut créer un flux

```python
flux = os.popen('ls')
flux.read()
```

Sortie du flux (en une seule chaîne de caractères) à stocker dans une variable si on veut l'utiliser 

---
class: middle, center, section

# Exécution récurrente de script

---
## Dans le code - Commande de type `sleep`

Boucle (éventuellement infinie) réalisant une opération à intervalles réguliers

--
#### en R

```r
while (TRUE) {
  # Code à réaliser
  Sys.sleep(temps) # temps défini en nombre de secondes
}
```

--
#### en Python

```python
import time

while True:
    # Code à réaliser
    time.sleep(5) # temps défini en nombre de secondes
```

---
## Dans le code - Commande de type `sleep`

--
### Avantage

- Très simple à programmer

--

### Problèmes 

- Processus à lancer en tâche de fond (avec `&` dans le `shell`)
    - Toujours présent en mémoire vive donc
    - Si machine arrêtée puis redémarrée, le processus à relancer
--
- Temps d'exécution du code à réaliser pouvant varié
    - Processeur et autres ressources pouvant être utilisés par d'autres processus
    - Code lui même pouvant varié en fonction des entrées/sorties
    - Intervalles d'exécution pas forcément identiques

---
## Dans le code - Boucle `while` et test sur heure et/ou date

Boucle (éventuellement infinie) réalisant une opération lorsque l'heure et/ou la date 

--
#### en R

```r
while (TRUE) {
    if (test_time(Sys.time())) { # fonction test_time() à définir
        # Code à réaliser
    }
}
```

--
#### en Python

```python
import time

while True:
    if test_time(time.localtime()): # fonction test_time() à définir
        # Code à réaliser
```

---
## Dans le code - Boucle `while` et test sur heure et/ou date

--

### Avantage

- Assez simple à programmer
    - Test par forcément évident si intervalles un peu particulier
        - par ex. tous les mardis et jeudis, à 10h et 16h
--
- Intervalles d'exécution contrôlés
    - Non dépendant du temps d'exécution du code à réaliser
        - **Sauf** si celui-ci met plus de temps que l'intervalle entre deux exécution !

--

### Problème

- Processus à lancer en tâche de fond (avec `&` dans le `shell`)
    - Toujours présent en mémoire vive donc
    - Si machine arrêtée puis redémarrée, le processus à relancer
    
---
## Commande `watch`

- [`watch`](https://manpages.ubuntu.com/manpages/jammy/en/man1/watch.1.html) disponible de base dans les distributions Linux (dont Ubuntu)

- Affiche le résultat du commande exécutée à intervalles de temps régulier
    - 2 secondes par défaut
    - Heure d'exécution affichée en haut à droite de la fenêtre
    - `uptime` permettant de voir l'heure

```bash
$ watch uptime
```

--

- Option `-n` permettant de choisir l'intervalle d'exécution (en secondes)

```bash
$ watch -n 10 uptime
```

--

- Autres options possibles pour biper si changement (`-b`), afficher les différences de résultats (`-d`)...

---
## Commande `cron`

- [`cron`](https://doc.ubuntu-fr.org/cron) disponible de base dans les distributions Linux (dont Ubuntu)

- Dédié à la programmation de lancement automatique (sur serveur)

--

### Liste des programmations

```bash
$ crontab -l
```

--

### Création de lancement automatique tâches

- Ouvre le fichier texte permettant la programmation de tâches, selon une certaine syntaxe
    - une ligne : une tâche programmée

```bash
$ crontab -e
```

---
## Commande `cron` - Syntaxe

```cron
minute heure jour_mois mois jour_semaine commande
```

--
- Définition des valeurs :
    - minute : de 0 à 59
    - heure : de 0 à 23
    - jour du mois : de 1 à 31
    - mois : de 1 à 12 ou `jan`, `feb`, ..., `nov` et `dec`
    - jour_semaine : de 1 (lundi) à 7 (dimanche - qui peut aussi s'écrire 0) ou `mon`, `tue`, ..., `sat` et `sun`
--
- Spécifications particulières :
    - `*` : toutes les valeurs possibles pour ce champ
    - `,` : pour définir une liste de valeurs
    - `-` : pour définir une plage de valeurs
    - `/` : pour définir un palier entre les valeurs


---
## Commande `cron` - Exemples

- Lancement du script `commande.sh` tous les 14 novembre à 15h52

```cron
52 15 14 11 * /home/user/commande.sh
```

--

- Lancement du même script tous les premier du mois, à 1h30

```cron
30 1 1 * * /home/user/commande.sh
```

--

- Lancement du même script tous les mardis et jeudis, à 10h et 16h

```cron
0 10,16 * * tue,thu /home/user/commande.sh
```

--

- Lancement du même script toutes les 5 minutes de 9h à 17h les jours de semaine

```cron
*/5 9-17 * * 1-5 /home/user/commande.sh
```

---
## Commande `cron` - Raccourcis

Raccourcis possibles pour la définition de la récurrence :
    
- `@reboot` : à chaque redémarrage
- `@yearly`/`@annually` : tous les ans (*i.e* `0 0 1 1 *`)
- `@monthly` : tous les mois (*i.e* `0 0 1 * *`)
- `@weekly` : une fois par semaine le dimanche (*i.e* `0 0 * * 0`)
- `@daily`/`@midnight` : tous les jours à minuit (*i.e* `0 0 * * *`)
- `@hourly` : toutes les heures (*i.e.* `0 * * * *`)

--

Exemple : lancement de la commande tous les jours

```cron
@daily /home/user/commande.sh
```

---
## Commande `cron` - Compléments

- Commandes exécutées en mode `root` (avec tous les droits donc)
    - Attention à ce que vous faîtes

--

- Possibilité de spécifier l'utilisateur (pour exécuter selon les droits de celui-ci) en l'insérant entre la programmation et la commande

```cron
@daily user /home/user/commande.sh
```

--

- Suppression de toutes les tâches 

```bash
$ crontab -r
```

--

- Et spécifiquement pour un utilisateur

```bash
$ crontab -r -u username
```

---
## Commande `cron` - Compléments

- Bien tester le code pour être sûr qu'il fonctionne, que les droits soient bons (si utilisateur spécifié)

--

- Si affichage de la commande, envoi automatique d'un mail après exécution
    - Possible si `mailutils` installé

--

- Chemin par défaut : répertoire de l'utilisateur
    - Attention à bien les spécifier dans vos codes

--

- Logs présents dans le répertoire `/var/log/syslog/`
    - Possibilité de configurer autrement si besoin
