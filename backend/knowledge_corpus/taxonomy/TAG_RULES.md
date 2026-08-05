# Tag Rules — Règles de classement

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md), [ALIASES.md](ALIASES.md) — **Used By:** contributeurs, moteurs

## Objective
Fixer **toutes** les règles de classification de la taxonomie.

## Règles fondamentales
1. **Une seule branche principale.** Une carte appartient à **une** activité principale (`activite:`) et
   **une** famille (déduite). Les autres axes sont des **facettes** (multi-valuées).
2. **Slugs stables.** `axe:valeur` en `kebab-case` sans accent. Un slug identifie **une** chose, pour toujours.
3. **Métier gelé.** `famille:`/`activite:`/qualification = **miroir** de la taxonomie gelée ; jamais
   renommés/supprimés ici (source : `catalog/trades`).
4. **Alias autorisés.** Un même concept peut avoir des alias d'entrée (ex. `metier:`→`activite:`,
   « cumulus »→`equipement:chauffe-eau`) — déclarés dans [ALIASES.md](ALIASES.md).
5. **Synonymes documentés, pas dupliqués.** Un synonyme pointe vers le slug officiel ; on ne crée pas
   deux valeurs pour la même chose.
6. **Renommages historisés.** Un libellé peut évoluer ; le **slug** ne change pas. Tout est journalisé.
7. **Suppressions interdites.** Une valeur obsolète est marquée `deprecated`, jamais supprimée (Loi 5).
8. **Évolution structurelle = ADR.** Ajouter un **axe**, un **niveau**, ou toucher au métier gelé exige un ADR.
   Ajouter une **valeur** à un axe éditorial = simple relecture (pas d'ADR).

## Axes officiels (13)
`famille:` · `activite:` (alias `metier:`) · `sous-famille:` · `intervention:` · `probleme:` ·
`materiau:` · `outil:` · `equipement:` · `piece:` · `batiment:` · `client:` · `projet:` · `marque:`.

## Qualité (rappel)
Complète · sans doublon · stable · cohérente · évolutive · compatible recherche IA. Voir [../QUALITY_RULES.md](../QUALITY_RULES.md).

## Changelog
- 1.0 (2026-08-02) — Règles initiales (13 axes).
