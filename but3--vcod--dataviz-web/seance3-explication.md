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

---
class: middle, inverse, center

## Premier graphique

---
### 


