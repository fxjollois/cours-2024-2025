---
layout: slides
---

class: middle, center, inverse, title
# Programmation Web

## Master AMSD/MLSD

### Shiny - Widgets HTML

<!--
https://fxjollois.github.io/cours-2018-2019/stid-2afa--prog-r/seance5-bis.html
-->

---
## Widgets HTML

- Extension [htmlwidgets](http://www.htmlwidgets.org/) 

- Intégration possible d'éléments de librairies `JavaScript` dans une application shiny

--

### Packages vus ici

- `DT`: Des tableaux améliorés

- `formattable`: (encore) des tableaux améliorés

- `sparkline` : Des graphiques simples de type [**sparkline**](https://fr.wikipedia.org/wiki/Sparkline) dans un tableau

- `leaflet` : Des cartes

---
class: section, middle, center
## `DT`

---
## `DT`

- Package [`DT`](http://rstudio.github.io/DT/) permettant de générer des tableaux paramétrables

- Meilleure gestion des grandes données

- Présentations plus intéressantes

--

- `datatableOutput()` (ou `DTOutput()`)
    - Nom de la table à utiliser dans la partie serveur
    - Possibilité de régler la largeur et la hauteur de l'affichage dans la page web

--

- `renderDataTable()` (ou `renderDT()`)
    - Data frame à afficher
    - Paramètres pour améliorer l'affichage


---
## Exemple simple

- Affichage de l'ensemble du `data.frame` `txhousing` (présent dans la librairie `ggplot2`)
- Possibilité de tri, de recherche d'une chaîne et de navigation dans la table


```r
library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)

shinyApp(
  ui = dashboardPage(
    dashboardHeader( title = "Test DT" ),
    dashboardSidebar(),
    dashboardBody(
      dataTableOutput("tableau")
    ),
    title = "Test DT",
    skin = "yellow"
  ),
  server = function(input, output) {
    output$tableau <- renderDataTable({
      datatable(txhousing)
    })
  }
)
```

---
## Quelques effets de styles

- Suppression des noms de lignes (avec `rownames = FALSE`)

- Renommage de certaines colonnes (avec `colnames = ...`)

- Ajout d'un titre (avec `caption = ...`)

- Mise en place d'un filtre par colonne (avec `filter = 'top'`)

```r
datatable(txhousing, 
          rownames = FALSE, 
          colnames = c('Ville' = 'city', 
                       'Année' = 'year', 
                       'Mois' = 'month'),
          caption = "Données concernant les ventes immobilières au Texas - 2001-2015",
          filter = 'top')
```

---
## Formatage et couleurs

- Fonctions prédéfinies pour définir un format spécifique pour une ou plusieurs colonnes
    - Couleurs de fonds
    - Type de polices
    - ...

--

### Quelques fonctions usuelles

- `formatCurrency()` : Formatage monétaire pour la colonne `volume`
- `formatDate()` : Formatage de la date 
    - notez l'utilisation de la fonction `date_decimal()` du package `lubridate`
- `formatStyle()` : Formatage d'une colonne
- `styleColorBar()` : Ajout d'une barre en fonction de la valeur dans la colonne `median`


---
### Ajout des librairies utilisées

```r
library(lubridate)
library(dplyr)
```

### Code à placer dans la partie serveur

```r
datatable(txhousing %>% mutate(date = date_decimal(date))) %>%
  formatCurrency("volume") %>%
  formatDate("date", "toLocaleDateString") %>%
  formatStyle(
    'city',  
    color = 'white', 
    backgroundColor = 'slategrey', 
    fontWeight = 'bold') %>%
  formatStyle(
    'median',
    background = styleColorBar(range(txhousing$median, na.rm = TRUE), 'lightblue'),
    backgroundSize = '98% 88%',
    backgroundRepeat = 'no-repeat',
    backgroundPosition = 'center'
  )
```

---
## Exportation des données

- Extension `Buttons` permettant d'ajouter automatiquement des boutons, pour exporter les données 

- Différents formats possibles (`csv`, `excel` et `pdf`)

```r
datatable(
  txhousing, 
  extensions = 'Buttons', 
  options = list(
    dom = 'Bfrtip',
    buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
  )
)
```

---
## Scrolling amélioré

- Présentation des tables larges pas idéal
    - Colonnes pas visible de suite
    - Déplacement pas aisé

- Option `scrollX` permettant de faire un scrolling en largeur
    
- Extension `FixedColumns` permettant de fixer certaines colonnes

```r
datatable(
  txhousing, 
  rownames = FALSE,
  extensions = 'FixedColumns',
  options = list(
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 1, rightColumns = 1)
  )
)
```

---
## Sélection de lignes

Deux variables présentes dans `input` sont disponibles :

- `tableau_rows_current` : liste des lignes du tableau qui sont affichées

- `tableau_rows_selected` : lilste des lignes sélectionnées dans le navigateur

--

.left-column50[
```r
library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
library(ggplot2)

resume = txhousing %>% 
  group_by(city) %>% 
  summarise(volume = sum(volume, na.rm = T), 
            median = median(median, na.rm = T))
```
]

.right-column50[
```r
ui = dashboardPage(
    dashboardHeader(title = "Test DT"),
    dashboardSidebar(),
    dashboardBody(
        dataTableOutput("tableau"),
        plotOutput("graphique")
    ),
    title = "Test DT",
    skin = "yellow"
)
```
]

---
## Sélection de lignes

- Utilisation de ces variables dans la partie serveur

- Mise à jour automatique lorsque l'utilisateur clique sur une ligne

--

```r
server = function(input, output) {
    output$tableau <- renderDataTable({
        datatable(resume)
    })
    
    output$graphique <- renderPlot({
        df = resume %>%
            mutate(affiche = ifelse(row_number() %in% input$tableau_rows_current, "oui", "non"),
                selection = ifelse(row_number() %in% input$tableau_rows_selected, "oui", "non"))
        ggplot(df, aes(median, volume, label = city, color = affiche, size = selection)) +
            geom_point() +
            theme_classic()
    })
}

shinyApp(ui, server)
```

---
class: section, middle, center
## `formattable`

---
## `formattable`

- Package [`formattable`](https://renkun-ken.github.io/formattable/) permettant de générer des tableaux paramétrables

- Présentations plus intéressantes

- Pas spécialement adapté à de grands tableaux

--

- `formattableOutput()` 
    - Nom de la table à utiliser dans la partie serveur

--

- `renderFormattable()` 
    - Data frame à afficher sous la forme d'un `formattable`


---
## Exemple simple

- Affichage des premières lignes du `data.frame` `txhousing` (présent dans la librairie `ggplot2`)


```r
library(shiny)
library(shinydashboard)
library(formattable)
library(ggplot2)

shinyApp(
  ui = dashboardPage(
    dashboardHeader( title = "Test formattable" ),
    dashboardSidebar(),
    dashboardBody(
      formattableOutput("tableau"),
      
    ),
    title = "Test formattable",
    skin = "yellow"
  ),
  server = function(input, output) {
    output$tableau <- renderFormattable({
      formattable(head(txhousing, 10))
    })
  }
)
```

---
## Un peu de formatage 

- Fonctions déjà présentes

- `accounting()` : pour une mise en forme comptable
    - ici, on indique que le séparateur de milliers (`big.mark`) est l'espace

- `currency()` : format monétaire
    - idem, espace comme séparateur de milliers
    - ajout du symbole € (avant le nombre)

- `percent()` : format pourcentage

---
### Avant l'appli

```r
resume = txhousing %>%
  group_by(city) %>%
  summarise(volume = sum(volume, na.rm = TRUE)) %>%
  mutate(volume = accounting(volume, big.mark = " "),
         volumeEuro = currency(volume, symbol = "€", big.mark = " "),
         part = percent(volume / sum(volume, na.rm = TRUE)))
```

### Dans la partie serveur

```r
output$tableau <- renderFormattable({
      formattable(resume)
    })
```

---
## Couleurs du texte en fonction de la valeur de la variable

- `formatter` : Création d'une fonction de formatage de style

- `style` : fonction permettant de définir le style CSS voulu 

### A définir en amont de l'application

```r
format_perf <- formatter(
  "span", 
  style = x ~ style(color = ifelse(x > .20, "green", ifelse(x < .01, "red", "black"))))
```

### Dans la partie serveur

```r
formattable(resume, list(part = format_perf))
```

---
## Couleurs du texte en fonction de la valeur d'une autre variable

- Même fonction, mais changement de la *formule* dans le paramètre `style`

### A définir en amont de l'application

```r
format_vol <- formatter(
  "span", 
  style = ~ style(color = ifelse(part > .20, "green", "black"),
                  "font-weight" = ifelse(part > .20, "bold", NA)))
```

### Dans la partie serveur

```r
formattable(resume, list(part = format_perf, volume = format_vol, volumeEuro = format_vol))
```

---
## Couleurs de fonds en fonction de la valeur de la variable

- `color_tile` : Couleurs de fond en fonction de la variable (choix des couleurs en paramètres)

- `color_bar` : barre de largeurs différentes selon la valeur (valeur max = toute la largeur)

- Attention, des soucis d'affichage peuvent apparaître

### Dans la partie serveur

```r
formattable(
  resume, 
  list(
    volume = format_vol,
    volumeEuro = color_tile("yellow", "darkgreen"),
    part = color_bar("orange")
  )
)
```

---
class: section, middle, center
## `sparkline`

---
## `sparkline`

- Graphiques [**sparkline**](https://fr.wikipedia.org/wiki/Sparkline) introduit par [Tufte](https://www.edwardtufte.com/tufte/)
    - Introduire des petits graphiques dans du texte ou un tableau

- Utilisation du package [`formattable`](https://cran.r-project.org/web/packages/formattable/index.html)
    - code plus complexe pour le package `DT`

--

### Définition de l'affichage d'une cellule par une fonction

.left-column50[
```r
boxCell <- function(x){
  lapply(x, function(xx){
    as.character(as.tags(
      sparkline(xx, type="box",
                chartRangeMin = min(unlist(xx)),
                chartRangeMax = max(unlist(xx)))
    ))
  })
}
```
]
.right-column50[
```r
lineCell <- function(x){
  lapply(x, function(xx){
    as.character(as.tags(
      sparkline(xx, type="line",
                chartRangeMin = min(unlist(xx)),
                chartRangeMax = max(unlist(xx)))
    ))
  })
}
```
]

---

.left-column50[
```r
library(shiny)
library(shinydashboard)
library(sparkline)
library(formattable)
library(dplyr)
library(ggplot2)
library(htmltools)

resume = txhousing %>%
  group_by(city) %>%
  summarise(Volume = sum(volume, na.rm = T), 
            Median = median(median, na.rm = T),
            "Median price" = list(median), 
            "Volume evolution" = list(volume))

```
]
.right-column50[
```r
ui = dashboardPage(
    dashboardHeader(
        title = "Test sparkline"
    ),
    dashboardSidebar(),
    dashboardBody(
        uiOutput("tableau")
    ),
    title = "Test sparkline",
    skin = "yellow"
)
```
]

<div style="clear: left;">&nbsp;</div>

```r
server = function(input, output) {
    output$tableau <- renderUI({
        resume %>%
            formattable(
                formatters = list(area(col = 4) ~ boxCell, area(col = 5) ~ lineCell)
            ) %>%
            formattable::as.htmlwidget() %>%
            tagList() %>%
            attachDependencies(htmlwidgets:::widget_dependencies("sparkline","sparkline")) %>%
            browsable()
    })
}
shinyApp(ui, server)
```


---
class: section, middle, center
## `leaflet`

---
## Carte simple

- Package [`leaflet`](http://rstudio.github.io/leaflet/) pour générer des cartes

- Ajout d'informations dessus

--

.left-column50[
```r
library(shiny)
library(shinydashboard)
library(leaflet)

map = leaflet() %>%
  addTiles() %>%
  setView(lng = -101, lat = 30, zoom = 5) # Texas
```
]
.right-column50[
```r
shinyApp(
  ui = dashboardPage(
    dashboardHeader(
      title = "Test leaflet"
    ),
    dashboardSidebar(),
    dashboardBody(
      leafletOutput("carte")
    ),
    title = "Test leaflet",
    skin = "yellow"
  ),
  server = function(input, output) {
    output$carte <- renderLeaflet({
      map
    })
  }
)
```
]

---
## Carte à partir de données `GeoJSON`

- Format  [`GeoJSON`](http://geojson.org/) : standard pour éléments géographiques
    - Points ou zones (polygones)
    - Réalisation de cartes dites [**choroplèthes**](https://fr.wikipedia.org/wiki/Carte_choropl%C3%A8the)
    
- Sur cette [page](http://catalog.opendata.city/dataset/texas-cities-polygon/resource/15f90106-372f-4128-890b-e31351152e23), 
toutes les villes du Texas (voici le [fichier en question](texas-city.geojson))

- Utilisation du package [`geojsonio`](https://docs.ropensci.org/geojsonio/) pour la lecture du fichier, avec la fonction `geojson_read()`
    - paramètre `what` indiquant que ce sont des données spatial (`"sp"`)

```r
library(geojsonio)

txgeo = geojson_read("texas-city.geojson", what = "sp")
```

---
## Carte à partir de données `GeoJSON`

- Intégration des données GeoJSON lors de l'appel à la fonction `leaflet()`

- `addPolygons()` : ajout des formes contenues dans la variable `txgeo` donc

```r
map = leaflet(txgeo) %>%
  addTiles() %>%
  addPolygons(fillColor = "gray", fillOpacity = .5, color = "red", weight = 1)
```

- Reste du code identique à la première carte créée

---
## Couleurs en fonction d'une variable

- Colorer chaque polygone en fonction d'une variable

- Utilisation des données `txhousing` (de `ggplot2`) pour le calcul de la somme des volumes de ventes

- Jointure nécessaire entre les données géographiques et les données numériques

--

- Objet `txgeo` d'un type un peu particulier et contenant (accès avec `@`)
    - `data` : data frame avec l'identifiant et le nom de la ville
    - `polygons` : liste polygones (coordonnées des points de celui-ci + d'autres informations)
    - `plotOrder` : vecteur avec l'ordre d'affichage des polygones
    - `bbox` : matrice avec limites en longitude et en latitude des formes contenues dans l'objet
    - `proj4string` : référentiel de projection

---

- Idée : intégrer les informations numériques dans le data frame `data` pour que `leaflet` puisse utiliser les variables ajoutées
    - Jointure faite avec `inner_join()` du package `dplyr`

- Ajout d'une pop-up incluant le nom de la ville et la somme des volumes

--

```r
resume = txhousing %>%
  group_by(city) %>%
  summarise(volume = sum(volume, na.rm = TRUE))

txgeo = geojson_read("texas-city.geojson", what = "sp")
txgeo = subset(txgeo, sub(", TX", "", name) %in% unique(txhousing$city))

txgeo@data$city = sub(", TX", "", txgeo@data$name)
txgeo@data = dplyr::left_join(txgeo@data, resume, all.x = TRUE)

pal = colorNumeric("viridis", NULL)
map = leaflet(txgeo) %>%
  addTiles() %>%
  addPolygons(fillColor = ~pal(volume), 
              fillOpacity = .5, 
              color = "red", weight = 1,
              label = ~paste0(city, ": ", formatC(volume, big.mark = ","))) %>%
  addLegend(pal = pal, values = ~volume, opacity = 1.0,
            labFormat = labelFormat(transform = function(x) round(x)))
```



