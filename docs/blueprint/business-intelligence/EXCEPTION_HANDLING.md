# Exception Handling — Cas particuliers

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [UNCERTAINTY.md](UNCERTAINTY.md), [RISK_ANALYSIS.md](RISK_ANALYSIS.md) — **Used By:** Decision, AI Companion — **Niveau:** 2 · Architecture

## Objective
Décrire comment le raisonnement traite l'**inhabituel** : cas hors modèle, contradictions, situations à risque.

## Types d'exception & conduite
| Exception | Conduite |
|---|---|
| **Situation inconnue** (aucune carte pertinente) | **ne pas inventer** → proposer d'investiguer / faire remonter (enrichissement Corpus, validation humaine) |
| **Contradiction** (sources divergentes) | privilégier la **confiance la plus haute** (A>B>C>D) ; si égal → **demander** |
| **Hors qualification** (travail réservé) | **signaler** et réorienter vers un qualifié ; ne pas proposer comme banal |
| **Risque grave non réductible** | **refus** d'intervention (RISK_ANALYSIS) |
| **Donnée manquante critique** | **suspendre** (UNCERTAINTY) |
| **Demande contraire à la sécurité/norme** | **refuser** poliment + expliquer |

## Règles
- Une exception **n'est jamais masquée** : elle est **explicitée** et, si utile, **remontée** pour enrichir le savoir (via le cycle Knowledge, validation humaine).
- Le raisonnement **dégrade proprement** : à défaut de solution sûre, il **propose une étape sûre** (diagnostic, mise en sécurité) plutôt qu'un geste hasardeux.
- Aucune exception ne justifie d'**inventer** ou de **contourner** la sécurité.

## Changelog
- 1.0 (2026-08-02) — Gestion des exceptions initiale.
