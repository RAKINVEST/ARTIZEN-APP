# Flow Validation — Validation des flux métier

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../flows/FLOW_INDEX.md](../flows/FLOW_INDEX.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Valider les **40 flux** : scénarios, transitions, états, erreurs, acteurs, permissions.

## Contrôles transverses
| Contrôle | Résultat |
|---|---|
| Scénario nominal décrit | 40/40 |
| Diagramme de séquence (Mermaid) | 40/40 |
| États & transitions | couverts ([../flows/FLOW_STATES.md](../flows/FLOW_STATES.md)) |
| Erreurs & cas limites | couverts ([../flows/FLOW_ERRORS.md](../flows/FLOW_ERRORS.md)) |
| Acteurs identifiés | oui (artisan, système, IA) |
| Permissions | couvertes ([../flows/FLOW_PERMISSIONS.md](../flows/FLOW_PERMISSIONS.md)) |

## Cohérence avec les invariants
| Invariant | Vérifié dans les flux |
|---|---|
| Rien n'est appliqué sans confirmation explicite | import / branding : proposition → validation artisan |
| Un devis se supprime, ne se modifie pas (V2) | flux de statut : pas de PUT/PATCH ; `draft` supprimable ; 409 sinon |
| L'IA ne décide aucun montant | flux assistant : sélection d'articles + quantité relue |
| Traitement long asynchrone | import/OCR/PDF : hors event-loop, notification |

## Transitions d'état (devis) — confirmées
`draft → sent → accepted | refused` (jamais de retour à `draft`), source unique `QUOTE_TRANSITIONS`,
verrou de ligne sur `change_status`/`delete`. Aucun flux ne contredit cette machine.

## Points de vigilance
| Flux (famille) | Constat | Décision |
|---|---|---|
| Import / extraction | recoupe les moteurs OCR / Document-Analysis / Quote-Extraction | aligné sur OD-2 |
| Reporting / analytics | recoupe Performance | aligné sur OD-1 |
Aucune transition manquante ni état orphelin détecté.

## Acceptance Criteria
Les 40 flux sont validés (scénarios, états, erreurs, acteurs, permissions) et cohérents avec les invariants.

## Related Documents
[../flows/FLOW_STATES.md](../flows/FLOW_STATES.md) · [TRACEABILITY_REPORT.md](TRACEABILITY_REPORT.md)

## Next Reading
[CONTRACT_VALIDATION.md](CONTRACT_VALIDATION.md)

## Changelog
- 1.0 (2026-08-02) — Validation initiale.
