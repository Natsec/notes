# Capture The Flag

- Commencer par brancher le câble réseau :wink:
- Lancer Wireshark pour observer ce qu'il se passe sur la ligne

Si on a ferré une bonne info (genre l'IP d'un bon poisson) :
- s'assigner une IP sur le même réseau
- `nmap -sP <net>/<mask>`, noter les IP intéressantes
- `nmap -A -T4 les IP` et noter les services des IP

Si on a trouvé un serveur DNS :
- `echo 'nameserver <ip>' >> /etc/resolv.conf`

## DNS

Mapper un domaine : https://dnsdumpster.com

Pour faire un transfert de zone :
```
dig @<?> AXFR <fqdn ?>
```
