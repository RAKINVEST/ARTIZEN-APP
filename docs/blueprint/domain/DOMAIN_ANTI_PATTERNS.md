# Domain Anti-Patterns — Erreurs interdites & règles de modification

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [DOMAIN_PATTERNS.md](DOMAIN_PATTERNS.md) — **Used By:** revue de tout nouvel objet — **Niveau:** 2 · Architecture

## Objective
Lister les erreurs de modélisation **interdites** et fixer les conditions sous lesquelles un objet peut évoluer (sinon : ADR obligatoire).

## Anti-patterns interdits
| Anti-pattern | Pourquoi interdit | À faire à la place |
|---|---|---|
| **Doublon d'objet** (un second « Mission ») | viole la source unique (Loi 1) | une seule Mission ; référencer |
| **Moteur propriétaire secondaire** | ambiguïté de propriété | un seul propriétaire par objet |
| **Dépendance circulaire** | rend l'évolution impossible (Loi 17) | passer par un événement/DTO |
| **Fusion de deux responsabilités** | objet fourre-tout | scinder en deux objets |
| **Champ sans justification métier** | dette et ambiguïté | ne rien ajouter sans besoin réel |
| **Agrégat « Catalog » générique** | fourre-tout de la Business Library | Article/Kit/Phrase distincts |
| **3 objets concurrents pour les fichiers** (Document/Photo/Attachment séparés et égaux) | duplication de responsabilité | Document = propriétaire ; Photo/Attachment = facettes |
| **Fusionner Event / History / Audit** | usages distincts | trois modèles de la même famille, séparés |
| **Écriture cœur par un moteur read-side** | viole Loi 7 | le moteur propose, l'UI écrit |
| **Suppression d'une donnée métier** | viole Loi 5 | archiver / remplacer / historiser |
| **Inventer une valeur** pour satisfaire une contrainte | viole « la source est la vérité » | laisser vide et signaler |

## Règles de modification d'un objet
Un objet métier ne peut évoluer **sans ADR** que si **toutes** ces conditions restent vraies :
1. sa **responsabilité** reste identique ;
2. son **propriétaire** reste identique ;
3. ses **invariants** sont préservés ;
4. ses **événements** restent compatibles (pas de rupture de schéma).

Si l'une saute → **ADR obligatoire** (voir [../templates/ADR_TEMPLATE.md](../templates/ADR_TEMPLATE.md)), décision tracée, ancien état *superseded* (jamais effacé).

## Acceptance Criteria
Les anti-patterns majeurs sont listés ; les 4 conditions de modification sont explicites.

## Related Documents
[DOMAIN_PATTERNS.md](DOMAIN_PATTERNS.md) · [OBJECT_RULES.md](OBJECT_RULES.md) · [../adr/README.md](../adr/README.md)

## Next Reading
[objects/](objects/)

## Changelog
- 1.0 (2026-08-02) — Anti-patterns et règles de modification initiaux.
