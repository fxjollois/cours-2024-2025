# Système pour la Data Science

## Master AMSD/MLSD

### Langage système de base

#### Création d'une machine virtuelle Ubuntu Server

- Installer Virtual Box que vous pouvez [télécharger ici](https://www.virtualbox.org/)

- Téléchargez [Ubuntu Server](https://ubuntu.com/download/server)

- Dans VirtualBox, cliquer sur **Nouvelle**
    - Nom = *Serveur Linux Data Science*
    - Dossier = laisser tel quel (ou choisir un dossier spécifique si vous le souhaitez)
    - Type = Linux
    - Version = Ubuntu (64-bits) 
    - **Suivant**
    
- Quantité de mémoire : 
    - idéalement 2Go (*i.e.* 2048 Mo - ce qui est proposé par défaut me semble-t'il)
    - Plus si vous le pouvez (pas plus de la moitié de la capacité de votre machine)
    - **Suivant**

- Disque dur : laissez "Créer un disque dur virtuel maintenant"
    - Type de disque dur : laissez "VDI"
        - Continuer
    - Stockage sur disque dur : laissez "Dynamiquement alloué"
        - Continuer
    - Emplacement : laissez le chemin indiqué
        - Pour la taille, mettez au moins 50 Go si vous le pouvez
    - **Suivant**

- Récapitulatif
    - **Finish**
        
> **La machine est créée**

- Sélectionner la machine virtuelle, et cliquer sur *Configuration*

- Choisir *Stockage*
    - Sélectionner "Vide" dans la partie "Contrôleur : IDE"
    - Cliquer sur l'icône à droite de "Maître secondaire IDE", et choisir "Choose a disk file"
        - Sélectionner le fichier ISO de Ubuntu Server
        - Cliquer sur Ouvrir
    - Cliquer sur **OK**

> **La machine va faire comme si le fichier ISO était un disque dur en plus**

- Cliquer sur *Démarrer*

- Choisir "Try or Install Ubuntu Server" et taper sur Entrée (ou attendre que ça se lance automatiquement)

- Choisir la langue

- Choisir la configuration du clavier
    - Taper "Tab" pour naviguer entre les items
    - Choisir la bonne disposition
    - Choisir "Terminé" et taper sur Entrée

- Choisir le type d'installation
    - Laisser le choix par défaut et taper sur Entrée

- Connection réseau
    - Laisser le choix par défaut et taper sur Entrée

- Configurer le proxy
    - Laisser le choix par défaut et taper sur Entrée

- Configurer le miroir d'achive d'Ubuntu
    - Laisser le choix par défaut et taper sur Entrée

- Configurer le stockage
    - Laisser le choix par défaut et taper sur Entrée (en le sélectionnant via "Tab")

- Suite de la configuration du stockage
    - Laisser le choix par défaut et taper sur Entrée

- Confirmer l'action en sélectionnant **Continuer** et en tapant sur Entrée

- Configurer votre profil (navigation avec Tab encore)
    - Votre nom : comme vous le souhaitez
    - Nom de la machine : idem (par exemple `sysdatascience`) 
    - Nom d'utilisateur : idem (par exemple `user`)
    - Mot de passe : à vous de choisir (par exemple `123456`)
    - Choisir Terminé puis entrée
    
- Configurer SSH
    - Sélectionner "Installer le serveur OpenSSH" (en tapant sur Entrée)
    - Choisir Terminé sur Entrée

- Server snaps à choisir (rien à sélectionner a priori)
    - Choisir Terminé puis sur Entrée

> **Le système s'installe** (cela prend un peu de temps)

- Une fois l'installation terminé, sélectionner "Redémarrer maintenant"
    - Appuyez une fois encore sur Entrée (cela devrait supprimer le lecteur du fichier ISO)

- Une fois relancéuser, vous devriez avoir cette invite (en appuyant sur Entrée éventuellement)

```
sysdatascience login:
```

- Tapez votre nom d'utilisateur et votre mot de passe (cf étape précédente)
    - *Nota Bene* : sur Linux, lorsque vous tapez un mot de passe, rien ne se passe -> c'est normal

> **Vous êtes connecté sur votre serveur**, et devriez avoir qqch du genre 

```
user@sysdatascience:~$ 
```

> **Votre serveur est fonctionnel** et vous pouvez tester les commandes du cours



    


