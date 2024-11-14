# Web-scraping avec Python

- Inspiré par cette page : <https://outscraper.com/how-to-scrape-google-maps-with-python-and-selenium/>
- Installation à faire auparavant :
    - Packages [`selenium`](https://selenium-python.readthedocs.io/api.html#locate-elements-by) et [`bs4`](https://www.crummy.com/software/BeautifulSoup) (BeautifulSoup) pour Python
    - Exécutable [`chromedriver`](https://chromedriver.chromium.org/downloads) (selon votre OS)

## Première étape : configurer le navigateur 

Vous devez placer `chromedriver` dans le même répertoire que votre notebook

```python
from selenium import webdriver

driver = webdriver.Chrome()
```

### Création de l'URL à récupérer

```python
base_url = "https://www.google.com/maps/search/"
place_info = "IUT+paris+rives+de+seine"
comp_url = "/@48.8489968,2.3125954,12z"

url = base_url + place_info + comp_url
url
```

## Deuxième étape : récupération du contenu HTML

- Lors de l'exécution de ce code, une fenêtre va s'ouvrir dans laquelle vous devrez cliquer (a priori sur "Tout accepter")
- **NE PAS FERMER CETTE FENETRE !**

```python
driver.get(url)
```

- Lancer le code suivant pour effectivement récupérer le contenu désiré

```python
html = driver.page_source
```

## Troisième étape : recherche de ce qui nous intéresse (ici la partie Informations)

```python
from bs4 import BeautifulSoup

soup = BeautifulSoup(html)
results = soup.select("div[aria-label*='Informations']")
results
```

- Si on cherche s'il y a un site web 

```python
results = soup.select("a[aria-label*='Site Web']")
results
```

Pour avoir exactement l'adresse, on récupère le texte du premier résultat obtenu précédemment

```python
results[0].text
```

Mais on peut aussi vouloir récupérer le lien web (dans `href`)

```python
results[0]["href"]
```

## Dernière étape : une fois qu'on a récupéré tout ce qu'on souhaite, on ferme correctement le navigateur

```python
driver.close()
```
