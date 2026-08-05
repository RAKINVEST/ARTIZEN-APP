# Sécurité & réglementation géothermie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-geothermie` |
| Titre | Sécurité & réglementation géothermie |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Forage/captage vertical** : foreur **qualifié** + déclaration **GMI** (géothermie de minime importance). `[A]` ⟦cadre exact à confirmer⟧
- [ ] **PAC** (circuit frigorifère) : intervenant **attesté F-Gaz**. `[A]`
- [ ] **Raccordement électrique** : intervenant **habilité** (NF C 15-100). `[A]`
- [ ] Caloporteur : produit conforme, **pas de rejet** à l'environnement. `[B]`
- [ ] EPI ; circuit dépressurisé avant ouverture. `[B]`

> Chaque domaine (forage, frigorifère, électrique) relève de sa **qualification** propre.

## Cadre
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-geothermie](../../professions/geothermie/cards/principe-geothermie.md).
- **Tags** : `metier:geothermie famille:fluides sous-famille:securite type:checklist cluster:securite cluster:reglementation cluster:normes securite:forage securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
