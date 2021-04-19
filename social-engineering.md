# Social Engineering

- [La pyramide du Social Engineering](#la-pyramide-du-social-engineering)
  - [1. OSINT (Open Source Intelligence)](#1-osint-open-source-intelligence)
    - [Non-Technical OSINT](#non-technical-osint)
    - [Technical OSINT](#technical-osint)
  - [2. Développement du prétexte](#2-développement-du-prétexte)
    - [L'approche](#lapproche)
    - [Le modèle DISC](#le-modèle-disc)
  - [3. Plan d'attaque](#3-plan-dattaque)
  - [4. Lancement de l'attaque](#4-lancement-de-lattaque)
  - [5. Compte rendu](#5-compte-rendu)
- [Se protéger](#se-protéger)

---

> [Social Engineering: The Science of Human Hacking, 2nd Edition](https://www.chasse-aux-livres.fr/prix/111943338X/social-engineering-hadnagy), Christopher Hadnagy.

Christopher Hadnagy définit l'ingénierie sociale comme *tout acte qui influence une personne à faire une action, qui pourrait ou ne pas être, dans son intérêt*.

Les utilisations mal intentionnées de l'ingénierie sociale peuvent être classées en 3 vecteurs d'attaque :
- Texte : Interaction minimale, comprend le [phishing](https://en.wikipedia.org/wiki/Phishing) et leurs variantes.
- Voix : Interaction en temps réel avec la cible. Il faut pouvoir s'adapter à l'interlocuteur
- Impersonation : l'attaquant se fait passer physiquement pour quelqu'un qu'il n'est pas. Requiert le plus de compétence, de moyens (humains/financiers), et de préparation.

L'être humain est un être vivant social, et c'est dans notre instinct d'aider notre semblable.

L'ingénierie social tire profit du fait qu'il existe dans la société des biais

## La pyramide du Social Engineering

Cette représentation permet de comprendre l'ordre et l'importance des différentes étape de la réalisation d'une attaque, sous l'angle d'un professionel dont le but est de faire réaliser au client ses vulnérabilités, et lui permettre de comprendre ce qui peut être amélioré, pour mieux se protéger.

![The SE Pyramid](assets/se-pyramid.jpg)

1. OSINT (Open Source Intelligence)
2. Développement du prétexte
3. Plan d'attaque
4. Lancement de l'attaque
5. Compte rendu

### 1. OSINT (Open Source Intelligence)

L'OSINT, pour Open Source Intelligence, consiste à se renseigner sur une personne/entreprise, à partir d'informations disponibles publiquement. C'est la partie essentielle de l'ingénierie sociale, sur laquelle l'attaquant passe le plus de temps. Pour se protéger, on peut éviter d'exposer trop d'informations publiquement, comme sur les réseaux sociaux. Il existe des moyens techniques de récolter ces informations (recherche google), et non techniques (discussion, observation). Pour l'attaquant il convient de bien documenter ses recherches, pour mieux les exploiter plus tard.

#### Non-Technical OSINT

Par l'**observation**, un attaquant peut obtenir des informations utiles :
- aux vêtements (y'a-t-il un code vestimentaire ?)
- les points d'entrée et de sortie du lieu
- les conditions d'entrée
- la sécurité du périmètre (caméras ?)
- le personnel de sécurité
- équipements

#### Technical OSINT

Outils :
- Moteur de recherche des fuites d'information : https://intelx.io/about
- Moteur de recherche de l'Internet des objets : https://www.shodan.io/
- Pour s'entraîner au GEOINT : https://www.geoguessr.com/
- Maltego
- Recon-ng
- theHarvester
- SpiderFoot
- Google Dork : https://www.sans.org/security-resources/GoogleCheatSheet.pdf
- `robot.txt` des sites
- Métadonnées des fichiers

Acronymes :
- https://www.acronymfinder.com/
- https://acronyms.thefreedictionary.com/

https://www.social-engineer.org/framework/

### 2. Développement du prétexte

Cette partie consiste à trouver une raison valable de rentrer en contact avec la cible. Partie cruciale qui peut grandement faciliter la tâche de l'attaquant s'il s'est bien renseigné. C'est aussi ici que l'attaquant détermine s'il aura besoin d'équipements (c'est plus facile de rentrer quelque part avec une échelle sous le bras).

#### L'approche

> citation p63.

Que ce soit le modèle de Shannon-Weaver ou le modèle SMCR de Berlo, pour qu'il y ait communication, il faut :
1. un expéditeur (humain, machine)
2. un message
3. un canal (la voix dans l'air, un texte dans un fil)
4. un destinataire (humain, machine)

Quand une personne nous approche pour interagir avec nous, on a tendance à se demander :
- Qui est-tu ?
- Que veux-tu ?
- Es-tu une menace ?
- Combien de temps ça va prendre ?

Si l'attaquant répond à ces 4 questions dans les premiers instants de l'interaction, il peut influencer la communication. Bien sûr ce n'est pas une vérité universelle, mais c'est ce qu'un attaquant aura tendance à faire pour mettre à l'aise sa cible. Comprendre cela permet de mieux s'en protéger.

#### Le modèle DISC

Plutôt que d'etablir le profil psychologique d'un individu rapidement, ce qui peut conduire à des erreurs d'interprétation, le modèle DISC de William Moulton Marston se concentre sur la compréhension du profil de communication d'une personne. Cette compréhension permet de mieux s'adapter à l'interlocuteur lors de l'approche initiale, et de construire une relation de confiance.

Il existe différentes descriptions de l'acronyme DISC, mais Chris.H utilise :
- **D**irect
- **I**nfluent
- **S**upporteur
- **C**onsciencieux

Pour connaître ton profil de communication, il suffit de se poser deux questions :
1. Est-tu plus **direct** ou **indirect** dans ta façon de communiquer ? Tu vas au point rapidement ou tu prend ton temps ?
2. Est-tu plus orienté sur les **tâches** ou sur les **personnes** ? Quand tu doit faire une tâche, tu t'occupe plus de faire la tâche ou de trouver des personnes qui vont t'aider à l'accomplir ?

En fonction de ces deux réponses, on peut se placer sur le modèle DISC, qui nous permet de connaître notre profil de communication :

![The DISC model](assets/se-disc.jpg)

Ainsi, en fonction de notre profil de communication, l'attaquant va adapter sa manière de communiquer pour mieux nous convaincre.

Bien communiquer permet de construire un rapport de confiance avec une personne, et de lui donner envie de nous aider. Le modèle DISC n'est pas un outil magique, et comme tout outil, on peut l'utiliser de manière bienveillante, ou malveillante, tout dépend de nous.

> *Leave them feeling better for having met you*, Chris.H

### 3. Plan d'attaque

Un prétexte ne suffit pas, il faut un plan. Quel est le but de l'attaquant ? Que recherche le client ? Quel est le meilleur moment pour lancer l'attaque ? Qui doit être disponible à tout moment pour pouvoir nous aider ?

### 4. Lancement de l'attaque

Il est important d'être préparé, mais pas au mot prêt, car il faut pouvoir s'adapter aux imprévus, de grandes lignes suffisent.

### 5. Compte rendu

C'est pas fun, mais cette partie permet de faire comprendre au client comment il peut s'améliorer.

## Se protéger

Tout l'enjeu pour se protéger est de reste dans le fonctionneme Beta, pour cela:
- s'assurer de l'identité de la personne
-

L'habit fait le moine

Notre cerveau a évolué en s'adaptant à un monde (environnement, société) qui existe depuis des centaines de milliers d'année, en très peu de temps, ce monde a changé, et notre cerveau est resté le même.
