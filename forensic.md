# Forensic

## Autopsy
>Autopsy c'est la vie !

## Volatility

Identifier le profil de mémoire :
```bash
# 2.6
volatility -f memory.raw imageinfo
```

Tester les différents profils :
```bash
# 2.6
volatility -f memory.raw imageinfo --profile=PROFILE pslist
```
Utiliser celui qui trouve le plus de process.
