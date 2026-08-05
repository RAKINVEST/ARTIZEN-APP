# Contract Validation — Validation des contrats

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../contracts/CONTRACT_INDEX.md](../contracts/CONTRACT_INDEX.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Valider les **26 catégories de contrats** : API, DTO, Events, Commands, Queries, Errors, versionnement, compatibilité.

## Contrôles transverses
| Contrôle | Résultat |
|---|---|
| API : verbe, entrée, sortie, statuts | couverts ([../contracts/API_CONTRACTS.md](../contracts/API_CONTRACTS.md)) |
| DTO définis et versionnés | oui ([../contracts/DTO_CONTRACTS.md](../contracts/DTO_CONTRACTS.md)) |
| Événements (nom, charge, producteur/consommateur) | oui ([../contracts/EVENT_CONTRACTS.md](../contracts/EVENT_CONTRACTS.md)) |
| Commands / Queries séparés (CQRS documentaire) | oui |
| Enveloppe d'erreur `{error:{code,message}}` | unique et cohérente ([../contracts/ERROR_CONTRACTS.md](../contracts/ERROR_CONTRACTS.md)) |
| Statuts HTTP normalisés (401/403/404/409/413/415/422/429) | cohérents avec [../implementation/ERROR_HANDLING.md](../implementation/ERROR_HANDLING.md) |
| Versionnement sémantique | [../contracts/VERSIONING_POLICY.md](../contracts/VERSIONING_POLICY.md) |
| Compatibilité (additif ; rupture → version majeure + ADR) | [../contracts/COMPATIBILITY_RULES.md](../contracts/COMPATIBILITY_RULES.md) |
| Sécurité (JWT, tenant → 404, rate-limit) | [../contracts/SECURITY_CONTRACTS.md](../contracts/SECURITY_CONTRACTS.md) |

## Cohérence code ↔ contrat (vérifiée sur invariants réels)
| Invariant réel (CLAUDE.md) | Contrat correspondant | Cohérent ? |
|---|---|---|
| `company_id` du JWT, jamais du client | SECURITY / API | Oui |
| Tenant mismatch → 404 (pas 403) | ERROR / SECURITY | Oui |
| Pas de PUT/PATCH sur `/quotes` ; PUT `/status` | COMMAND / API | Oui |
| Enveloppe d'erreur unique | ERROR | Oui |
| Upload borné (413/415) + garde de corps | VALIDATION | Oui |

## Contrats incomplets
Aucune catégorie manquante (26/26). Réserve de **profondeur** : les fiches de catégorie décrivent
la règle et le gabarit, l'énumération exhaustive endpoint-par-endpoint s'enrichit au fil du
développement (dette D4), **le contrat restant la référence** — le code s'y adapte, jamais l'inverse.

## Le principe directeur (rappel)
> Le contrat est la référence ; le code s'adapte au contrat, jamais l'inverse.
Confirmé cohérent sur toute la chaîne Flux → Contrats → Implémentation.

## Acceptance Criteria
Les 26 catégories sont validées et cohérentes avec les invariants de code ; aucune catégorie absente.

## Related Documents
[../contracts/CONTRACT_PATTERNS.md](../contracts/CONTRACT_PATTERNS.md) · [TRACEABILITY_REPORT.md](TRACEABILITY_REPORT.md)

## Next Reading
[QUALITY_SCORECARD.md](QUALITY_SCORECARD.md)

## Changelog
- 1.0 (2026-08-02) — Validation initiale.
