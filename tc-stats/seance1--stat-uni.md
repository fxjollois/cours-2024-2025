---
layout: slides
---

class: title, inverse, center, middle

# Rappel de Statistique
## FX Jollois
### BUT TC - 2ème année

---

# Qu'est-ce que la statistique ?

- Ensemble de méthodes permettant de décrire et d'analyser des observations (communément appelées **données** de nos jours)

- Utilisé maintenant dans tous les secteurs d'activités
  - Economie et finance : marketing, sondages...
  - Industrie : fiabilité, contrôle qualité...
  - Santé : recherche médicale, gestion des hôpitaux...
  - Environnement : prévisions climatiques et météorologiques, pollution...
  - Web : réseaux, publicité...
  - ...

- Essor important avec le développement des outils informatiques et du web

---
  
## Définitions de base
  
- **Population** : ensemble d'entités (personnes, objets, \ldots) étudiées
- **Individu** (ou *unité statistique*) : entité étudiée
- **Variable** : caractéristique étudiée sur chaque individu
- **Observation** : mesure 
- **Série statistique** : série d'observations recueillies sur les individus
- **Tableau de données** : stockage de la série statistique
  - Individus croisant des variables 
  - Chaque ligne représente un individu
  - Chaque colonne représente une variable (ou attribut)
  - C'est ce qu'on fait classiquement dans un tableur de type Excel

---

## Type de variables
  
### Variable quantitative
  
- Caractéristiques numériques : opérations de type somme ayant un sens

### Continue
  
- Mesurable
- Ex : taille, poids, durée...

### Discrète
  
- Dénombrable ou mesurable en espace fini
- Ex : âge, quantité en stock...

---

## Type de variables
  
### Variable qualitative
  
- Caractéristiques non numériques : opérations de type somme n'ayant pas de sens
- Valeurs possibles : **Modalités** (ou catégories)

### Nominale

- Modalités n'ayant pas de lien entre elles (Ex : couleur des yeux, sexe...)
- Cas particulier *Binaire* : 2 valeurs possibles uniquement (Ex : oui/non, présence/absence...)

### Ordinale 

- Modalités devant être triées dans un ordre spécifique (Ex : mois, sentiment...)


---

## Transformation de variable
  
### Quantitative en qualitative
  
- Courant de transformer une variable **quantitative** en variable **qualitative ordinale**
- Ex : Catégorie d'âge, Nombre d'enfants du foyer, ...

- Différents problèmes se posent
- Combien de modalités (*intervalles* ici) ? 
  - Taille identique des intervalles ou variable (*amplitude*) ?
  - Seuils des intervalles ?
  
  
---

## Transformation de variable
  
### Standardisation ou normalisation d'une variable quantitative
  
- Obligatoire pour l'utilisation de certaines méthodes statistiques

- 2 opérations sont réalisées :
  - Centrage : on retire la moyenne à chaque valeur
  - Réduction : on divise par la variance
$$
  x_{norm} = \frac{x - \bar{x}}{\sigma^2}
$$


---

## Premier problème : décrire les données

On parle de **Statistique descriptive** ou **exploratoire**

### Objectifs 

- Résumer l'information contenue dans les données
- Faire ressortir des éléments intéressants
- Poser des hypothèses sur des phénomènes potentiellement existant dans les données

### Outils
  
- Description numérique (moyenne, occurrences, corrélation...)
- Description graphique (histogramme, diagramme en barres, nuage de points...)


---

class: inverse, middle, center

# Variable quantitative

---

## Variable quantitative
  
- Moyenne \\(\bar{x}\\)
$$
  \bar{x} = \frac{1}{n} \sum_{i=1}^n x_i
$$
  
- Variance (et écart-type \\(\sigma(x)\\))
$$
  \sigma^2(x) = \frac{1}{n} \sum_{i=1}^n (x_i - \bar{x})^2
$$
  
---

## Variable quantitative
  
- Médiane \\(med(x)\\) : valeur permettant de séparer les observations ordonnées prises par \\(x\\) en 2 groupes de même taille
$$
  med(x) = m | P(x \le m) = .5
$$
  - si \\(n\\) est impair : \\(med(x) = x_{(n + 1) / 2}\\)
  - si \\(n\\) est pair : \\(med(x) = \frac{x_{n/2} + x_{n/2 + 1}}{2}\\)
  
