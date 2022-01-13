# Firewall

- [nftables](#nftables)
- [Stormshield (Airbus)](#stormshield-airbus)
- [FortiGate (Fortinet)](#fortigate-fortinet)
- [VPN IPsec](#vpn-ipsec)

---

## nftables

```bash
sudo apt install nftables
```

Editer le fichier `/etc/nftables.conf` :
```bash
#!/usr/sbin/nft -f

# on supprime toutes les règles
flush ruleset

table inet filter {
  chain INPUT {
    # politique par défaut à drop
    type filter hook input priority 0; policy drop;

    # trafic local (127.0.0.1)
    iif lo counter accept
    # retour des paquets correspondants à des connexions déjà établies
    ct state {established, related} accept
    # protocole ICMP (dont les pings)
    ip protocol icmp accept
    # connexions SSH
    tcp dport ssh accept
    # on log les paquets droppés
    limit rate 10/minute log prefix "dropped "
  }

  chain FORWARD {
    # le serveur n'est pas un routeur, donc on drop tout
    type filter hook forward priority 0; policy drop;
  }

  chain OUTPUT {
    # on considère le serveur comme de confiance,
    # il peut initier des connections
    type filter hook output priority 0; policy accept;
  }
}
```

Activation du lancement du service au démarrage, puis lancement du service :
```bash
sudo systemctl enable iptables
sudo systemctl start iptables
```

Pour afficher les règles qui sont appliquées actuellement :
```bash
nft list table filter
```

## Stormshield (Airbus)

Credentials par défaut : `admin:adminadmin`.

Il existe deux cli, la cli de base et la cli propriétaire :
```shell
# afficher les interfaces et changer une adresse ip
ifinfo
ifconfig em1 192.168.2.254/24

cli
    config network interface address add ifname=in address=192.168.X.254 mask=24
    config network interface activate

    # reset de la config par défaut
    defaultconfig

    # sauvegarder la configuration
    config backup list=all > /tmp/backup_xxxx.na
```

## FortiGate (Fortinet)

Credentials par défaut : `admin` et pas de mot de passe.

La CLI a le même principe de fonctionnement que Cisco :
```shell
? # afficher les suggestions

# afficher les interfaces


# configurer l'adresse ip
config system interface
    edit port1
        set ip 192.168.10.254/24
        set allowaccess ping ssh http https
        next # equivalent de exit
        end  # pour sauver et sortir

```

## VPN IPsec

Penser à :
- créer une route vers le LAN distant
- créer deux règles de pare-feu (dans chaque sens)
    - src : iface LAN
    - dest : iface du tunnel IPsec
