# Flow Errors — Gestion des erreurs

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [FLOW_PRINCIPLES.md](FLOW_PRINCIPLES.md) — **Used By:** flows/ — **Niveau:** 2 · Architecture

## Objective
Cataloguer les erreurs possibles d'un flux, leur traitement, le rollback et la reprise — pour qu'aucun échec ne laisse le système dans un état incohérent.

## Catalogue d'erreurs
| Erreur | Comportement | Rollback / Reprise |
|---|---|---|
| **Validation impossible** | refus explicite, message clair, aucune persistance | l'artisan corrige et rejoue |
| **Permission refusée** | « introuvable » si cross-tenant, sinon refus | aucune fuite d'existence |
| **Conflit** (édition concurrente) | détecté, l'utilisateur choisit | reprise sur la version à jour |
| **Ressource absente** | 404 métier explicite | pas de création implicite |
| **Échec IA** (extraction/suggestion) | dégradation gracieuse : le flux continue sans la partie IA | reprise possible ; jamais de donnée inventée |
| **Échec OCR** | analyse marquée en échec, l'artisan complète à la main | reprise manuelle |
| **Échec stockage** | l'action métier n'est pas confirmée ; l'objet ne « perd » jamais silencieusement une pièce | réessai ; alerte si persistant |
| **Échec réseau** | opération non validée ; état inchangé | réessai ; file d'attente pour l'asynchrone |
| **Échec d'envoi** (e-mail) | l'action est journalisée ; l'échec ne bloque pas la réponse mais est **remonté** (jamais silencieux) | réessai ; supervision |

## Règles
- Une étape échouée **n'avance pas** l'état : pas d'état à moitié.
- Rollback = compensation métier (ex. brouillon supprimé) ; jamais de destruction d'une donnée capitalisée (Loi 5).
- Tout échec est **journalisé** (History) et, si opérationnel, **remonté** (pas d'échec silencieux).

## Acceptance Criteria
Les 9 familles d'erreurs ont un comportement et une stratégie de reprise.

## Related Documents
[FLOW_PERMISSIONS.md](FLOW_PERMISSIONS.md) · [FLOW_ANTI_PATTERNS.md](FLOW_ANTI_PATTERNS.md)

## Next Reading
[FLOW_PERMISSIONS.md](FLOW_PERMISSIONS.md)

## Changelog
- 1.0 (2026-08-02) — Catalogue d'erreurs initial.
