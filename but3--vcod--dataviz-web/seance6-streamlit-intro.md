# Séance 6 - Introduction à `streamlit`

VS Code

- Créer new folder

- Créer un fichier et copier
import streamlit
 
streamlit.write("""
# Production scientifique mondiale
Voici un tableau de bord sur la **production scientifique mondiale**
""")
 
- Créer un environnement

- dans le terminal, installer streamlit
pip install streamlit

- dans le terminal, écrire
streamlit run app.py

- Télécharger le fichier scimagojr.csv (https://fxjollois.github.io/donnees/scimagojr/scimagojr.csv) dans le répertoire de app.py

- Ajouter le code suivant 
import pandas

data = pandas.read_csv("scimagojr.csv")
streamlit.write(data.query("Year == 2021").head(10))

- Modifier pour supprimer l'index
streamlit.dataframe(data.query("Year == 2021").head(10), hide_index = True)

- Ajout d'un sélection de l'année
annee = streamlit.slider("Année", min(data["Year"]), max(data["Year"]), max(data["Year"]))

streamlit.dataframe(data.query("Year == @annee").head(10), hide_index = True)

- ajout du choix de la taille du TOP
taille = streamlit.radio("Taille", [3, 5, 10, 20], 1)

streamlit.dataframe(data.query("Year == @annee").head(taille), hide_index = True)

- en horizontal
horizontal = True

- choix des régions
regions = streamlit.multiselect("Régions", set(data["Region"]))

if (regions):
    streamlit.dataframe(data.query("Year == @annee & Region in @regions").head(taille), hide_index = True)
else:
    streamlit.dataframe(data.query("Year == @annee").head(taille), hide_index = True)

- choix TOP / FLOP
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

- un peu de mise en page

col1, col2 = streamlit.columns(2)

with col1:
    annee = streamlit.slider("Année", min(data["Year"]), max(data["Year"]), max(data["Year"]))
    taille = streamlit.radio("Taille", [3, 5, 10, 20], 1, horizontal = True)

with col2:
    regions = streamlit.multiselect("Régions", set(data["Region"]))
    flop = streamlit.checkbox("FLOP")
    
- Ajout d'un titre aoprès le tableau

msg = "TOP"
temp = data.query("Year == @annee")
if (regions):
    temp = temp.query("Region in @regions")
if (flop):
    temp = temp.iloc[::-1]
    msg = "FLOP"

streamlit.dataframe(temp.head(taille), hide_index = True)
streamlit.caption(msg + " des pays des régions sélectionnées (monde si aucune).")

- Représentation de l'évolution des rangs des payx du TOP10
streamlit.header("Evolution des rangs des pays tu TOP10", divider = True)

streamlit.line_chart(data.query("Rank <= 10"), x = "Year", y = "Rank", color = "Country")

- Amélioration du graphique en utilisant plotly
import plotly.express as px

fig = px.line(data.query("Rank <= 10"), x = "Year", y = "Rank", color = "Country", markers = True)
streamlit.plotly_chart(fig)

- Et encore plus amélioré

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

- Quelques élèments de texte

streamlit.??

write() -> pour intégrer qqch dans l'appli (résultat dépendant de ce qui est mis en paramètre)
text() -> pur texte
markdown() -> explicitement du markdown
title() -< titre de niveau 1
header() -> titre de niveau 2 (avec une ligne en dessous avec divider = True)
subheader() -> niveau 3
caption() -> titre d'une figure ou d'un tableau (plutôt à placer en dessous)
code() -< du code
divider() -> ligne de séparation

dans le texte : https://docs.streamlit.io/develop/api-reference/text/st.markdown
- des emojis possibles ":emoji:" -> https://share.streamlit.io/streamlit/emoji-shortcodes
- des icones avec ":material/nom_icone:" -> https://fonts.google.com/icons?icon.set=Material+Symbols&icon.style=Rounded
- de la couleur ":couleur[texte à colorier]" ou ":couleur-background[texte à surligner donc]"

Voici un :red[**tableau de bord**] sur la :green-background[production scientifique mondiale] :material/School: :sunglasses:


- Espace à gauche pour paramètres

with streamlit.sidebar:
    annee = streamlit.slider("Année", min(data["Year"]), max(data["Year"]), max(data["Year"]))
    taille = streamlit.radio("Taille", [3, 5, 10, 20], 1, horizontal = True)
    regions = streamlit.multiselect("Régions", set(data["Region"]))
    flop = streamlit.checkbox("FLOP")

- Avec onglets

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

- Configuration globale

streamlit.set_page_config(
    page_title="Production scientifique mondiale | Séance 6",
    page_icon=":student:",
    layout="wide"
)

- gestion des sélections (et plus généralements des évènements)

--- d'un dataframe

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
    

--- d'un diagramme en bar plotly

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



