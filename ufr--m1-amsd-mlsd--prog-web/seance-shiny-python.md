---
layout: slides
---

class: middle, center, inverse, title
# Programmation Web

## Master AMSD/MLSD

### Shiny - sous Python

---
## Présentation

Module [**`shiny`**](https://shiny.posit.co/py/) développé sous Python

Si vous voulez tester en direct : <https://shinylive.io/py/examples/#basic-app>

### Intérêts

- Python très utilisé dans tout ce qui est Machine Learning / Data Science

- Possibilité de développer des serveurs web entièrement en Python

- Développé par la même équipe que **R Studio**, **Shiny** R, **tidyverse**...

---
## "Concurrence"

### [**`streamlit`**](https://streamlit.io/)

- Très rapide pour développer une application
- Redémarre toute l'application à chaque interaction de l'utilisateur
- Plutôt orienté petite application très simple


### [**`shiny`**]() sous R

- Quelques différences de syntaxe
- Quelques différences de noms de fonction

---
## 2 façons de développer une application

### `express`

- Proche de `streamlit`
- Rapide à mettre en oeuvre
- Délicat à utiliser si appli complexe

### `core`

- Proche de `shiny` sous R
- Un peu plus long de developpement au début
- Parfaitement capable de gérer des applis complexes
- Ecriture en fichiers multiples possibles (UI et serveur séparés par exemple)

---
## 2 façons de développer une application

### `express`

- Un seul fichier de code interprété séquentiellement
- Placement des inputs et définition complète des outputs là où on veut les voir apparaître
- Mélange de la partie UI et de la partie serveur

### `core`

- Définition de l'UI d'une part, et du serveur par ailleurs
- Dans l'UI, placement des outputs, et définition de ceux-ci dans le serveur
- Séparation des deux pour plus de lisibilité

---
## Mise en oeuvre idéale

1. Création d'un répertoire dédié à l'applciation

1. Création d'un environnement virtuel
```{bash}
python3 -m venv .venv
```

1. Activation de l'environnement virtuel
```{bash}
source .venv/bin/activate
```
        
1. Installation du package `shiny` (et des autres utilisés)

1. Ecriture du code, et lancement de l'application
```{bash}
shiny run --reload --launch-browser app_dir/app.py
```

---
## Différence principale R / Python

- Les `xxxInput()` de R deviennent des `ui.input_xxx()` dans Python

- les `renderXxx()` de R deviennent des `@render.xxx` dans Python
    - avec définition d'une fonction ensuite, qui retourne un objet de type `xxx`

### Exemple basique (ici avec `express`)

```{python}
from shiny.express import input, render, ui

ui.input_slider("val", "Slider label", min=0, max=100, value=50)

@render.text
def slider_val():
    return f"Slider value: {input.val()}"
```

NB : le nom de la fonction `slider_val()` n'est en aucun cas important

---
## Même exemple en version `core`

- Ajout de `ui.output_xxx()` pour faire le lien entre UI et serveur
    - il faut donc faire attention aux noms utilisés, contrairement à la version  `express`

```{python}
from shiny import App, render, ui

app_ui = ui.page_fixed(
    ui.input_slider("val", "Slider label", min=0, max=100, value=50),
    ui.output_text("txt")
)

def server(input, output, session):
    @render.text
    def txt():
        return f"Slider value: {input.val()}"

app = App(app_ui, server)
```

NB : il est par contre ici important de nommer la fonction `txt()`

---
## Composants

### Inputs

- Liste détaillée : <https://shiny.posit.co/py/components/#inputs>
- Glboalement identique à la version R

### Outputs

- Liste détaillée : <https://shiny.posit.co/py/components/#outputs>
- Quasi identique à la version R (avec plus de graphiques)

### Extensions

- Liste présente pour Python : <https://github.com/nanxstats/awesome-shiny-extensions?tab=readme-ov-file#shiny-for-python>
- En développement connstant donc à vérifier régulièrement

---
## Organisation des éléments

<https://shiny.posit.co/py/layouts/>

- Rendu parfois différent entre R et Python

- Notion de page de navigation
    - `ui.page_navbar()`

- Idem, notion de page de *contrôle* (sur le côté) 
    - `ui.page_sidebar()` et `ui.sidebar()`
    - le reste dans la partie principale

- Notion de bloc d'onglets
    - `ui.navset_xxx()` et `ui.nav_panel()`
    - `xxx` : choix de représentation des zones de choix de l'onglet affiché


---
## Par rapport à ce qu'on a vu en R

### `shinydashboard` 

- Tout ce qui était intéressant a été totalement intégré à `shiny`
- Que ce soit en Python ou en R finalement
    
### UI réactive

- `@render.ui` permet de retourner tout élément d'UI (simple ou multiples avec une `list`)
- `ui.panel_conditional()` pour remplacer `conditionalPanel()`
- `ui.insert_ui()` pour insérer (et `ui.remove_ui()` pour supprimer)
- `ui.update_xxx()` pour mettre à jour des inputs dans la partie serveur

---
## Affichage d'une table

2 options en *natif*

- *Data Grid*, avec `ui.output_data_frame()` et `render.DataGrid()` (à retourner dans la fonction)
    - `@render.data_frame` à placer avant la fonction
    - Rendu paramétrable (taille en particulier)
    - Sélection des lignes, tri voir édition par l'utilisateur possibles
    - Ajout de filtres pour chaque colonne
    - Style possible mais pas en fonction des valeurs présentes
    

- *Data Table*, avec `ui.output_data_frame()` et `@render.DataTable()`
    - Fonctionnement quasi identique à *Data Grid*

---
## Utilisation du package `itables`

- Module [`itables`](https://mwouts.github.io/itables/quick_start.html) : *implémentation* de `DataTables` JS en Python

- Utilisable dans un notebook, une application streamlit et donc aussi shiny

- en mode `express` :

```{python}
from shinywidgets import render_widget
from itables.widget import ITable

@render_widget
def my_table():
    return ITable(data)
```

- en mode `core`, utilisation de `output_widget()` de `shinywidgets`

- Possibilité de faire les mêmes personnalisation qu'en R

---
## Graphisme en python : `plotnine`

- Module [`plotnine`](https://plotnine.org/) : portage de `ggplot2` en `python`

- Fonction `ggplot()` créé un objet qu'on peut renvoyer dans un `@render.plot`

- Même fonctionne que sous R globalement

- Plus de thèmes pré-définis

- Pas de `coord_polar()`, donc pas de diagramme circulaire a priori

- Encore en développement donc à suivre de près

---
## Carte Leaflet : ipyleaflet

- Module [`ipyleaflet`](https://github.com/jupyter-widgets/ipyleaflet)

- Utilisable dans un notebook et une application shiny

- Exemple direct en shiny : <https://shinylive.io/py/examples/#map>

- Intégration avec `shinywidgets` (`output_widget()` pour l'UI et `render_widget` pour le serveur)

- Même fonctionne que sous R globalement (ajout de marqueurs, de formes basées sur des GeoJSON...)




