---
layout: slides
---

class: middle, center, inverse, title
# Programmation Web

## Master AMSD/MLSD

### Shiny - Quelques compléments concernant l'UI

---

## Plan

- Package `shinydashboard`

- 1, 2, 3 fichiers pour une appli ?

- Elèments HTML intégrables dans une appli shiny

- UI réactive

---
class: section, middle, center
## `shinydashboard`

---
## Présentation

[`shinydashboard`](https://rstudio.github.io/shinydashboard/index.html) : package R

- Dédié à la création de tableaux de bord (mais pas que)

- Ajout d'élèments visuels intéressants (cadres pour valeurs importantes, ensemble d'onglets...)

- Basé sur le framework JS [AdminLTE](https://github.com/almasaeed2010/AdminLTE)
    - Exemples visibles sur [AdminLTE.io](https://adminlte.io/themes/v3/)

---
## Squelette

- Fonction `dashboardPage()`

--

- Trois arguments obligatoires
    - En-tête en haut, créée avec la fonction `dashboardHeader()`
    - Partie gauche (pour les interactions a priori), créée avec la fonction `dashboardSidebar()`
    - Partie droite (principale), créée avec la fonction `dashboardBody()`

--

- Deux autres paramètres optionnels
    - Titre (donné dans `title`) dans le navigateur (pas visible donc sur la page)
    - Habillage ou couleur principale (avec le paramètre `skin`)
        - Valeurs possibles : `"blue"`, `"black"`, `"purple"`, `"green"`, `"red"` ou `"yellow"`

---
## Squelette

```r
library(shiny)
library(shinydashboard)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(),
    title = "Titre dans le navigateur",
    skin = "red"
  ),
  server = function(input, output) {
  }
)
```

---
## En-tête - fonction `dashboardHeader()`

- Ajout du titre de l'application (apparaîtra en haut à gauche), avec paramètre `title`
    - si trop long, ajustement possible avec `titleWidth`
- Possibilité d'ajouter différents items dans la barre de menu en haut (pas vue ici)
    - Partie en haut à droite souvent dédidée aux diverses notifications

--

```r
library(shiny)
library(shinydashboard)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(
      title = "Titre de l'application",
      titleWidth = 300
    ),
    dashboardSidebar(),
    dashboardBody(),
    title = "Titre dans le navigateur",
    skin = "red"
  ),
  server = function(input, output) {
  }
)
```

--

- Possibilité de la cacher avec l'option `disable = TRUE`

---
## Partie principale - fonction `dashboardBody()`

- Possibilité d'intégrer tous les éléments classiques d'une application shiny que vous avez déjà vu
- Différentes *boîtes* disponibles dans le package, en plus des `outputs` classiques que l'on peut avoir
- Contenu des boîtes présentées dans la suite

--

```r
library(shiny)
library(shinydashboard)

shinyApp(
  ui = dashboardPage(
    dashboardHeader( ... ),
    dashboardSidebar(),
    dashboardBody(
      box( ... ),
      infoBox( ... ),
      valueBox( ... ),
      tabBox( ... )
    ),
    title = "Titre dans le navigateur",
    skin = "red"
  ),
  server = function(input, output) {
  }
)
```

---
## `box()` 

- Boîte flottante avec encadrement, permettant un positionnement au choix (cf plus)
- Intégration d'éléments de type `input` ou `output`

--

```r
box(
    title = "Evolution des ventes",
    footer = "en US$",
    status = "info",
    solidHeader = TRUE,
    width = 8,
    "graphique à prévoir ici"
)
```

--

- `title` : titre affiché en haut de la box
- `footer` : texte en pied de la boîte
- `status` : statut de la boîte, définissant un aspect type (regarder `?validStatuses` pour plus d'infos)
- `solidHeader` : pour dire si le titre a une couleur de fond ou non (à tester pour voir l'effet produit)
- `width` : largeur de la boîte (entre 1 et 12)

---
## `infoBox()`

- Mise en valeur d'une information, courte, avec 2 élèments (titre et valeur)
- Personnalisation possible avec ajout d'une icône [Font-Awesome](https://fontawesome.io/icons/) ou [Glyphicons](https://getbootstrap.com/docs/3.4/components/#glyphicons)

--

```r
infoBox(
    title = "Progression",
    value = "+ 20%",
    subtitle = "Entre 2000 et 2020",
    icon = icon("line-chart"),
    fill = TRUE,
    color = "light-blue",
    width = 4
)
```

--

- `title` : nom de l'information affichée
- `value` : valeur de celle-ci
- `subtitle` : sous-titre affiché en petit en bas de la box
- `icon` : choix de l'icône
- `fill` : option modifiant l'aspect (à tester pour voir ce que vous préférez)
- `color` : couleur principale de la boîte (à choisir dans `?validColors`)
- `width` : largeur de la boîte (entre 1 et 12)

---
## `valueBox()`

- Autre type de mise en valeur, plus orienté numérique que `infoBox()`
- Personnalisable avec une icône aussi (même source)

--

```r
valueBox(
    value = "12,34",
    subtitle = "Volume total des ventes (en milliards)",
    icon = icon("usd"),
    color = "green",
    width = 4
)
```

--

- `value` : valeur à mettre en valeur
- `subtitle` : sous-titre affiché en petit en bas de la box
- `icon` : choix de l'icône
- `color` : couleur principale de la boîte (à choisir dans `?validColors`)
- `width` : largeur de la boîte (entre 1 et 12)

---
## Et en mode réactive ?

.left-column50[

#### Côté UI

```r
infoBoxOutput("ibox")
```

&nbsp;

&nbsp;

```r
valueBoxOutput("vbox")
```

]

--

.right-column50[
#### Côté serveur

```r
output$ibox <- renderInfoBox({
    # divers calculs si besoin
    infoBox(
        ... 
    )
})
```

```r
output$vbox <- renderValueBox({
    # divers calculs si besoin
    valueBox(
        ... 
    )
})
```

]


---
## `tabBox()`

- Box avec des onglets
- Chaque onglet peut contenir tous les éléments possibles d'une appli shiny (tableau, graphique, box...)

--

```r
tabBox(
    title = "Informations",
    width = 4,
    tabPanel(title = "Onglet 1", "contenu 1"),
    tabPanel(title = "Onglet 2", "contenu 2")
)
```

--

- `title` : titre affiché en haut de la box
- `width` : largeur de la boîte (entre 1 et 12)
- `tabPanel()` : définition d'un nouvel onglet
    - `title` : titre de l'onglet (affiché dans la partie de sélection de ceux-ci)
    - Contenu de l'onglet

---
## Remarques

### Pourquoi `width` a une valeur entre 1 et 12 ?

- Framework basé sur [Bootstrap](http://getbootstrap.com/)
- Chaque élément divisé en 12 colonnes
- Largeur des éléments à l'intérieur défini par rapport à ces 12 colonnes
    - *ex* : si on veut un élément qui fasse la moitié, on définit une largeur de 6

--

### Comment gérer les placements ?

- Box : éléments flottants s'empilant de gauche à droite par défaut
    - Prise en compte de la hauteur des éléments précédents
- 2 fonctions permettant de *fixer* les placements
    - `fluidRow()` : tout ce qui est dedans dans la même ligne (tant que cela rentre, *i.e.* largeur totale inférieure à 12)
    - `column()` : tout ce qui est dedans est dans la même colonne (dont on peut définir la largeur)

---
## Partie de gauche - fonction `dashboardSidebar()`

- Contenu de la partie gauche (par défaut) du tableau de bord
- Dédiée principalement aux différents choix que pourra faire l'utilisateur
- Possibilité d'avoir plusieurs pages, regroupant des graphiques et/ou boîtes
    - Définition d'un menu (avec plusieurs items) dans la partie de gauche
    - Contenu de chaque item de ce menu dans la principale

--

```r
dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Vue 1", tabName = "vue1", icon = icon("dashboard")),
    menuItem(text = "Vue 2", tabName = "vue2", icon = icon("list-ol")),
    menuItem(text = "Le prof", icon = icon("chalkboard-user"), href = "http://fxjollois.github.io")
  )
)
```

--

- `sidebarMenu()` : définition du menu
- `menuItem()` : un item, qui peut être un lien vers une page de l'appli ou un URL
    - `text` : texte à afficher
    - `tabName` : nom de la page qu'on veut afficher lorsqu'on clique dessus
    - `icon` : icône à afficher à gauche 
    - `href` : URL si on veut pointer dessus
    - Possibilité de mettre un badge à droite (avec une couleur, du genre "new")
    

---
## Intégration des items dans la partie principale

- `tabItems()` : ensemble des pages
- `tabItem()` : définition du contenu d'une page
- Lien entre les deux (menu et contenu) grâce à `tabName`

--

```r
dashboardBody(
  tabItems(
    tabItem(
      tabName = "vue1",
      box( ... ),
      infoBox( ... ),
      valueBox( ... ),
      tabBox( ... )
    ),
    tabItem(
      tabName = "vue2",
      box(title = "Infos 1", width = 4, "un graphique"),
      box(title = "Infos 2", width = 4, "un tableau de valeur"),
      box(title = "Infos 3", width = 4, "un autre graphique")
    )
  )
)
```

---
class: section, middle, center
## 1, 2 ou 3 fichiers pour une appli ?

---
## Pourquoi se poser la question ?

### Utilisation d'un seul fichier 

- Tout dans un fichier `app.R` (nom obligatoire pour déploiement par la suite)
- Maîtrise de ce qui a dans l'appli
- Passage *rapide* entre interface et calculs

--

### Quels inconvénients ?

- Si l'appli devient trop *grosse*, difficulté de se retrouver dans le code
- Parties interface et calculs souvent fait par 2 personnes (voire équipes) différentes

---
## Quelles solutions ?

--

### Séparation en 2 fichiers

- Interface dans un fichier `ui.R` (nom obligatoire)
- Calculs dans un fichier `server.R` (idem, et dans le même répertoire bien évidemment)
- Séparation des deux tâches
    - Interface souvent réfléchie en amont : on place ce qu'on veut voir et comment
    - Calculs faits ensuite : on y met le contenu

--

### Pourquoi pas aller jusqu'à 3 fichiers ?

- Parties communes aux deux fichiers à placer dans un fichier `global.R` 
- Appels aux librairies communes
- Chargement de données 
- Création de variables et/ou fonctions

---
class: section, middle, center
## Elèments HTML intégrables dans une appli shiny

---
## Intégration de balises HTML

### Possibilité de créer des élèments classiques en HTML 

via la librairie [`htmltools`](https://rstudio.github.io/htmltools/)

- `h1()`, `h2()`... : titre de niveau 1 à 6
- `p()` : paragraphe de texte simple
- `strong()`, `em()`, `pre()`, `code()`... 
- Paramètres de type `id`, `class`... possibles

--

### Pour aller plus loin : `tag()`

Fonction créant un élèment HTML avec une balise passée en paramètre

- Premier paramètre : tag HTML à ajouter (tous les tags possibles, même définis)
- Autres paramètres : 
    - Contenu de la balise
    - Possibilité de définir des paramètres sur ce tag (`id`, `class`, `style`...)

---
## Intégration de style CSS

- Dans la création de l'élèment

```r
p("ERROR", style = "background-color: red; color: white;")
```

--

- Ajout dans l'en-tête

```r
tags$head(tags$style("p { background-color: red; color: white; }"))
```

--

- Appel à un fichier CSS

```r
tags$link(rel = "stylesheet", type = "text/css", href = "www/style.css")
```

---
class: section, middle, center
## UI réactive

Comment créer des élèments de l'interface dynamiquement ?

---
## Première option

Utilisation des fonctions `uiOutput()` et `renderUI()`

--

- `uiOutput()` prend comme seul paramètre le nom de la variable à affecter dans la partie serveur

--

- `renderUI()` contient le ou les élèments à intégrer dans l'UI
    - Si un seul élèment, on ne renvoie que celui-ci
    - Si on veut plusieurs élèments, il faut les intégrer dans une `list()`

---
## Dans le code

.left-column50[

#### Côté UI

```r
uiOutput("interface")
```

]

--

.right-column50[
#### Côté serveur

##### Si un seul élèment
```r
output$interface <- renderUI({
    # divers calculs si besoin
    p(class = "bg-danger", "ERROR")
})
```

##### Si plusieurs élèments

```r
output$interface <- renderUI({
    # divers calculs si besoin
    list(
        p(class = "bg-primary", "OK"),
        selectInput("choix", 1:5),
        textOutput("texte")
    )
})
```

]

---
## Deuxième option

Utilisation de la fonction `conditionalPanel()`

- Premier paramètre `condition` : définition de la condition (simple) déterminant si la suite doit être affichée ou non
- Autres paramètres : élèments à afficher si la condition est respectée

--

```r
conditionalPanel(
    condition = "input.choix == 'Fichier texte'",
    fileInput("fichier")
)
```

---
## Deuxième option

Possibilité d'utiliser aussi des élèments calculés dans le serveur

--

#### Côté UI

```r
conditionalPanel(
    condition = "ouput$nb > 100",
    checkboxInput("headonly", "Afficher uniquement les 100 premières lignes"))
)
```
--

#### Côté serveur

```r
 output$nb <- reactive({
    nrow(donnees())
  })
  
  # Pour envoyer la valeur de nb au navigateur
  outputOptions(output, "nb", suspendWhenHidden = FALSE)  
```

---
## Troisième option

Insertion et suppression d'élèments, lors d'évènements (type `actionButton()`)

- `selector` : paramètre permettant de sélectionner l'élèment HTML dans lequel l'élèment va être insérer (sélecteur CSS usuel)
- `ui` : élèment à insérer

--

#### Insertion avec `insertUI()`

```r
insertUI(
    selector = '#contenant',
    ui = p("Elément inséré", id = "identifiant")
)
```

--

#### Suppression avec `removeUI()`

```r
removeUI(
    selector = "#identifiant"
)
```