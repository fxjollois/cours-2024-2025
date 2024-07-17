# SAE Collecte automatisée de données web

<!--
- 10h de TP
- 6 heures de suivi
- Pas de soutenances
Base SIRENE à compléter par
- Coordonnées géographiques
- Informations sur le web via Google Maps
-->

A partir des données de la [base SIRENE](https://www.data.gouv.fr/fr/datasets/base-sirene-des-entreprises-et-de-leurs-etablissements-siren-siret/) (et plus particulièrement le fichier `StockEtablissement`), vous devez compléter les informations par :

- les coordonnées géographiques via l'[API Adresse](https://adresse.data.gouv.fr/api-doc/adresse) ([guide](https://guides.etalab.gouv.fr/apis-geo/1-api-adresse.html#les-donnees-d-adresses))
- les informations obtenues via une recherche sur [Google Maps](https://www.google.com/maps/search/), via du web-scraping.

## A PRENDRE EN CONSIDERATION

- Fichier de départ très lourd (**6,84 Go**) donc à ne pas charger en une fois !
    - Développer le code sur 50 ou 100 lignes (pas forcément les premières)
    - [Fichier avec les 1000 premières lignes](StockEtablissement_utf8_1000.csv)
- Appel à l'API Adresse à modérer (limite de 50 requêtes par seconde et par IP pour le géocodage simple via l’API Adresse - tous les ordinateurs de l'IUT ont la même adresse IP en sortie)
    - Utilisation de `time.sleep(1)` (ne pas oublier `import time`) pour retarder d'une seconde ce qui suit
- Rendu au format `zip`, contenant un fichier de code (`.ipynb`) et un court rapport expliquant la démarche et les problèmes rencontrés, à déposer sur cette adresse : 

<https://cloud.parisdescartes.fr/index.php/s/BsdJWfD7rnGdtnr>

## Pseudo-algo à prévoir

Voila le pseudo-algo à prévoir

```
N <- Nombre de lignes du fichier StockEtablissement - 1
P <- Taille des pas de lecture (100 par exemple)
i = 1
Tant Que i < N Faire
    Lire les P prochaines lignes
    Pour chaque siret Faire
        Chercher la localisation geographique
        Chercher les informations compléments sur Google Maps
        Ajouter ces informations au DataFrame
        Pause
    Fin Pour
    i <- i + P
    Ecrire les lignes dans le fichier (Faire attention si c'est la première fois)
Fin Tant Que
```

## Séances

- [Premiers éléments de collecte de données sur le web](seance1)
- [Interrogation de l'API Adresse par fichier `CSV`](seance2)
