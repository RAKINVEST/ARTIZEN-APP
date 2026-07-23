# Spécification de restitution — la loi du renderer — v1.0

**La constitution du moteur de restitution à l'identique.** Sœur de la
[EXTRACTION_SPEC](EXTRACTION_SPEC.md) : celle-ci régit l'**extracteur** (ce qui
*décrit* la page) ; ce document régit le **renderer** (ce qui la *redessine*).
Figée *avant* toute ligne de code de rendu à l'identique, elle est le contrat par
lequel tout renderer sera jugé. La modifier, c'est amender la constitution — une
nouvelle version numérotée et justifiée.

> Elle découle directement de la [règle d'or de la marque](../../../docs/BRAND.md) :
>
> ### « Je ne vois pas la différence avec le mien. »

---

## Mission critique

La promesse principale d'ARTIZEN, énoncée comme un **objectif technique
mesurable**, pas comme un slogan :

> **Un artisan ne doit pas être capable de distinguer son devis original du devis
> restitué par ARTIZEN.**

Toute décision de développement du renderer sert cette phrase. L'artisan doit
avoir l'impression que **son logiciel d'origine** a produit le document. Le
renderer ne crée jamais un nouveau devis : il **redessine exactement le sien**.

---

## La règle fondamentale — la séparation des rôles

```
Le moteur ne comprend pas le métier.   →  il DÉCRIT   (extracteur — EXTRACTION_SPEC)
L'IA comprend.                          →  elle attribue des rôles (Brique 5)
Le renderer redessine.                  →  il RESTITUE, à l'identique (ce document)
```

Le renderer est **descriptif et déterministe**, comme l'extracteur : il rejoue une
description graphique (`.artizen`), il n'invente aucune forme, aucune couleur,
aucune position. Même `.artizen` → même PDF, octet pour octet
([Replay](EXTRACTION_SPEC.md#6-reproductibilité--le-replay)). Aucune créativité
n'entre ici : c'est précisément ce qui la rend reproductible et mesurable.

---

## Interdiction absolue

Le renderer ne doit **jamais** :

- moderniser le design
- améliorer la lisibilité
- réorganiser les blocs
- choisir une « meilleure » typographie
- harmoniser les espacements
- remplacer une couleur
- simplifier une mise en page
- remplacer une table par une autre
- recréer « dans le même esprit »

**Toutes ces actions sont des régressions**, pas des améliorations — et le
benchmark doit les faire chuter, pas monter. Aucun élément graphique ne peut être
*interprété* : il est redessiné tel qu'il a été décrit, ou il est signalé comme
non restituable, jamais « arrangé » en silence.

---

## Reproduire à l'identique — la checklist

Pour **chaque** élément, restituer sans écart perceptible :

| Géométrie | Texte & typographie | Graphisme | Structure |
|---|---|---|---|
| dimensions de page | police | logo (+ taille, position) | tableaux |
| marges | graisse | images | en-têtes |
| coordonnées X/Y | taille | couleurs de fond | pieds de page |
| largeur des colonnes | couleur exacte | rayons d'arrondis | pagination |
| hauteur des lignes | interligne | épaisseur des bordures | sauts de page |
| alignements | espacement des paragraphes | filets / séparateurs | ordre des blocs |
| espaces blancs | retours à la ligne | signatures | mentions légales |

Les **seuils** de ce qui compte comme « sans écart perceptible » sont ceux, déjà
mesurés, de l'[EXTRACTION_SPEC §4](EXTRACTION_SPEC.md#4-quelles-erreurs-sont-acceptables--les-seuils) :
coordonnée ≤ 0,1 pt, taille de police ≤ 0,25 pt, couleur **ΔE\*ab < 2,0**
(imperceptible à l'œil). Le renderer hérite de ces tolérances : il ne s'accorde
aucune liberté que l'oracle ne tolère déjà.

---

## Le test avant chaque commit

Une seule question, posée avant chaque livraison de code de rendu :

> ### « Un artisan pourrait-il reconnaître lequel est l'original ? »

Si la réponse est **oui**, le travail n'est pas terminé. Ce test est
volontairement subjectif *en plus* d'être mesuré : les chiffres attrapent les
écarts locaux, l'œil attrape ce que les chiffres manquent (un rythme, une densité,
un « air de famille » rompu).

---

## Critères de validation

Un développement du renderer n'est accepté que si **tous** sont vrais :

- ✓ **Oracle ≥ objectif défini** (badge de certification de la source, cf.
  [EXTRACTION_SPEC §5](EXTRACTION_SPEC.md#5-comment-mesurer-le-succès--une-métrique-par-sous-système))
- ✓ **Aucune régression** au benchmark (`--gate`, `--replay`)
- ✓ **[Double Gold](GOLD_STANDARD_PROTOCOL.md) valide** — la référence elle-même est fiable
- ✓ **Comparaison visuelle satisfaisante** — aucune différence perceptible à l'œil,
  original et rendu côte à côte

Le dernier critère est le juge de dernier ressort, inscrit aussi dans les
[SUCCESS_CRITERIA](SUCCESS_CRITERIA.md).

---

## Ce que ce moteur *n'est pas* — et l'état honnête aujourd'hui

Cette distinction est vitale, sous peine de rompre la promesse en croyant la
tenir :

- **Le produit livré aujourd'hui (V1/V2)** *applique* l'identité de l'artisan
  (couleurs, logo, coordonnées détectées) sur **la mise en page d'ARTIZEN**. C'est
  « votre identité, notre modèle ». L'« aperçu du rendu » de l'import montre
  précisément cela. C'est utile et honnête **tant qu'on l'appelle « votre identité
  appliquée »** — jamais « votre devis restitué ». Faire passer cet aperçu pour une
  restitution à l'identique serait exactement la rupture de promesse que la règle
  d'or interdit.

- **Le moteur de restitution à l'identique** (ce document) est celui qui, à partir
  du `.artizen` extrait, **redessine la mise en page exacte de l'artisan**. Il est
  **gelé**, en attente du [Starter Corpus](../../Corpus/README.md) (5 devis réels),
  et se développe contre lui, jamais sur un PDF maison (ADR-005). Aucune ligne de
  code de rendu à l'identique n'est écrite sans un document réel qui la justifie.

Autrement dit : *la règle d'or est déjà la loi ; le moteur qui la satisfait
pleinement reste à construire, avec la discipline mesurée du reste du programme.*

---

## Statut

**v1.0 — figée.** Décision fondatrice consignée en
[ADR-019](DECISION_LOG.md). Toute évolution des interdits, de la checklist ou des
critères exige une nouvelle version datée et motivée. Comme pour l'extraction,
c'est ce qui permet au renderer d'évoluer de façon *contrôlée* sans jamais
remettre en cause la promesse qu'il sert.