- Quantile \\(q_p(x)\\) : valeur pour laquelle une proportion \\(p\\) d'observations sont inférieures
$$
  q_p(x) = q | P(x \le q) = p
$$
  - Quartiles \\(Q1\\) et \\(Q3\\) : respectivement 25% et 75% (utilisés dans les boîtes à moustaches)
  - Quantiles usuels : \\(.01\\) (1%), \\(.1\\) (10%), \\(.9\\) (90%), \\(.99\\) (99%)\\)

---

## Variable quantitative
  
### Histogramme 

<svg id="monsvg" width="730" height="244"><g transform="translate(40,10)"><g transform="translate(0,204)" fill="none" font-size="10" font-family="sans-serif" text-anchor="middle"><path class="domain" stroke="currentColor" d="M0.5,6V0.5H660.5V6"></path><g class="tick" opacity="1" transform="translate(0.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">0</text></g><g class="tick" opacity="1" transform="translate(60.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">5</text></g><g class="tick" opacity="1" transform="translate(120.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">10</text></g><g class="tick" opacity="1" transform="translate(180.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">15</text></g><g class="tick" opacity="1" transform="translate(240.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">20</text></g><g class="tick" opacity="1" transform="translate(300.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">25</text></g><g class="tick" opacity="1" transform="translate(360.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">30</text></g><g class="tick" opacity="1" transform="translate(420.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">35</text></g><g class="tick" opacity="1" transform="translate(480.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">40</text></g><g class="tick" opacity="1" transform="translate(540.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">45</text></g><g class="tick" opacity="1" transform="translate(600.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">50</text></g><g class="tick" opacity="1" transform="translate(660.5,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">55</text></g></g><g fill="none" font-size="10" font-family="sans-serif" text-anchor="end"><path class="domain" stroke="currentColor" d="M-6,204.5H0.5V0.5H-6"></path><g class="tick" opacity="1" transform="translate(0,204.5)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">0</text></g><g class="tick" opacity="1" transform="translate(0,189.27611940298507)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">5</text></g><g class="tick" opacity="1" transform="translate(0,174.05223880597015)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">10</text></g><g class="tick" opacity="1" transform="translate(0,158.82835820895522)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">15</text></g><g class="tick" opacity="1" transform="translate(0,143.6044776119403)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">20</text></g><g class="tick" opacity="1" transform="translate(0,128.3805970149254)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">25</text></g><g class="tick" opacity="1" transform="translate(0,113.15671641791046)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">30</text></g><g class="tick" opacity="1" transform="translate(0,97.93283582089553)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">35</text></g><g class="tick" opacity="1" transform="translate(0,82.70895522388061)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">40</text></g><g class="tick" opacity="1" transform="translate(0,67.48507462686567)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">45</text></g><g class="tick" opacity="1" transform="translate(0,52.261194029850735)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">50</text></g><g class="tick" opacity="1" transform="translate(0,37.037313432835816)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">55</text></g><g class="tick" opacity="1" transform="translate(0,21.81343283582089)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">60</text></g><g class="tick" opacity="1" transform="translate(0,6.589552238805965)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">65</text></g></g><rect x="1" y="200.955223880597" width="59" height="3.0447761194029965" style="fill: steelblue;"></rect><rect x="61" y="155.28358208955223" width="59" height="48.716417910447774" style="fill: steelblue;"></rect><rect x="121" y="12.17910447761193" width="59" height="191.82089552238807" style="fill: steelblue;"></rect><rect x="181" y="0" width="59" height="204" style="fill: steelblue;"></rect><rect x="241" y="79.16417910447761" width="59" height="124.83582089552239" style="fill: steelblue;"></rect><rect x="301" y="130.92537313432837" width="59" height="73.07462686567163" style="fill: steelblue;"></rect><rect x="361" y="155.28358208955223" width="59" height="48.716417910447774" style="fill: steelblue;"></rect><rect x="421" y="185.73134328358208" width="59" height="18.268656716417922" style="fill: steelblue;"></rect><rect x="481" y="188.77611940298507" width="59" height="15.223880597014926" style="fill: steelblue;"></rect><rect x="541" y="191.82089552238807" width="59" height="12.17910447761193" style="fill: steelblue;"></rect><rect x="601" y="200.955223880597" width="59" height="3.0447761194029965" style="fill: steelblue;"></rect></g></svg>

