# Séance 6 - Introduction à `streamlit`

Nous allons voir l'utilisation du package [`streamlit`](https://streamlit.io/), équivalent Python de `shiny` pour R. Pour réaliser notre application, nous allons utiliser un environnement de développement, de type VS Code (utilisé ici) ou Spyder.

## Préparation de l'environnement de développement

Nous utilisons donc ici l'outil [VS Code](https://code.visualstudio.com/), très utilisé actuellement. Suivez les étapes suivantes pour mettre en place les élèments nous permettant de créer, développer et tester notre application.

- Créer un nouveau répertoire dans l'explorateur Windows (dans votre espace personnel par exemple)
- Dans VS Code, cliquer sur *File*, puis sur *Open Folder*
- Choississez le répertoire que vous venez de créer
- Créer un nouveau fichier en (bien choisir **Python File** en haut) :
    - Soit cliquant sur *New File* dans la fenêtre centrale
    - Soit allant sur *File* puis *New File...*
- Copier le code suivant dans le fichier

```python
import streamlit
 
streamlit.write("""
# Production scientifique mondiale
Voici un tableau de bord sur la **production scientifique mondiale**
""")
```

Sauvegarder ensuite le fichier, en l'appelant `app.py` par exemple. Il n'est normalement pas possible de l'exécuter directement car nous n'avons pas installé la librairie `streamlit`. Et pour développer, l'idéal est de créer un [environnement Python](https://docs.python.org/fr/3/tutorial/venv.html).

<!-- https://python.doctor/page-virtualenv-python-environnement-virtuel -->

Nous allons le faire directement dans VS Code, en suivant les étapes suivantes :

- Lancer la palette de commande (qui permet d'exécuter certaines opérations dans VS Code) en cliquant sur *View* puis *Command Palette*
- Chercher la commande *Python: Create environnement* (en écrivant la commande, il y a une sélection automatique des commandes listées)
- Cliquer ensuite sur *Venv*, puis choisir l'interpréteur par défaut

Un nouvel environnement est créé, visible car le dossier `.venv` est créé dans le répertoire de travail.

Nous allons maintenant installer la librairie `streamlit` et exécuter notre application pour la première fois.

- Lancer le *Terminal* en cliquant sur *Terminal* puis *New Terminal*
- Installer la librairie avec la commande suivante :

```bash
pip install streamlit
```

- Ensuite, lancer l'appli en exécutant la commande suivante :

```bash
streamlit run app.py
```

> Votre application doit se lancer dans le navigateur par défaut. Par la suite, vous pouvez **uniquement sauvegarder** votre fichier `app.py` (dans VS Code) **et recharger** (`Ctrl+R`) la page de l'appli (dans votre navigateur) à chaque étape pour voir les changements effectués dans votre application.

## Quelques éléments de base

Vous devez d'abord télécharger le fichier [`scimagojr.csv`](https://fxjollois.github.io/donnees/scimagojr/scimagojr.csv) dans le répertoire de votre application.

### Affichage simple d'un dataframe

Ajouter le code suivant à votre application

```python
import pandas

data = pandas.read_csv("scimagojr.csv")
streamlit.write(data.query("Year == 2021").head(10))
```

La fonction `write()` ajoute l'élément dans l'application, et réagit en fonction de l'élèment passé en paramètre. 

### Affichage plus spécifique

La fonction `dataframe()` est elle dédiée spécifiquement à l'affichage d'un dataframe pandas dans une application. Elle permet donc plus de possibilités.

Dans la suite, on souhaite par exemple supprimer l'index

```python
streamlit.dataframe(data.query("Year == 2021").head(10), hide_index = True)
```

### Ajout d'un slider (sélection d'une valeur quantitative discrète)

En ajoutant le code suivant, on créé un outil de sélection de l'année

```python
annee = streamlit.slider("Année", min(data["Year"]), max(data["Year"]), max(data["Year"]))

streamlit.dataframe(data.query("Year == @annee").head(10), hide_index = True)
```

### Ajout de boutons radio (sélection d'une modalité parmi plusieurs)

Ici, on ajoute un choix de la taille du TOP (entre les valeurs 3, 5, 10 et 20)

```python
taille = streamlit.radio("Taille", [3, 5, 10, 20], 1)

streamlit.dataframe(data.query("Year == @annee").head(taille), hide_index = True)
```

Si on souhaite avoir les boutons sur une ligne, on peut ajouter l'option `horizontal = True` à la fonction `radio()`

### Ajout d'un sélecteur multiple

Pour le choix des régions, on veut laisser la possibilité d'en sélectionner plusieurs. Nous utilisons la fonction `multiselect()`. On doit gérer la possibilité qu'aucune sélection ne soit faite, en testant le résultat de la sélection. Si celui-ci n'est pas vide (ce que fait la condition du `if`), il y a bien une sélection. Sinon, on affiche toutes les régions. 

```python
regions = streamlit.multiselect("Régions", set(data["Region"]))

if (regions):
    streamlit.dataframe(data.query("Year == @annee & Region in @regions").head(taille), hide_index = True)
else:
    streamlit.dataframe(data.query("Year == @annee").head(taille), hide_index = True)
```

### Ajout d'une checkbox

On veut pouvoir alterner entre TOP (meillleurs) et FLOP (plus mauvais). Le plus simple est d'utiliser une checkbox. 

A cette étape, il est préférable de ré-écrire le code pour le rendre plus lisible et que les opérations soient faites correctement.

```python
data = pandas.read_csv("scimagojr.csv")

annee = streamlit.slider("Année", min(data["Year"]), max(data["Year"]), max(data["Year"]))
taille = streamlit.radio("Taille", [3, 5, 10, 20], 1, horizontal = True)
regions = streamlit.multiselect("Régions", set(data["Region"]))
flop = streamlit.checkbox("FLOP")

temp = data.query("Year == @annee")
if (regions):
    temp = temp.query("Region in @regions")
if (flop):
    temp = temp.iloc[::-1]

streamlit.dataframe(temp.head(taille), hide_index = True)
```

### Un peu de mise en page en colonnes

On peut créer un système de colonnes pour répartir les sélecteurs par exemple. Ici, on créé deux colonnes, qu'on utilise pour les positionner autrement.

```python
col1, col2 = streamlit.columns(2)

with col1:
    annee = streamlit.slider("Année", min(data["Year"]), max(data["Year"]), max(data["Year"]))
    taille = streamlit.radio("Taille", [3, 5, 10, 20], 1, horizontal = True)

with col2:
    regions = streamlit.multiselect("Régions", set(data["Region"]))
    flop = streamlit.checkbox("FLOP")
```

### Ajout d'un titre 

Après le tableau (ou après une figure), il est d'usage de mettre un titre, permettant de spécifier certaines informations (par exemple). Pour ajouter un tel titre (avec l'indication de TOP ou FLOP), on peut modifier le code comme ci-dessous :

