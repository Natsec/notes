# Virtualisation

## Proxmox

> *"Proxmox c'est la vida"*, Charles Darwin

```bash
# manipuler les VM
qm list
qm start|shutdown|stop 101

# les backup sont dans /var/lib/vz/dump

# si il y a un lock
rm /run/lock/101
# ou ?
rm /run/lock/qemu-server/lock-100.conf
```

## Docker

```bash
# télécharger/lancer une image et rediriger le port 8080 du host vers le 80 du guest
docker run -p 8080:80 debian
# télécharger/lancer une image en mode interactif `-it` et obtenir un shell
docker run -it debian bash

# sauvegarder les modifs d'une image
exit
docker ps -a
docker commit <CONTAINER_ID> <new_image_name>

# lister les images locales
docker images
# lister les conteneurs en cours d'exécution
docker ps
# ceux qui ont été exécutés
docker ps -a

# supprimer un conteneur
docker rm <id/nom du conteneur>
# supprimer une image
docker rmi <id/nom image>
```

## VMware

Pour monter un partage dans VMware :
```bash
# pour un partage nommé partage
mkdir share
vmhgfs-fuse .host:partage ./share
```
