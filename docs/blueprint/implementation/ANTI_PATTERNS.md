# Implementation Anti-Patterns — Pratiques interdites

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [ENGINEERING_GUIDE.md](ENGINEERING_GUIDE.md) — **Used By:** revue — **Niveau:** 3 · Implémentation

## Objective
Nommer les pratiques bannies pour qu'une revue puisse les refuser sans débat.

## Anti-patterns d'ingénierie
| Anti-pattern | Pourquoi interdit | Règle opposée |
|---|---|---|
| **Infrastructure spéculative** | moteur/couche « au cas où » sans besoin réel (Loi 17) | Build Product, Not Infrastructure |
| **Réinvention** | recréer un objet/moteur/contrat existant | réutilisation prouvée |
| **Duplication de calcul** | recalculer un montant hors du calculateur unique | un seul lieu calcule (ADR-023) |
| **`float` pour l'argent** | arrondis faux | `Decimal` + `ROUND_HALF_UP` par ligne |
| **`except:` nu / `except Exception`** | masque les bugs | exceptions typées par domaine |
| **Secret/PII en log ou en dur** | fuite de sécurité | variables d'environnement, logs propres |
| **`company_id` venant du client** | fuite inter-tenant | `company_id` du contexte |
| **Cycle de dépendances** | couplage ingérable | dépendances à sens unique |
| **Moteur qui décide** | trahit la promesse | l'artisan décide (Loi 7/18) |
| **Read-side qui écrit dans le cœur** | corrompt la source unique | moteurs en lecture d'événements |
| **Destruction de donnée métier** | irréversible | archiver, jamais supprimer (Loi 5) |
| **Jargon face à l'artisan** | casse « deux langues » | vocabulaire artisan |
| **Contrat cassé sans ADR** | rupture silencieuse | compatible ou versionné + ADR |
| **TODO permanent / code mort** | dette cachée | supprimer ou traiter |
| **Merge sans revue/tests** | régression | DoD + revue obligatoires |

## Acceptance Criteria
Aucun de ces anti-patterns n'apparaît dans un diff fusionné.

## Related Documents
[CHECKLISTS.md](CHECKLISTS.md) · [DONE_DEFINITION.md](DONE_DEFINITION.md) · [../domain/DOMAIN_ANTI_PATTERNS.md](../domain/DOMAIN_ANTI_PATTERNS.md)

## Next Reading
[README.md](README.md)

## Changelog
- 1.0 (2026-08-02) — Anti-patterns initiaux.
