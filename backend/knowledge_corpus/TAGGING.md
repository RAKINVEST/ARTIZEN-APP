# Tagging — Taxonomie de tags

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../TAXONOMIE-METIERS.md](../TAXONOMIE-METIERS.md), [SEARCH_STRATEGY.md](SEARCH_STRATEGY.md) — **Used By:** contributeurs, recherche

## Objective
Fournir une **taxonomie de tags** cohérente et extensible, permettant la recherche multi-axes sans
duplication de contenu. Les tags sont des **facettes** portées par la carte (objet `Knowledge`).

## Convention de tag
- Format : `axe:valeur`, en `kebab-case`, sans accent. Ex. `metier:plomberie`, `equipement:chauffe-eau`.
- Un axe peut être multi-valué (`materiau:cuivre`, `materiau:per`).
- Vocabulaire **extensible** mais **contrôlé** : une nouvelle valeur passe par la relecture (éviter les synonymes).

## Les 11 axes officiels
| Axe | Préfixe | Source / vocabulaire | Exemple |
|---|---|---|---|
| Métier | `metier:` | **taxonomie officielle gelée** ([../TAXONOMIE-METIERS.md](../TAXONOMIE-METIERS.md)) | `metier:plomberie` |
| Famille | `famille:` | familles/activités de la taxonomie | `famille:sanitaire` |
| Problème | `probleme:` | vocabulaire éditorial contrôlé | `probleme:fuite` |
| Équipement | `equipement:` | vocabulaire éditorial | `equipement:chauffe-eau` |
| Matériau | `materiau:` | vocabulaire éditorial | `materiau:cuivre` |
| Pièce | `piece:` | vocabulaire éditorial | `piece:salle-de-bain` |
| Marque | `marque:` | vocabulaire éditorial | `marque:grohe` |
| Complexité | `complexite:` | `simple` / `moyenne` / `avancee` / `expert` | `complexite:moyenne` |
| Urgence | `urgence:` | `programmee` / `rapide` / `urgente` | `urgence:urgente` |
| Saison | `saison:` | `printemps`/`ete`/`automne`/`hiver`/`toute-saison` | `saison:hiver` |
| Type d'intervention | `type:` | `installation`/`reparation`/`entretien`/`diagnostic`/`renovation` | `type:reparation` |

## Règles
- **Métier/Famille** : la source de vérité est la **taxonomie officielle** ; **ne pas** créer de
  valeur concurrente (slugs gelés). Toute divergence se résout vers la taxonomie.
- Les autres axes ont un **vocabulaire éditorial** : contrôlé, sans synonymes (voir GOVERNANCE).
- Un tag ne **remplace jamais** une relation structurée ([RELATIONSHIP_RULES.md](RELATIONSHIP_RULES.md)) :
  le tag classe, la relation lie.

## Extensibilité
De nouvelles valeurs de vocabulaire sont ajoutées **sans changer la structure** (contenant stable).
Un **nouvel axe** de tag relèverait d'une décision (revue éditoriale documentée).

## Changelog
- 1.0 (2026-08-02) — Taxonomie initiale (11 axes).
