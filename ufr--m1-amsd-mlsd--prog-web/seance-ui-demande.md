# Programmation Web

## Master AMSD/MLSD

### Shiny - UI interactive et programmation modulaire

## Demande à réaliser


Créer une application affichant des données

- Utilisation du framework `shinydashboard`
- Choix du data.frame à afficher dans la partie gauche
- Affichage du contenu du data.frame dans la partie à droite
    - Ajout de box pour indiquer le nombre de lignes, de variables
- Présence de quelques données déjà dans R
    - `mtcars`, `iris`, `LifeCycleSavings` par exemple
- Interface permettant la lecture d'un fichier de données
    - Fichier texte avec séparateur
        - Choix de certaines options
            - séparateur de valeurs
            - noms des variables présents
            - séparateur de décimales
            - ...
        - Doit fonctionner avec les fichiers suivants
            - <http://fxjollois.github.io/donnees/hepatitis.TXT>
            - <http://fxjollois.github.io/donnees/US_DATA.txt>
            - <http://fxjollois.github.io/donnees/heart_bis.txt>
            - <http://fxjollois.github.io/donnees/Detroit_homicide.txt>
    - Fichier `.RData` : choix de la variable à utiliser dedans pour le data.frame
        - Doit fonctionner avec le fichier [donnees.RData](donnees.RData)
            - Présence de 2 dataframes : `texas` et `diamonds` (à pouvoir choisir donc)

