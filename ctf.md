# Capture The Flag

## Liens
https://www.thehacker.recipes/

## Départ
- Commencer par brancher le câble réseau 😉
- Lancer Wireshark pour observer ce qu'il se passe sur la ligne

Si on a ferré une bonne info (genre l'IP d'un bon poisson) :
- s'assigner une IP sur le même réseau

## Reconnaissance
```
nmap -T4 -sV --script vulners -oN scan1.txt <net>
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
- Rejeu du [RedHack CTF](https://redhack.eu/) 2019
- Rejeu du [Norzh CTF](https://norzh-ctf.fr/) 2020
- Qualifications du CTF de l'[European Cyber Week](https://www.european-cyber-week.eu/) 2020
- Challenge de la [DGSE](https://www.challengecybersec.fr/) 2020
