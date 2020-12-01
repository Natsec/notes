# Firewall

## FortiGate

### Command Line Interface

La CLI a le même principe de fonctionnement que Cisco.

Credentials par défaut : `admin` et pas de mot de passe.

```shell
# afficher les suggestions
?

# configurer l'adresse ip
config system interface
  edit port1
    set ip 192.168.10.254/24
    set allowaccess ping ssh http https
    next # equivalent de exit
    end  # pour sauver et sortir
```

## StormShield

### Command Line Interface

```shell

```
