# Action Plan — Plan de consolidation

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [TECHNICAL_DEBT.md](TECHNICAL_DEBT.md), [OPEN_DECISIONS.md](OPEN_DECISIONS.md) — **Used By:** planification — **Niveau:** 2 · Architecture

## Objective
Lister **uniquement des actions de consolidation documentaire**. Aucune nouvelle fonctionnalité produit,
aucun élargissement de périmètre (interdiction de mission respectée).

## Actions
| # | Action | Dette/Décision | Priorité | Effort | Statut |
|---|---|---|---|---|---|
| **A1** | Ajouter `_TEMPLATE.md` dans `engines/engines/` (symétrie avec objets) | D1 | Basse | S | ✅ **fait** (audit) |
| **A2** | Aligner les libellés de lien sur leur cible (cosmétique) | D3 | Basse | S | ✅ **fait** (audit) |
| **A3** | Enrichir en profondeur les fiches en série au fil du développement | D4 | Moyenne | continu | continu |
| **A4** | Rédiger un ADR par décision ouverte au moment de son arbitrage | OD-1..7 | Moyenne | M | V2 |
| **A5** | Graver les frontières des familles « journal » et « document » | OD-3/7 | Moyenne | M | V2 |
| **A6** | Planifier le refactor `Company` (sortie du cycle `users↔branding`) | OD-6/D2 | Moyenne | L | V2 |

## Ce que le plan NE fait PAS (garde-fous mission)
- Ne supprime ni n'invente aucun moteur/objet.
- Ne modifie ni la Vision ni les Livres Produit.
- N'étend pas le périmètre. Seule la cohérence est améliorée.

## Séquencement recommandé
1. **Immédiat (consolidation légère)** : A1, A2 — ✅ **réalisés pendant l'audit**.
2. **Au fil du dev** : A3.
3. **V2, par ADR** : A4, A5, A6.

## Acceptance Criteria
Toutes les actions sont documentaires, priorisées, rattachées à une dette/décision ; aucune n'élargit le périmètre.

## Related Documents
[OPEN_DECISIONS.md](OPEN_DECISIONS.md) · [GLOBAL_AUDIT.md](GLOBAL_AUDIT.md)

## Next Reading
[README.md](README.md)

## Changelog
- 1.0 (2026-08-02) — Plan initial.
