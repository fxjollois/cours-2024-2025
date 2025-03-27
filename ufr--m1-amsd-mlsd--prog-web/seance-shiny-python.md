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

