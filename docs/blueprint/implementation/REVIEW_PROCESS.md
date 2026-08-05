# Review Process — Revue de code

> **Version** 1.0 — **Status** Frozen — **Owner** Lead — **Last Update** 2026-08-02
> **Depends On:** [QUALITY_STANDARD.md](QUALITY_STANDARD.md) — **Used By:** toute PR — **Niveau:** 3 · Implémentation

## Objective
Procédure officielle : aucune PR n'est fusionnée sans revue conforme.

## Grille de revue (une PR doit vérifier)
| Axe | Contrôle |
|---|---|
| **Architecture** | respecte Blueprint/Domain/Engines/Flows/Contracts ; pas de cycle |
| **Réutilisation** | prouve qu'aucun moteur/objet/contrat/événement/API existant ne répond déjà |
| **Qualité** | seuils [QUALITY_STANDARD.md](QUALITY_STANDARD.md) |
| **Lisibilité** | nommage, *pourquoi* commenté (anglais) |
| **Complexité** | fonctions courtes, pas de géant |
| **Sécurité** | [SECURITY_GUIDELINES.md](SECURITY_GUIDELINES.md) (secrets, tenant, validation) |
| **Performance** | [PERFORMANCE_GUIDELINES.md](PERFORMANCE_GUIDELINES.md) |
| **Tests** | présents aux bons niveaux, verts |
| **Documentation** | technique + Blueprint si impact architectural |
| **Compatibilité** | contrats compatibles ou ADR |

## Règles
- Une PR = une intention claire, taille raisonnable.
- Au moins un relecteur ; l'auteur ne s'auto-valide pas.
- Toute remarque bloquante est résolue avant merge.
- **ultrareview** disponible (revue multi-agent cloud) — déclenchée par l'utilisateur, jamais par l'agent.

## Forbidden
Merge sans revue · contourner une remarque bloquante · PR fourre-tout.

## Acceptance Criteria
Chaque PR fusionnée coche tous les axes de la grille.

## Related Documents
[DONE_DEFINITION.md](DONE_DEFINITION.md) · [BRANCHING_STRATEGY.md](BRANCHING_STRATEGY.md)

## Next Reading
[CI_CD_POLICY.md](CI_CD_POLICY.md)

## Changelog
- 1.0 (2026-08-02) — Procédure initiale.
