# Intervention Types — Types d'intervention

> **Version** 1.0 — **Status** Validated (éditorial) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md) — **Used By:** cards, filtres, workflow

## Objective
Classer **le geste** d'une carte. Axe `intervention:`. Vocabulaire contrôlé, extensible.

## Vocabulaire officiel (`intervention:`)
| Slug | Sens |
|---|---|
| `installer` | poser un équipement neuf |
| `mettre-en-service` | démarrer/paramétrer après installation |
| `deposer` | retirer un équipement existant |
| `remplacer` | déposer + installer à l'identique/équivalent |
| `reparer` | remettre en état sans remplacer |
| `depanner` | rétablir en urgence un fonctionnement |
| `diagnostiquer` | identifier une cause/état |
| `controler` | vérifier conformité/état (avec relevé) |
| `verifier` | contrôle simple, sans relevé formel |
| `entretenir` | maintenance préventive périodique |
| `nettoyer` | remise en propreté / après-chantier |
| `regler` | ajuster un paramètre |
| `modifier` | changer une configuration existante |
| `renover` | reprise/rénovation d'un ouvrage |
| `creer` | créer un ouvrage/réseau nouveau |
| `raccorder` | connecter à un réseau/alimentation |
| `mettre-aux-normes` | mise en conformité réglementaire |
| `mettre-hors-service` | consigner / neutraliser |

## Règles
- Une carte porte **au moins un** `intervention:` (souvent un seul principal).
- Ne pas confondre avec la **sous-famille** (thème) ni le **problème** (symptôme).
- Extensible sans changement de structure ; synonymes → [ALIASES.md](ALIASES.md).

## Décompte
**18 types d'intervention** (extensible).

## Changelog
- 1.0 (2026-08-02) — Vocabulaire initial (18).
