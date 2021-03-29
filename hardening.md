# Linux hardening

## Sources

Guides de l'ANSSI : https://www.ssi.gouv.fr/administration/bonnes-pratiques/

Sites :
- https://k-lfa.info/hardening-linux-tips/

## SSH

https://www.ssh.com/ssh/

## Audit de conformité

**Debsecan** trouve les vulnérabilités des paquets installés sur le système :
```bash
sudo apt install debsecan
# afficher les paquets pour lesquels il y a un correctif
debsecan --suite $(lsb_release --codename --short) --only-fixed --format detail
# mettre à jour les paquets concerné
sudo apt update; debsecan --suite $(lsb_release --codename --short) --only-fixed --format packages | xargs -L1 sudo apt install
```

**Lynis** analyse le système d’exploitation :
```bash
sudo apt install lynis
lynis audit system
# exporter le rapport au format HTML
lynis audit system | ansi2html -la > report.html
```
