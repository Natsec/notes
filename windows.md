# Windows

- [Principes](#principes)
  - [Permissions](#permissions)
  - [GPO](#gpo)
  - [Privileges](#privileges)
  - [Windows Privilege Escalation Vectors](#windows-privilege-escalation-vectors)
  - [Initial Information Gathering](#initial-information-gathering)
- [Forensic](#forensic)
  - [Ruches de registre](#ruches-de-registre)
  - [MFT](#mft)
- [PowerShell](#powershell)
- [Mots de passe](#mots-de-passe)
  - [Mot de passe dans SYSVOL](#mot-de-passe-dans-sysvol)
  - [Kerberoast](#kerberoast)
- [Partage](#partage)
- [Liens utiles](#liens-utiles)

---

> *In case of doubt, reboot*, Rowan Atkinson

## Principes

### Permissions

Pour check/set les permissions :
```bash
icacls <dossier>
# I  - permission inherited from the parent container
# F  - full access (full control)
# M  - modify right/access
# OI - object inherit
# IO - inherit only
# CI - container inherit
# RX - read and execute
# AD - append data (add subdirectories)
# WD - write data and add files
```

### GPO

Mettre à jour les GPO :
```bash
gpupdate /force
```

### Privileges

On a typical Windows server, you may find several different account types :
- **Domain Administrators** : This is typically the highest account level you will find in an enterprise along with Enterprise Administrators. An account with this level of privilege can manage all accounts of the organization, their access levels, and almost anything you can think of.
- **Services** : Accounts used by software to perform their tasks such as back-ups or antivirus scans.
- **Domain users** : Accounts typically used by employees. These should have just enough privileges to do their daily jobs. For example, a system administrator may restrict a user's ability to install and uninstall software.
- **Local accounts** : These accounts are only valid on the local system and can not be used over the domain.

### Windows Privilege Escalation Vectors

A few common vectors that could allow any user to increase their privilege levels on a Windows system :
- **Stored Credentials** : Important credentials can be saved in files by the user or in the configuration file of an application installed on the target system.
- **Windows Kernel Exploit** : The Windows operating system installed on the target system can have a known vulnerability that can be exploited to increase privilege levels.
- **Insecure File/Folder Permissions** : In some situations, even a low privileged user can have read or write privileges over files and folders that can contain sensitive information.
- **Insecure Service Permissions** : Similar to permissions over sensitive files and folders, low privileged users may have rights over services. These can be somewhat harmless such as querying the service status (SERVICE_QUERY_STATUS) or more interesting rights such as starting and stopping a service (SERVICE_START and SERVICE_STOP, respectively).
- **DLL Hijacking** : Applications use DLL files to support their execution. You can think of these as smaller applications that can be launched by the main application. Sometimes DLLs that are deleted or not present on the system are called by the application. This error doesn't always result in a failure of the application, and the application can still run. Finding a DLL the application is looking for in a location we can write to can help us create a malicious DLL file that will be run by the application. In such a case, the malicious DLL will run with the main application's privilege level. If the application has a higher privilege level than our current user, this could allow us to launch a shell with a higher privilege level.
- **Unquoted Service Path** : If the executable path of a service contains a space and is not enclosed within quotes, a hacker could introduce their own malicious executables to run instead of the intended executable.
- **Always Install Elevated** : Windows applications can be installed using Windows Installer (also known as MSI packages) files. These files make the installation process easy and straightforward. Windows systems can be configured with the "AlwaysInstallElevated" policy. This allows the installation process to run with administrator privileges without requiring the user to have these privileges. This feature allows users to install software that may need higher privileges without having this privilege level. If "AlwaysInstallElevated" is configured, a malicious executable packaged as an MSI file could be run to obtain a higher privilege level.
- **Other software** : Software, applications, or scripts installed on the target machine may also provide privilege escalation vectors.

### Initial Information Gathering

A few key points in enumeration :
- **Users** on the target system : The `net users` command will list users on the target system.
- **OS version** : The `systeminfo | findstr /B /C: "OS Name"/C: "OS Version"` command will output information about the operating system. This should be used to do further research on whether a privilege escalation vulnerability exists for this version.
- **Installed services** : the `wmic service list` command will list services installed on the target system.

## Forensic

### Ruches de registre

https://tryhackme.com/room/windowsforensics1

Les fichiers intéréssants sont :
```
C
├── Users
│   ├── Administrator
│   │   ├── AppData
│   │   │   └── Local
│   │   │       └── Microsoft
│   │   │           └── Windows
│   │   │               ├── UsrClass.dat
│   │   │               ├── UsrClass.dat.LOG1
│   │   │               └── UsrClass.dat.LOG2
│   │   ├── NTUSER.DAT
│   │   ├── ntuser.dat.LOG1
│   │   └── ntuser.dat.LOG2
│   └── arthur
│       ├── AppData
│       │   └── Local
│       │       └── Microsoft
│       │           └── Windows
│       │               ├── UsrClass.dat
│       │               ├── UsrClass.dat.LOG1
│       │               └── UsrClass.dat.LOG2
│       ├── NTUSER.DAT
│       ├── ntuser.dat.LOG1
│       └── ntuser.dat.LOG2
└── Windows
    ├── appcompat
    │   └── Programs
    │       ├── Amcache.hve
    │       ├── Amcache.hve.LOG1
    │       └── Amcache.hve.LOG2
    └── System32
        └── config
            ├── RegBack
            │   ├── DEFAULT
            │   ├── SAM
            │   ├── SECURITY
            │   ├── SOFTWARE
            │   └── SYSTEM
            ├── DEFAULT
            ├── DEFAULT.LOG1
            ├── DEFAULT.LOG2
            ├── SAM
            ├── SAM.LOG1
            ├── SAM.LOG2
            ├── SECURITY
            ├── SECURITY.LOG1
            ├── SECURITY.LOG2
            ├── SOFTWARE
            ├── SOFTWARE.LOG1
            ├── SOFTWARE.LOG2
            ├── SYSTEM
            ├── SYSTEM.LOG1
            └── SYSTEM.LOG2

17 directories, 35 files
```

Les fichiers `.LOG` sont les journaux de modification des ruches de registre. Il contiennent des données plus récentes et sont donc à considérer. [Zimmerman's Registry Explorer](https://ericzimmerman.github.io/) permet de les prendre en compte lors de la lecture.

### MFT

Parser une MFT et la lire :
```ps1
.\MFTECmd.exe -f 'C:\users\THM-4n6\Desktop\triage\C\$MFT' --csv parsed-mft.csv
.\MFTECmd.exe -f 'C:\users\THM-4n6\Desktop\triage\C\$BOOT' --csv parsed-mft.csv
```

EZviewer pour regarder les csv.

## PowerShell

```powershell
# afficher en arborescence
tree /f

# lien symbolique
new-item -itemtype symboliclink -path . -name settings.json -value "C:\Users\Kamil\OneDrive\Windows Terminal\settings.json"

# Hash
Get-FileHash filename -Algorithm MD5|SHA256|SHA512
CertUtil -hashfile filename MD5|SHA256|SHA512
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

Pentesting Active Directory mindmap :
- https://www.xmind.net/m/5dypm8/
- https://i.ibb.co/TKYNCNP/Pentest-ad.png
