# Librairie Plotly

La librairie [`plotly`](https://plotly.com) est très intéressante, car elle a beaucoup d'avantages :

- Large palette de graphique possible
- Interactivé possible
- Disponible aussi dans R et Python (ainsi que d'autres langages)

Nous allons voir l'usage de certains graphiques, ainsi que cetaines options classiques. Mais ce tutoriel n'est clairement pas exhaustif et l'aide en ligne est là pour vous aider.

## Importation de la librairie 

Pour cela, la première possibilité est de placer le code ci-dessous dans la balise `<head>` de votre fichier HTML :

```html
<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
```

Il est bien évidemment possible de télécharger le fichier dans le répertoire de votre page web, et d'y faire référence directement (avec `src="plotly-2.35.2.min.js"` uniquement).

Pour information, cela créé un objet javascript nommé `Plotly` dans la page, qu'on utilisera pour créer les graphiques.

## Création d'un graphique en barres

### Données utilisées

Nous allons continuer de travailler sur les données vues la séance précédente, à savoir :

```js
var valeurs = [12, 5, 21, 18, 14],
    modalites = ["A", "B", "C", "E", "Z"];
```

### Création du contenant

**NB** : les fonctions de créations de graphiques nécessitent le passage en paramètre de l'identifiant de la balise dans laquelle mettre le graphique. Ainsi, le code doit être exécuté après la création de celle-ci. Donc, pour le moment, nous allons écrire le code JS dans une balise `<script>` après la création de la balise accueillant le graphique.

Le plus simple est de créer une balise `<div>` avec un identifiant spécifique, comme ci-dessous.

```html
<div id="graphique_barres"></div>
```

### Création du contenu

Ensuite, on va, dans une balise de script, procéder en deux étapes :

1- Créer une variable (nommée `data` ici), contenant les valeurs à mettre en $X$ et en $Y$, et le type de graphique
2- Appler la fonction `newPlot()` de l'objet `Plotly` avec l'identifiant de la balise où placer le graphique et les données du graphique.

```js
var data = [
    {
        x: modalites,
        y: valeurs,
        type: 'bar'
    }
];
Plotly.newPlot('graphique_barres', data);
```

### Quelques modifications possibles

La première est spécifique aux diagrammes en barres, les suivantes s'appliquent aux autres types de graphique.

#### Texte sur chaque barre

En ajoutant le champs `text` dans les données, on peut par exemple afficher les valeurs en haut de la barre directement. Si on ajoute en plus le champs `textposition` avec la valeur `"outside"`, le texte est écrit au-dessus des barres.

#### Customisation de la pop-up

On peut customiser la pop-up qui s'affiche en passant la souris sur une barre, avec le champs `hoverinfo` qui peut prendre les valeurs suivantes, entre autres : 
- "none" : supprime l'affichage
- "x" ou "y" : pour ne voir que l'une des deux informations

On peut aller plus loin avec `hovertemplate` qui permet de rédéfinir la façon d'écrire la pop-up, avec utilisation des valeurs des variables en utilisant `%{variable}`. La balise `<extra>` permet d'ajouter des informations et par défaut affiche `trace: 0`.

Essayez avec `'Modalité : %{x}, Valeur : %{y}<extra></extra>'`

#### Customisation des couleurs et autres

Le champs `marker` permet de changer les couleurs utiliser, et d'autres paramètres. Il faut lui passer comme valeur un litéral avec différents champs :

- `color` permet donc de changer la couleur des barres
    - si une seule valeur : même couleur pour toutes les barres 
    - si on veut une couleur par barre, il faut un tableau d'autant de couleur
- `line` permet de spécifier une bordure (en indiquant la couleur et la taille éventuellement)
- `opacity` permet de définir une opacité entre 0 (invisible) et 1 (totalement visible)

Essayez avec l'exemple ci-dessous :

```js
{
    color: "DarkSalmon",
    line: {
        color: "FireBrick",
        width: 2
    },
    opacity: 0.5
}
```

Si on change la valeur passée à `color` avec le code ci-dessous, cela permet d'avoir la barre de la modalité B avec une couleur différente.

- la fonction `map()` sur un tableau exécute la fonction (anonyme ici) passée en paramètre à chaque valeur du tableau
- la fonction passée en paramètre a un ou deux paramètres possibles
    - si un seul : la valeur de l'élément (nommé `e` ici)
    - si deux : la valeur et la position
- le formalisme `condition ? valeur_si_vrai : valeur_si_faux` en JS permet de faire un test et de renvoyer une valeur spécifique en fonction du résultat du test

```js
modalites.map(function(e) { return e == "B" ? "DarkRed" : "DarkSalmon" })
```


## Création d'un graphique type nuage de points 

### Données utilisées

Nous allons utiliser les données suivantes (même *X* pour tout le monde mais *Y* spécifique à chaque modalité):

```js
var X = [ 1,  2,  3,  4,  5,  6],
    A = [18, 12, 16,  9, 17, 17],
    B = [ 9,  4,  6,  7,  3,  5],
    C = [ 1,  6,  4,  2,  5,  2],
    E = [15, 14, 10, 12, 13, 16],
    Z = [ 8, 12,  7, 15, 11,  9];
```

### Création du contenant

on va créer une nouvelle balise `<div>` avec un identifiant spécifique, comme ci-dessous.

```html
<div id="graphique_nuage"></div>
```

### Création du contenu

Ensuite, on va, dans une balise de script, procéder en trois étapes cette fois-ci :

1- Créer une variable par modalité (nommée `traceA` pour *A*, ...), contenant les valeurs à mettre en $X$ et en $Y$
    - Dans Plotly, on parle de **trace**
2- Créer une variable (`data3` ici), qui sera une liste contenant les 5 variables créées juste avant
2- Appler la fonction `newPlot()` de l'objet `Plotly` avec l'identifiant de la balise où placer le graphique et les données du graphique.

```js
var traceA = { x: X, y: A, type: "scatter" },
    traceB = { x: X, y: B, type: "scatter" },
    traceC = { x: X, y: C, type: "scatter" },
    traceE = { x: X, y: E, type: "scatter" },
    traceZ = { x: X, y: Z, type: "scatter" };
var data3 = [traceA, traceB, traceC, traceE, traceZ];
Plotly.newPlot("graphique_nuage", data3);
```

Puisqu'on a indique que le type était `"scatter"`, le graphique créé est un ensemble de lignes avec chacune une couleur, et identifiées *traceA*, *traceB*... dans la légende.

### Automatisation

L'object javascript `window`, automatiquement créé lors du chargement d'une page, contient l'ensemble des variables créées dans cette page (entre autres). Il est donc possible d'accéder à leur valeur avec une code du type `window["A"]` pour l'objet `A`. Ainsi, nous pouvons automatiser la création du graphique précédant, avec le code ci-dessous :

```js
Plotly.newPlot(
    "graphique_nuage", 
    modalites.map(function(e) { 
        return { x: X, y: window[e], type: "scatter" }
    })
);
```

### Quelques modifications possibles

#### Ajout d'un texte pour la légende

Le champs `name` dans chaque trace permet de changer ce qui est affiché dans la légende. Ici, on doit ajouter `name: e` dans l'objet retourné.

#### Changement de type de *trace*

Ici, on voit que chaque trace est une ligne avec un point à chaque valeur. On peut modifier cela en ajoutant le champt `mode` à l'objet retourné. Celui-ci peut prendre plusieurs valeurs dont les suivantes :

- "lines" : uniquement la ligne
- "markers" : uniquement les points
- "lines+markers" : les deux (idem si on ne met pas le champs)

#### Personnalisation du graphique

Lors de l'appel de la fonction `newPlot()`, on peut ajouter des options dans un troisième paramètre (souvent nommé `layout` quand on le définit en amont de l'appel). Dans le code ci-dessous, on a fait les opérations suivantes :

- Ajout d'un titre
- Définition de l'étendu de l'axe Y
- Modification de la taille de la police d'écriture de la légende

```js
Plotly.newPlot(
    "graphique_nuage", 
    modalites.map(function(e) { 
        return { 
            x: X, y: window[e], type: "scatter", 
            name: e, mode: "lines+markers" 
        }
    }),
    {
        title: "Evolution des modalités",
        yaxis: { range: [0, 20] },
        legend: { font: { size: 20 }}
    }
);
```

Bien évidemment, beaucoup d'autres choses sont possibles dans cette personnalisation.


## Interaction entre les deux graphiques

Il est possible de gérer les évènements sur une page, tel qu'un clic de souris. Pour ceci, on créé ce qu'on appelle des *(event) listeners* qui surveille une activité particulière (clic de souris, mouvement de souris, touche appuyée...). Pour plus d'informations, je vous conseille de visiter [cette page](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Building_blocks/Events) très complète.

Pour créer un *listener*, il faut préciser sur quel élément nous l'ajoutons, avec la fonction `getElementById()` par exemple. Dans le code ci-dessous, on surveille la balise dans laquelle nous avons placé le graphique en barres.

L'évènement suivi ici (`"plotly_click"`) est de type particulier puisque spécifique à Plotly, mais il correspond à un clic sur un des éléments du graphique.

La fonction *listener* prend donc en paramètre l'évènement suivi et une fonction qui sera exécutée lors de la survenu d'un évènement (ici, donc, un clic sur une des barres).

Cette fonction passée en paramètre (anonyme ici) a un paramètre possible, qui va nous permettre d'accèder aux données de la barre sur laquelle on a cliqué. Dans notre cas, cet objet a un champs `points` qui contient les barres sélectionnés. On ne va prendre que la première, qu'on va stocker dans une variable `infos`.

On créé ensuite ensuite un tableau de couleurs, avec une couleur spécifique pour la barre choisie, grâce au code vu précédemment et le champs `label` de notre variable `infos`.

Ensuite, nous mettons à jour les graphiques à l'aide de la fonction `restyle()` de Plotly qui permet, comme son nom l'indique, de modifier le style d'un graphique. 

- Pour les barres, on change donc les couleurs avec la liste créé avant
- Pour les lignes, on fait cela en deux étapes :
    - on change les couleurs de toutes les lignes pour les mettre en gris
    - on change la couleur de celle choisie, connue grâce à la position présente dans le champs `pointIndex` de la variable `infos`

```js
document.getElementById("graphique_barres").on(
    'plotly_click', 
    function(e) {
        var infos = e.points[0],
            couleurs = modalites.map(function(d) { return d == infos.label ? "DarkRed" : "lightgray" });
        Plotly.restyle("graphique_barres", { "marker.color": [couleurs] })
        Plotly.restyle("graphique_nuage", { "marker.color": "lightgray" })
        Plotly.restyle("graphique_nuage", { "marker.color": "DarkRed" }, [infos.pointIndex])
    }
);
```


