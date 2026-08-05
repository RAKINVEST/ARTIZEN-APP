# Engine Anti-Patterns — Erreurs interdites & recouvrements

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [ENGINE_GUIDELINES.md](ENGINE_GUIDELINES.md) — **Used By:** revue de tout moteur — **Niveau:** 2 · Architecture

## Objective
Interdire les mauvaises structures et **signaler les recouvrements** entre les 40 moteurs demandés (deux moteurs ne résolvent jamais le même problème — Loi 1).

## Anti-patterns interdits
| Anti-pattern | Pourquoi | À faire |
|---|---|---|
| **Engine God** | responsabilités multiples | scinder |
| **Engine fourre-tout** | pas de frontière | une responsabilité par moteur |
| **Dépendance circulaire** | évolution impossible | événement/contrat |
| **Accès direct aux données d'un autre moteur** | couplage fort, viole les frontières | référence par id / événement |
| **Couplage fort** | rigidité | contrats stables |
| **Duplication** | deux moteurs, un problème | consolider (ci-dessous) |
| **Responsabilités multiples** | ambiguïté | découper |
| **Services cachés** | contournement des contrats | tout service est déclaré |

## Recouvrements à consolider (parmi les 40 demandés)
| Moteurs qui se recouvrent | Décision |
|---|---|
| **Analytics** ≈ **Performance** ≈ **Reporting** | une **famille read-side** : Performance (calcul), Reporting (vue). « Analytics » n'est pas un moteur distinct → alias de Performance. |
| **OCR** ⊂ **Document Analysis** | OCR est une capacité interne de l'analyse, pas un moteur métier séparé. |
| **Authentication** + **Authorization** | infrastructure d'accès (deux responsabilités distinctes mais L0) ; aucune logique métier. |
| **Storage** + **PDF** + **Media** | infrastructure : Storage (octets), PDF (rendu), Media (Document/Photo). Ne possèdent aucun objet métier hormis Media→Document. |
| **Catalog** = **Business Library** | même contexte ; **Kit** et **Phrase Library** en sont des sous-parties (objets Kit/Phrase), pas des contextes rivaux. |
| **Billing** ⊂ **Commercial Documents** | avec Quote ; partagent la famille « document commercial ». |
| **Conversation** ⊂ **AI** | Conversation = l'objet AIConversation ; AI = le fournisseur. L'IA n'décide jamais (Loi 7/18). |
| **Import/Export** ↔ **Quote Extraction** ↔ **Document Analysis** | pipeline d'échange/analyse ; responsabilités distinctes mais coordonnées, jamais fusionnées. |
| **Audit** vs **History** | distincts (sécurité vs journal métier), même famille « journal » append-only ; jamais fusionnés ni dupliqués. |
| **Supplier** | un seul moteur (L2) ; l'entrée dupliquée en L7 de la carte est une coquille signalée ici. |

## Règle
Avant de créer un moteur, vérifier qu'il n'est pas un **alias** d'un moteur existant (tableau ci-dessus). Sinon → alias documenté, pas de nouveau moteur.

## Acceptance Criteria
Les anti-patterns majeurs et tous les recouvrements des 40 moteurs sont documentés avec leur résolution.

## Related Documents
[ENGINE_MAP.md](ENGINE_MAP.md) · [ENGINE_BOUNDARIES.md](ENGINE_BOUNDARIES.md)

## Next Reading
[engines/](engines/)

## Changelog
- 1.0 (2026-08-02) — Anti-patterns et recouvrements initiaux.
