# Linux

- [Clavier](#clavier)
- [Root](#root)
- [GPG](#gpg)
- [Aléatoire](#aléatoire)
- [Bash](#bash)
- [Backup](#backup)
  - [SSH Key Based Authentication](#ssh-key-based-authentication)
- [Audit de conformité](#audit-de-conformité)
- [SSH](#ssh)
- [Clé bootable](#clé-bootable)
- [LDAP](#ldap)
- [Network](#network)
  - [DNS](#dns)
- [Services](#services)
- [Logging](#logging)
- [User](#user)

Cheatsheet :
- https://devhints.io/bash

## Clavier

```bash
# passer en français
setxkbmap fr
```

Pour désactiver le 🔔 : décommenter `# set bell-style none` dans `/etc/inputrc`.

## Root

Pour reset un mot de passe root oublié :
1. faire `e` dans le menu grub
2. ajouter `rw init=/bin/bash` à la fin de la ligne `linux`
3. faire `^x` ou `F10` pour démarrer l'image

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

### SSH Key Based Authentication

Générer une paire de clé sur la machine cliente :
```bash
# la base
ssh-keygen -f ~/.ssh/id_projet2a -C "serveur calcul projet2A" -t rsa -b 4096
# le future
ssh-keygen -f ~/.ssh/id_projet2a -C "serveur calcul projet2A" -t ed25519
```

Copier la clé publique vers le serveur :
```bash
ssh-copy-id -i ~/.ssh/id_projet2a.pub natsec@172.16.22.1
# OU
# copier la clé publique dans le fichier /home/natsec/.ssh/authorized_keys du serveur
```

Editer le fichier `~/.ssh/config` :
```
Host s serveur_de_calcul
    HostName 172.16.22.1
    IdentityFile ~/.ssh/id_projet2a
    User natsec
    #ProxyJump jumphost
```

Pour éviter de retaper trop souvent la passphrase de la clé privée, on peut utiliser `ssh-agent` qui va la stocker en mémoire temporairement :
```bash
# lancer l'agent de gestion des clés
eval `ssh-agent`
# lister les identités
ssh-add -l
# ajouter la clé à l'agent
ssh-add ~/.ssh/id_projet2a
```

## Audit de conformité

Pour mettre à jour les paquets concerné :
```bash
sudo apt update; debsecan --suite $(lsb_release --codename --short) --only-fixed --format packages | xargs -L1 sudo apt install
```
```bash
# installation
sudo apt install lynis

# audit basique du système
lynis audit system

# exporter le rapport au format HTML
lynis audit system | ansi2html -la > report.html
```

## SSH

Rebond :
```bash
ssh -J host1 host2 ...
```

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

## Clé bootable

Pour rendre une clé bootable :
```bash
lsblk
dd if=file.iso of=/dev/sdb bs=16M conv=fsync status=progress
```

## LDAP
```bash
ldapsearch -x -H ldap://192.168.43.231:390 -b "ou=Employees,ou=Company,dc=ilex-si,dc=com" "(&(|(title=Dir*)(title=Ing*)(title=Resp*))(description=F))"
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

Pour ajouter un utilisateur au groupe `sudo` :
```bash
usermod -a -G sudo utilisateur
```
