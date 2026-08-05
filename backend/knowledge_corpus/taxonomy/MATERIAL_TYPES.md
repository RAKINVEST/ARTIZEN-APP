# Material Types — Matériaux

> **Version** 1.0 — **Status** Validated (éditorial) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md) — **Used By:** cards, recherche

## Objective
Classer les **matériaux** cités par une carte. Axe `materiau:`. Éditorial (un matériau **n'est pas** un
objet du domaine — cf. corpus RELATIONSHIP_RULES). Vocabulaire contrôlé, extensible.

## Vocabulaire officiel (`materiau:`)
**Canalisations/plomberie** : `pvc` · `per` · `cuivre` · `multicouche` · `pehd` · `pp` · `pvc-pression`
**Métaux** : `acier` · `acier-galvanise` · `inox` · `fonte` · `laiton` · `aluminium` · `zinc`
**Construction** : `beton` · `parpaing` · `brique` · `platre` · `bois` · `placo` · `carrelage` · `verre`
**Isolants** : `laine-de-verre` · `laine-de-roche` · `polystyrene` · `polyurethane`
**Étanchéité/joints** : `silicone` · `mastic` · `bitume` · `epdm`

## Règles
- `materiau:` peut être **multi-valué** sur une carte.
- Une **marque** n'est pas un matériau → axe `marque:` ([BRAND_RULES.md](BRAND_RULES.md)).
- Extensible ; synonymes (ex. « PVC-U ») → [ALIASES.md](ALIASES.md).

## Décompte
**~30 matériaux** répartis en 5 groupes (extensible).

## Changelog
- 1.0 (2026-08-02) — Classification initiale.
