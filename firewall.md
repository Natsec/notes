# Firewall

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
