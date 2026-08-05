# Essai de réception / mise en service d'une alarme

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `essai-reception-alarme` |
| Titre | Essai de réception / mise en service d'une alarme |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier qu'un système d'alarme fonctionne **complètement** avant remise au client. `[C]`

## Étapes
1. **Tester chaque détecteur** (contact/volumétrique) et son affectation de **zone**. `[C]`
2. Vérifier l'**autoprotection** (ouverture/arrachement) de chaque élément. `[A]`
3. Tester **sirènes** + **transmission** (notification/télésurveillance) réelle. `[C]`
4. Vérifier **batterie de secours** (continuité), scénarios d'armement, temporisations. `[C]` → [configurer-badges-telecommandes-armement](../../professions/alarme-intrusion/cards/configurer-badges-telecommandes-armement.md)

> Un essai partiel ne vaut pas une **réception** ; documenter les tests. `[B]`

## Cadre
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [essayer-maintenir-alarme](../../professions/alarme-intrusion/cards/essayer-maintenir-alarme.md).
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:controler cluster:essais cluster:scenarios-d-armement type:procedure securite:autoprotection`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
