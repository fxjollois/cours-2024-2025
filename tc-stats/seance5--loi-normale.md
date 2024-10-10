# Loi Normale

Reprendre fichier `tips.csv` :

- [Format Excel](tips.xlsx)
- [Format Libre Office](tips.ods)

## 1ère étape :

- Calculer moyenne et écart-type de total_bill (colonne `A:A`) dans les cellules `M2` et `M3` (par exemple)
- Calculer les bornes d'un intervalle basé sur la moyenne *+* ou *-* 2 fois l'écart-type, en écrivant dans les cellules les formules suivantes : 
    - `M5` : `=M2-2*M3` 
    - `M6` : `=M2+2*M3`
- Creér une colonne indiquant si la valeur de `total_bill` est dans cet intervalle (en indiquant *OUI* et *NON* par exemple), en écrivant dans la cellule `H2` la formule 
```
=SI(A2>$M$5;SI(A2<$M$6;"OUI";"NON");"NON")
```
  - Dupliquer la formule pour toutes les lignes
- Calculer la répartition des réponses de la colonne `H`
  - Avec un tableau croisé dynamique par exemple

> On trouve qu'environ 95% des valeurs sont dans l'intervalle et donc 5% en dehors

## 2ème étape :

- Dans une nouvelle feuille, créer une liste de valeur allant de -5 à 5 par pas de *0.25* à partir de la cellule `A2` (et en-dessous)
- Ecrire *Densité* et *Répartition* sur la première ligne
- Ecrire dans `B2` la formule `=LOI.NORMALE(A2;0;1;0)`
    - Ceci calcule la densité de probabilité d'une loi normale *N(0,1)* pour la valeur dans `A2`
- Ecrire dans `C2` la formule `=LOI.NORMALE(A2;0;1;1)`
    - Ici, nous avons la fonction de répartition de la même loi normale
- Dupliquer les formules pour toutes les valeurs de la colonne `A`
- Sélectionner les 3 colonnes et ajouter un graphique
    - Choisir *XY (dispersion)* avec que les lignes
    
> Nous retrouvons la forme de la loi normale vue en cours

## 3ème étape :

- Repérer la ligne 14, pour laquelle la valeur dans la colonne `A` est égale à *-2*
    - La valeur de la colonne `C` est la valeur de la fonction de répartition, *i.e.* *P(X < -2)*
    - C'est-à-dire la probabilité qu'une valeur issue d'une loi normale *N(0;1)* soit inférieure à 2
    - On a donc environ 2,2% de chance qu'une valeur soit inférieure à -2
- Idem ligne 30 correspondant à *2*
    - On a donc environ 97,7% de chance qu'une valeur soit inféreure à 2

> On peut en conclure que j'ai 95,5% environ de chance d'avoir une valeur comprise entre -2 et 2, pour une loi normale *N(0,1)*

## 4ème étape :

- Dans une nouvelle feuille, créer une liste de valeurs : *0.025*, *0.05*, *0.10*, *0.9*, *0.95* et *0.975*
- Ecrire Valeur
- Dans `B2`, écrire la formule `=LOI.NORMALE.INVERSE(A2;0;1)`
    - Ceci calcule la valeur *x* pour laquelle *P(X < x) = 0.025*
- Dupliquer les formules pour toutes les valeurs de la colonne `A`
    - Il est normal que cela ne fonctionne pas pour 0 et 1
- Repérer la ligne 3, pour laquelle on a *0.025*
    - Ceci indique qu'il y a *2.5* % de chance d'avoir une valeur inférieure à *1.96* pour une loi normale *N(0,1)*
- Idem ligne 7, pour laquelle on a *0.975*
    - nous avons la même valeur, *1.96*

> Ceci implique qu'il y a 95% de chances d'avoir une valeur entre -1,96 et 1,96 pour une loi normale *N(0,1)*


## 5ème étape

- Dans la feuille avec les données `tips`, écrire dans `I2` la formule suivante `=(A2-moyenne)/ecart-type`
- Calculer le nombre de valeurs de cette colonne comprise entre *-1.96* et *1.96*
    - on retrouve la même répartition

Si *X* suit une loi normale *N(m,\sigma)*, il est possible de passer à une v.a. *Y* de loi normale *N(0,1)* en réalisant deux opérations : enlever la moyenne et diviser par l'écart-type

> *Y = \frac{X - m}{\sigma}*

## A faire

- Calculer les bornes de l'intervalle comprenant 95% des valeurs de la colonne `tip` (`B`) 
  - Regarder la répartition des valeurs dans cet intervalle et en-dehors
- Faire de même pour la variable `size`. Est-ce pertinent ?
