# Python

- [Lire/Ecrire un fichier](#lireecrire-un-fichier)
- [Requêtes](#requêtes)
- [Regex](#regex)
- [Color print](#color-print)
- [Distance de Levenshtein](#distance-de-levenshtein)
- [Brute force](#brute-force)

## Lire/Ecrire un fichier

```python
# lire
f = open("input.txt", "r", encoding='utf-8')
# ligne par ligne
for line in f.readlines():
    line = line.strip()
    print(line)
# texte entier
text = f.read()
f.close

# ecrire
f = open("output.txt", "w")
f.write("Mon texte")
f.close
# OU
with open("output.txt", "w") as f:
    f.write("Mon texte")
```

## Requêtes

https://realpython.com/python-requests/

https://blog.bearer.sh/making-api-requests-with-python/

```python
import requests

response = requests.get("http://web.cryptohack.org/jwt-secrets/create_session/kamil/")
print(response.text)

jwt = response.json()["session"]
```

## Regex

```python
match = re.findall('motif(.+)', line)
if match:
    print(match)
    print(match[0])
    for m in match:
        print(m)
```

## Color print
```python
import builtins
def print(*args):
    """Override of the builtin print function.

    This function prints text in color for better visibility.

    Args:
        *args (obj): Variable number of argument without keywords.
    """
    builtins.print("\033[34m[INFO] ", end="")
    builtins.print(*args)
    builtins.print("\033[0m", end="")
```

## Distance de Levenshtein

https://rosettacode.org/wiki/Levenshtein_distance#Python :
```python
def levenshtein(s1,s2):
    if len(s1) > len(s2):
        s1,s2 = s2,s1
        distances = range(len(s1) + 1)
        for index2,char2 in enumerate(s2):
            newDistances = [index2+1]
            for index1,char1 in enumerate(s1):
                if char1 == char2:
                    newDistances.append(distances[index1])
                else:
                    newDistances.append(1 + min((distances[index1],distances[index1+1],newDistances[-1])))
        distances = newDistances
    return distances[-1]
```

## Brute force

Pour générer une wordlist :
```python
import itertools

alphabet = "abcdefghijklmnopqrstuvwxyz"
taille = 4
espace = len(alphabet) ** taille
print(espace)

for n in range(1, taille+1):
    for key in itertools.product(alphabet, repeat=n):
        key = ''.join(key)
        print(key)
```
