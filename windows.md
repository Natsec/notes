# Windows

> Dans le doute, reboot

## PowerShell

```powershell
# afficher en arborescence
tree /f

# lien symbolique
new-item -itemtype symboliclink -path . -name settings.json -value "C:\Users\Kamil\OneDrive\Windows Terminal\settings.json"
```

## cours

Pour se connecter en local et pas sur le domaine : `.\username`


Clé AES256 donnée gentiement par Microsoft : `4e 99 06 e8  fc b6 6c c9  fa f4 93 10  62 0f fe e8 f4 96 e8 06  cc 05 79 90  20 9b 09 a4  33 b6 6c 1b` avec IV `00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00`
déchiffrer mot de passe GPP : https://github.com/t0thkr1s/gpp-decrypt/



Kerberoast

https://m0chan.github.io/2019/07/31/How-To-Attack-Kerberos-101.html

https://medium.com/@riccardo.ancarani94/exploiting-unconstrained-delegation-a81eabbd6976
