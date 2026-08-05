# Knowledge Factory — Vue d'ensemble

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** responsables, experts, IA

## Objective
Décrire la **fabrique** : ses postes, ses rôles, et le principe de **qualité constante à toute échelle**.

## Principe directeur
> **La qualité vient de la chaîne, pas de l'auteur.** Chaque carte traverse les **mêmes postes**,
> subit les **mêmes contrôles**, et n'est publiée que par une **validation humaine**. C'est ce qui
> permet de passer de 10 à 100 000 cartes sans perte de cohérence.

## Les postes (stations)
| Poste | Entrée | Sortie | Acteur |
|---|---|---|---|
| **Cadrage** | idée / besoin / signal terrain | fiche cadrée (titre, taxonomie) | Auteur / IA |
| **Rédaction** | fiche cadrée | Brouillon rempli | Auteur / IA |
| **Enrichissement** | Brouillon | Brouillon complété (média, relations, sources) | Auteur / IA |
| **Contrôle qualité** | Brouillon complété | conforme ou renvoyé | Contrôle / IA |
| **Relecture métier** | Brouillon conforme | exact ou corrections | Relecteur (expert) |
| **Validation** | Brouillon relu | **Validé** (publié) | **Validateur humain** |
| **Amélioration** | carte validée | proposition de nouvelle version | Auteur / IA / terrain |
| **Archivage** | version remplacée | Archivé (historisé) | Responsable |

## Rôles (rappel — [../GOVERNANCE.md](../GOVERNANCE.md))
Auteur · Relecteur · Validateur (expert métier) · Responsable Corpus · **IA (propose seulement)**.

## Rôle de l'IA (opérationnel)
L'IA peut **proposer, compléter, reformuler, relier, détecter des doublons, contrôler la cohérence**.
Elle **ne publie jamais** une carte seule : toute sortie IA est un **Brouillon** entrant dans la chaîne,
validé par un humain (Loi 7/18). Toute proposition IA est **traçable** à ses sources.

## Qualité à l'échelle
Homogénéité par **modèle unique** ([../cards/CARD_TEMPLATE.md](../cards/CARD_TEMPLATE.md)) + **checklist**
+ **score** + **taxonomie**. La montée en volume se gère par le **pipeline** et la **file**
([KNOWLEDGE_PIPELINE.md](KNOWLEDGE_PIPELINE.md), [KNOWLEDGE_QUEUE.md](KNOWLEDGE_QUEUE.md)), jamais en
relâchant les contrôles.

## Changelog
- 1.0 (2026-08-02) — Vue d'ensemble initiale.
