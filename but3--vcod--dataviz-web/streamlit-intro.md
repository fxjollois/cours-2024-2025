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



