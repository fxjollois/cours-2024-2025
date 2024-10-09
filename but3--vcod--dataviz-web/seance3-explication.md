---
layout: slides
---

class: middle, center, inverse, title
# Plotly

## Explication de la correction de la séance 2

Voir le [résultat attendu](seance2/seance2-demande.html)


---
class: middle, inverse, center

## Partie HTML/CSS

---
### En-tête : Chargement des données

- Un titre pour faire propre
- La première balise importe la librairie (fichier téléchargé localement ici)
- Les 3 dernières balises `script` servent donc à charger les données

```html
<title>Production scientifique mondiale</title>
<script src="plotly-2.35.2.min.js" charset="utf-8"></script>
<script src="top_regions.js"></script>
<script src="par_annee.js"></script>
<script src="documents_citations.js"></script>
```

---
### CSS pour positionnement des graphiques du haut

- Centrage du titre
- les 2 balises identifiées `top_regions` et `par_annee` seront flottantes
    - 2 graphiques du haut
    - si leur longueur le permet, elles seront donc l'une à côté de l'autre

```html
<style>
    h1 {
        text-align: center;
    }
    #top_regions {
        float: left;
    }
    #par_annee {
        float: right;
    }
</style>
```

---
### Contenants

- 3 `div` à créer mais d'autres pour organisation
- une globale qui fera 80% de la largeur et sera centrée
- une pour les 2 graphes du haut
- car une autre intégrée pour *nettoyer* les balises et ne pas avoir d'impact des `float` sur l'affichage de la dernière

```html
<h1>Production scientifique mondiale</h1>
<div style="width: 80%; margin: 0 auto;">
    <div>
        <div id = "top_regions"></div>
        <div id = "par_annee"></div>
    </div>
    <div style="clear: both;">&nbsp;</div>
    <div id = "documents_citations"></div>
</div>
```

> Le reste est dans une même balise `script` finale

---
class: middle, inverse, center

## Premier graphique : `top_regions`

---
### Rappel sur les données dans `top_regions.js`

```js
var top_regions = [
    {
        "Region": "Western Europe",
        "Documents": 20856135
    },
    {
        "Region": "Asiatic Region",
        "Documents": 18336647
    },
    ...
];
```

---
### Préparation des données

- Récupération uniquement de la région, puis du nombre de documents
    - un tableau de noms de région pour `y` donc
    - un tableau du nombre de documents pour chaque région pour `x`
- Indication
    - de type diagramme en barres
    - couleur spécifique (la même pour tous)
    - orientation horizontale


```js
var trace_top_regions = [
    {
        y: top_regions.map(function(e) { return e.Region }),
        x: top_regions.map(function(e) { return e.Documents }),
        type: "bar",
        marker: { color: "darkgrey" },
        orientation: "h"
    }
];
```

---
### Affichage du graphique

- 2 premiers paramètres : balise et données
- Quelques ajustement sur le graphique
    - Ajout d'un titre
    - Marge gauche plus grande pour bien tout lire
    - Pas de zoom possible sur les axes
- Pas d'affichage de la barre de menu en haut à droite

```js
Plotly.newPlot(
    "top_regions", 
    trace_top_regions, 
    {  
        title: "Classement des régions selon la production scientifique",
        margin: { l: 150 }, 
        xaxis: { fixedrange: true }, 
        yaxis: { fixedrange: true }
    },  
    { displayModeBar: false }
);
```


---
class: middle, inverse, center

## Deuxième graphique : `par_annee`

---
### Rappel sur les données dans `par_annee.js`

```js
var par_annee = [
    {
        "Year": 1996,
        "Africa": 11302,
        "Africa/Middle East": 2943,
        "Asiatic Region": 178482,
        "Eastern Europe": 76566,
        "Latin America": 24879,
        "Middle East": 22105,
        "Northern America": 404624,
        "Pacific Region": 30997,
        "Western Europe": 401269
    },
    {
        "Year": 1997,
        "Africa": 12304,
        "Africa/Middle East": 2955,
        "Asiatic Region": 197687,
        "Eastern Europe": 80078,
        "Latin America": 29058,
        "Middle East": 23427,
        "Northern America": 405251,
        "Pacific Region": 32386,
        "Western Europe": 429562
    },
    ...
];
```

---
### Préparation des données

```js
var regions = top_regions.map(function(e) { return e.Region }),
    traces_par_annee = regions.map(function(e) { 
        return {
            x: par_annee.map(function(d) { return d.Year; }),
            y: par_annee.map(function(d) { return d[e]; }),
            text: par_annee.map(function(d) { return d.Year == 2021 ? e : ""}),
            name: e,
            type: "scatter",
            mode: "lines+text",
            textposition: "right",
            marker: { color: "darkgrey" }
        }
    }),
    traces_par_annee_bis = traces_par_annee.map(function (e) {
        e.y = e.y.map(function(d) { return d / e.y[0] * 100; });
        return e;
    });
```

