# Forensic

## Autopsy
>Autopsy c'est la vie !

## Volatility

Identifier le profil de mémoire :
```
volatility -f memory.raw imageinfo
```

Tester les différents profils :
```
volatility -f memory.raw imageinfo --profile=PROFILE pslist
```
Utiliser celui qui trouve le plus de process.
