# Contrôle des évacuations EP (avant saison des pluies)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-evacuation-ep` |
| Titre | Contrôle des évacuations EP (avant saison des pluies) |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier le bon écoulement des eaux pluviales avant la saison des pluies. `[C]`

## Étapes
1. Nettoyer goutières/chéneaux (feuilles, mousses). `[C]`
2. Contrôler **crapaudines** et naissances. `[C]`
3. Vérifier l'écoulement des **descentes** (rinçage). `[C]`
4. Contrôler le raccordement au réseau au sol. `[C]` → [deboucher-evacuation-sanitaire](../../professions/plomberie/cards/deboucher-evacuation-sanitaire.md)

## Cadre
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-zinguerie](../../professions/zinguerie/cards/entretenir-zinguerie.md).
- **Tags** : `metier:zinguerie famille:enveloppe sous-famille:zinguerie intervention:controler cluster:controle cluster:descentes-ep cluster:maintenance type:procedure securite:hauteur relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
