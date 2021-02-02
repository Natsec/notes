# Linux

- [Linux](#linux)
  - [Clavier](#clavier)
  - [Bash](#bash)
  - [Backup](#backup)
  - [SSH](#ssh)
  - [Network](#network)
    - [DNS](#dns)
  - [Services](#services)
  - [Logging](#logging)
  - [User](#user)

Pour reset un mot de passe root oublié :
1. faire `e` dans le menu grub
2. ajouter `rw init=/bin/bash` à la fin de la ligne `linux`
3. faire `^x` ou `F10` pour démarrer l'image

## Clavier

```bash
# passer en français
setxkbmap fr
```

## Aléatoire

Pour générer de l'aléatoire (pas pour de la crypto) :
```bash
cat /dev/urandom | head | sha1sum
cat /dev/urandom | head -c32 | base64
cat /dev/urandom | tr -dc a-zA-Z0-9 | head -c32; echo
```

## Bash

Pour lancer une commande sur chaque ligne d'un retour :
```bash
find /etc -name php.ini | xargs -L1 less
```

Reproduire une arborescence locale sur une machine distante (Ansible like) :
```bash
cd `dirname $0`
for host in `ls -1 files`; do
    rsync -rvu files/$host/ $host:/
done
```

Télécharger un paquet en local (check https://pkjs.org pour les dependances) :
```bash
apt reinstall -d -o=dir::cache=/tmp openssh-server openssh-client
cd /tmp/archives
```

## Backup

Backup avec rsync (local/distant) :
```bash
rsync --delete -avu /home/user/dossier remote@192.168.1.2:/home/remote/dossier
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

Se connecter dès qu'un hôte est disponible :
```bash
h=192.168.1.2; until nc -z -w1 $h 22; do sleep 1; echo waiting $h; done; ssh $h
```

Rebond :
```bash
ssh -J host1 host2 ...
```

Configuration du client ssh dans `~/.ssh/config` :
```
Host alias1 alias2
    HostName 192.168.1.2
    IdentityFile ~/.ssh/id_rsa_alias1
    User remoteuser
    #ProxyJump jumphost
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
