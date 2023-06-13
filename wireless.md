# Wireless

## RFID

Tag RFID :
```bash
# apt install nfclib-bin
nfc-scan-device -v
nfc-list -v

# crack and dump mifare tag data to file
mfoc -O tag.mfd
```

## Bettercap

```bash
apt install bettercap
```

Pour lancer un caplet :
```bash
bettercap -caplet mon_script.cap
```

TODO Man in the middle :
```bash
bettercap
    net.prob
    net.show
```

### Caplets TODO

### Afficher les machines du réseau local
```bash
# com
bettercap -caplet mon_script.cap
```

### Afficher les equipements bluetooth autour de soi
```bash
# com
bettercap -caplet mon_script.cap
```
