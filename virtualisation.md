# Virtualisation

## Proxmox

> *"Proxmox c'est la vida"*, Charles Darwin

```bash
# manipuler les VM
qm list
qm start|shutdown|stop 101

# les backup sont dans /var/lib/vz/dump

# pour enlever un lock
qm unlock 101
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

# télécharger une image docker sous forme d'archive
mkdir aoc; cd aoc
docker save -o aoc.tar public.ecr.aws/h0w1j9u3/grinch-aoc:latest
tar -xvf aoc.tar
# regarder le manifest.json de l'image docker
cat manifest.json | jq
# le fichier de la variable Config contient les
# commandes qui ont servis à construire l'image docker
cat f886f00520700e2ddd74a14856fcc07a360c819b4cea8cee8be83d4de01e9787.json | jq
# si une commande ne contient pas "empty_layer": true, alors elle a sa propre layer
# pour trouver la layer d'un fichier en particuler
ls -1 | strings -n 20 | xargs -L1 -I% sh -c "tar -tf %/layer.tar | sed 's@^@% /@'" | grep -i motif
# quand on a trouvé la layer, on peut l'extraire et accéder au contenu du fichier
cd 4416e55edf1a706527e19102949972f4a8d89bbe2a45f917565ee9f3b08b7682
tar -xvf 4416e55edf1a706527e19102949972f4a8d89bbe2a45f917565ee9f3b08b7682
tree
```

## VMware

Pour monter un partage dans VMware :
```bash
# pour un partage nommé partage
mkdir share
vmhgfs-fuse .host:partage ./share
```
