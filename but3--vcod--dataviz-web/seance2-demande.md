# TP - Utilisation de Plotly - Demande à réaliser

Nous allons travailler sur la production scientifique mondiale, depuis 1996. Les données ont été collectées à partir du site [SCImago Journal & Country Rank](http://www.scimagojr.com/help.php). Nous utiliserons 3 fichiers javascript, contenant chacun la déclaration d'une variable JSON :

- [`top_regions.js`](seance2/top_regions.js) : Production scientifique totale par régions du monde, entre 1996 et 2023
- [`par_annee.js`](seance2/par_annee.js) : Total par année et par région
- [`documents_citations.js`](seance2/documents_citations.js) : Production de l'année 2023, par pays avec comme information
    - le nom du pays
    - la région du monde de celui-ci
    - le nombre de documents scientifiques produits par ce pays
    - le nombre de citations d'un des documents scientifiques produits par ce pays

A partir de ces données, on veut produire un tableau de bord schématisé ci-dessous, avec trois graphiques :

1. Production scientifique par région 
    - Diagramme en barres
    - Même couleur de départ pour toutes les barres (à définir et choisir)
    - Lors d'un clic souris sur une barre, passage à une couleur spécifique pour la région sélectionnée et une couleur moins intense pour les autres (à votre guise)
    - Déselection lors d'un double-clic
2. Evolution de la production sur la période pour chaque région
    - Ensemble de séries temporelles
    - Même couleur de départ pour toutes les barres
    - Lors de la sélection d'une région dans le graphique 1, passage à une couleur spécifique (idéalement la même qu'au-dessus) pour la région sélectionnée (et les autres moins intenses)
    - Si désélection, retour aux couleurs d'origine
3. Croisement du nombre de documents et du nombre de citations
    - Nuage de points (documents en X, citations en Y)
    - Echelles logarithmiques
    - Affichage du nom du pays lors du passage de la souris au-dessus d'un point
    - Lors de la sélection d'une région dans le graphique 1, passage à une couleur spécifique (idéalement la même qu'au-dessus) pour les pays de la région sélectionnée (et les autres moins intenses)
    - Si désélection, retour aux couleurs d'origine

<div>
    <div style="float: left; width: 35%; height: 200px; border: solid 1px black; position: relative;">
        <p style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -100%);">1- Par régions</p>
    </div>
    <div style="float: right; width: 64%; height: 200px; border: solid 1px black; position: relative;">
        <p style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -100%);">2- Par année</p>
    </div>
    <div style="clear:both"></div>
    <div style="width: 100%; height: 200px; border: solid 1px black; position: relative;">
        <p style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -100%);">3- Croisement documents / citations</p>
    </div>
</div>


**Bonus** : l'idéal serait de faire un graphique en base 100 pour le 2 :

- tous les pays commencent à 100 en 1996
- chaque valeur d'une année est en référence à ce 100
    - une valeur de 200 indique que le nombre a doublé depuis 1996
    
L'intérêt de ce type de graphique est bien de voir l'évolution, non pas la quantité. Il serait donc intéressant de faire le calcul pour afficher les valeurs en base 100 donc.