*A noter* : première ligne permettant de créer la liste des régions dans l'ordre d'affichage du premier graphique

---
### Focus sur la création de la trace

- Pour chaque région (dans le bon ordre donc)
    - Liste des années dans le tableau `par_annee` pour `x`
    - Liste des valeurs de la région pour `y`
    - Nom du pays pour 2021, et chaîne vide sinon pour `text`
- Indication
    - de type nuage de points, avec lignes et texte seulement
    - couleur spécifique (la même pour tous)
    - position du texte à droite du point

```js
traces_par_annee = regions.map(function(e) { 
    return {
        x: par_annee.map(function(d) { return d.Year; }),
        y: par_annee.map(function(d) { return d[e]; }),
        text: par_annee.map(function(d) { return d.Year == 2021 ? e : ""}),
        type: "scatter",
        mode: "lines+text",
        textposition: "right",
        marker: { color: "darkgrey" }
    }
})
```

---
### Affichage du graphique

- 2 premiers paramètres : balise et données
- Quelques ajustement sur le graphique
    - Ajout d'un titre
    - Suppression de la légende, inutile ici
    - Pas de zoom possible sur les axes et étendue spécifique pour X (pour affichage)
- Pas d'affichage de la barre de menu en haut à droite

```js
Plotly.newPlot(
    "par_annee", 
    traces_par_annee_bis, 
    { 
        title: "Evolution sur la période (base 100 en 1996)",
        showlegend: false, 
        xaxis: { range: [1996, 2028], fixedrange: true }, 
        yaxis: { fixedrange: true }
    },  
    { displayModeBar: false }
);
```


---
class: middle, inverse, center

## Troisième graphique : `documents_citations`

---
### Rappel sur les données dans `documents_citations.js`

```js
var documents_citations = [
    {
        "Country": "China",
        "Region": "Asiatic Region",
        "Documents": 1043131,
        "Citations": 1094503
    },
    {
        "Country": "United States",
        "Region": "Northern America",
        "Documents": 714412,
        "Citations": 654637
    },
    {
        "Country": "India",
        "Region": "Asiatic Region",
        "Documents": 306647,
        "Citations": 252299
    },
    ...
];
```

---
### Préparation des données

- Liste du nombre de documents par pays pour `x`
- Liste du nombre de documents par pays pour `y`
- Liste des noms de pays pour `text`
- Indication
    - de type nuage de points, avec les points seulement
    - couleur spécifique (la même pour tous)
    - taille définie (la même pour tous)

```js
var traces_documents_citations = [
    {
        x: documents_citations.map(function(e) { return e.Documents; }),
        y: documents_citations.map(function(e) { return e.Citations; }),
        text: documents_citations.map(function(e) { return e.Country; }),
        type: "scatter",
        mode: "markers",
        marker: { color: "darkgray", size: 5 }
    }
];
```

---
### Affichage du graphique

- 2 premiers paramètres : balise et données
- Quelques ajustement sur le graphique
    - Ajout d'un titre
    - Axes logarithmiques (pour les deux) avec ajustement automatique de l'étendue
- Pas d'affichage de la barre de menu en haut à droite

```js
Plotly.newPlot(
    "documents_citations", 
    traces_documents_citations, 
    {
        title: "Croisement en documents produits et citations en 2021",
        xaxis: {
            type: 'log',
            autorange: true
        },
        yaxis: {
            type: 'log',
            autorange: true
        }
    },  
    { displayModeBar: false }
);
```


---
class: middle, inverse, center

## Gestion des interactions

---
### Lors d'un clic sur une barre du premier graphique

Dans la fonction anonyme création de 4 variables 

- les informations concernant la barre sur laquelle on a cliqué
- une liste de couleurs par région, identiques pour tous, sauf pour celle sur laquelle on a cliqué 
- une liste de couleurs par pays, identiques pour tous, sauf pour ceux dont la région est celle voulue
- une liste de tailles par pays, identiques pour tous, sauf pour ceux dont la région est celle voulue

```js
document.getElementById("top_regions").on(
    'plotly_click', 
    function(e) {
*        var infos = e.points[0],
*            couleurs_regions = top_regions.map(function(d) { return d.Region == infos.label ? "DarkRed" : "lightgray" }),
*            couleurs_pays = documents_citations.map(function(d) { return d.Region == infos.label ? "DarkRed" : "lightgray" }),
*            tailles_pays = documents_citations.map(function(d) { return d.Region == infos.label ? 12 : 5 });
        Plotly.restyle("top_regions", { "marker.color": [couleurs_regions] })
        Plotly.restyle("par_annee", { "marker.color": "lightgray", opacity: 0.5 })
        Plotly.restyle("par_annee", { "marker.color": "DarkRed", opacity: 1 }, [infos.pointIndex])
        Plotly.restyle("documents_citations", { "marker.size": [tailles_pays], "marker.color": [couleurs_pays]})
    });
```




