# Python

- [Python](#python)
	- [Lire un fichier ligne par ligne](#lire-un-fichier-ligne-par-ligne)
	- [Regex](#regex)
	- [Ecrire un fichier](#ecrire-un-fichier)
	- [Distance de Levenshtein](#distance-de-levenshtein)
	- [Brute force](#brute-force)

## Lire un fichier ligne par ligne
Pour lire le fichier entier : `text = f.read()`
```python
f = open("input.txt", "r", encoding='utf-8')
for line in f.readlines():
	line = line.strip()

	print(line)
f.close
```

## Regex
Pour tester : https://regex101.com
```python
match = re.findall('@>(.*?)<@', line)
if match:
	print(match)
	print(match[0])
	for m in match:
		print(m)
```

## Ecrire un fichier
```python
f = open("output.txt", "w")
f.write("Mon texte")
f.close
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
Code Python pour générer une wordlist :
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