- Nombre de "barres" pouvant influer sur l'analyse

---

## Variable quantitative
  
### Boîte à moustaches

<svg id="monsvg" width="730" height="244"><g transform="translate(40,10)"><g transform="translate(0,204)" fill="none" font-size="10" font-family="sans-serif" text-anchor="middle"><path class="domain" stroke="currentColor" d="M0.5,6V0.5H660.5V6"></path><g class="tick" opacity="1" transform="translate(27.182027649769587,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">5</text></g><g class="tick" opacity="1" transform="translate(96.30645161290322,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">10</text></g><g class="tick" opacity="1" transform="translate(165.43087557603684,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">15</text></g><g class="tick" opacity="1" transform="translate(234.5552995391705,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">20</text></g><g class="tick" opacity="1" transform="translate(303.6797235023041,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">25</text></g><g class="tick" opacity="1" transform="translate(372.8041474654378,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">30</text></g><g class="tick" opacity="1" transform="translate(441.9285714285714,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">35</text></g><g class="tick" opacity="1" transform="translate(511.052995391705,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">40</text></g><g class="tick" opacity="1" transform="translate(580.1774193548387,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">45</text></g><g class="tick" opacity="1" transform="translate(649.3018433179724,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">50</text></g></g><line x1="0" x2="514.6658986175114" y1="112" y2="112" stroke="black"></line><rect x="142.08525345622118" y="61" width="149.03225806451613" height="102" stroke="black" style="fill: steelblue;"></rect><line x1="0" x2="0" y1="61" y2="163" stroke="black"></line><line x1="203.57142857142858" x2="203.57142857142858" y1="61" y2="163" stroke="black"></line><line x1="514.6658986175114" x2="514.6658986175114" y1="61" y2="163" stroke="black"></line><circle cx="624.8847926267281" cy="112" r="2.04"></circle><circle cx="569.9999999999999" cy="112" r="2.04"></circle><circle cx="527.0046082949308" cy="112" r="2.04"></circle><circle cx="623.5023041474655" cy="112" r="2.04"></circle><circle cx="660" cy="112" r="2.04"></circle><circle cx="584.516129032258" cy="112" r="2.04"></circle><circle cx="518.1566820276497" cy="112" r="2.04"></circle><circle cx="553.5483870967741" cy="112" r="2.04"></circle><circle cx="625.7142857142857" cy="112" r="2.04"></circle></g></svg>

- Moustache au min et max OU à 1.5 fois la distance interquartile (\\(Q1-Q3\\)) des quantiles \\(Q1\\) et \\(Q3\\)

---

## Variable quantitative
  
### A quoi doit-on faire attention ?

- Si divergence moyenne et médiane, valeurs extrêmes présentes
  - Déséquilibre de la répartition des valeurs 
- Présence de valeurs aberrantes (nommés **outliers**)

---
class: inverse, middle, center

# Variable qualitative

---

## Variable qualitative
  
### Nominale
  
- Modalités de la variable \\(x\\) : \\(m_j\\) (avec \\(j=1,...,p\\))
- Effectif (ou occurrences) d'une modalité \\(n_j\\) : nombre d'individus ayant la modalité \\(m_j\\)
  - Fréquence d'une modalité \\(f_j\\)
$$
    f_j = \frac{n_j}{n}
$$

---

## Variable qualitative
  
### Ordinale

Effectif cumulé \\(n_j^{cum}\\) : nombre d'individus ayant une modalité entre \\(m_1\\) et \\(m_j\\) inclus

- N'a de sens que s'il y a un ordre naturel entre les modalités
- Fréquence cumulée : somme des fréquences des modalités entre \\(m_1\\) et \\(m_j\\)
$$
    n_j^{cum} = \sum_{k=1}^j n_k 
$$
$$
    f_j^{cum} = \sum_{k=1}^j f_k
$$
  
---

## Variable qualitative
  
### Diagramme en barres

