# Engine Lifecycle — Cycle de vie d'un moteur

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [ENGINE_MAP.md](ENGINE_MAP.md) — **Used By:** engines/, implementation — **Niveau:** 2 · Architecture

## Objective
Décrire les phases de vie d'un moteur et les conditions sous lesquelles il peut évoluer, être remplacé ou déprécié — sans jamais casser l'existant (Loi 17).

## Phases
| Phase | Contenu |
|---|---|
| **Création** | un moteur naît avec un **consommateur réel** (Loi 17) ; sinon il n'est que *spécifié* (fiche), pas construit. |
| **Initialisation** | frontière, objets possédés, contrat public et événements déclarés (fiche du moteur). |
| **Configuration** | via Settings ; aucune valeur métier codée en dur. |
| **Utilisation** | dialogue par événements/contrats ; jamais d'accès sauvage. |
| **Migration** | évolution compatible (API + événements) ; schémas d'événements versionnés/upcastés. |
| **Dépréciation** | statut `Deprecated`, remplaçant désigné ; les consommateurs migrent à leur rythme. |
| **Remplacement** | un nouveau moteur reprend la responsabilité ; l'ancien reste tracé (ADR *superseded*). |
| **Suppression** | seulement quand plus aucun consommateur ; les **données** métier ne sont jamais détruites (Loi 5). |

## Règles d'évolution (sinon ADR obligatoire)
Un moteur évolue **sans ADR** uniquement si **toutes** ces conditions tiennent :
1. sa **responsabilité** reste identique ;
2. son **API/contrat** reste compatible ;
3. ses **événements** restent cohérents (pas de rupture de schéma) ;
4. son **Domain Owner** (objets possédés) reste identique.

Sinon → **ADR** ([../templates/ADR_TEMPLATE.md](../templates/ADR_TEMPLATE.md)), décision tracée, ancien état *superseded* (jamais effacé).

## Acceptance Criteria
Les 8 phases sont définies ; les 4 conditions d'évolution sont explicites.

## Related Documents
[ENGINE_GUIDELINES.md](ENGINE_GUIDELINES.md) · [../adr/README.md](../adr/README.md)

## Next Reading
[ENGINE_GUIDELINES.md](ENGINE_GUIDELINES.md)

## Changelog
- 1.0 (2026-08-02) — Cycle de vie initial.
