# YARA

YARA is a tool aimed at (but not limited to) helping malware researchers to identify and classify malware samples. With YARA you can create descriptions of malware families (or whatever you want to describe) based on textual or binary patterns. Each description, a.k.a. rule, consists of a set of strings and a boolean expression which determine its logic.

[Documentation](https://yara.readthedocs.io/)

## Utilisation basique

On crée le fichier `myrule.yar` :
```yara
rule rulename
    {
        meta:
            author = "tryhackme"
            description = "test rule"
            created = "21/12/2021 16:09"
        strings:
            $textstring = "text"
            $hexstring = {4D 5A}
        conditions:
            $textstring and $hexstring
    }
```

Pour lancer un scan :
```bash
yara [options] myrule.yar <file|dir>
# -m : show metadata of matching rule
# -c : count match
# -n : negate match
```
