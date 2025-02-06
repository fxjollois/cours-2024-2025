# Séance 3 : Web-scraping avec Python

Dans cette séance, nous allons voir comment récupérer des informations dans une page web, en récupérant son contenu dans Python. Ici, nous avos choisi de récupérer les informations d'une recherche via *Google Maps* (en particulier un potentiel *site web*). 

Nous ne pouvons pas nous contenter de faire une requête comme précédemment, car beaucoup de serveurs web bloquent les accès de ce type. Pour faire cette opération, nous devons accéder à une page web comme si nous étions un utilisateur classique, en programmant ce qu'on peut appeler un *bot*. On va utiliser deux packages (à installer donc) :

- [`selenium`](https://www.selenium.dev) qui va nous permettre de piloter notre navigateur web ;
- [`bs4`](https://www.crummy.com/software/BeautifulSoup) (BeautifulSoup -- *parser* HTML) qui va nous permettre de récupérer dans un contenu HTML ce qu'on désire.

Pour que `selenium` fonctionne comme ce qui suit, sous Windows, il est nécessaire d'avoir télécharger l'exécutable [`chromedriver`](https://chromedriver.chromium.org) dans le répertoire de travail de Python. Vous pouvez récupérer les versions stables sur [cette page](https://googlechromelabs.github.io/chrome-for-testing/#stable) (copier-coller le lien HTML dans la barre du navigateur pour télécharger le fichier).

## Première étape : configurer le navigateur 

Pour rappel, vous devez placer `chromedriver` dans le même répertoire que votre notebook (et le bon en fonction de votre OS).


```python
from selenium import webdriver

driver = webdriver.Chrome()
```

### Création de l'URL à récupérer

On créé l'URL de la page qu'on souhaite récupérer. Pour faire une recherche dans Google Maps, il est préférable de mettre le nom de l'établissement, ainsi que les coordonnées géographiques de celui-ci.


```python
base_url = "https://www.google.com/maps/search/"
place_info = "IUT+paris+rives+de+seine"
comp_url = "/@48.8489968,2.3125954,12z"

url = base_url + place_info + comp_url
url
```




    'https://www.google.com/maps/search/IUT+paris+rives+de+seine/@48.8489968,2.3125954,12z'




## Deuxième étape : récupération du contenu HTML

Lors de l'exécution de ce code, une instance du navigateur *Chrme* va s'ouvrir, dans laquelle vous devrez cliquer sur *Tout accepter*. Cette fenêtre servira pour accéder aux différentes pages web donc.

> **NE PAS FERMER CETTE FENETRE !**


```python
driver.get(url)
```

Une fois cette fenêtre ouverte, on peut exécuter le code suivant pour effectivement récupérer le contenu désiré.


```python
html = driver.page_source
html
```


## Troisième étape : Recherche de ce qui nous intéresse

Après **analyse d'une page Google Maps**, à faire dans un navigateur, avec l'inspecteur, ce que nous voulons récupérer est contenu dans la partie *Informations*. Plus exactement, dans une `div` dont le paramètre `aria-label` contient la valeur `"Informations"`.


```python
from bs4 import BeautifulSoup

soup = BeautifulSoup(html)
results = soup.select("div[aria-label*='Informations']")
results
```




    [<div aria-label="IUT de Paris - Rives de Seine - Université Paris Cité - Informations" class="m6QErb XiKgde" role="region" style=""><div jslog="39448;" ve-visible="cf"></div><div jslog="39497;" ve-visible="cf"></div><div class="RcCsl fVHpi w4vB1d NOE9ve M0S7ae AG25L"><div class="OyjIsf"></div><button aria-label="Adresse: 143 Av. de Versailles, 75016 Paris " class="CsEnBe" data-item-id="address" data-tooltip="Copier l'adresse" jsaction="pane.wfvdle34;clickmod:pane.wfvdle34;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="36622; track:click; mutable:true;"><div class="AeaXub"><div class="cXHGnc"><span aria-hidden="true" class="google-symbols PHazN" style="font-size: 24px;"></span></div><div class="rogA2c"><div class="Io6YTe fontBodyMedium kR99db fdkmkc">143 Av. de Versailles, 75016 Paris</div><div class="gSkmPd fontBodySmall CuiGbf DshQNd"></div></div></div></button><div class="UCw5gc"><div class="C9yzub"><div class="etWJQ kdfrQc NUqjXc"><button aria-label="Copier l'adresse" class="g88MCb S9kvJb" data-tooltip="Copier l'adresse" data-value="Copier l'adresse" jsaction="pane.wfvdle35;keydown:pane.wfvdle35;mouseover:pane.wfvdle35;mouseout:pane.wfvdle35;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="38087;track:click;mutable:true;"><span class="DVeyrd"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="Cw1rxd google-symbols G47vBd SwaGS" style="font-size: 18px;"></span></span></button></div></div></div></div><div class="OqCZI fontBodyMedium WVXvdc" jslog="36914;metadata:WyIwYWhVS0V3aVgycnZfbnJPS0F4V0pWS1FFSFo0aEtINFE4QmNJQXlnQSJd"><div aria-expanded="false" class="OMl5r hH0dDd jBYmhd" data-hide-tooltip-on-mouse-move="true" jsaction="pane.openhours.wfvdle36.dropdown; keydown:pane.openhours.wfvdle36.dropdown" jslog="14925;track:click,keydown_click;mutable:true;metadata:WyIwYWhVS0V3aVgycnZfbnJPS0F4V0pWS1FFSFo0aEtINFE4QmNJQXlnQSJd" role="button" tabindex="0"><div class="OyjIsf"></div><span aria-label="Horaires" class="LT79uc google-symbols PHazN" role="img" style="font-size: 24px;"></span><div class="MkV9"><div class="o0Svhf"><span class="ZDu9vd"><span><span style="font-weight: 400; color: rgba(25,134,57,1.00);">Ouvert</span><span style="font-weight: 400;"> ⋅ Ferme à 19:00</span></span></span> <span aria-label="Afficher les horaires d'ouverture pendant la semaine" class="puWIL hKrmvd google-symbols OazX1c" role="img" style="font-size: 18px;"></span></div></div></div><div aria-label="jeudi, de 07:45 à 19:00; vendredi, de 07:45 à 19:00; samedi, de 07:45 à 12:30; dimanche, Fermé; lundi, de 07:45 à 19:00; mardi (Réveillon de Noël), de 07:45 à 19:00, Les horaires peuvent être modifiés.; mercredi (Jour de Noël), de 07:45 à 19:00, Les horaires peuvent être modifiés.. Masquer les horaires d'ouverture pendant la semaine" class="t39EBf GUrTXd"><div><table class="eK4R0e fontBodyMedium"><tbody><tr class="y0skZc"><td class="ylH6lf fontTitleSmall"><div>jeudi</div></td><td aria-label="de 07:45 à 19:00" class="mxowUb" role="text"><ul class="fontTitleSmall"><li class="G8aQO">07:45–19:00</li></ul></td><td class="HuudEc"><button aria-label="jeudi, de 07:45 à 19:00, Copier les horaires d'ouverture" class="mWUh3d" data-hide-tooltip-on-mouse-move="true" data-tooltip="Copier les horaires d'ouverture" data-value="jeudi, 07:45–19:00" jsaction="pane.openhours.wfvdle36.copy; focus:pane.focusTooltip; blur:pane.blurTooltip"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="GYnni google-symbols G47vBd" style="font-size: 18px;"></span></button></td></tr><tr class="y0skZc"><td class="ylH6lf"><div>vendredi</div></td><td aria-label="de 07:45 à 19:00" class="mxowUb" role="text"><ul><li class="G8aQO">07:45–19:00</li></ul></td><td class="HuudEc"><button aria-label="vendredi, de 07:45 à 19:00, Copier les horaires d'ouverture" class="mWUh3d" data-hide-tooltip-on-mouse-move="true" data-tooltip="Copier les horaires d'ouverture" data-value="vendredi, 07:45–19:00" jsaction="pane.openhours.wfvdle36.copy; focus:pane.focusTooltip; blur:pane.blurTooltip"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="GYnni google-symbols G47vBd" style="font-size: 18px;"></span></button></td></tr><tr class="y0skZc"><td class="ylH6lf"><div>samedi</div></td><td aria-label="de 07:45 à 12:30" class="mxowUb" role="text"><ul><li class="G8aQO">07:45–12:30</li></ul></td><td class="HuudEc"><button aria-label="samedi, de 07:45 à 12:30, Copier les horaires d'ouverture" class="mWUh3d" data-hide-tooltip-on-mouse-move="true" data-tooltip="Copier les horaires d'ouverture" data-value="samedi, 07:45–12:30" jsaction="pane.openhours.wfvdle36.copy; focus:pane.focusTooltip; blur:pane.blurTooltip"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="GYnni google-symbols G47vBd" style="font-size: 18px;"></span></button></td></tr><tr class="y0skZc"><td class="ylH6lf"><div>dimanche</div></td><td aria-label="Fermé" class="mxowUb" role="text"><ul><li class="G8aQO">Fermé</li></ul></td><td class="HuudEc"><button aria-label="dimanche, Fermé, Copier les horaires d'ouverture" class="mWUh3d" data-hide-tooltip-on-mouse-move="true" data-tooltip="Copier les horaires d'ouverture" data-value="dimanche, Fermé" jsaction="pane.openhours.wfvdle36.copy; focus:pane.focusTooltip; blur:pane.blurTooltip"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="GYnni google-symbols G47vBd" style="font-size: 18px;"></span></button></td></tr><tr class="y0skZc"><td class="ylH6lf"><div>lundi</div></td><td aria-label="de 07:45 à 19:00" class="mxowUb" role="text"><ul><li class="G8aQO">07:45–19:00</li></ul></td><td class="HuudEc"><button aria-label="lundi, de 07:45 à 19:00, Copier les horaires d'ouverture" class="mWUh3d" data-hide-tooltip-on-mouse-move="true" data-tooltip="Copier les horaires d'ouverture" data-value="lundi, 07:45–19:00" jsaction="pane.openhours.wfvdle36.copy; focus:pane.focusTooltip; blur:pane.blurTooltip"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="GYnni google-symbols G47vBd" style="font-size: 18px;"></span></button></td></tr><tr class="y0skZc"><td class="ylH6lf"><div>mardi</div><div class="GfF3rf">(Réveillon de Noël)</div></td><td aria-label="de 07:45 à 19:00, Les horaires peuvent être modifiés." class="mxowUb" role="text"><ul><li class="G8aQO">07:45–19:00</li></ul><div class="GfF3rf"> <span class="zdqHHd">Les horaires peuvent être différents</span></div></td><td class="HuudEc"><button aria-label="mardi (Réveillon de Noël), de 07:45 à 19:00, Les horaires peuvent être modifiés., Copier les horaires d'ouverture" class="mWUh3d" data-hide-tooltip-on-mouse-move="true" data-tooltip="Copier les horaires d'ouverture" data-value="mardi (Réveillon de Noël), 07:45–19:00, Les horaires peuvent être modifiés." jsaction="pane.openhours.wfvdle36.copy; focus:pane.focusTooltip; blur:pane.blurTooltip"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="GYnni google-symbols G47vBd" style="font-size: 18px;"></span></button></td></tr><tr class="y0skZc"><td class="ylH6lf"><div>mercredi</div><div class="GfF3rf">(Jour de Noël)</div></td><td aria-label="de 07:45 à 19:00, Les horaires peuvent être modifiés." class="mxowUb" role="text"><ul><li class="G8aQO">07:45–19:00</li></ul><div class="GfF3rf"> <span class="zdqHHd">Les horaires peuvent être différents</span></div></td><td class="HuudEc"><button aria-label="mercredi (Jour de Noël), de 07:45 à 19:00, Les horaires peuvent être modifiés., Copier les horaires d'ouverture" class="mWUh3d" data-hide-tooltip-on-mouse-move="true" data-tooltip="Copier les horaires d'ouverture" data-value="mercredi (Jour de Noël), 07:45–19:00, Les horaires peuvent être modifiés." jsaction="pane.openhours.wfvdle36.copy; focus:pane.focusTooltip; blur:pane.blurTooltip"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="GYnni google-symbols G47vBd" style="font-size: 18px;"></span></button></td></tr></tbody></table><div class="onOnO"><div class=""><button aria-label="Suggérer une modification des horaires d'ouverture" class="M77dve" jsaction="pane.wfvdle37" jslog="119438;track:click;mutable:true;metadata:WyIwYWhVS0V3aVgycnZfbnJPS0F4V0pWS1FFSFo0aEtINFE4QmNJQXlnQSJd"><div class="BgrMEd cYlvTc VOgY4"><div class="OyjIsf zemfqc"></div><span class="wNNZR fontTitleSmall">Suggérer de nouveaux horaires</span></div></button></div></div></div></div><div class="z6qSc GUrTXd"><div><div></div><div class="uLQcoc"></div></div></div></div><div class="RcCsl fVHpi w4vB1d NOE9ve M0S7ae AG25L"><div class="OyjIsf"></div><a aria-label="Site Web: iutparis-seine.u-paris.fr " class="CsEnBe" data-item-id="authority" data-tooltip="Accéder au site Web" href="https://iutparis-seine.u-paris.fr/" jsaction="pane.wfvdle38;clickmod:pane.wfvdle38;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="3443; track:click; mutable:true;metadata:W251bGwsIixBT3ZWYXcwUWNzQWRUa0ZvcGZuMW9ZaHhtbkZ3LCwwYWhVS0V3aVgycnZfbnJPS0F4V0pWS1FFSFo0aEtINFE2MWdJRXlnTywiXQ=="><div class="AeaXub"><div class="cXHGnc"><span aria-hidden="true" class="google-symbols PHazN" style="font-size: 24px;"></span></div><div class="rogA2c ITvuef"><div class="Io6YTe fontBodyMedium kR99db fdkmkc">iutparis-seine.u-paris.fr</div><div class="gSkmPd fontBodySmall CuiGbf DshQNd"></div></div></div></a><div class="UCw5gc"><div class="C9yzub"><div class="etWJQ kdfrQc NUqjXc"><a aria-label="Accéder au site Web" class="lcr4fd S9kvJb" data-tooltip="Accéder au site Web" data-value="Accéder au site Web" href="https://iutparis-seine.u-paris.fr/" jsaction="pane.wfvdle39;keydown:pane.wfvdle39;mouseover:pane.wfvdle39;mouseout:pane.wfvdle39;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="38093;track:click;mutable:true;metadata:W251bGwsIixBT3ZWYXcwUWNzQWRUa0ZvcGZuMW9ZaHhtbkZ3LCwwYWhVS0V3aVgycnZfbnJPS0F4V0pWS1FFSFo0aEtINFE2MWdJRXlnTywiXQ=="><span class="DVeyrd"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="Cw1rxd google-symbols G47vBd SwaGS" style="font-size: 18px;"></span></span></a></div><div class="etWJQ kdfrQc NUqjXc"><button aria-label="Copier le site Web" class="g88MCb S9kvJb" data-tooltip="Copier le site Web" data-value="Copier le site Web" jsaction="pane.wfvdle40;keydown:pane.wfvdle40;mouseover:pane.wfvdle40;mouseout:pane.wfvdle40;focus:pane.focusTooltip;blur:pane.blurTooltip"><span class="DVeyrd"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="Cw1rxd google-symbols G47vBd SwaGS" style="font-size: 18px;"></span></span></button></div></div></div></div><div class="RcCsl fVHpi w4vB1d NOE9ve M0S7ae AG25L"><div class="OyjIsf"></div><button aria-label="Numéro de téléphone: 01 76 53 47 00 " class="CsEnBe" data-item-id="phone:tel:0176534700" data-tooltip="Copier le numéro de téléphone" jsaction="pane.wfvdle41;clickmod:pane.wfvdle41;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="18491; track:click; mutable:true;metadata:WyIwYWhVS0V3aVgycnZfbnJPS0F4V0pWS1FFSFo0aEtINFFfZG9CQ0JBb0RBIl0="><div class="AeaXub"><div class="cXHGnc"><span aria-hidden="true" class="google-symbols NhBTye PHazN" style="font-size: 24px;"></span></div><div class="rogA2c"><div class="Io6YTe fontBodyMedium kR99db fdkmkc">01 76 53 47 00</div><div class="gSkmPd fontBodySmall CuiGbf DshQNd"></div></div></div></button><div class="UCw5gc"><div class="C9yzub"><div class="etWJQ kdfrQc NUqjXc"><button aria-label="Copier le numéro de téléphone" class="g88MCb S9kvJb" data-tooltip="Copier le numéro de téléphone" data-value="Copier le numéro de téléphone" jsaction="pane.wfvdle42;keydown:pane.wfvdle42;mouseover:pane.wfvdle42;mouseout:pane.wfvdle42;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="38097;track:click;mutable:true;"><span class="DVeyrd"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="Cw1rxd google-symbols G47vBd SwaGS" style="font-size: 18px;"></span></span></button></div><div class="etWJQ kdfrQc NUqjXc"><a aria-label="Composer le numéro de téléphone" class="lcr4fd S9kvJb" data-tooltip="Composer le numéro de téléphone" data-value="Composer le numéro de téléphone" href="tel:0176534700" jsaction="pane.wfvdle43;keydown:pane.wfvdle43;mouseover:pane.wfvdle43;mouseout:pane.wfvdle43;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="38096;track:click;mutable:true;metadata:WyIwYWhVS0V3aVgycnZfbnJPS0F4V0pWS1FFSFo0aEtINFFfZG9CQ0JBb0RBIl0="><span class="DVeyrd"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="Cw1rxd google-symbols SwaGS" style="font-size: 18px;"></span></span></a></div></div></div></div><div class="RcCsl fVHpi w4vB1d NOE9ve M0S7ae AG25L"><div class="OyjIsf"></div><button aria-label="Plus code: R7R9+R4 Paris" class="CsEnBe" data-item-id="oloc" data-tooltip="Copier le plus code" jsaction="pane.wfvdle44;clickmod:pane.wfvdle44;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="27644; track:click; mutable:true;"><div class="AeaXub"><div class="cXHGnc"><span aria-hidden="true" class="google-symbols PHazN" style="font-size: 24px;"></span></div><div class="rogA2c"><div class="Io6YTe fontBodyMedium kR99db fdkmkc">R7R9+R4 Paris</div><div class="gSkmPd fontBodySmall CuiGbf DshQNd"></div></div></div></button><div class="UCw5gc"><div class="C9yzub"><div class="etWJQ kdfrQc NUqjXc"><button aria-label="Copier le plus code" class="g88MCb S9kvJb" data-tooltip="Copier le plus code" data-value="Copier le plus code" jsaction="pane.wfvdle45;keydown:pane.wfvdle45;mouseover:pane.wfvdle45;mouseout:pane.wfvdle45;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="55025;track:click;mutable:true;"><span class="DVeyrd"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="Cw1rxd google-symbols G47vBd SwaGS" style="font-size: 18px;"></span></span></button></div><div class="etWJQ kdfrQc NUqjXc"><button aria-label="En savoir plus sur les plus codes" class="g88MCb S9kvJb" data-tooltip="En savoir plus sur les plus codes" data-value="En savoir plus sur les plus codes" jsaction="pane.wfvdle46;keydown:pane.wfvdle46;mouseover:pane.wfvdle46;mouseout:pane.wfvdle46;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="27021;track:click;mutable:true;"><span class="DVeyrd"><div class="OyjIsf zemfqc"></div><span aria-hidden="true" class="Cw1rxd google-symbols SwaGS" style="font-size: 18px;"></span></span></button></div></div></div></div></div>]



Pour récupérer l'adresse du site web, s'il y en a un, encore une fois après recherche via l'inspecteur, nous cherchons plus exactement la balise `a` dont le paramètre `aria-label` contient la valeur `"Site Web"`.


```python
results = soup.select("a[aria-label*='Site Web']")
results
```




    [<a aria-label="Site Web: iutparis-seine.u-paris.fr " class="CsEnBe" data-item-id="authority" data-tooltip="Accéder au site Web" href="https://iutparis-seine.u-paris.fr/" jsaction="pane.wfvdle38;clickmod:pane.wfvdle38;focus:pane.focusTooltip;blur:pane.blurTooltip" jslog="3443; track:click; mutable:true;metadata:W251bGwsIixBT3ZWYXcwUWNzQWRUa0ZvcGZuMW9ZaHhtbkZ3LCwwYWhVS0V3aVgycnZfbnJPS0F4V0pWS1FFSFo0aEtINFE2MWdJRXlnTywiXQ=="><div class="AeaXub"><div class="cXHGnc"><span aria-hidden="true" class="google-symbols PHazN" style="font-size: 24px;"></span></div><div class="rogA2c ITvuef"><div class="Io6YTe fontBodyMedium kR99db fdkmkc">iutparis-seine.u-paris.fr</div><div class="gSkmPd fontBodySmall CuiGbf DshQNd"></div></div></div></a>]



Pour avoir exactement l'adresse, on récupère le lien web (contenu dans la balise `href`) du premier résultat obtenu précédemment.


```python
results[0]["href"]
```




    'https://iutparis-seine.u-paris.fr/'



## Dernière étape : fermeture du navigateur

Une fois qu'on a récupéré tout ce qu'on souhaite (donc une fois l'exécution complète du *bot*), il est préférable de fermer correctement le navigateur, surtout si votre code est prévu pour s'exécuter en arrière plan sur un serveur.


```python
driver.close()
```

## A FAIRE

A partir du fichier [StockEtablissement_utf8_1000__complété.csv](StockEtablissement_utf8_1000__complété.csv) sur les 1000 premiers établissements, dans lequel nous avons ajouté les coordonnées géographiques, vous devez chercher, pour chaque établissement, s'il existe un site web et récupérer l'adresse. Toutes les URL seront au final stockées dans une nouvelle variable, `website`, ajouté à toutes les autres informations.


```python
import pandas

df = pandas.read_csv("StockEtablissement_utf8_1000__complété.csv")
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>siren</th>
      <th>nic</th>
      <th>siret</th>
      <th>statutDiffusionEtablissement</th>
      <th>dateCreationEtablissement</th>
      <th>trancheEffectifsEtablissement</th>
      <th>anneeEffectifsEtablissement</th>
      <th>activitePrincipaleRegistreMetiersEtablissement</th>
      <th>dateDernierTraitementEtablissement</th>
      <th>etablissementSiege</th>
      <th>...</th>
      <th>etatAdministratifEtablissement</th>
      <th>enseigne1Etablissement</th>
      <th>enseigne2Etablissement</th>
      <th>enseigne3Etablissement</th>
      <th>denominationUsuelleEtablissement</th>
      <th>activitePrincipaleEtablissement</th>
      <th>nomenclatureActivitePrincipaleEtablissement</th>
      <th>caractereEmployeurEtablissement</th>
      <th>latitude</th>
      <th>longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>325175</td>
      <td>16</td>
      <td>32517500016</td>
      <td>O</td>
      <td>2000-09-26</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3212ZZ</td>
      <td>2015-03-18T00:58:59</td>
      <td>False</td>
      <td>...</td>
      <td>F</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>32.12Z</td>
      <td>NAFRev2</td>
      <td>N</td>
      <td>49.220518</td>
      <td>6.015168</td>
    </tr>
    <tr>
      <th>1</th>
      <td>325175</td>
      <td>24</td>
      <td>32517500024</td>
      <td>O</td>
      <td>2008-05-20</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2011-12-12T09:40:04</td>
      <td>False</td>
      <td>...</td>
      <td>F</td>
      <td>TAHITI PERLES CREATIONS</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>47.89Z</td>
      <td>NAFRev2</td>
      <td>N</td>
      <td>43.938190</td>
      <td>4.882656</td>
    </tr>
    <tr>
      <th>2</th>
      <td>325175</td>
      <td>32</td>
      <td>32517500032</td>
      <td>O</td>
      <td>2009-05-27</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2014-07-08T00:10:21</td>
      <td>False</td>
      <td>...</td>
      <td>F</td>
      <td>TAHITI PERLES CREATIONS</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>32.12Z</td>
      <td>NAFRev2</td>
      <td>N</td>
      <td>43.932374</td>
      <td>4.844274</td>
    </tr>
    <tr>
      <th>3</th>
      <td>325175</td>
      <td>40</td>
      <td>32517500040</td>
      <td>O</td>
      <td>2011-10-21</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3212ZZ</td>
      <td>2015-03-18T00:58:59</td>
      <td>False</td>
      <td>...</td>
      <td>F</td>
      <td>TAHITI PERLES CREATION</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>32.12Z</td>
      <td>NAFRev2</td>
      <td>N</td>
      <td>43.280158</td>
      <td>5.623075</td>
    </tr>
    <tr>
      <th>4</th>
      <td>325175</td>
      <td>57</td>
      <td>32517500057</td>
      <td>O</td>
      <td>2014-01-07</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2018-07-10T14:17:15</td>
      <td>False</td>
      <td>...</td>
      <td>F</td>
      <td>TAHITI PERLES CREATION</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>32.12Z</td>
      <td>NAFRev2</td>
      <td>N</td>
      <td>43.299866</td>
      <td>5.397044</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>994</th>
      <td>5742028</td>
      <td>29</td>
      <td>574202800029</td>
      <td>O</td>
      <td>2002-01-01</td>
      <td>NN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2013-12-11T08:50:11</td>
      <td>False</td>
      <td>...</td>
      <td>F</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>01.11Z</td>
      <td>NAFRev2</td>
      <td>N</td>
      <td>44.115767</td>
      <td>6.010904</td>
    </tr>
    <tr>
      <th>995</th>
      <td>5742036</td>
      <td>14</td>
      <td>574203600014</td>
      <td>O</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>True</td>
      <td>...</td>
      <td>F</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>69.22</td>
      <td>NAP</td>
      <td>N</td>
      <td>44.179140</td>
      <td>5.947317</td>
    </tr>
    <tr>
      <th>996</th>
      <td>5742093</td>
      <td>15</td>
      <td>574209300015</td>
      <td>O</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2019-08-25T12:02:35</td>
      <td>True</td>
      <td>...</td>
      <td>F</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>62.43</td>
      <td>NAP</td>
      <td>N</td>
      <td>44.197272</td>
      <td>5.944793</td>
    </tr>
    <tr>
      <th>997</th>
      <td>5742101</td>
      <td>16</td>
      <td>574210100016</td>
      <td>O</td>
      <td>1900-01-01</td>
      <td>NN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2019-11-14T14:00:14</td>
      <td>True</td>
      <td>...</td>
      <td>F</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>N</td>
      <td>44.427401</td>
      <td>6.435844</td>
    </tr>
    <tr>
      <th>998</th>
      <td>5742176</td>
      <td>18</td>
      <td>574217600018</td>
      <td>O</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>True</td>
      <td>...</td>
      <td>F</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>00.97</td>
      <td>NAP</td>
      <td>N</td>
      <td>44.197636</td>
      <td>5.945917</td>
    </tr>
  </tbody>
</table>
<p>999 rows × 50 columns</p>
</div>




```python

```
