# Intervention Reasoning — Choix & adaptation de l'intervention

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [DECISION_PATTERNS.md](DECISION_PATTERNS.md) — **Used By:** Decision, AI Companion — **Niveau:** 2 · Architecture

## Objective
Décrire comment l'artisan **choisit** et **adapte** son intervention à la situation.

## Choisir l'intervention
- Partir de la **cause** (diagnostic) et de l'**intention** (`intervention:`).
- Comparer les options (réparer / remplacer / entretenir…) selon durabilité, sécurité, coût global, contraintes chantier.
- Retenir l'option qui **sert le client** et respecte **sécurité + conformité** (priorité absolue).

## Adapter l'intervention (facteurs du contexte)
| Facteur | Adaptation |
|---|---|
| Matériau / équipement | méthode et outillage adaptés (`materiau:`/`equipement:`) |
| Pièce / bâtiment | contraintes d'accès, protections |
| Urgence | dimensionnement (dépannage vs solution durable) |
| Saison | pertinence (ex. gel) |
| Compétences / qualifications | ce que l'artisan **a le droit** de faire (qualifs d'exercice) |
| Stock | disponibilité (sinon proposer commande) |

## Règles
- L'adaptation **puise dans des connaissances validées** ; elle **n'invente pas** une méthode.
- Une intervention **hors qualification** de l'artisan est **signalée**, pas proposée comme allant de soi.
- La proposition finale reste **soumise à validation** (Loi 7/18) et **expliquée** ([EXPLAINABILITY.md](EXPLAINABILITY.md)).

## Changelog
- 1.0 (2026-08-02) — Raisonnement d'intervention initial.
