# Baisse de débit d'un forage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `baisse-debit-forage` |
| Titre | Baisse de débit d'un forage |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Baisse de débit** / rabattement anormal, pompe qui désamorce. `[C]`

## Causes probables
1. **Crépine colmatée** (fer/manganese, fines). `[C]` → [entretenir-controler-forage](../../professions/forage/cards/entretenir-controler-forage.md)
2. **Pompe** usée / mal immergée / défaut électrique. `[C]` → [installer-pompe-immergee](../../professions/forage/cards/installer-pompe-immergee.md)
3. **Baisse de la nappe** (sécheresse/surexploitation). `[C]` → [realiser-essai-debit](../../professions/forage/cards/realiser-essai-debit.md)

## Résolution
- Diagnostiquer (niveau/pompe/crépine), développer/nettoyer la crépine, ajuster l'immersion ; respecter la ressource. `[C]`

## Cadre
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-forage](../../professions/forage/cards/entretenir-controler-forage.md).
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage probleme:debit cluster:crepine cluster:pompes-immergees cluster:diagnostic type:diagnostic securite:nappe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
