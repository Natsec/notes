# Network

## Wireshark

Pour suivre des échanges :
- Statistiques
  - Hiérarchie des Protocoles
  - Conversations
  - Endpoints

Pour reconstituer une conversation téléphonique :
```wireshark
Telephony > RTP > RTP stream
```

Pour déchiffrer un flux TLS 1.2 :
```wireshark
R-click paquet > Protocol Preference > Transport Layer Security > RSA keys list ...
```
>Marche pas si un algo de chiffrement offrant la **P**erfect **F**orward **S**ecrecy est utilisé par TLS, sauf si l'échange était en debug et qu'on a les logs des identifiants de session.

## tshark

```bash
# afficher les champs d'une capture réseau
tshark -r data.pcap -T fields -e frame.time_delta
```

| Champ              | Description                     |
| ------------------ | ------------------------------- |
| `frame.time_delta` | Temps entre les trames ethernet |
| `dns.qry.name`     | Nom de la requête DNS           |
