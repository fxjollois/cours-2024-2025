# Séance 5

## Travail à réaliser

En repartant des données de production scientifique (au format `CSV` cette fois) disponible via ce lien <https://fxjollois.github.io/donnees/scimagojr/scimagojr.csv>, refaire les demandes suivants :


- Faire toutes les demandes dans le tutoriel pour améliorer le TOP
- **Documents et Citations** : nuage de points entre le nombre de documents produits et le nombre moyen de citations pour la dernière année disponible, pour chaque pays, avec les contraintes suivantes :
    - couleur (entre du vert pour le 1er et du rouge pour le dernier) en fonction de son rang
    - taille en fonction du *H-index*
    - lignes de références au niveau des moyennes de chaque variable
    - axes logarithmiques
    - nom de chaque pays indiqué lorsque la souris passe dessus, avec région, nombre de documents et nombre de citations
    
- **Evolution TOP10** : graphique montrant l'évolution des rangs des pays sur la période, uniquement pour les dix premiers rangs par année, avec les contraintes suinvantes :
    - une couleur par pays
    - une ligne par pays avec des points pour chaque année
    - il faut gérer les cas où certains pays sortent et entrent dans le TOP10 au cours de la période
    - nom du pays, nombre de documents produits sur l'année lors du passage de la souris dessus

