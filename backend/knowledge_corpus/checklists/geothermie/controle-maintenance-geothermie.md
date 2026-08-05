# Contrôle / maintenance géothermie (captage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-geothermie` |
| Titre | Contrôle / maintenance géothermie (captage) |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier (partie captage)
- [ ] Pression du circuit de captage conforme. `[C]`
- [ ] **Taux d'antigel** du caloporteur. `[C]` ⟦seuil à confirmer⟧
- [ ] Équilibrage des boucles au collecteur. `[C]`
- [ ] Circulateur (débit, bruit, étanchéité). `[C]`
- [ ] Échangeur/filtre (encrassement, boues). `[C]`
- [ ] Absence de fuite. `[C]`

> **PAC (frigorifère) et forage : intervenants qualifiés (F-Gaz / foreur).** `[A]`

## Cadre
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-installation-geothermie](../../professions/geothermie/cards/entretenir-installation-geothermie.md).
- **Tags** : `metier:geothermie famille:fluides sous-famille:captage type:checklist cluster:maintenance cluster:entretien cluster:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
