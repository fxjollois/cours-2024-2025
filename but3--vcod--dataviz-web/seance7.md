# Séance 7 - Compléments `streamlit`

Créer un répertoire
Lancer VS Code
Ouvrir le répertoire créé
Créer un fichier `app.py`
Créer un environnement virtuel
Activer l'environnement virtuel
Installer les packages : streamlit, pandas


## Affichage d'une carte simple

import folium
from streamlit_folium import st_folium

m = folium.Map(location = centre, zoom_start=12)
st_folium(m, width=725)

## Récupération de la position de clic

st_data = st_folium(m, width=725)
st_data

## Ajout de marqueurs

centre = [48.866667, 2.333333]
m = folium.Map(location = centre, zoom_start=12)
folium.Marker(centre, popup = "Centre de Paris", tooltip = "Paris centre").add_to(m)
folium.Marker([48.8489968, 2.3125954], popup = "IUT Paris-Rives de Seine", tooltip = "IUT").add_to(m)

st_data = st_folium(m, width=725)
st_data

## Ajout de bcp de marqueurs

centre = [48.866667, 2.333333]
m = folium.Map(location = centre, zoom_start=12)
marker_cluster = MarkerCluster().add_to(m)
for index, row in df.iterrows() :
  folium.Marker(
      location = [row['latitude'], row['longitude']]
  ).add_to(marker_cluster)

st_data = st_folium(m, width=725)
