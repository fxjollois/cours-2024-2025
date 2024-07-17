# Système pour la Data Science

## Master AMSD/MLSD

### Scripts `shell` à traduire

#### Demande à réaliser

Vous pouvez/devez utiliser les outils RStudio et Jupyter Notebook pour créer les programmes demandés ci-dessous

## Mettre à jour votre machine virtuelle

La dernière commande est pour être sûr que tout est OK.

```bash
$ sudo apt update
$ sudo apt upgrade
$ sudo apt update
```

## Installer les outils de travail

- Installer R si ce n'est pas encore fait
    - [lien vers la procédure officielle](https://cloud.r-project.org/bin/linux/ubuntu/)
    
- Installer RStudio Server
    - [lien vers la procédure officielle](https://posit.co/download/rstudio-server/)
    - [autre aide](https://www.r-bloggers.com/2015/01/installing-rstudio-server-on-ubuntu-server/)

- Installer Python 3 si ce n'est pas déjà fait (testé avec `$ type python3`)
    - [lien vers la procédure](https://docs.python-guide.org/starting/install3/linux/)
    - Mais **surtout installer `pip`** : `$ sudo apt install python3-pip`

- Installer Jupyter Hub / Jupyter Lab
    - [lien vers la procédure](https://jupyterhub.readthedocs.io/en/stable/)


- Tester si les deux services (R Studio Server et Jupyter Hub) fonctionnent
    - Dans VirtualBox, configuration de la VM -> Réseau -> "Accès par pont"
    - Utiliser `$ ip addr` dans le `shell` pour connaître l'adresse IP (locale) de votre machine virtuelle
    - Pour RStudio Server : adresse de type `http://192.168.1.15:8787` (attention, `192.168.1.15` est l'adresse IP en local sur ma machine)
    - Pour JupyterLab : adresse de type `http://192.168.1.15:8000`

- **A noter** : RStudio Server et Jupyter Lab vous offre tous les deux la possibilité d'écrire des fichiers texte (donc un script `shell`) et d'avoir un terminal de commande (donc de faire du `shell` dans un navigateur). Ce qui sera beaucoup plus pratique pour écrire les scripts `shell`.

## En langage R

Traduire les deux scripts demandés à la [séance précédente](seance2-demande) en **R**

- Script de recherche d'informations
- Script d'extraction 

## En langage Python

Faire de même en langage **Python**

- Script de recherche d'informations
- Script d'extraction 

## Comparer les trois scripts

- Sur la taille du code
- Sur la difficulté de développement
- Sur la gestion de la mémoire vive