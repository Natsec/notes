# Reverse Engineering and Malware Analysis

## Dynamic analysis

> *[CAPE](https://github.com/kevoreilly/CAPEv2) is the captain now*, [Captain Jack Sparrot](https://www.reddit.com/r/AnimalsBeingDerps/comments/thfshg/what_an_epic_gamer/) circa 1588

## Android

Pour décompresser une sauvegarde Android non chiffrée :
```bash
# ajoute un header tar pour pouvoir extraire l'archive
(printf "\x1f\x8b\x08\x00\x00\x00\x00\x00"; tail -c +25 backup.ab) | tar -xzvf -
```

Pour décompiler :
- un apk : [JADX](https://github.com/skylot/jadx) (existe en gui)
- un jar : [Java Decompiler](http://java-decompiler.github.io/) (existe en gui)

Emulateur Android :
```shell
# lister les images d'émulateurs existants
emulator -list-avds

# lancer l'image avec le noyau original
emulator -avd Pixel_4_API_29

# lancer l'image à froid avec un autre noyau
emulator -avd Pixel_4_API_29 -kernel bzImage -wipe-data
```

## Debugger

Pour lancer :
```bash
gdb <binaire>
```

| Commande                                               | Description                                                                 |
| ------------------------------------------------------ | --------------------------------------------------------------------------- |
| [p](https://visualgdb.com/gdbreference/commands/print) | Prints the value of a given expression.                                     |
| p/x                                                    | affiche en hexadécimal                                                      |
| [x](https://visualgdb.com/gdbreference/commands/x)     | Displays the memory contents at a given address using the specified format. |
| x/8x                                                   | affiche 8 octets en hexadecimal                                             |
| x/8i                                                   | affiche 8 instructions en assembleur                                        |
| macro define offsetof(t, f) &((t *) 0)->f              | définit une macro nommée offsetof                                           |

```gdb
# afficher l'adresse d'une fonction/variable
(gdb) p [fonction/&variable]

# afficher le contenu d'une fonction en hexadécimal
(gbd) x/8x [fonction]

# afficher le contenu d'une fonction en assembleur
(gbd) x/4i [fonction]

# afficher les champs d'une structure S
(gdb) pt struct S
(gdb) pt/o struct S

# afficher l'offset d'un champ F dans une structure S
(gdb) p offsetof(struct S, F)
```
