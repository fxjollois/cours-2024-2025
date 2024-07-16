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
  
- Moyenne $\bar{x}$
$$
  \bar{x} = \frac{1}{n} \sum_{i=1}^n x_i
$$
  
- Variance (et écart-type $\sigma(x)$)
$$
  \sigma^2(x) = \frac{1}{n} \sum_{i=1}^n (x_i - \bar{x})^2
$$
  
---

## Variable quantitative
  
- Médiane $med(x)$ : valeur permettant de séparer les observations ordonnées prises par $x$ en 2 groupes de même taille
$$
  med(x) = m | P(x \le m) = .5
$$
  - si $n$ est impair : $med(x) = x_{(n + 1) / 2}$
  - si $n$ est pair : $med(x) = \frac{x_{n/2} + x_{n/2 + 1}}{2}$
  
- Quantile $q_p(x)$ : valeur pour laquelle une proportion $p$ d'observations sont inférieures
$$
  q_p(x) = q | P(x \le q) = p
$$
  - Quartiles $Q1$ et $Q3$ : respectivement 25% et 75% (utilisés dans les boîtes à moustaches)
  - Quantiles usuels : $.01$ (1%), $.1$ (10%), $.9$ (90%) et $.99$ (99%)

---

## Variable quantitative
  
### Représentation graphique 
  
Histogramme 

<?xml version="1.0"?>
<svg xmlns="http://www.w3.org/2000/svg" width="361.35" height="289.08" viewBox="0,0,361.35,289.08">
<desc>R SVG Plot!</desc>
<rect width="100%" height="100%" style="fill:#FFFFFF"/>
<line x1="29.12" y1="264.08" x2="340.56" y2="264.08" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="29.12" y1="264.08" x2="29.12" y2="268.25" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="81.03" y1="264.08" x2="81.03" y2="268.25" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="132.94" y1="264.08" x2="132.94" y2="268.25" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="184.84" y1="264.08" x2="184.84" y2="268.25" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="236.75" y1="264.08" x2="236.75" y2="268.25" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="288.65" y1="264.08" x2="288.65" y2="268.25" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="340.56" y1="264.08" x2="340.56" y2="268.25" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<text transform="translate(24.96,279.91) "  style="font-size:10" >-3</text>
<text transform="translate(76.45,279.91) "  style="font-size:10" >-2</text>
<text transform="translate(128.35,279.91) "  style="font-size:10" >-1</text>
<text transform="translate(182.09,279.91) "  style="font-size:10" >0</text>
<text transform="translate(234.00,279.91) "  style="font-size:10" >1</text>
<text transform="translate(285.90,279.91) "  style="font-size:10" >2</text>
<text transform="translate(337.81,279.91) "  style="font-size:10" >3</text>
<line x1="16.67" y1="264.08" x2="16.67" y2="35.73" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="16.67" y1="264.08" x2="12.50" y2="264.08" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="16.67" y1="218.41" x2="12.50" y2="218.41" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="16.67" y1="172.74" x2="12.50" y2="172.74" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="16.67" y1="127.07" x2="12.50" y2="127.07" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="16.67" y1="81.40" x2="12.50" y2="81.40" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<line x1="16.67" y1="35.73" x2="12.50" y2="35.73" style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
<text transform="translate(9.17,266.83)  rotate(-90)"  style="font-size:10" >0</text>
<text transform="translate(9.17,221.16)  rotate(-90)"  style="font-size:10" >5</text>
<text transform="translate(9.17,178.24)  rotate(-90)"  style="font-size:10" >10</text>
<text transform="translate(9.17,132.57)  rotate(-90)"  style="font-size:10" >15</text>
<text transform="translate(9.17,86.90)  rotate(-90)"  style="font-size:10" >20</text>
<text transform="translate(9.17,41.23)  rotate(-90)"  style="font-size:10" >25</text>
<polygon points="29.12 , 264.08 29.12 , 254.95 55.08 , 254.95 55.08 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="55.08 , 264.08 55.08 , 245.81 81.03 , 245.81 81.03 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="81.03 , 264.08 81.03 , 218.41 106.98 , 218.41 106.98 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="106.98 , 264.08 106.98 , 154.47 132.94 , 154.47 132.94 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="132.94 , 264.08 132.94 , 172.74 158.89 , 172.74 158.89 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="158.89 , 264.08 158.89 , 90.54 184.84 , 90.54 184.84 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="184.84 , 264.08 184.84 , 17.47 210.79 , 17.47 210.79 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="210.79 , 264.08 210.79 , 145.34 236.75 , 145.34 236.75 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="236.75 , 264.08 236.75 , 209.28 262.70 , 209.28 262.70 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="262.70 , 264.08 262.70 , 227.54 288.65 , 227.54 288.65 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="288.65 , 264.08 288.65 , 264.08 314.61 , 264.08 314.61 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polygon points="314.61 , 264.08 314.61 , 254.95 340.56 , 254.95 340.56 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#ADD8E6;stroke-opacity:1.000000;fill-opacity:1.000000" />
<polyline points="16.67 , 264.08 353.02 , 264.08 353.02 , 8.33 16.67 , 8.33 16.67 , 264.08 " style="stroke-width:1;stroke:#000000;fill:#000000;stroke-opacity:1.000000;fill-opacity:0.000000"/>
</svg>

