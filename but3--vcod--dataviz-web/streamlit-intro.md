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

