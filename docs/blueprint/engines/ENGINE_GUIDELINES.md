# Engine Guidelines — Qualité & création d'un moteur

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [ENGINE_BOUNDARIES.md](ENGINE_BOUNDARIES.md) — **Used By:** tout nouveau moteur — **Niveau:** 2 · Architecture

## Objective
Fixer les qualités qu'un moteur doit présenter et la procédure pour en spécifier un nouveau.

## Qualités exigées
| Qualité | Signification | Vérifiable par |
|---|---|---|
| **Indépendant** | une responsabilité, une frontière | fiche + matrice |
| **Cohésif (fort)** | tout dans le moteur sert sa responsabilité | revue de fiche |
| **Faiblement couplé** | dialogue par événements/contrats | matrice de dépendances (acyclique) |
| **Observable** | journalise ses actions, expose sa santé | journalisation/observabilité (fiche) |
| **Testable** | logique pure isolable, effets aux frontières | tests de contrat/domaine |
| **Documenté** | fiche complète + contrats | présence des champs |

## Procédure : ajouter un moteur
1. Vérifier un **consommateur réel** (sinon : ne pas créer — Loi 17).
2. Vérifier qu'aucun moteur existant ne porte déjà cette responsabilité (Loi 1).
3. Rédiger la **fiche** (modèle [../templates/ENGINE_TEMPLATE.md](../templates/ENGINE_TEMPLATE.md)) : responsabilité unique, objets possédés, dépendances, événements, contrat, frontières.
4. Déclarer ses **événements** (events/) et son **contrat** (contracts/).
5. Passer la revue anti-patterns ([ENGINE_ANTI_PATTERNS.md](ENGINE_ANTI_PATTERNS.md)).

## Constraints
Un moteur qui échoue à une qualité n'est pas accepté. Aucune responsabilité partagée.

## Acceptance Criteria
Les six qualités sont définies et vérifiables ; la procédure d'ajout est explicite.

## Related Documents
[ENGINE_ANTI_PATTERNS.md](ENGINE_ANTI_PATTERNS.md) · [../templates/ENGINE_TEMPLATE.md](../templates/ENGINE_TEMPLATE.md)

## Next Reading
[ENGINE_ANTI_PATTERNS.md](ENGINE_ANTI_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — Guidelines initiales.
