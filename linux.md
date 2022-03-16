# Linux

- [Clavier](#clavier)
- [Couleurs](#couleurs)
- [Root](#root)
- [GPG](#gpg)
- [Aléatoire](#aléatoire)
- [Bash](#bash)
- [Intégrité, diff et patch](#intégrité-diff-et-patch)
- [Backup](#backup)
- [Git](#git)
- [SSH](#ssh)
  - [Key Based Authentication](#key-based-authentication)
- [Fichier ISO](#fichier-iso)
- [Système](#système)
  - [Etendre une partition LVM](#etendre-une-partition-lvm)
- [Network](#network)
  - [DNS](#dns)
  - [LDAP](#ldap)
- [Paquets](#paquets)
- [Services](#services)
- [Logging](#logging)
- [User](#user)
- [SELinux](#selinux)
- [Debian](#debian)
  - [Téléchargement de l'image](#téléchargement-de-limage)
  - [Vérification de la signature du fichier d'empreinte](#vérification-de-la-signature-du-fichier-dempreinte)
  - [Vérification de l'empreinte](#vérification-de-lempreinte)

---

Cheatsheet :
- https://devhints.io/bash

## Clavier

```bash
# passer en français
setxkbmap fr
# réparer un terminal cassé
reset
```

Pour désactiver le bell : décommenter `# set bell-style none` dans `/etc/inputrc`, puis reboot.

## Couleurs

Afficher la palette de couleurs :
```bash
# apt install colortest
colortest-16b
```

## Root

Pour reset un mot de passe root "oublié" :
1. faire <kbd>e</kbd> dans le menu grub
2. ajouter `rw init=/bin/bash` à la fin de la ligne `linux`
3. faire <kbd>Ctrl</kbd>+<kbd>x</kbd> ou <kbd>F10</kbd> pour démarrer l'image

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

Générer de l'aléatoire (pas pour de la crypto) :
```bash
head /dev/urandom | sha256sum
head /dev/urandom | tr -dc a-zA-Z0-9 | head -c32; echo
head /dev/urandom -c32 | base64
```

Générer de l'aléatoire [cryptographiquement sûr](https://man.cx/rand) :
```bash
openssl rand -hex 32
openssl rand -base64 32
```

Afficher l'entropie du système :
```bash
cat /proc/sys/kernel/random/entropy_avail
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
# pour trier par taille de fichier
ncdu --si
  ggtssc

# pour trier par date de modification
ncdu --si -e
  ggtMmc
```

## Intégrité, diff et patch

Enregistrer et vérifier les empreintes récursivement :
```bash
find | xargs -L1 sha512sum | sort -k2 > hash.txt
diff hash.txt <(find | xargs -L1 sha512sum | sort -k2)
```

Différences entre 2 répertoires :
```bash
diff -qr dossier1 dossier2
```

Pour prendre en compte les mises à jours d'un fichier, tout en conservant les modifications personnelles :
```bash
diff -u base1 base2 > update.patch
patch mod1 update.patch -o mod2
```

## Backup

Backup avec rsync (local/distant) :
```bash
rsync --delete -avu --exclude dossier /home/user/dossier remote@192.168.1.2:/home/remote/dossier
```

## Git

Pour annuler le dernier commit :
```bash
git reset --soft HEAD~1
```

Pour ignorer un file/dir qui a déjà été commit :
1. Le mettre dans `.gitignore`
2. Faire `git rm --cached <filename>` pour le supprimer du repo (n'est pas supprimé en local)

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

### Key Based Authentication

Générer une paire de clé sur la machine cliente :
```bash
h=projet2a ; ssh-keygen -f ~/.ssh/id_$h -C $h -t ed25519
# afficher l'empreinte d'une clé
ssh-keygen -lv -f ~/.ssh/id_projet2a
```

Copier la clé publique vers le serveur :
```bash
ssh-copy-id -i ~/.ssh/id_projet2a.pub natsec@172.16.22.1
# OU
# copier la clé publique dans le fichier /home/natsec/.ssh/authorized_keys du serveur
```

Editer le fichier `~/.ssh/config` :
```
Host alias1 alias2 serveur_de_calcul
    HostName 172.16.22.1
    IdentityFile ~/.ssh/id_projet2a
    User natsec
    #Port 22
    #ProxyJump jumphost
```

Si on a chiffré la clé privée avec une passphrase, pour éviter de retaper trop souvent la passphrase, on peut utiliser `ssh-agent` qui va la stocker en mémoire temporairement :
```bash
# lancer l'agent de gestion des clés
eval `ssh-agent`
# lister les identités
ssh-add -l
# ajouter la clé aux identités
ssh-add ~/.ssh/id_projet2a
```

Pour lire le contenu d'une clé publique :
```bash
ssh-keygen -f key.pub -e -m pkcs8 > pubkey.pem
openssl rsa -inform PEM -pubin -in pubkey.pem -noout -text
```

## Fichier ISO

Pour rendre une clé bootable au `dd` :
```bash
lsblk
dd if=file.iso of=/dev/sdb bs=16M conv=fsync status=progress
```

Pour monter une image ISO :
```bash
mount -o loop debian-10.9.0-amd64-DVD-1.iso /media/cdrom
```

## Système

### Etendre une partition LVM

Sur l'hyperviseur : augmenter la taille du disque ou en ajouter un à la VM.

Dans la VM :
```bash
# créer une partition avec cfdisk
cfdisk /dev/sdX
    [ New ]
        prendre tout espace disponible
    [ Type ]
        Linux LVM
    [ Write ]
        q pour quitter

# faire prendre en compte les changement par l'OS
partprobe

# créer un Physical Volume (PV) sur la nouvelle partition (ex : /dev/sda4)
pvcreate [nouvelle partition]

# afficher les PV (et noter le Volume Group (VG) aux-quels ils sont associés)
pvs OU pvdisplay

# étendre le Volume Group (VG) au PV nouvellement créé
vgextend [nom du VG] [nouvelle partition]

# le VG s'étend maintenant sur la nouvelle partition
pvs OU pvdisplay

# afficher la taille du VG et l'espace disponible
vgs OU vgdisplay

# étendre le Logical Volume (LV ou autrement dit la partition à agrandir) avec l'espace disponible du VG
lvextend -l +100%FREE /dev/mapper/[nom du LV]

# faire prendre en compte la nouvelle taille de la partition par le système
resize2fs /dev/mapper/[nom du LV]

# super nickel !
df -h
```

## Network

```bash
# lister les interfaces et les routes
alias ipl='ip -br a; echo; ip r'

# changer l'adresse ip
nano /etc/network/interfaces; systemctl restart networking && ip -br a; echo; ip r

# obtenir son IP publique :
curl ifconfig.me
```

### DNS

On edite le fichier `/etc/resolv.conf` :
```bash
#search sous-domaine.domain.tld
nameserver 8.8.8.8
nameserver 192.168.1.254
```

### LDAP

```bash
ldapsearch -x -H ldap://192.168.43.231:390 -b "ou=employees,ou=company,dc=nasa,dc=com" "(&(|(title=Dir*)(title=Ing*)(title=Resp*))(description=F))"
```

## Paquets

Lister les fichers installés par un paquet : `dpkg -L`

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

## SELinux

Pour désactiver SELinux :
```bash
# en live
setenforce 0
# persistant
sed -i 's/SELINUX=.+/SELINUX=permissive/' /etc/selinux/sysconfig
```

## Debian

### Téléchargement de l'image

Il est préférable d'utiliser la version `netinst`, qui ne contient que les paquets essentiels, ce qui permet de respecter le principe de minimisation.

Pour obtenir l'image d'installation Debian, on se rend sur https://www.debian.org/CD/netinst/. Le fichier téléchargé est un `.torrent`, qui nous permet de télécharger l'image iso via le protocole BitTorrent.

Pour s'assurer que l'image n'a pas été modifiée, à cause d'une erreur de copie, ou par malveillance, on va vérifier l'empreinte de l'image. On se rend sur le répertoire https://cdimage.debian.org/debian-cd/current/amd64/bt-cd/, et on récupère les deux fichiers `SHA512SUMS` et `SHA512SUMS.sign`.

### Vérification de la signature du fichier d'empreinte

On commence par vérifier que le fichier contenant l'empreinte de l'image a bien été généré par l'équipe Debian, et n'a pas été modidié depuis. Pour cela on vérifie la signature du fichier `SHA512SUMS`.

On récupère la clé publique de Debian en allant sur https://www.debian.org/CD/verify. Idéalement, il faudrait le faire avec une connection Internet différente de celle utilisée pour récupérer l'image. On regarde la dernière clé utilisée par l'équipe, et on note son identifiant :
```
pub                    4096R/6294BE9B 2011-01-05
Empreinte de la clef = DF9B 9C49 EAA9 2984 3258  9D76 DA87 E80D 6294 BE9B
uid                    Debian CD signing key <debian-cd@lists.debian.org>
sub                    4096R/11CD9819 2011-01-05
```

Pour récupérer la clé, on fait :
```bash
gpg --keyserver keyring.debian.org --recv 6294BE9B
```

On vérifie la signature du fichier :
```
user@debian: share $ gpg --verify SHA512SUMS.sign
gpg: les données signées sont supposées être dans « SHA512SUMS »
gpg: Signature faite le sam. 06 févr. 2021 20:38:14 CET
gpg: avec la clef RSA DF9B9C49EAA9298432589D76DA87E80D6294BE9B
gpg: Bonne signature de « Debian CD signing key <debian-cd@lists.debian.org> » [inconnu]
gpg: Attention : cette clef n'est pas certifiée avec une signature de confiance.
gpg:             Rien n'indique que la signature appartient à son propriétaire.
Empreinte de clef principale : DF9B 9C49 EAA9 2984 3258  9D76 DA87 E80D 6294 BE9B
```

Si les deux empreintes commencent bien par `DF9B 9C49 EAA9 2984`, c'est bien l'équipe Debian qui a signé le fichier `SHA512SUMS`.

### Vérification de l'empreinte

On peut maintenant comparer l'empreinte de l'image iso avec celle donnée par Debian avec :
```bash
sha512sum -c SHA512SUMS --ignore-missing
debian-10.8.0-amd64-netinst.iso: Réussi
```
