# Engine Validation — Validation des moteurs

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../engines/ENGINE_MAP.md](../engines/ENGINE_MAP.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Valider les **40 moteurs** : responsabilité, frontières, dépendances, couplage, événements, propriétaire, interopérabilité.

## Inventaire (40, mesuré)
AI, Analytics, Audit, Authentication, Authorization, Billing, Branding, Catalog, Company,
Conversation, Customer, Document-Analysis, History, Import-Export, Intervention, Kit, Knowledge,
Maintenance, Media, Mission, Notification, OCR, PDF, Performance, Phrase-Library, Planning,
Quote-Extraction, Quote, Reporting, Search, Settings, Site, Stock, Storage, Supplier, Template,
User, Vehicle, Warranty, Workflow.

## Contrôles transverses
| Contrôle | Résultat |
|---|---|
| Responsabilité unique déclarée | Oui pour 40/40 |
| Frontières explicites (ce qu'il ne fait pas) | Oui (fiches STEP 3) |
| Dépendances à sens unique | Oui ; aucun cycle inter-moteurs |
| Couplage via événements (read-side) | Oui — un moteur ne mute pas le cœur (Loi 7) |
| Propriétaire renseigné | Oui |
| Ne décide pas à la place de l'artisan | Oui (Loi 7/18) |

## Chevauchements à arbitrer (non bloquants)
| Moteur | Chevauche | Décision |
|---|---|---|
| `Analytics` | `Performance`, `Reporting` | façades d'un même socle de métriques → OD-1 |
| `Reporting` | `Performance` | idem |
| `OCR` | `Document-Analysis` | étape d'un pipeline → OD-2 |
| `Import-Export` | `Quote-Extraction`, `Document-Analysis` | pipeline d'import → OD-2 |
| `Conversation` | `AI` | capacité conversationnelle du moteur `AI` → OD-5 |
| `Audit` / `History` | famille journal | frontières à graver → OD-3 |

Ces moteurs **restent** au catalogue (interdiction de suppression) ; seule leur relation est consolidée.

## Interopérabilité
Les échanges passent par **événements** et **contrats** ([../contracts/EVENT_CONTRACTS.md](../contracts/EVENT_CONTRACTS.md)),
jamais par appel direct au cœur. Confirmé cohérent avec [../engines/ENGINE_INTERACTIONS.md](../engines/ENGINE_INTERACTIONS.md).

## Asymétrie de structure
~~Le dossier `engines/engines/` ne contenait pas de `_TEMPLATE.md`.~~ **Corrigé pendant l'audit** (A1) :
`engines/engines/_TEMPLATE.md` ajouté — symétrie rétablie avec `domain/objects/`.

## Acceptance Criteria
Les 40 moteurs sont validés ; chevauchements et asymétries tracés ; aucun cycle inter-moteurs.

## Related Documents
[../engines/ENGINE_BOUNDARIES.md](../engines/ENGINE_BOUNDARIES.md) · [OPEN_DECISIONS.md](OPEN_DECISIONS.md)

## Next Reading
[DOMAIN_VALIDATION.md](DOMAIN_VALIDATION.md)

## Changelog
- 1.0 (2026-08-02) — Validation initiale.