[Par Jkv — Travail personnel, Domaine public](https://commons.wikimedia.org/w/index.php?curid=1886663)


---

## Variable quantitative
  
### Représentation graphique 
  
Boîte à moustaches

![](https://upload.wikimedia.org/wikipedia/commons/9/99/Boite_a_moustaches.png)

- Moustache au min et au max OU à 1.5 fois la distance interquartile ($Q1-Q3$) des quantiles $Q1$ et $Q3$

[Par HB sur Wikipédia français — Transféré de fr.wikipedia à Commons par Korrigan utilisant CommonsHelper., Domaine public](https://commons.wikimedia.org/w/index.php?curid=4861114)

---

## Variable quantitative

A quoi doit-on faire attention :

- Si divergence moyenne et médiane, valeurs extrêmes présentes
  - Déséquilibre de la répartition des valeurs 
- Présence de valeurs aberrantes (nommés **outliers**)

---

## Variable qualitative
  
### Nominale
  
- Modalités de la variable $x$ : $m_j$ (avec $j=1,...,p$)
- Effectif (ou occurrences) d'une modalité $n_j$ : nombre d'individus ayant la modalité $m_j$
  - Fréquence d'une modalité $f_j$
$$
f_j = \frac{n_j}{n}
$$

### Ordinale

- Effectif cumulé $n_j^{cum}$ : nombre d'individus ayant une modalité entre $n_1$ et $n_j$
  - Fréquence cumulée

$$n_j^{cum} = \sum_{k=1}^j n_k \mbox{ and } f_j^{cum} = \sum_{k=1}^j f_k$$
  
---

## Variable qualitative
  
Exemple : Jour de la semaine (*ordinale* de plus)

### Représentation numérique

```{r ql-num}
tab = table(data$day, useNA = "ifany")
tib = tibble(
  Modalités = labels(tab)[[1]],
  Effectifs = tab,
  "Eff. cum." = cumsum(tab),
  Fréquences = as.numeric(prop.table(tab)),
  "Fréq. cum." = cumsum(prop.table(tab))
)
kable(tib, digits = 2) %>%
  kable_styling(position = "center")
```

### A regarder aussi :
  
- Différence entre les proportions 
- Si modalités peu fréquentes, regroupement de modalités à envisager

---

## Variable qualitative
  
### Représentation graphique
  
Diagramme en barres

```{r ql-graph-bar}
ggplot(data, aes(day, fill = day)) +
  geom_bar(show.legend = FALSE) +
  theme_minimal() +
  theme(text = element_text(size = 25))
```

---

## Quantitative vs quantitative
  
- Covariance
$$
  cov(x,y) = \frac{1}{n} \sum_{i=1}^n (x_i - \bar{x}) (y_i - \bar{y})
$$
  - Problème : non bornée et donc non exploitable

- Coefficient de corrélation linéaire (de *Pearson*)
$$
  \rho(x,y) = \frac{cov(x,y)}{\sigma^2(x) \sigma^2(y)}
$$
  - Covariance des variables normalisées
- Valeurs comprises entre -1 et 1
  - $0$ : pas de lien linéaire (autre type de lien possible)
  - $1$ : lien positif fort (si $x$ augmente, $y$ augmente)
  - $-1$ : lien négatif fort (si $x$ augmente, $y$ diminue)

---

## Quantitative vs quantitative
  
Exemple : Montant de la table et Pourboire

### Représentation numérique

```{r qtqt-num}
x = data$total_bill
y = data$tip
tib = tibble(
  Statistique = c("Covariance", "Corrélation"),
  Valeur = sapply(c(cov, cor), function(f) { f(x, y) })
)
kable(tib, digits = 2) %>%
  kable_styling(position = "center")
```

### A regarder aussi :
  
- Présence d'**outliers** avec un comportement atypique

---

## Quantitative vs quantitative

### Représentation graphique 
Nuage de points

```{r qtqt-graph}
ggplot(data, aes(total_bill, tip)) + 
  geom_point(color = "steelblue") + theme_minimal() +
  theme(text = element_text(size = 25))
```

---

## Anscombe

La visualisation est aussi importante (voire plus) que la représentation numérique !

Entre ces quatre séries :

- même moyenne et même variance pour $x$ et $y$
- même coefficient de corrélation entre les deux

```{r anscombe-tab}
a = lapply(1:4, function (i) { 
  anscombe %>% 
    select(ends_with(as.character(i))) %>% 
    rename_with(function (n) { substr(n, 1, 1)}) %>%
    mutate(id = i)
  })
c = sapply(a, function(df) {
  res = c(m_x = mean(df$x), m_y = mean(df$y),
          s_x = sd(df$x), s_y = sd(df$y),
          cov = cov(df$x, df$y), cor = cor(df$x, df$y))
})
rownames(c) = c("Moyenne(x)", "Moyenne(y)", "Ecart-type(x)", "Ecart-type(y)", "Covariance", "Corrélation")
colnames(c) = 1:4
kable(c, digits = 2) %>%
  kable_styling(position = "center")
```

---

## Anscombe

```{r anscombe-graph}
b = Reduce(rbind, a)
ggplot(b, aes(x, y)) +
  geom_point(size = 4) +
  facet_wrap(~ id) +
  theme_minimal() +
  theme(text = element_text(size = 25))
```

---

## Qualitative vs qualitative

- Table de contingence
  - Croisement des 2 ensembles de modalités, avec le nombre d'individus ayant chaque couple de modalités
- $n_{ij}$ : Nombre d'observations ayant la modalité $i$ pour $x$ et $j$ pour $y$
  - $n_{i.}$ : Effectif marginal (nombre d'observations ayant la modalité $i$ pour $x$)
- $n_{.j}$ : Effectif marginal (nombre d'observations ayant la modalité $j$ pour $y$)

|      | 1 | \ldots | $j$ | \ldots | $\ell$ | Total |
|------|---|--------|-----|--------|--------|-------|
|    1 |
|\ldots|
| $i$  |   |        | $n_{ij}$ |   |        | $n_{i.}$ |
|\ldots|
| $k$  |
|Total |   |        | $n_{.j}$ |   |        | $n_{..}=n$ |

---

## Qualitative vs qualitative

- Profils lignes et colonnes
  - Distribution d'une variable conditionnellement aux modalités de l'autre
  
- Profil ligne
  - Pour une ligne $i$ : $\frac{n_{ij}}{n_{i.}}$
  - Somme des valeurs en lignes = 100%

-Profil colonne
  - Pour une colonne $j$ : $\frac{n_{ij}}{n_{.j}}$
  - Somme des valeurs en colonnes = 100%

---

## Qualitative vs qualitative

Exemple : Jour de la semaine et Présence de fumeur

### Représentation numérique

```{r qlql-num}
mat = table(data$day, data$smoker)
tib = tibble(as.data.frame.matrix(mat) %>% rownames_to_column("color"))
kable(tib) %>%
  kable_styling(position = "center")
```

### A regarder aussi :

- Couple de modalités très peu pris
- Ici aussi, regroupement de modalités à envisager éventuellement

---

## Qualitative vs qualitative

### Représentation graphique 

```{r qtql-graph}
ggplot(data, aes(day, fill = smoker)) +
  geom_bar(position = "dodge", color = "black") +
  scale_fill_brewer(palette = "Dark2") +
  theme_minimal() +
  labs(y = "") +
  theme(text = element_text(size = 25))
```


---

## Qualitative vs qualitative

### Représentation numérique

Profils colonnes ici (sommes en colonnes = 100%)

```{r qlql-num-2}
matcol = prop.table(mat, margin = 2)
tib = tibble(as.data.frame.matrix(matcol) %>% rownames_to_column("color"))
kable(tib, digits = 2) %>%
  kable_styling(position = "center")
```

---

## Qualitative vs qualitative

### Représentation graphique 

Profils colonnes

```{r qtql-graph-2}
ggplot(data, aes(smoker, fill = day)) +
  geom_bar(position = "fill", color = "black") +
  theme_minimal() +
  theme(text = element_text(size = 25))
```

---

## Qualitative vs qualitative

### Représentation numérique

Profils lignes ici (sommes en lignes = 100%)

```{r qlql-num-3}
matlig = prop.table(mat, margin = 1)
tib = tibble(as.data.frame.matrix(matlig) %>% rownames_to_column("color"))
kable(tib, digits = 2) %>%
  kable_styling(position = "center")
```

---

## Qualitative vs qualitative

### Représentation graphique 

Profils lignes

```{r qtql-graph-3}
ggplot(data, aes(day, fill = smoker)) +
  geom_bar(position = "fill", color = "black") +
  scale_fill_brewer(palette = "Dark2") +
  theme_minimal() +
  theme(text = element_text(size = 25))
```


---

## Qualitative vs quantitative

- Soit $Y$ la variable qualitative à $m$ modalités, et $X$ la variable quantitative
- Sous-populations déterminées par les modalités de $Y$
- Indicateurs calculés pour chaque modalité k


$$\bar{x_j} = \frac{1}{n_j} \sum_{i | y_i = j} x_i$$

$$\sigma^2(x_j) = \frac{1}{n_j} \sum {}_{i | y_i = j} (x_i - \bar{x_j})^2$$

---

## Qualitative vs quantitative

Exemple : Montant payé et Jour de la semaine

### Représentation numérique

```{r qlqt-num}
tib = data %>% 
  group_by(day) %>% 
  summarise(Moyenne = mean(total_bill), 
            "Ecart-type" = sd(total_bill), 
            "Médiane" = median(total_bill))
kable(tib, digits = 2) %>%
  kable_styling(position = "center")
```

### A regarder aussi :

- Outliers

---

## Qualitative vs quantitative

### Représentation graphique 
Boîte à moustaches

```{r qlqt-graph}
ggplot(data, aes(day, total_bill, fill = day)) +
  geom_boxplot() +
  #scale_fill_brewer(palette = "Dark2") +
  theme_minimal() +
  theme(text = element_text(size = 25))
```



---

## Deuxième problème : Extrapoler à partir de données

On parle alors de **statistique inférentielle**

### Cadre

- Données issues d'un échantillon d'une population
- Modèle probabiliste sur la population 
- Méthodes d'échantillonnage pour choisir au mieux l'échantillon

### Objectifs 

- Etendre les conclusions faites sur l'échantillon à toute la population
- Valider des hypothèses faites sur la population en analysant l'échantillon

### Outils

- Estimation : approximer des paramètres de la population
- Test : valider les hypothèses
- Modélisation : rechercher des liens entre variables


