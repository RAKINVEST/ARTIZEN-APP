# Contrôle de la chaîne du froid (relevés)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-chaine-du-froid` |
| Titre | Contrôle de la chaîne du froid (relevés) |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier le respect des températures de conservation et leur traçabilité. `[C]`

## Étapes
1. Relever les températures (consigne vs réelle) de chaque enceinte. `[C]`
2. Vérifier les **alarmes** et l'enregistrement (traçabilité). `[B]`
3. Contrôler dégivrage et évaporateurs. `[C]`
4. Consigner les écarts et actions. `[C]` ⟦exigences hygiène/HACCP à confirmer⟧

## Cadre
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [parametrer-regulation-froid](../../professions/froid/cards/parametrer-regulation-froid.md).
- **Tags** : `metier:froid famille:fluides sous-famille:froid-commercial intervention:controler cluster:controle cluster:regulation cluster:maintenance type:procedure securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