```python
msg = "TOP"
temp = data.query("Year == @annee")
if (regions):
    temp = temp.query("Region in @regions")
if (flop):
    temp = temp.iloc[::-1]
    msg = "FLOP"

streamlit.dataframe(temp.head(taille), hide_index = True)
streamlit.caption(msg + " des pays des régions sélectionnées (monde si aucune).")
```

## Création d'un graphique

### De base

La librairie `streamlit` permet de faire un certain nombre de graphiques. On peut par exemple utiliser la fonction `line_chart()` pour voir l'évolution de la position des pays dans le TOP10 tout au long de la période.

```python
streamlit.line_chart(data.query("Rank <= 10"), x = "Year", y = "Rank", color = "Country")
```

### Avec `plotly`

La librairie `plotly`, en plus d'être accessible en JS, l'est aussi en Python. En particulier, le sous-module `express` permet de réaliser des graphiques simplement.

```python
import plotly.express as px

fig = px.line(data.query("Rank <= 10"), x = "Year", y = "Rank", color = "Country", markers = True)
streamlit.plotly_chart(fig)
```

### Et encore plus amélioré

Si on veut pousser plus loin la création de ce graphique, on doit complexifier grandement le code.

```python
import plotly.graph_objects as go
fig = go.Figure()
for pays in set(data["Country"]):
    temp_pays = data.query("Country == @pays")
    temp_pays["rang"] = [e if e <= 10 else None for e in temp_pays["Rank"]]
    if any(temp_pays["rang"]):
        fig.add_trace(go.Scatter(
            x = temp_pays["Year"],
            y = temp_pays["rang"],
            mode = "lines+markers",
            name = pays
        ))
        temp_pays_fin = temp_pays.query("rang > 0").tail(1)
        ancreY = "middle"
        if list(temp_pays_fin["Year"])[0] < max(data["Year"]):
            ancreY = "top"
        fig.add_annotation(
            x = list(temp_pays_fin["Year"])[0], y = list(temp_pays_fin["rang"])[0],
            text = pays, showarrow = False, xanchor = "left", yanchor = ancreY, xshift = 2) 
fig.update_yaxes(range = [10.5,0.5])
fig.update_layout(showlegend = False)
streamlit.plotly_chart(fig)
```

## Quelques élèments de texte

On dispose de plusieurs fonctions permettant d'écrire du texte et de le structurer :

