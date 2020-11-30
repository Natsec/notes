# Capture The Flag

- [Capture The Flag](#capture-the-flag)
	- [Liens](#liens)
	- [Départ](#départ)
	- [Reconnaissance](#reconnaissance)
	- [Pivot](#pivot)
	- [DNS](#dns)
	- [Vulnérabilités](#vulnérabilités)
	- [Participations](#participations)

## Liens
https://www.thehacker.recipes/

## Départ
- Commencer par brancher le câble réseau 😉
- Lancer Wireshark pour observer ce qu'il se passe sur la ligne

Si on a ferré une bonne info (genre l'IP d'un bon poisson) :
- s'assigner une IP sur le même réseau

## Reconnaissance
```bash
# sur les well known services
nmap -T4 -sV --script vulners -oN scan1.txt <net>
# sur tous les ports
nmap -T4 -sV --script vulners -oN scan1.txt <net> -p-
```

Si t'obtiens un accès sur un linux :
```bash
history
ip -br a; echo; ip r
```

## Pivot
Regarder les routes de la machine :
```
ip r
```

## DNS

Si on a trouvé un serveur DNS :
```
echo 'nameserver <ip>' >> /etc/resolv.conf
```

Mapper un domaine : https://dnsdumpster.com

Pour faire un transfert de zone :
```
dig @<?> AXFR <fqdn ?>
```

## Vulnérabilités

Pour chercher des vulnérabilités :
- https://www.exploit-db.com
- https://nvd.nist.gov/vuln/search

ou la commande `searchsploit`

## Participations
L'important c'est de participer hein ? Du coup :
- Rejeu du [RedHack CTF](https://redhack.eu) 2019
- Rejeu du [Norzh CTF](https://norzh-ctf.fr) 2020
- Qualifications du CTF de l'[European Cyber Week](https://www.european-cyber-week.eu) 2020 : 162/249
- CTF [Brigitte Friang](https://www.challengecybersec.fr) 2020 de la DGSE
- CTF [DG'hAck](https://www.dghack.fr) 2020 de la DGA : 343/2063
