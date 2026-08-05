# Decision Scoring — Classement

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [DECISION_RULES.md](DECISION_RULES.md), [DECISION_CONTEXT.md](DECISION_CONTEXT.md) — **Used By:** DECISION_PIPELINE — **Niveau:** 2 · Architecture

## Objective
Définir **comment** les candidats (cartes, kits, phrases, procédures…) sont **classés**. Le scoring
**ordonne** ; il ne **crée** ni ne **modifie** aucune connaissance.

## Facteurs de score (pondérés — indicatifs, calibrables)
| Facteur | Sens | Poids |
|---|---|---|
| **Statut** | Validé > Brouillon | élevé |
| **Confiance** | A > B > C > D | élevé |
| **Pertinence contexte** | correspondance activité/équipement/pièce/saison (tags) | élevé |
| **Préférence utilisateur** | choix passés, habitudes | moyen |
| **Fraîcheur** | dernière version validée récente | faible |
| **Couverture/complétude** | carte complète (relations, sécurité) | moyen |
| **Sécurité/normes** | présence des éléments critiques | élevé (garde) |

## Règles
- Le score **respecte** les priorités dures de [DECISION_RULES.md](DECISION_RULES.md) (un non-validé ne
  passe jamais devant un validé équivalent).
- Poids **calibrables** sans changer la structure ; calcul déterministe (mêmes entrées → même ordre).
- Le scoring **n'écrit rien** ; il produit un **ordre** annoté (pour l'explication).

## Honnêteté
Ce document **spécifie** des facteurs/poids ; **aucune mesure réelle** n'est produite ici. La formule
exacte appartient à l'implémentation (et peut s'appuyer sur Performance).

## Conformité
Ordonne seulement ; respecte règles/confiance ; déterministe ; aucune invention. ✅

## Changelog
- 1.0 (2026-08-02) — Scoring initial.
