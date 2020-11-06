# Linux

## Keyboard
```
setxkbmap fr
```

## Network

Liste des interfaces, et des routes :
```
ip -br a; echo; ip r
```

Changer l'adresse ip :
```
nano /etc/network/interfaces; systemctl restart networking && ip -br a; echo; ip r
```

### Afficher les ports en écoute
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

### DNS
On edite le fichier `/etc/resolv.conf` :
```bash
#search sous-domaine.domain.tld
nameserver 8.8.8.8
nameserver 192.168.1.254
```

## Logging
Afficher les tentatives de connexion SSH échouées en temps réel :
```
journalctl -f | grep -i "for invalid user"
```

## User
Pour créer un utilisateur système `wiki`, on peut faire :
```
sudo useradd --system wiki -s /sbin/nologin
```
