# Author Guide — Guide du rédacteur

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../EDITORIAL_GUIDE.md](../EDITORIAL_GUIDE.md), [CONFIDENCE_MODEL.md](CONFIDENCE_MODEL.md), [SOURCE_POLICY.md](SOURCE_POLICY.md) — **Used By:** auteurs, IA

## Objective
Comment **rédiger** une carte de niveau industriel. Complète (n'annule pas) [../EDITORIAL_GUIDE.md](../EDITORIAL_GUIDE.md).

## Règles de rédaction
| Sujet | Règle |
|---|---|
| **Style** | impératif, direct, orienté geste ; phrases courtes ; **montrer** plutôt qu'expliquer |
| **Niveau de détail** | suffisant pour exécuter sans ambiguïté ; ni survol ni thèse ; une carte = une opération |
| **Terminologie** | vocabulaire **artisan** (deux langues) ; termes de la [taxonomie](../taxonomy/README.md) ; pas de jargon d'ingénierie |
| **Neutralité** | aucune préférence de marque non justifiée techniquement ([../taxonomy/BRAND_RULES.md](../taxonomy/BRAND_RULES.md)) |
| **Illustrations / captures** | schémas légendés ; une illustration doit **servir le geste**, pas décorer |
| **Photos** | terrain réelles, **sans donnée personnelle/identifiante** ; via l'objet `Photo`/`Media` (référence) |
| **Sources** | chaque information sourcée + **niveau de confiance** ([CONFIDENCE_MODEL.md](CONFIDENCE_MODEL.md), [SOURCE_POLICY.md](SOURCE_POLICY.md)) |
| **Références** | normes/DTU cités précisément ; **jamais** de norme inventée ou approximative |

## Obligations
- Partir du [modèle officiel](../cards/CARD_TEMPLATE.md) ; renseigner **tags** et **relations**.
- Marquer le **niveau de confiance** de chaque information clé (A/B/C/D).
- Aucun prix/TVA (le montant vit dans `Catalog`/calculateur — ADR-023).

## Rôle de l'IA côté rédaction
Proposer un brouillon, compléter des champs, reformuler, suggérer relations/tags, signaler un doublon.
**Toute sortie IA = Brouillon** à relire ; l'IA **n'invente pas** (traçable aux sources).

## Interdits
Publier soi-même · inventer une norme · photo avec donnée personnelle · jargon à l'écran · carte fourre-tout.

## Changelog
- 1.0 (2026-08-02) — Guide initial.
