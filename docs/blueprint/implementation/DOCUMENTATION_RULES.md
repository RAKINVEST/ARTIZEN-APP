# Documentation Rules — Règles de documentation

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../quality/CONVENTIONS.md](../quality/CONVENTIONS.md) — **Used By:** tout développement — **Niveau:** 3 · Implémentation

## Objective
Fixer quand et comment documenter.

## Règles
| Type | Quand | Où |
|---|---|---|
| **Doc technique** | tout comportement non trivial | commentaires (anglais, *pourquoi*) + README de module |
| **Doc utilisateur** | fonctionnalité visible artisan | guides produit (français, langage artisan) |
| **Blueprint** | tout **impact architectural** (objet/moteur/événement/contrat/flux) | mise à jour de la section concernée + ADR |
| **ADR** | décision structurante ou rupture de compatibilité | `docs/blueprint/adr/` |
| **Changelog** | toute évolution | `CHANGELOG.md` + entête du document |

## Règles transverses
- Français pour la doc du dépôt, anglais pour les commentaires de code (convention gelée).
- Une information n'existe qu'une fois (Loi 1) ; ailleurs, on **référence**.
- Un document suit le format unique ([../templates/DOCUMENT_TEMPLATE.md](../templates/DOCUMENT_TEMPLATE.md)).

## Forbidden
Impact architectural sans mise à jour du Blueprint · doc dupliquée · terme d'ingénierie dans une doc utilisateur.

## Acceptance Criteria
Toute PR à impact architectural met à jour le Blueprint et, si besoin, crée un ADR.

## Related Documents
[../quality/CONVENTIONS.md](../quality/CONVENTIONS.md) · [DONE_DEFINITION.md](DONE_DEFINITION.md)

## Next Reading
[SECURITY_GUIDELINES.md](SECURITY_GUIDELINES.md)

## Changelog
- 1.0 (2026-08-02) — Règles initiales.
