# Mise en service d'un climatiseur (cadre)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mise-en-service-climatisation` |
| Titre | Mise en service d'un climatiseur (cadre) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Encadrer la mise en service : partie accessible par l'installateur, partie **frigorifère** par un attesté F-Gaz. `[B]`

## Étapes
1. Contrôles préalables (implantation, condensats, électrique). `[C]` → [controle-avant-mise-en-service-clim](../../checklists/climatisation/controle-avant-mise-en-service-clim.md)
2. **Tirage au vide + mise en gaz + étanchéité** par un frigoriste attesté. `[A]`
3. Mise en route, contrôle froid/chaud, paramétrage. `[C]` ⟦selon fabricant⟧

## Cadre
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-checklist` → [controle-avant-mise-en-service-clim](../../checklists/climatisation/controle-avant-mise-en-service-clim.md).
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation intervention:mettre-en-service cluster:mise-en-service type:procedure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
