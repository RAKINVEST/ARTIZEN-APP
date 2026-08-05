# Knowledge Objects — Propriétaires, utilisés, référencés

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../engines/Knowledge.md](../engines/Knowledge.md), [../../domain/objects/Knowledge.md](../../domain/objects/Knowledge.md) — **Used By:** KNOWLEDGE_GRAPH — **Niveau:** 2 · Architecture

## Objective
Lister **exactement** les objets manipulés par le moteur, par rôle, **sans en créer aucun**.

## Objets propriétaires (le moteur les possède et les écrit)
| Objet | Justification (fiche gelée) |
|---|---|
| **`Knowledge`** | propriétaire unique = Knowledge (fiche moteur + fiche objet) |

> **C'est le seul objet possédé.** La Knowledge Card = `Knowledge`. Aucun autre objet créé.

## Objets utilisés (le moteur s'en sert, ne les possède pas)
| Objet | Usage | Écriture ? |
|---|---|---|
| **`Media`** | pièces jointes d'une fiche (photos, schémas) — « Objets utilisés » de la fiche moteur | non (référence/attache) |

## Objets référencés en lecture (contexte, par id, via événements)
Repris des « Objets liés » de l'objet `Knowledge` (gelé) : le moteur les **référence par id**, en
**lecture seule**, jamais en écriture.
| Objet | Rôle pour la Card | Interdit |
|---|---|---|
| `Mission` | d'où le savoir est tiré | **écrire Mission** (interdit explicite) |
| `Intervention` | l'opération concernée | écrire |
| `Photo` | illustration terrain | écrire |
| `Document` | pièce liée (rapport, notice) | écrire |

## Objets exposés (ce que le moteur restitue à l'extérieur)
Le moteur expose **`Knowledge`** (la Card) et ses **projections** (vues), en lecture, via
contrats/événements — jamais la base d'un autre moteur. Voir [KNOWLEDGE_VIEWS.md](KNOWLEDGE_VIEWS.md).

## Interdits (frontière)
- Créer, renommer, déplacer un objet du Domain Model → **ADR requis** (non fait ici).
- Écrire `Mission` ou tout objet non propriétaire.

## Conformité (STEP 1–8)
- Propriétaire/utilisés/interdits **identiques** à la fiche moteur gelée. ✅
- Objets référencés = « Objets liés » gelés de `Knowledge`. ✅
- Aucun objet nouveau. ✅

## Related Documents
[KNOWLEDGE_GRAPH.md](KNOWLEDGE_GRAPH.md) · [KNOWLEDGE_RELATIONS.md](KNOWLEDGE_RELATIONS.md)

## Next Reading
[KNOWLEDGE_GRAPH.md](KNOWLEDGE_GRAPH.md)

## Changelog
- 1.0 (2026-08-02) — Spécification initiale.
