# Moteur — <Nom>

> **Version** 0.1 — **Status** Draft — **Owner** <équipe> — **Last Update** AAAA-MM-JJ
> **Depends On:** [../domain/](../domain/README.md) — **Used By:** <contrats, moteurs> — **Niveau:** 2 · Architecture

## Objective
<Rôle unique du moteur.>

## Responsibilities
| Fait | Ne fait **jamais** |
|---|---|
| … | … |

## Consumes (événements / entrées)
<Événements de domaine écoutés, ou données lues (par DTO/événement, jamais internes).>

## Produces (sorties)
<Ce que le moteur produit (suggestions, read-models, indicateurs…). Toute sortie décisionnelle porte confiance + justification (Loi 6).>

## Public Contract
<Renvoi vers le document de contrat correspondant (contracts/).>

## Constraints
Consommateur réel requis avant construction (Loi 17). Un moteur read-side ne mute jamais un agrégat cœur (Loi 7).

## Rules
<Règles propres au moteur, avec références aux lois.>

## Forbidden
Dépendre d'un autre moteur par appel direct. Contenir une logique spécifique à un métier.

## Acceptance Criteria
Tableau Fait/Ne fait jamais complet · contrat public déclaré · dépendances listées.

## Related Documents
## Next Reading
## Changelog
- 0.1 (AAAA-MM-JJ) — Création.
