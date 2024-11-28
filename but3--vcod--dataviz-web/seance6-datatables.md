# Librairie DataTables

La librairie [`DataTables`](https://datatables.net/) permet de présenter des tableaux de façon avancé en HTML. Elle nécessite l'importation de la librairie [`jQuery`](https://jquery.com/), très utilisé pour simplifier certaines opérations en Javascript.

## Création d'une table en D3

Pour voir le fonctionnement de la librairie `DT`, nous allons d'abord créer une table HTML à partir des données précédemment utilisé dans ce cours.

### Fichier HTML de base

On créé d'abord un fichier HTML de base, dans lequel nous chargeons les librairies `D3`, `jQuery` et `DataTables`, ainsi qu'un script JS que nous allons développé plus tard.

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Exemple d'utilisation DataTables</title>
        
        <script src="https://d3js.org/d3.v7.min.js"></script>
        
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        
        <link href="https://cdn.datatables.net/v/dt/dt-2.1.8/datatables.min.css" rel="stylesheet">
        <script src="https://cdn.datatables.net/v/dt/dt-2.1.8/datatables.min.js"></script>
    </head>
    <body>
        <div id = "contenant">
        </div>
        <script src="seance6-exemple.js"></script>
    </body>
</html>
```

### Script JS associé

Dans un autre fichier (nommé idéalement `seance6-exemple.js`, sinon modifier le fichier HTML en conséquence), on créé donc le tableau HTML automatiquement à partir du fichier CSV chargé.

```js
d3.csv(
    "https://fxjollois.github.io/donnees/scimagojr/scimagojr.csv",
    function (d) {
        return {
            Country: d.Country,
            Region: d.Region,
            Year: parseInt(d.Year),
            Rank: parseInt(d.Rank),
            Documents: parseInt(d.Documents),
            Citations: parseInt(d.Citations),
            Hindex: parseInt(d["H index"])
        };
    })
    .then(function(data) {
        // Création du tableau
        d3.select("#contenant").append("table")
            .attr("id", "table_donnees")
            .append("thead")
            .append("tr")
            .selectAll("th")
            .data(Object.keys(data[0]))
            .enter()
            .append("th")
            .html(d => d);
        d3.select("#table_donnees").append("tbody")
            .selectAll("tr")
            .data(data.filter(d => d.Year === 2021)) // on se restreint à 2021 uniquement
            .enter()
            .append("tr").selectAll("td")
                .data(d => Object.values(d))
                .enter()
                .append("td")
                .html(d => d);
    
        // PLACE OU METTRE LE CODE CI-DESSOUS
});
```

Lors de la visualisation du résultat HTML, vous voyez bien le tableau HTML à presque 6000 lignes.

## Utilisation de DataTables sans configuration

Pour modifier l'aspect de la table HTML, ce qui est l'intérêt premier de la librairie, nous créons un nouvel objet `DataTable` avec en paramètre l'identifiant de la table HTML concernée.

```js
new DataTable("#table_donnees");
```

Voici les éléments intéressants à remarquer :

- Il y a par défaut 10 lignes présentées, et il est possible de naviguer dans le tableau avec les éléments en bas à droite, pour sélectionner les différentes pages
- Il est possible de modifier le nobre de lignes affichées en changeant le paramètre en haut à gauche
- Dans le cadre en haut à droite, nous pouvons faire une recherche (essayez par exemple de taper "France")
- Il est aussi possible de faire un tri de la table, en cliquant sur une des flèches à droite de chaque nom de colonne (en haut tri croissant et en bas tri décroissant)
- En bas à gauche, nous avons le nombre total de lignes et lesquelles sont affichées

## Suppression de certaines fonctionnalités

On peut souhaiter ne pas laisser la possibilité de faire du tri ou une autre fonctionnalité. Dans ce cas, on passe en paramètre un littéral JSON, en plus de l'identifiant de la table, en indiquant `false` pour les fonctionnalités que l'on ne souhaite pas. Par exemple, pour ne pas laisser la possibilité de faire du tri, si de recherche, on procède ainsi :

```js
new DataTable("#table_donnees", { searching: false, ordering: false });
```

Voici les différentes fonctionnalités qu'on peut interdire :

- `searching` : la recherche d'une chaîne de caractères dans une des cellules
- `ordering` : le tri (croissant ou décroissant) sur une colonne
- `paging` : le découpage en plusieurs pages
- `info` : les infos présentes en bas à gauche

## Tri des données en amont

On peut définir un tri par défaut, on utilise le paramètre `order` qui prend un tableau de couples : [numéro de colonne (qui débute à 0), type de tri (`"asc"` ou `"desc"`)]. Ici, on trie par ordre décroissant les régions, puis par ordre croissant du rang.

```js
new DataTable("#table_donnees", { order: [[1, "desc"], [3, "asc"]] });
```

## Affichage avec scrolling

Plutôt que de naviguer dans les pages, on peut préférer permettre un scrolling sur la tableau, comme ci-dessous :

```js
new DataTable("#table_donnees", { paging: false, scrollCollapse: true, scrollY: '600px' });
```

## Style global

Si on affecte des classes spécifiques à la balise `table` directement, le style du tableau change :

- `cell-border` : bordure autour des cellules
- `compact` : diminue le *padding* des cellules pour rendre l'affichage plus compacte
- `hover` : surligne la ligne sur laquelle passe la souris avec une couleur différente
- `order-column` : mets en avant la colonne sur laquelle le tri est fait
- `row-border` : ajour une bordure au dessus et en dessous de chaque ligne
- `stripe` : alterne les couleurs de fond pour les lignes

La classe `display` est un raccourci pour avec les classes `stripe`, `hover`, `order-column` et `row-border` en même temps.

Les changements de couleurs, de police et autres peuvent se faire en CSS bien évidemment.

## Changement des libellés des colonnes

```js
new DataTable("#table_donnees", {
    columns: [
        { title: "Pays" }, 
        { title: "Région" }, 
        { title: "Année" }, 
        { title: "Rang" }, 
        { title: "Documents" }, 
        { title: "Citations" }, 
        { title: "H-index" }
    ]
});
```

```js
new DataTable("#table_donnees", {
    columnDefs: [
        { targets: 0, title: "Pays" }
    ]
});
```

`columnDefs` permet aussi de définir d'autres éléments sur une colonne spécifique (ou toutes les colonnes en indiquant `"_all"` dans `targets`) dont :

- `visible` : colonne masquée si mis à `false`
- `orderable` : 
- `searchable` : 

## Titre pour le tableau

```js
new DataTable("#table_donnees", { caption : "Production scientifique mondiale depuis 1996" });
```


## Extensions

### Buttons

        <link href="https://cdn.datatables.net/buttons/3.2.0/css/buttons.dataTables.min.css" rel="stylesheet">
        <script src="https://cdn.datatables.net/buttons/3.2.0/js/dataTables.buttons.min.js"></script>

??? -> Marche pas

### FixedColumns

### FixedHeader

## Plug-Ins

### percentageBars



## Sélection des lignes


## A FAIRE

### Données

Nous disposons de deux fichiers CSV (cf liens ci-dessous) contenant les informations de ventes immobilières dans des villes (du Texas pour information), avec en détail :

- [`tab_resume.csv`](seance6/tab_resume.csv) : Résumé par ville
    - Champs : nom de la ville, nombre de ventes total sur la période, volume (en $) des ventes et prix médian de ventes
- [`tab_complet.csv`](seance6/tab_complet.csv) : Détail par mois
    - Champs : nom de la ville, année et mois, et sur le mois, nombre de ventes, volume (en $) et prix médian
    
### Demande initiale

On veut avoir un tableau reprenant les informations du premier fichier, au format numérique simple. Et un graphique en-dessous qui affiche l'évolution du nombre de ventes de toutes les villes. 

Lorsqu'une ou plusieurs sont sélectionnées dans le tableau, on souhaite mettre en avant leur évolution dans le graphique.

### Complément

- On veut que la colonne du prix médian soit une barre représentant ce prix médian par rapport au prix médian maximum constaté ;
- On veut pouvoir choisir la variable représentée dans le graphique, à savoir : le nombre de ventes total, le volume (en $) ou le prix médian de ventes.



