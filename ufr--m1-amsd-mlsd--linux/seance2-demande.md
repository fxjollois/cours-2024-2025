# Système pour la Data Science

## Master AMSD/MLSD

### Scripts `shell`

#### Demande à réaliser

## Manipulations à faire en amont

- Créer un répertoire `seance2` dans le répertoire du cours
- Copier le répertoire `UbiqLog4UCI` dans ce nouveau répertoire

## Scripts simples

- Ecrire un script prenant des entiers en paramètres et affichant la somme de ceux-ci
    - Gérer le cas aucun paramètre fourni
    - Gérer le cas paramètre non entier

- Ecrire un script qui demande "Avez-vous compris le cours (Oui/Non/Exit) ?"
    - Qui répond 
        - "Bravo" si l'utlisateur répond "Oui"
        - "N'hésitez pas à poser des questions à l'enseignant" si l'utilisateur répond "Non"
        - "Au revoir" si l'utlisateur répond "Exit"
        - "Merci de lire les consignes..." sinon
    - Gérer les variations à la réponse
        - "Oui" peut être écrit aussi "oui", "OUI", "o", "O"
        - "Non" peut être écrit aussi "non", "NON", "n", "N"
        - "Exit" peut êter écrit aussi "exit", "EXIT", "e", "E"

## Script de recherche d'informations

On va travailler sur les fichiers présents dans le répertoire `UbiqLog4UCI`.

- Faire un script qui demande à l'utilisateur un numéro d'individu (de 1 à ?) et qui vérifie que celui-ci existe bien dans la liste des répertoires
    - De plus, le script nous indiquera si cet individu est un homme (`M` dans le nom) ou une femme (`F`)

- Compléter ce script pour demander une date à l'utilisateur
    - Le script indiquera s'il y a bien un fichier de log pour ce jour la et cette personne

- Compléter encore le script pour pouvoir passer en paramètre les deux informations, avec le formalisme suivant :
    - `-i 12` : pour tester si l'individu 12 existe
    - `-d 2014-01-11` : pour tester si la date existe pour cet individu
        - si l'option `-i` n'est pas utilisée, alors message d'erreur
    
- Gérer les appels 
    - si pas de paramètre : demande de l'utilisateur puis de la date
    - si juste utilisateur (`-i`) : affichage pour dire si c'est un homme ou une femme, puis demande de la date
    - si utilisateur (`-i`) et date (`-d`) : affichage pour dire si c'est un homme ou une femme, et dire si la date existe

## Script d'extraction 

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

### A faire

- Créer un script permettant de concaténer toutes les informations dans un seul fichier avec le formalisme vu ci-dessus
    - nom du fichier par défaut `sortie.json`

- Modifier le script pour pouvoir indiquer le nom du fichier à écrire
    - paramètre `-o` suivi par le nom de fichier à écrire

- Etendre ce script à la possibilité de demander de n'extraire que les lignes correspondant à une certainte recherche (similaire à celle faite avec `grep`)
    - l'utilisateur indiquera comme paramètre `-s` suivi du critère de recherche (syntaxe `grep`)


