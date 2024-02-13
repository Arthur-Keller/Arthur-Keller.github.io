---
title: TP2 de virtualisation
author: Arthur KELLER
header-includes: 
  - \usepackage{fancyhdr}
  - \pagestyle{fancy}
  - \fancyhead{}
  - \fancyhead[C]{Virtualisation}
  - \fancyhead[R]{\thepage}
  - \fancyfoot{}
  - \fancyfoot[C]{\thepage}
  - \renewcommand{\headrulewidth}{0.4pt}
  - \renewcommand{\footrulewidth}{0pt}
---

## Premiers conteneurs

#### Lancer bash dans un conteneur interactif utilisant l’image debian
```bash
root@debian:~# docker run -it debian
```

#### Installez la commande tree
```bash
apt-get install tree
```

#### Tester la
```bash
tree
```

#### Quittez le conteneur et créez en un nouveau utilisant la même image
```bash
exit
tree
```

#### Que pouvez vous en conclure ?
> La commande s'est installé que dans un conteneur et ne peut pas etre utiliser d'en d'autre

#### Supprimer les conteneurs
```bash
docker container prune
```

## Conteneurs en arrière plan

#### Créez un conteneur qui utilise l’image jpetazzo/clock et qui s’exécute en avant plan
```bash
docker run -it jpetazzo/clock
```

#### Stoppez le conteneur avec Ctrl-C et créez en un nouveau en arrière plan avec la même image, en lui donnant un nom de votre choix
```bash
docker run --name tp2 -it jpetazzo/clock &
```

#### Utilisez la commande docker container ls pour trouver le nom de ce conteneur
```bash
docker container ls
```

#### Grâce à la commande docker logs affichez la sortie du conteneur
```bash
docker logs tp2
```

#### Quelle option permet d’afficher la sortie en continu ?
```bash
docker logs -f tp2
```

#### Quelle commande permet d’exécuter un nouveau processus dans un conteneur déjà en fonctionnement ?
```bash
docker container exec -i ...
```

#### Utilisez cette commande pour lancer le shell sh dans le conteneur en cours d’exécution
```bash
docker container exec -i sh
```

#### Une fois dans ce shell, lancez la commande ps
```bash
ps
```

#### Qu’en déduisez vous sur le point d’entrée de l’image jpetazzo/clock ?
> On ne voit que les processures qui sont lancés dans ton conteneur

#### Arrêtez le conteneur
```bash
docker stop 8e8bbd065934
```

#### Redémarrez le (attention, sans en créer un nouveau il faut démarrer le conteneur stoppé)
```bash
docker start 8e8bbd065934
```

## Variables d’environnement
#### Créez un nouveau conteneur basé sur l’image debian en mode interactif avec les variables d’environnement suivantes définies dans la commande docker run
- TP avec comme valeur "02"
- SUJET avec comme valeur "Docker"

```bash
docker run -e TP="02" SUJET="Docker" -it debian
```

#### Vérifiez dans le shell du conteneur que vos variables d’environnement ont été correctement positionnées
```bash
echo $TP && $SUJET
```

#### Affichez la date et l’heure du conteneur à l’aide de la commande date, que remarquez vous ?
```bash
date

# Reponse : Nous sommmes dans le fuseau horaire de l'angleterre
Tue Feb 13 14:41:34 UTC 2024
```

#### Effectuez une recherche afin de trouver comment démarrer un conteneur qui affichera la date dans le bon fuseau horaire
```bash
TZ='Europe/Paris' date
```

## Utilisation d’image officielle
#### À l’aide de la documentation de l’image sur [https://hub.docker.com](https://hub.docker.com), démarrez un conteneur qui exécute PostgreSQL en version 14 respectant les consignes suivantes:
- Un utilisateur "user" doit exister et pouvoir se connecter avec le mot de passe "user"
- Une base nommée userdb doit être créée dont le propriétaire est l’utilisateur "user"
- Aucune de ces configurations ne doit être effectuée manuellement après démarrage du conteneur
- Le conteneur doit exposer le port tcp 5432 sur la machine virtuelle

```bash
docker run --name postgres-container -e POSTGRES_USER=user -e POSTGRES_PASSWORD=user -p 5432:5432 -d postgres:14
```

#### Dans votre machine virtuelle, installez le paquet postgresql-client et utilisez la commande psql pour vérifier que votre conteneur respecte bien les consignes
```bash
# Installation du paquet postgresql-client
apt-get install postgresql-client

# Test de connexion à la base
psql -U user -h localhost
```