# Sub-families — Sous-familles éditoriales

> **Version** 1.0 — **Status** Validated (éditorial, extensible) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [PROFESSIONS.md](PROFESSIONS.md) — **Used By:** classement des cards

## Objective
Fournir un **raffinement éditorial** sous l'activité, pour regrouper les Knowledge Cards. **Ce niveau
n'existe pas dans la taxonomie gelée** : il ne modifie **pas** l'ossature famille→activité, il la
**complète** pour le classement du corpus. Vocabulaire **contrôlé et extensible**.

## Distinctions à ne pas confondre
- Une **sous-famille** classe un **thème** dans une activité (ex. `sous-famille:robinetterie`).
- Un **type d'intervention** (dépannage, entretien…) → [INTERVENTION_TYPES.md](INTERVENTION_TYPES.md), **pas** une sous-famille.
- Une **activité** existante (ex. `traitement-eau`) reste une activité, **pas** une sous-famille.

## Amorce par famille (extensible, `sous-famille:`)
| Famille | Sous-familles éditoriales (amorce) |
|---|---|
| `fluides` | `sanitaire` · `evacuation` · `alimentation` · `production-ecs` · `robinetterie` · `reseaux-gaz` · `aeraulique` · `regulation` |
| `electricite` | `tableau-electrique` · `courants-forts` · `courants-faibles` · `eclairage` · `reseau-vdi` · `securite-electronique` |
| `finition` | `platre-cloisons` · `peinture-decoration` · `sols` · `murs` · `agencement-interieur` |
| `enveloppe` | `charpente-structure` · `couverture-toiture` · `menuiserie-fermetures` · `isolation-thermique` · `facade-bardage` · `etancheite` |
| `gros-oeuvre` | `fondations` · `elevation` · `dallage` · `reseaux-enterres` · `terrassement-vrd` |
| `specialises` | `metallerie` · `motorisation` · `exterieur-paysage` · `services-techniques` · `diagnostic-controle` |

## Règles
- Une sous-famille est **rattachée à une famille** (et pertinente pour ≥ 1 activité).
- Vocabulaire **extensible sans changement de structure** ; pas de synonymes ([ALIASES.md](ALIASES.md)).
- Aucune sous-famille ne duplique une activité ou un type d'intervention.

## Décompte d'amorce
**35 sous-familles** (extensible). Ce n'est pas une liste fermée : de nouvelles valeurs s'ajoutent au fil de l'eau.

## Changelog
- 1.0 (2026-08-02) — Amorce initiale (35 sous-familles éditoriales).
