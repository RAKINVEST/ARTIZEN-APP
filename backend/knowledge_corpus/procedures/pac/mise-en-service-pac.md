# Mise en service d'une PAC (cadre général)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mise-en-service-pac` |
| Titre | Mise en service d'une PAC (cadre général) |
| Profession | `metier:pac` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Encadrer la mise en service d'une PAC : partie accessible par l'installateur, partie frigorifère par un **attesté F-Gaz**. `[B]`

## Étapes
1. Contrôles préalables (implantation, électrique, hydraulique). `[C]` → [controle-avant-mise-en-service-pac](../../checklists/pac/controle-avant-mise-en-service-pac.md)
2. Mise en eau/purge du circuit émission (air/eau). `[C]`
3. **Contrôle d'étanchéité frigorifère + mise en route** par un frigoriste attesté. `[A]`
4. Paramétrage régulation et contrôle des performances. `[C]` ⟦selon fabricant⟧

## Cadre
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-checklist` → [controle-avant-mise-en-service-pac](../../checklists/pac/controle-avant-mise-en-service-pac.md).
- **Tags** : `metier:pac equipement:pac famille:fluides sous-famille:pac intervention:mettre-en-service cluster:mise-en-service type:procedure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
