# Virtualisation

## Proxmox

## Docker

```bash
# télécharger/lancer une image
docker run hello-world
# télécharger/lancer une image en mode interactif `-it` et obtenir un shell
docker run -it debian bash

# lister les images locales
docker images
# lister les conteneurs en cours d'exécution
docker ps
# ceux qui ont été exécutés
docker ps -a

# supprimer un conteneur
docker rm [id/nom du conteneur]
# supprimer une image
docker rmi [id/nom image]
```

## VMware

Pour monter un partage dans VMware :
```bash
# pour un partage nommé partage
mkdir share
vmhgfs-fuse .host:partage ./share
```
