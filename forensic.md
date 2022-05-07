# Forensic (Investigation Numérique)

> *Nul ne peut agir avec l’intensité que suppose l’action criminelle sans laisser des marques multiples de son passage*, Principe d'échange d'Edmond Locard

> https://www.unodc.org/documents/organized-crime/Law-Enforcement/Criminal_Intelligence_for_Analysts.pdf

## Intro

L'objectif est d'obtenir la timeline des actions qui ont menées à l'incident.

Principes :
- on travail jamais sur les preuves, on travail sur leurs copie
- on fait l'empreinte des éléments pour respecter la [chain of custody](https://en.wikipedia.org/wiki/Chain_of_custody)

## Acquisition

Convertir une image disque vmdk en raw, et monter sa partition NTFS :
```bash
# vmdk to raw
qemu-img convert -f vmdk -O raw BROCELIANDE_DC_Graal-disk1.vmdk dc_graal.raw

# afficher les partitions de l'image
mmls dc_graal.raw -B

# vérifier manuellement le type de partition
hexdump -C -s $((512*1259520)) dc_graal.raw | head

# monter la partition en lecture seule
sudo mkdir /dc_graal
sudo mount -o ro,offset=$((512*1259520)) dc_graal.raw /dc_graal/
ncdu /dc_graal
```

Convertir une image disque vmdk en raw, et monter sa partition LVM :
```bash
# vmdk to raw
qemu-img convert -f vmdk -O raw BROCELIANDE_CI_Camelot-disk1.vmdk gitlab_camelot.raw

# afficher les partitions de l'image
mmls gitlab_camelot.raw -B

# vérifier manuellement le type de partition
hexdump -C -s $((512*2101248)) gitlab_camelot.raw | head

# dumper la partition lvm2 et vérifier
mmcat gitlab_camelot.raw 6 > dump.lvm2
file dump.lvm2

# mapper et activer la partition lvm
sudo kpartx -a -v gitlab_camelot.lvm2
sudo lvscan
sudo lvchange -a y /dev/ubuntu-vg/ubuntu-lv
sudo lvscan

# monter la partition en lecture seule
sudo mkdir /ubuntu
sudo mount -o ro /dev/ubuntu-vg/ubuntu-lv /ubuntu/
ncdu /ubuntu
```

## Investigation : Autopsy

> Autopsy c'est la vie !

## Data recovery

`file` permet d'identifier le type d'un fichier.

`photorec` est un outil de récupération de fichiers.

`testdisk` est un outil de récupération de partition, il permet entre autre de parcourir des partitions sans avoir à les monter :
```bash
testdisk found_in_server_room.img
# Advanced > List
```

`extundelete`.

## Carving

`binwalk`

## Timeline

### Timeline rapide

`fls` de sleuthkit.

### Super timeline

plaso

Timesketch

## Windows Prefetch

When a program is run in Windows, it stores its information for future use. This stored information is used to load the program quickly in case of frequent use. This information is stored in prefetch files which are located in the `C:\Windows\Prefetch` directory.
Prefetch files have an extension of `pf`. Prefetch files contain the last run times of the application, the number of times the application was run, and any files and device handles used by the file.

For parsing a whole directory, we can use the following command :
```bash
PECmd.exe -d <path-to-Prefetch-directory> --csv <path-to-save-csv>
```

## Windows 10 Timeline

Windows 10 stores recently used applications and files in an SQLite database called the Windows 10 Timeline. It contains the application that was executed and the focus time of the application. The Windows 10 timeline is at `C:\Users\<username>\AppData\Local\ConnectedDevicesPlatform\{randomfolder}\ActivitiesCache.db` :
```bash
WxTCmd.exe -f <path-to-timeline-file> --csv <path-to-save-csv>
```

## Windows Jump Lists

## Exemple d'une investigation

Pour chaque étape, noter ce qui est fait, par qui, quand dans la chaîne of custody :
1. vérifier les hash des images disque (SHA256)
   - faire les hash d'un directory : https://worklifenotes.com/2020/03/05/get-sha256-hash-on-a-directory/
2. faire les timelines avec `fls`
   1. mactime -z
3. récupérer les logs (.evtx, .log)
4. récupérer les hives utilisateurs (Windows only)

## Memory analysis : Volatility

> *Volatility n'est qu'un parser, il ne fait pas l'analyse à votre place*, Maki, 2022

- savoir et ne pas oublier ce qu'on cherche
- ne pas trop se fier aux outils
- ne pas hésiter à tester

Comparaison entre la version 2 et 3 : https://blog.onfvp.com/post/volatility-cheatsheet/

### Profil de mémoire

```bash
# identifier le profil de mémoire
volatility -f memory.raw imageinfo

# tester et utiliser celui qui trouve le plus de process
volatility -f memory.raw imageinfo --profile=PROFILE pslist
```

Si le profil n'est pas reconnu, on va le créer :
1. identifier la version `strings dump.raw | grep -i "linux version"`
2. installer une VM avec l'OS identifié
   1. créer le profile de mémoire
3. copier le zip dans `plugins/overlays/linux/`
4. trouver le profile avec `volatility --info`, et l'utiliser

<!-- Le script :
```bash
#!/bin/bash
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility/tools/linux/ && make
cd ../../../
zip $(lsb_release -i -s)_$(uname -r)_profile.zip ./volatility/tools/linux/module.dwarf /boot/System.map-$(uname -r)
``` -->

Tips : vagrant pour récupérer l'OS déjà installé

### Commandes

Commandes intéréssantes :
```bash
# linux_mount
ramfs		/mnt/confidential		ramfs		rw,relatime

# linux_enumerate_files | grep "/mnt/confidential"
0xffff95a89ac72260		22114		/mnt/confidential/flag.txt

# linux_find_file -i 0xffff95a89ac72260 -O flag.txt
# cat flag.txt
C0D3N4M34P011011
```

- pstree
- malfind : indique les injections DLL et les shellcodes, c'est à l'humain d'interpréter ce qui est anormal
- netscan
- screenshot

### Sur Windows

Sur Windows, le fichier `hiberfil.sys` contient la mémoire vive de l'ordinateur.

L'outil [winpmem](https://winpmem.velocidex.com/) permet de faire un dump de la mémoire.

Regarder la mft
