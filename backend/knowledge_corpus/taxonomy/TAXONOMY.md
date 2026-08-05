# Taxonomy — Vue d'ensemble

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** contributeurs, moteurs, IA

## Objective
Décrire la structure globale de classement et le mapping avec la taxonomie gelée.

## Deux origines, une seule cohérence
| Origine | Axes | Autorité |
|---|---|---|
| **Gelée (domaine)** | famille, activité (=profession), qualification | `catalog/trades/taxonomy.py` — **miroir** ici |
| **Éditoriale (corpus)** | sous-famille, intervention, problème, matériau, outil, équipement, pièce, bâtiment, client, projet, marque | **ce dossier** |

## Ossature métier (gelée — rappel)
**Familles (6) → Activités (62) → Qualifications d'exercice (4)** + **Certifications d'entreprise (7, transverses)**.
Le modèle gelé **n'a pas** de niveau « sous-famille » : la sous-famille est un **raffinement éditorial**
sous l'activité, qui **n'altère pas** l'ossature ([SUB_FAMILIES.md](SUB_FAMILIES.md)).

## Convention de tag (rappel)
`axe:valeur` en `kebab-case` sans accent (voir [TAG_RULES.md](TAG_RULES.md)). Axes canoniques :
`famille:` · `activite:` (alias `metier:`) · `sous-famille:` · `intervention:` · `probleme:` ·
`materiau:` · `outil:` · `equipement:` · `piece:` · `batiment:` · `client:` · `projet:` · `marque:`.

## Règle de classement (résumé)
Une connaissance appartient à **une seule branche principale** par axe métier (une activité), mais peut
porter **plusieurs facettes** sur les autres axes. Détail : [TAG_RULES.md](TAG_RULES.md).

## Changelog
- 1.0 (2026-08-02) — Vue d'ensemble initiale.
