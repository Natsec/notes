# Forensic (Investigation Numérique)

> *Nul ne peut agir avec l’intensité que suppose l’action criminelle sans laisser des marques multiples de son passage*, Principe d'échange d'Edmond Locard

> https://www.unodc.org/documents/organized-crime/Law-Enforcement/Criminal_Intelligence_for_Analysts.pdf

## Intro

L'objectif est d'obtenir la timeline des actions qui ont menées à l'incident.

Principes :
- on travail jamais sur les preuves, on travail sur leur clone
- on fait l'empreinte des éléments pour respecter la [chain of custody](https://en.wikipedia.org/wiki/Chain_of_custody)

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

## Memory analysis : Volatility

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
