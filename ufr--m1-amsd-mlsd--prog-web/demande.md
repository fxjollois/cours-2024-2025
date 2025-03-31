## Demande sur Shiny Python

A partir des données [movies_small](https://fxjollois.github.io/donnees/movies_small.csv), refaire l'appli suivante à l'aide de [shiny sous Python](https://shiny.posit.co/py/) :

<https://fxjollois.shinyapps.io/datavizweb-seance8-grp34/>

**NOTER** les éléments suivants :

- La première page **Global** est statique
- La deuxième page **Par Genre** est dynamique
    - L'utilisateur peut choisir un genre à gauche
    - Les chiffres clés et le graphique dépendent donc du genre
    - La *value box* à droite a une couleur dépendant du résultat :
        - Si évolution négative, couleur rouge (voir par exemple *Romance*)
        - Si évolution inférieure à 15%, couleur jaune (voir par exemple *Animation*)
        - Si évolution supérieure à 15%, couleur verte (voir par exemple *Drama*)
        - Si évolution non calculable, couleur grise (voir par exemple *Musical* et *Sport*)
- La dernière page **Données brutes** est elle aussi statique