- `write()` : pour intégrer qqch dans l'appli (résultat dépendant de ce qui est mis en paramètre)
- `text()` : pur texte
- `markdown()` : explicitement du markdown
- `title()` : titre de niveau 1
- `header()` : titre de niveau 2 (avec une ligne en dessous avec divider = True)
- `subheader()` : niveau 3
- `caption()` : titre d'une figure ou d'un tableau (plutôt à placer en dessous)
- `code()` : du code
- `divider()` : ligne de séparation

Dans le texte écrit en [Markdown](https://docs.streamlit.io/develop/api-reference/text/st.markdown), on dispose aussi de différents éléments :

- des emojis possibles au format `":emoji:"` 
    - Liste des émojis disponible ici <https://share.streamlit.io/streamlit/emoji-shortcodes>
- des icones Google Fonts au format `":material/nom_icone:"` 
    - Liste disponible sur ce lien <https://fonts.google.com/icons?icon.set=Material+Symbols&icon.style=Rounded>
- de la couleur au format `":couleur[texte à colorier]"` (le texte) ou `":couleur-background[texte à surligner donc]"` (le fond)
    - Liste des couleurs usuels HTML

Par exemple, ajouter ce texte dans l'application :

```python
Voici un :red[**tableau de bord**] sur la :green-background[production scientifique mondiale] :material/School: :sunglasses:
```

## Structuration globale de l'application

### Espace à gauche pour paramètres

```python
with streamlit.sidebar:
    annee = streamlit.slider("Année", min(data["Year"]), max(data["Year"]), max(data["Year"]))
    taille = streamlit.radio("Taille", [3, 5, 10, 20], 1, horizontal = True)
    regions = streamlit.multiselect("Régions", set(data["Region"]))
    flop = streamlit.checkbox("FLOP")
```

### Système d'onglets

```python
onglet1, onglet2 = streamlit.tabs(["TOP/FLOP", "Evolution TOP10"])

with onglet1:
    streamlit.header("TOP/FLOP de la production par année", divider = True)
    streamlit.dataframe(temp.head(taille), hide_index = True)
    streamlit.caption(msg + " des pays des régions sélectionnées (monde si aucune).")

with onglet2:
    streamlit.header("Evolution des rangs des pays du TOP10", divider = True)
    import plotly.express as px
    fig = px.line(data.query("Rank <= 10"), x = "Year", y = "Rank", color = "Country", markers = True)
    streamlit.plotly_chart(fig)
```

### Configuration globale

```python
streamlit.set_page_config(
    page_title="Production scientifique mondiale | Séance 6",
    page_icon=":student:",
    layout="wide"
)
```

## Gestion des sélections (et plus généralements des évènements)

### Dans un dataframe

```
streamlit.set_page_config(layout="wide")

data = pandas.read_csv("scimagojr.csv")
top10 = data.query("Year == 2021").head(10)

col1, col2 = streamlit.columns(2)

liste_pays = []

with col1:
    selection = streamlit.dataframe(top10, hide_index = True, selection_mode = "multi-row", on_select = "rerun")
    streamlit.write(selection)
    streamlit.write(selection["selection"]["rows"])
    if (selection["selection"]["rows"]):
        streamlit.write(top10.iloc[selection["selection"]["rows"]])
        liste_pays = list(top10.iloc[selection["selection"]["rows"]]["Country"])
        streamlit.write(liste_pays)

with col2:
    if (liste_pays):
        fig = px.line(data.query("Rank <= 10 & Country in @liste_pays"), x = "Year", y = "Rank", color = "Country", markers = True)
    else:
        fig = px.line(data.query("Rank <= 10"), x = "Year", y = "Rank", color = "Country", markers = True)
    streamlit.plotly_chart(fig)
```

### Dans un diagramme en bar `plotly`

```python
streamlit.set_page_config(layout="wide")

data = pandas.read_csv("scimagojr.csv").query("Year == 2021").sort_values(by = "H index", ascending = False).head(20)

col1, col2 = streamlit.columns(2)

with col1:
    fig = px.bar(
        data.iloc[::-1],
        y = "Country",
        x = "H index"
    )
    selection = streamlit.plotly_chart(fig, on_select = "rerun", selection_mode = "points")
    streamlit.write(selection)

with col2:
    temp = data.filter(["Country", "Region", "H index", "Documents"])
    if (selection["selection"]["points"]):
        indice_pays = 19 - selection["selection"]["points"][0]["point_index"]
        temp = temp.style.applymap(lambda _: "background-color: lightblue", subset=(temp.index[indice_pays],))
    streamlit.dataframe(temp, hide_index = True, height = 750, use_container_width = True)
```


