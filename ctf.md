# Capture The Flag

- [Capture The Flag](#capture-the-flag)
  - [Reconnaissance](#reconnaissance)
    - [Scan de port](#scan-de-port)
    - [TODO Enumération SMB](#todo-enumération-smb)
  - [DNS](#dns)
  - [Cassage de mot de passe](#cassage-de-mot-de-passe)
  - [SQLite](#sqlite)
  - [Vulnérabilités](#vulnérabilités)
  - [Participations](#participations)

Liens :
- https://attack.mitre.org/matrices
- https://www.thehacker.recipes
- https://nicolasb.fr/blog/dghack-my-second-ctf

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

### Scan de port

```bash
# pinguer tout les hôtes d'un réseau (port 80 + ICMP echo-request)
nmap -T4 -sP 192.168.0.0/24

# scan discret (n'envoi que des TCP SYN, moins de chance que les connexions soient loggés)
nmap -T4 -sS <ip>

# OS + info sur les services
nmap -T4 -A -oN scan1.txt <ip>
# scan de vuln
nmap -T4 -sV --script vulners -oN scan1.txt <ip>
# sur tous les ports
nmap -T4 -sV --script vulners -oN scan1.txt <ip> -p-
```

### TODO Enumération SMB

Si les ports `139` et `445` sont ouverts, il y a des chances que SMB tourne sur la machine.

```bash
enum4linux -U <ip>
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
dig @<?> AXFR <fqdn ?>
```

## Cassage de mot de passe

Pour extraire le hash du mot de passe d'un zip : `zip2john file.zip > hash.txt`

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
```

## SQLite

```bash
sqlitebrowser fichier.sqlite
```

## Vulnérabilités

Pour chercher des vulnérabilités :
- https://www.exploit-db.com
- https://nvd.nist.gov/vuln/search

ou la commande `searchsploit`

## Participations

L'important c'est de participer, du coup :
- Rejeu du [RedHack CTF](https://redhack.eu) 2019
- Rejeu du [Norzh CTF](https://norzh-ctf.fr) 2020
- Qualifications du CTF de l'[European Cyber Week](https://www.european-cyber-week.eu) 2020 : 162/249
- CTF [Brigitte Friang](https://www.challengecybersec.fr) 2020 de la DGSE
- CTF [DG'hAck](https://www.dghack.fr) 2020 de la DGA : 343/2082
