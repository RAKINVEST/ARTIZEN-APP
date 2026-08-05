# Decision Patterns — Modèles de décision

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [REASONING_MODEL.md](REASONING_MODEL.md) — **Used By:** Decision, AI Companion — **Niveau:** 2 · Architecture

## Objective
Décrire les **grands modèles de raisonnement** mobilisés selon la situation.

## Les 9 modèles
| Modèle | Question centrale | Priorité dominante |
|---|---|---|
| **Diagnostic** | quelle est la cause ? | exactitude (avant tout geste) |
| **Remplacement** | remplacer ou réparer ? | durabilité / coût global |
| **Réparation** | peut-on réparer durablement ? | rapidité + fiabilité |
| **Maintenance** | prévenir la panne | périodicité / état |
| **Urgence** | rétablir vite et sûr | sécurité + délai |
| **Optimisation** | mieux/moins cher/plus durable | valeur pour le client |
| **Sécurité** | est-ce sûr pour tous ? | **priorité absolue** (jamais négociée) |
| **Prévention** | éviter la récidive | anticipation |
| **Conformité** | respecte-t-on normes/règles ? | légal / assurantiel |

## Règles de sélection du modèle
- **Sécurité et conformité** priment toujours ; un doute de sécurité **suspend** le raisonnement ordinaire.
- Le choix **remplacement vs réparation** s'appuie sur des connaissances **validées**, jamais sur une supposition.
- Plusieurs modèles peuvent se combiner (ex. urgence + sécurité) ; en cas de conflit, **sécurité > conformité > reste**.

## Lien
Chaque modèle mappe des **intentions** ([../engines/decision/DECISION_DOMAIN.md](../engines/decision/DECISION_DOMAIN.md)) et des tags de la [taxonomie](../../knowledge/taxonomy/README.md).

## Changelog
- 1.0 (2026-08-02) — Modèles initiaux (9).
