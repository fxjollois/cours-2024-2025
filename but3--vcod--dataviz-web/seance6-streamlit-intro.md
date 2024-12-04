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




