# Contracts

> **Version** 2.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../engines/README.md](../engines/README.md), [../events/README.md](../events/README.md) — **Used By:** implementation, ui, ai — **Niveau:** 2 · Architecture

## Objective
Définir le **langage officiel** de toute communication dans Artizen : moteurs, API, Flutter, IA, événements, futurs services. **Le contrat est la référence ; le code s'y adapte, jamais l'inverse.** Aucune implémentation ici.

## Contains
| Document | Rôle |
|---|---|
| [CONTRACT_INDEX.md](CONTRACT_INDEX.md) | catalogue + Contract Landscape (Mermaid) |
| [API_CONTRACTS.md](API_CONTRACTS.md) | conventions REST + API Map |
| [EVENT_CONTRACTS.md](EVENT_CONTRACTS.md) | conventions événements + Event Map |
| [COMMAND_CONTRACTS.md](COMMAND_CONTRACTS.md) | commandes (écritures) |
| [QUERY_CONTRACTS.md](QUERY_CONTRACTS.md) | lectures (pagination, tri, recherche) |
| [DTO_CONTRACTS.md](DTO_CONTRACTS.md) | objets échangés + DTO Map |
| [ERROR_CONTRACTS.md](ERROR_CONTRACTS.md) | bibliothèque d'erreurs normalisées |
| [VALIDATION_RULES.md](VALIDATION_RULES.md) | validations (syntaxe/métier/relations…) |
| [VERSIONING_POLICY.md](VERSIONING_POLICY.md) | breaking/minor/patch/deprecated/removed |
| [SECURITY_CONTRACTS.md](SECURITY_CONTRACTS.md) | auth, scopes, JWT, audit |
| [COMPATIBILITY_RULES.md](COMPATIBILITY_RULES.md) | rétro/forward-compat + matrice + Dependency Graph |
| [CONTRACT_PATTERNS.md](CONTRACT_PATTERNS.md) | patrons de contrat |
| [CONTRACT_ANTI_PATTERNS.md](CONTRACT_ANTI_PATTERNS.md) | anti-patterns |
| [contracts/](contracts/) | une fiche par catégorie de contrat |

## Navigation
**Pourquoi :** stabiliser les frontières pour évoluer 10 ans (Loi 17). **Public :** architectes, dev, IA. **Avant :** [../engines/README.md](../engines/README.md). **Après :** [../implementation/README.md](../implementation/README.md). **Dépendants :** implementation, ui, ai.

## Rules
Tout échange est **décrit avant d'être implémenté**. Toute sortie décisionnelle porte confiance + justification (Loi 6). Enveloppe d'erreur unique `{error:{code,message}}`. Tout contrat est versionné.

## Forbidden
DTO God · payload ambigu · champ sans propriétaire · erreur générique · version implicite · breaking change silencieux · null inexpliqué · formats multiples.

## Acceptance Criteria
Tous les contrats documentés · API couvertes · événements décrits · erreurs normalisées · validations et compatibilité définies · diagrammes présents.

## Related Documents
[../templates/API_TEMPLATE.md](../templates/API_TEMPLATE.md) · [../templates/CONTRACT_TEMPLATE.md](../templates/CONTRACT_TEMPLATE.md)

## Next Reading
[CONTRACT_INDEX.md](CONTRACT_INDEX.md)

## Changelog
- 2.0 (2026-08-02) — Contracts Specifications figées (Step 5) : 13 documents + fiches.
- 1.0 (2026-08-02) — Section créée (Step 1).