<svg id="monsvg" width="730" height="244"><g transform="translate(40,10)"><g transform="translate(0,204)" fill="none" font-size="10" font-family="sans-serif" text-anchor="middle"><path class="domain" stroke="currentColor" d="M0.5,6V0.5H660.5V6"></path><g class="tick" opacity="1" transform="translate(110.00000000000003,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">Fri</text></g><g class="tick" opacity="1" transform="translate(256.6666666666667,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">Sat</text></g><g class="tick" opacity="1" transform="translate(403.33333333333337,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">Sun</text></g><g class="tick" opacity="1" transform="translate(550,0)"><line stroke="currentColor" y2="6"></line><text fill="currentColor" y="9" dy="0.71em">Thur</text></g></g><g fill="none" font-size="10" font-family="sans-serif" text-anchor="end"><path class="domain" stroke="currentColor" d="M-6,204.5H0.5V0.5H-6"></path><g class="tick" opacity="1" transform="translate(0,204.5)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">0</text></g><g class="tick" opacity="1" transform="translate(0,184.95977011494253)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">10</text></g><g class="tick" opacity="1" transform="translate(0,165.41954022988506)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">20</text></g><g class="tick" opacity="1" transform="translate(0,145.8793103448276)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">30</text></g><g class="tick" opacity="1" transform="translate(0,126.33908045977012)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">40</text></g><g class="tick" opacity="1" transform="translate(0,106.79885057471263)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">50</text></g><g class="tick" opacity="1" transform="translate(0,87.25862068965516)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">60</text></g><g class="tick" opacity="1" transform="translate(0,67.71839080459768)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">70</text></g><g class="tick" opacity="1" transform="translate(0,48.178160919540225)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">80</text></g><g class="tick" opacity="1" transform="translate(0,28.637931034482747)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">90</text></g><g class="tick" opacity="1" transform="translate(0,9.09770114942527)"><line stroke="currentColor" x2="-6"></line><text fill="currentColor" x="-9" dy="0.32em">100</text></g></g><rect x="73.33333333333337" width="73.33333333333333" y="166.8735632183908" height="37.126436781609186" fill="steelblue"></rect><rect x="220.00000000000003" width="73.33333333333333" y="33.99999999999999" height="170" fill="steelblue"></rect><rect x="366.6666666666667" width="73.33333333333333" y="55.49425287356321" height="148.5057471264368" fill="steelblue"></rect><rect x="513.3333333333334" width="73.33333333333333" y="82.85057471264368" height="121.14942528735632" fill="steelblue"></rect><text x="110.00000000000003" y="161.8735632183908" text-anchor="middle" fill="steelblue">19</text><text x="256.6666666666667" y="28.999999999999993" text-anchor="middle" fill="steelblue">87</text><text x="403.33333333333337" y="50.49425287356321" text-anchor="middle" fill="steelblue">76</text><text x="550" y="77.85057471264368" text-anchor="middle" fill="steelblue">62</text></g></svg>

- Attention à l'ordre des barres si celui-ci a une importance

---

## Variable qualitative

### Diagrame circulaire

<svg id="monsvg" width="730" height="244"><g transform="translate(370,112)"><g class="arc"><path d="M5.633375276077825e-15,-92A92,92,0,0,1,43.23786035851346,-81.20644944595035L0,0Z" style="fill: rgb(27, 158, 119);"></path><text transform="translate(24.704349639496744,-98.96309973363554)" text-anchor="start">Fri</text></g><g class="arc"><path d="M43.23786035851346,-81.20644944595035A92,92,0,0,1,36.841759319916534,84.30115521280443L0,0Z" style="fill: rgb(217, 95, 2);"></path><text transform="translate(101.92391854999119,3.938886570436401)" text-anchor="start">Sat</text></g><g class="arc"><path d="M36.841759319916534,84.30115521280443A92,92,0,0,1,-91.9694990113168,2.3688080562589824L0,0Z" style="fill: rgb(117, 112, 179);"></path><text transform="translate(-54.74301178714321,86.06510710196497)" text-anchor="end">Sun</text></g><g class="arc"><path d="M-91.9694990113168,2.3688080562589824A92,92,0,0,1,-1.6900125828233473e-14,-92L0,0Z" style="fill: rgb(231, 41, 138);"></path><text transform="translate(-73.04752320806814,-71.19030378616702)" text-anchor="end">Thur</text></g></g></svg>

- N'a de sens que si la somme doit bien faire 100% (à éviter si réponse multiple possible par exemple)

---

## Variable qualitative

### A quoi doit-on faire attention ?
  
- Différence entre les proportions 
- Si modalités trop peu fréquentes, regroupement de modalités à envisager
- Pas de 3D pour le diagramme circulaire !!
- Si plus de 5 modalités, privilégier le diagramme en barres
