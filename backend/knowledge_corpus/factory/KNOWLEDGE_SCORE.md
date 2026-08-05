# Knowledge Score — Score qualité

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [QUALITY_CHECKLIST.md](QUALITY_CHECKLIST.md), [CONFIDENCE_MODEL.md](CONFIDENCE_MODEL.md) — **Used By:** contrôle qualité, validateurs, métriques

## Objective
Définir un **score qualité** reproductible d'une carte. Le score **complète** la checklist (barrière
oui/non) par une **mesure graduée** ; il ne remplace pas la validation humaine.

## Les 8 dimensions
| Dimension | Ce qu'elle mesure | Poids (indicatif) |
|---|---|---|
| **Complétude** | champs obligatoires + recommandés renseignés | 20 % |
| **Exactitude** | justesse métier (relecture) | 20 % |
| **Lisibilité** | clarté, test des 5 secondes | 10 % |
| **Relations** | liens pertinents posés (kit, diagnostic, norme…) | 10 % |
| **Illustrations** | schémas/photos utiles et conformes | 10 % |
| **Sources** | sourçage + niveau de confiance ([CONFIDENCE_MODEL.md](CONFIDENCE_MODEL.md)) | 15 % |
| **Validation** | statut (Brouillon/Validé) + qualité du valideur | 10 % |
| **Fraîcheur** | ancienneté de la dernière révision validée | 5 % |

## Seuils
- **Publication** : score ≥ **seuil de publication** (défini par la gouvernance) **ET** checklist complète.
- **Excellence** : score élevé + confiance moyenne A/B → carte de référence.
- Un score élevé **ne dispense jamais** de la validation humaine.

## Nature (honnêteté)
Ce document **spécifie** les dimensions et poids ; **aucune mesure réelle** n'est produite ici. Le
calcul appartient à l'implémentation (moteur Performance/Knowledge), qui reste **propriétaire** de
l'agrégation. Les poids sont **indicatifs** et calibrables sans changer la structure.

## Changelog
- 1.0 (2026-08-02) — Score initial (8 dimensions).
