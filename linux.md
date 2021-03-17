# Linux

- [Root](#root)
- [Clavier](#clavier)
- [GPG](#gpg)
- [Aléatoire](#aléatoire)
- [Bash](#bash)
- [Backup](#backup)
- [SSH](#ssh)
- [Clé bootable](#clé-bootable)
- [Network](#network)
  - [DNS](#dns)
- [Services](#services)
- [Logging](#logging)
- [User](#user)

Cheatsheet :
- https://devhints.io/bash

## Root

Pour reset un mot de passe root oublié :
1. faire `e` dans le menu grub
2. ajouter `rw init=/bin/bash` à la fin de la ligne `linux`
3. faire `^x` ou `F10` pour démarrer l'image

## Clavier

```bash
# passer en français
setxkbmap fr
```

## GPG

https://www.hacksanity.com/kb/gnupg-create-manage-keys/

Pour générer une clé GPG, l'afficher, et l'exporter :
```bash
# sudo apt install gnupg
gpg --full-generate-key
gpg --list-keys
gpg --armor --export 3AA5C34371567BD2 | tee key.asc
```

## Aléatoire

Pour générer de l'aléatoire (pas pour de la crypto) :
```bash
head /dev/urandom | sha1sum
head /dev/urandom | tr -dc a-zA-Z0-9 | head -c32; echo
head /dev/urandom -c32 | base64
```

## Bash

Trouver les fichiers contenants des motifs :
```bash
grep -Pil "mot1|mot2" *
```

Pour lancer une commande sur chaque ligne d'un retour :
```bash
find /etc -name *.txt | xargs -L1 -I% echo cp % /tmp
```

Reproduire une arborescence locale sur une machine distante (Ansible like) :
```bash
cd `dirname $0`
for local_file in `find files/$host -mindepth 1`; do
    remote_file=${local_file#*$host}
    if [ -d $local_file ]; then
        ssh $host "mkdir -p $remote_file"
    else
        echo "$remote_file"; scp -q $local_file $host:$remote_file
    fi
done
```

Télécharger un paquet en local (check https://pkgs.org pour les dependances) :
```bash
apt reinstall -d -o=dir::cache=/tmp openssh-server openssh-client
cd /tmp/archives
```

ncdu (ncurses disk usage) :
```bash
ncdu --si <--color dark>
    gg t ss c
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

## Clé bootable

Pour rendre une clé bootable :
```bash
lsblk
dd if=file.iso of=/dev/sdb bs=16M conv=fsync status=progress
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
