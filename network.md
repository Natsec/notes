# Network

## Wireshark

tshark :
```bash
# afficher les champs d'une capture réseau
tshark -r data.pcap -T fields -e frame.time_delta
```
Pour reconstituer une conversation téléphonique à partir d'une capture réseau :
```wireshark
Telephony > RTP > RTP stream
```

Pour suivre un flux TCP :
```wireshark
R-click paquet > Follow > TCP stream
```

Pour déchiffrer un flux TLS 1.2 :
```wireshark
R-click paquet > Protocol Preference > Transport Layer Security > RSA keys list ...
```
>Marche pas si un algo de chiffrement offrant la **P**erfect **F**orward **S**ecrecy est utilisé par TLS, sauf si l'échange était en debug et qu'on a les logs des identifiants de session.
