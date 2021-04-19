# Règles d'Audit

- [Objectif du document](#objectif-du-document)
- [Vocabulaire](#vocabulaire)
- [Principe des règles d'audit](#principe-des-règles-daudit)
- [Syntaxe des règles d'audit](#syntaxe-des-règles-daudit)
  - [Paramétrage d'auditd](#paramétrage-dauditd)
  - [Surveillance du système de fichier](#surveillance-du-système-de-fichier)
  - [Surveillance des appels système](#surveillance-des-appels-système)
- [Sources](#sources)

## Objectif du document

L'objectif de ce document est de fournir les informations permettants de **comprendre** et **rédiger** des règles d'audit d'un système Linux.

Il est le plus synthétique/pratique possible. Pour plus de détails, les sources se trouvent à la fin du document.

## Vocabulaire

**auditd** : Service qui intercepte les interactions entre l'espace utilisateur et le noyau du système.

**règle d'audit** : Condition pour qu'auditd génère un évènement lors d'une interception.

**évènement** : Message généré par auditd et qui donne des informations sur ce qu'il s'est passé. Auditd génère plusieurs évènements pour une action (ex: à l'exécution d'un programme, auditd pourra générer une log pour la commande, et une autre pour indique le répertoire de la commande).

## Principe des règles d'audit

Il existe 3 types de règles :
- Les règles qui permettent de **paramétrer** auditd lui-même
- Les règles qui permettent de surveiller les actions sur le **système de fichier**
- Les règles qui permettent de surveiller les **appels système**

Concernant les règles d'appel système, pour chaque interaction avec le noyau :
1. Auditd intercepte l'appel système
2. Parcourt les règles d'audit dans l'ordre de leur déclaration
3. La première règle qui match est traitée

> Comme auditd peut donner beaucoup d'informations sur des évènements qui se produisent souvent, il faut faire attention à l'utilité/quantité/qualité des règles qu'on met en place, et toujours tester avant de mettre en production, puis optimiser dans le temps.

## Syntaxe des règles d'audit

### Paramétrage d'auditd

```bash
# supprime toutes les règles d'audit
-D

# si le buffer de traitement atteint 1000 évènements à traiter, auditd déclenche l'action d'échec
-b 1000
# idem si on atteint 10 d'évènement par seconde
-r 10
# auditd est dans l'état activé
-e 1
# l'action d'échec est d'enregistrer l'évènement dans le journal du noyau
-f 1

# ignore les erreurs lors de la lecture du fichier de conf
-i
```

Il existe 4 principales options de paramétrage d'auditd :
- `-b` backlog limit : Nombre d'évènement dans le buffer de traitement au-delà duquel l'action d'échec est déclenché sur l'évènement.

- `-r` rate limit : Nombre d'évènement par seconde au-delà duquel l'action d'échec est déclenché sur l'évènement.

- `-e` enabled : Etat d'auditd.
  - `0` désactive auditd
  - `1` active auditd
  - `2` active auditd et vérouille la configuration.

- `-f` failure mode : Action à réaliser en état d'échec.
  - `0` silent : auditd ignore l'erreur
  - `1` printk : génère une log d'échec dans le noyau
  - `2` panic : le système s'arrête, c'est la fin du monde

- `-i` ignore errors : ignore les erreurs lors de la lecture du fichier de règles, permet notamment qu'une règle soit ajoutée malgré qu'un fichier/utilisateur n'existe pas encore au démarrage du service

### Surveillance du système de fichier

> Contrairement aux règles d'appel système, les watch n'impactent par les performances en fonction du nombre de règles. Pour surveiller un fichier/dossier, c'est la méthode à privilégier. Si on a besoin d'une règle plus expressive (les accès par root, les utilisateurs humains, etc) on transformera le watch en appel système.

Les règles de surveillance du système de fichier (ou watch) sont de la forme suivante :
```bash
# surveiller les accès en écriture et les changements d'attribut du fichier /etc/passwd
-w /etc/passwd -p wa
# surveiller les exécutions sur tous les fichiers du dossier /bin/
-w /bin/ -p x
```

- `-w` watch : Ajoute une surveillance sur un fichier. Si le fichier est un répertoire, tous les fichiers contenus dedans (récursivement) sont pris en compte, sauf les répertoires qui sont des points de montage.

- `-p` permission : Type d'accès à surveiller (si cette option n'est pas précisée, c'est la valeur `rwxa` qui est appliquée par défaut).
  - `r` : lecture
  - `w` : écriture
  - `x` : exécution
  - `a` : changements d'attribut (ex: changement de permissions, de propriétaire, ...)

- `-k` keyname : Mot-clé servant à identifier l'évènement. On peut répéter plusieurs fois l'options pour associer plusieurs mot-clés à l'évènement.

> Le fichier doit exister avant qu'un watch soit ajouté, TODO à vérifier

### Surveillance des appels système

> Chaque règle d'appel système est ajoutée à un moteur de correspondance qui intercepte chaque appel système de chaque programme de la machine. Une règle d'appel système supplémentaire impacte donc un peu plus les performances du système.

```bash
# intercepter des changements de temps lorsque l'utilisateur original est humain, sur les architectures 32 et 64 bits
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -F auid>=1000 -k T1070.006_2
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S clock_settime -F auid>=1000 -k T1070.006_1

# equivalent à -w /etc/passwd -p rw
-a always,exit -F path=/etc/passwd -F perm=rw
# equivalent à -w /usr/bin/ -p x
-a always,exit -F dir=/usr/bin/ -F perm=x
```

- `-a action,filter` OU `-a filter,action`: Ajoute une surveillance sur des appels système.
  - `action` : Détermine si on doit créer un évènement ou pas.
    - `always` : on crée toujours un évènement
    - `never` : on ne crée jamais un évènement, souvent utilisé pour filtrer les événements très fréquents tôt dans la chaîne
  - `filter` : Type d'appel système à intercepter.
    - `entry` : vérifié à l'entrée d'un appel système, certaines infos comme la valeur de sortie ne sont pas encore disponibles à ce moment, sera déprécié dans le futur, il vaut mieux utiliser le filtre exit
    - `exit` : vérifié à la sortie d'un appel système
    - `user` : vérifié pour certains évènements initiés en espace utilisateur
    - `task` : vérifié seulement pendant les appels système fork/clone, rarement utilisé en pratique
    - `exclude` : pour exclure certains évènements d'être émis. On préférera utiliser l'action `never` pour une meilleur lisibilité

- `-S` syscall : Nom ou numéro de l'appel système à intercepter. Pour gagner en performance, on peut en mettre plusieurs dans une règle en répétant l'option `-S`. Si la machine à superviser comporte des programmes en 32 bit et 64 bit, il faut dupliquer la règle en mettant les filtres `-F arch=b32` et `-F arch=b64` AVANT le -S. Pour optimiser les performances, c'est mieux de mettre la règle 64 bit avant 32 bit.

- `-F` field : Permet d'affiner la recherche. On peut en mettre plusieurs, la règle matchera si tous les champs matchent (ET logique). Il faut mettre le champs `-F arch=` avant les `-S`, et les autres `-F` après. La documentation des champs possible se trouve dans la page de manuel de [auditctl](https://man.cx/auditctl).

Les valeurs de champ `-F` importantes à comprendre sont :
- `auid`: permet de suivre l'uid original d'un utilisateur lorsqu'il lance un processus en changant d'identité. Lors de la connexion initiale d'un utilisateur, auditd enregistre l'uid de celui, si au cours de la session, l'utilisateur change d'identité pour faire une action, l'`auid` permet d'attribuer l'auteur initial. Un `auid` avec la valeur `-1` ou [4294967295](https://en.wikipedia.org/wiki/4,294,967,295#In_computing) indique un utilisateur pour lequel l'`auid` n'est pas défini.
- `euid`: l'uid de l'utilisateur
- `success`: code de retour de l'appel système, `0` pour un échec, `1` pour un succès.

## Sources

- Page de manuel de la commande [auditctl](https://man.cx/auditctl)
- Page de manuel du fichier [audit.rules](https://man.cx/audit.rules)
- [Documentation de SUSE Linux Enterprise](https://documentation.suse.com/sles/15-SP2/html/SLES-all/cha-audit-comp.html#sec-audit-rules)
- [Documentation de Red Hat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-understanding_audit_log_file)
- [Article du MISC](https://connect.ed-diamond.com/GNU-Linux-Magazine/GLMFHS-093/Journalisez-les-actions-de-vos-utilisateurs-avec-Auditd.html)
