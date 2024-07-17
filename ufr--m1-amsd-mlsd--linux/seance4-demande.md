# Système pour la Data Science

## Master AMSD/MLSD

### Gestion des scripts R et Python en `shell`

#### Demande à réaliser

## Mettre à jour votre machine virtuelle

La dernière commande est pour être sûr que tout est OK.

```bash
$ sudo apt update
$ sudo apt upgrade
$ sudo apt update
```

## Installer `mailutils`

Pour pouvoir recevoir des messages envoyés par `cron`

```bash
$ sudo apt install mailutils
```

## Récupération des données Velib'

- Ecrire en `shell`, R et en Python (3 versions donc) un script permettant de récupérer les données en temps réel des stations Velib
    - [Données Velib](https://opendata.paris.fr/explore/dataset/velib-disponibilite-en-temps-reel/information/?disjunctive.name&disjunctive.is_installed&disjunctive.is_renting&disjunctive.is_returning&disjunctive.nom_arrondissement_communes)
    - Le code doit récupérer le fichier `JSON` et le stocker dans un fichier avec l'horodatage dans le nom de fichier
        - Attention au répertoire de sauvegarde de ce fichier
    
- Programmer ces 3 codes pour qu'ils s'exécutent toutes les 5 minutes du 18 au 21 novembre

## Rendus

- Faire un fichier compressé avec les 3 codes + un fichier texte reprenant ce que vous avez programmé avec `cron`

- Déposer le fichier (avec votre **nom de famille** et votre **prénom** dans le **nom du fichier**) dans cet espace :

<https://cloud.parisdescartes.fr/index.php/s/R55XCmHs6axRQ4H>


