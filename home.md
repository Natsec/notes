---
title: Home
description: Hic Sunt Dracones
published: true
date: 2020-02-22T10:27:20.631Z
tags:
---

# Sommaire
[Notes générales sur Linux](https://wiki.natsec.fr/linux)
[CTF](https://wiki.natsec.fr/ctf)
[Notes sur Bettercap](https://wiki.natsec.fr/bettercap)
[Notes sur Python](https://wiki.natsec.fr/python)

# Server DNS
On edite le fichier `/etc/resolv.conf` :

```text
#search sous-domaine.domain.tld
nameserver 8.8.8.8
nameserver 192.168.1.254
```

# Commandes Linux
## Afficher les addresses IP (brief)
Pour afficher la liste des interfaces, leur état (`up/down`) et l'adresse ip :
```
ip -br a
```

## Afficher les routes
Pour afficher les routes de la machine :
```
ip r
```

## Afficher les ports en écoute
Pour afficher les ports en écoute, on peut faire :
```
ss -ltunp | column -t
```
`-l` (listen) pour afficher les ports en écoute
`-t` (tcp) pour les ports TCP
`-u` (udp) pour les ports UDP
`-n` (no resolve) pour ne pas résoudre les noms de port. Par exemple, affichera `443` au lieu de `https`
`-p` (process) pour afficher le processus qui écoute sur ce port
`column -t` pour un affichage plus agréable

On peut en faire un alias avec : `alias ss='ss -ltunp | column -t'`

## Créer un utilisateur système
Par exemple, pour créer l'utilisateur système `wiki`, on peut faire :
```
sudo useradd --system wiki -s /sbin/nologin
```

## Afficher les tentatives de connexion SSH échouées en temps réel
```
journalctl -f | grep -i "for invalid user"
```

## Regex balises HTML
`<\/*(\w+).*?>`
