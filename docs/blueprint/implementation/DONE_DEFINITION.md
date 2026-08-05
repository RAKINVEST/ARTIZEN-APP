# Definition of Done — Définition de « terminé »

> **Version** 1.0 — **Status** Frozen — **Owner** Lead — **Last Update** 2026-08-02
> **Depends On:** [REVIEW_PROCESS.md](REVIEW_PROCESS.md) — **Used By:** toute tâche — **Niveau:** 3 · Implémentation

## Objective
Un critère unique et non négociable de « terminé ». Une tâche non conforme n'est **pas** terminée.

## Definition of Done
Une tâche est *Done* quand **tout** est vrai :

1. **Conforme au Blueprint** — respecte Domain / Engines / Flows / Contracts ; aucun cycle introduit.
2. **Réutilisation prouvée** — aucun moteur/objet/événement/contrat/API existant ne répondait déjà (sinon on l'a réutilisé).
3. **Contrat respecté** — le code suit le contrat ; toute évolution est compatible ou porte un ADR.
4. **Tests** — présents aux bons niveaux, verts ; un bug corrigé a son test de non-régression.
5. **Qualité** — analyse statique/format verts ; seuils [QUALITY_STANDARD.md](QUALITY_STANDARD.md) tenus.
6. **Sécurité** — [SECURITY_GUIDELINES.md](SECURITY_GUIDELINES.md) respecté ; aucun secret dans le diff.
7. **Erreurs & observabilité** — enveloppe d'erreur + bons statuts ; actions significatives traçables.
8. **Deux langues** — aucun terme d'ingénierie face à l'artisan ; langage artisan à l'écran.
9. **Étoile polaire** — la tâche aide l'artisan à retrouver/restituer son identité (sinon elle n'aurait pas dû être développée).
10. **Documentation** — technique à jour ; Blueprint + ADR si impact architectural ; CHANGELOG.
11. **Revue** — PR relue et approuvée ; remarques bloquantes résolues.
12. **Migrations** — s'il y en a : relues, sans perte de donnée.

## Forbidden
Déclarer *Done* sans tests, sans revue, sans doc à jour, ou en violant un invariant produit.

## Acceptance Criteria
La checklist de DoD ([CHECKLISTS.md](CHECKLISTS.md)) est cochée intégralement.

## Related Documents
[CHECKLISTS.md](CHECKLISTS.md) · [../constitution/](../constitution/)

## Next Reading
[CHECKLISTS.md](CHECKLISTS.md)

## Changelog
- 1.0 (2026-08-02) — Définition initiale.
