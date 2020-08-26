---
title: Bettercap
description: Notes sur le couteau suisse du MITM
published: true
date: 2020-01-01T21:05:36.945Z
tags: wifi, bettercap
---

# Installation
```
apt update
apt install bettercap bettercap-ui
```
# Utilisation
Pour lancer un caplet :
```
bettercap -caplet mon_script.cap
```
# Caplets
## Afficher les machines du réseau local
```shell
#df
bettercap -caplet mon_script.cap
```
## Afficher les equipements bluetooth autour de soi
```shell
#df
bettercap -caplet mon_script.cap
```
