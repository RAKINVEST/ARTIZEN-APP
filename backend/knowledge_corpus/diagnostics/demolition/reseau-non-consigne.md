# Réseau non consigné rencontré

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reseau-non-consigne` |
| Titre | Réseau non consigné rencontré |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un **réseau actif** (électricité, gaz, eau) est découvert ou heurté pendant le curage/la démolition. `[C]`

> **URGENCE.** Arrêt ; ne pas toucher ; électricité = risque électrocution, gaz = risque explosion. Alerter l'exploitant/secours. `[A]`

## Causes probables
1. **Consignation** non réalisée / incomplète. `[C]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)
2. Réseau non repéré au diagnostic. `[C]` → [realiser-diagnostic-prealable](../../professions/demolition/cards/realiser-diagnostic-prealable.md)

## Résolution
- **Arrêter** ; faire **consigner** par l'exploitant/électricien ; ne reprendre qu'après confirmation. `[A]`

## Cadre
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [realiser-diagnostic-prealable](../../professions/demolition/cards/realiser-diagnostic-prealable.md).
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition probleme:reseau cluster:diagnostic-prealable type:diagnostic securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
