# Compatibility Rules — Compatibilité & matrice

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [VERSIONING_POLICY.md](VERSIONING_POLICY.md) — **Used By:** tous les contrats — **Niveau:** 2 · Architecture

## Objective
Garantir que producteurs et consommateurs d'un contrat restent compatibles dans le temps.

## Règles
| Notion | Règle |
|---|---|
| **Backward compatibility** | un nouveau producteur reste lisible par un ancien consommateur (ajouts optionnels seulement) |
| **Forward compatibility** | un consommateur ignore les champs inconnus (tolérance) |
| **Migration** | fournie pour tout changement majeur ; événements upcastés |
| **Dépréciation** | statut `Deprecated` + remplaçant + période de support annoncée |
| **Support** | au moins une version majeure antérieure pendant la période de dépréciation |

## Matrice de compatibilité (modèle)
| Contrat | Producteur | Consommateur | Version | Compatibilité |
|---|---|---|---|---|
| Quote DTO | Quote Engine | Flutter, Billing | 1.x | ✅ rétro (ajouts optionnels) |
| `QuoteAccepted` | Quote Engine | Billing, Performance | v1 | ✅ upcasting prévu en v2 |
| REST `/quotes` | API | Flutter | 1.x | ✅ ; breaking → `/v2` + ADR |
| ExtractedQuote DTO | Quote Extraction | Flutter | 1.x | ✅ montants en chaîne (fidélité) |

## Dependency Graph (Mermaid)
```mermaid
flowchart LR
  P1[Quote Engine] -->|Quote DTO v1| C1[Flutter]
  P1 -->|QuoteAccepted v1| C2[Billing]
  P1 -->|QuoteAccepted v1| C3[Performance]
  P2[API /api] -->|REST v1| C1
  P3[Quote Extraction] -->|ExtractedQuote v1| C1
  classDef p fill:#e8e2ff; class P1,P2,P3 p;
```

## Forbidden
Rompre la compatibilité sans version majeure + ADR + migration.

## Acceptance Criteria
Rétro/forward-compat définies ; matrice producteur/consommateur/version/compatibilité fournie ; graphe présent.

## Related Documents
[VERSIONING_POLICY.md](VERSIONING_POLICY.md) · [CONTRACT_PATTERNS.md](CONTRACT_PATTERNS.md)

## Next Reading
[CONTRACT_PATTERNS.md](CONTRACT_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — Règles + matrice + graphe initiaux.
