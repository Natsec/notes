# Linux

Pour reset un mot de passe root oublié :
1. faire `e` dans le menu grub
2. ajouter `rw init=/bin/bash` à la fin de la ligne `linux`
3. faire `^x` ou `F10` pour démarrer l'image

## Clavier

```bash
# passer en français
setxkbmap fr
```

## SSH

Pour monter un répertoire distant avec ssh :
```bash
apt install sshfs
# monter
sshfs user@host:/remote_dir /mnt
# démonter
fusermount -u /mnt
```

Rebond :
```bash
ssh -J host1 host2 ...
```

## Network

```bash
# lister les interfaces et les routes
alias ipl='ip -br a; echo; ip r'

# changer l'adresse ip
nano /etc/network/interfaces; systemctl restart networking && ip -br a; echo; ip r
```

### DNS

On edite le fichier `/etc/resolv.conf` :
```bash
#search sous-domaine.domain.tld
nameserver 8.8.8.8
nameserver 192.168.1.254
```

## Services

```bash
# afficher les ports en écoute
alias ss='ss -ltunp | column -t'

# lancer une tâche en arrière plan en la détachant du terminal
nohup <commande> &
```

## Logging

```bash
# afficher les tentatives de connexion SSH échouées en temps réel
journalctl -f | grep -i "for invalid user"

# afficher les log d'un service en live
journalctl -uf <service>
```

## User

Pour créer un utilisateur système `wiki`, on peut faire :
```
sudo useradd --system wiki -s /sbin/nologin
```
