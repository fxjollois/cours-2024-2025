# Programmation Web

## Master AMSD/MLSD

### Shiny - Widgets HTML

## Demande à réaliser

Sur les données `txhousing` (du package `ggplot2` pour rappel), créer une application avec

- un onglet avec 
    - une table résumant les villes
        - Nom de la ville
        - Volume total des ventes
            - avec une représentation graphique, dans le tableau, permettant de savoir si c'est élevé ou non, par rapport aux autres villes
        - Prix médian moyen de vente
            - idem que pour le volume
        - Pourcentage d'évolution depuis 2000
            - idem aussi, avec en bonus, une couleur rouge si c'est négatif et vert si c'est positif
    - un graphique 
        - montrant l'évolution sur la période des villes sélectionnées dans le tableau ci-dessus
        - avec l'évolution globale moyenne en référence
    - une carte montrant les villes sélectionnées
- un onglet avec
    - une carte générale, affichant une couleur par rapport au prix médian moyen de chaque ville et en améliorant la pop-up qui s'affiche afin de lui mettre plus d'informations
    - en bonus, un choix de la variable à utiliser pour la couleur (volume total, prix médian moyen, % d'évolution depuis 2000, nombre de ventes...)
