# Contrôle / maintenance froid commercial

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-froid-commercial` |
| Titre | Contrôle / maintenance froid commercial |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier (parties accessibles)
- [ ] Températures conformes ; alarmes actives. `[C]`
- [ ] **Condenseur** propre, ventilateurs OK. `[C]`
- [ ] Évaporateur sans givrage anormal ; dégivrage OK. `[C]`
- [ ] **Évacuation des condensats** libre (cordon anti-gel en négatif). `[C]`
- [ ] Joints de porte / rideaux de nuit étanches. `[C]`
- [ ] Absence de trace d'huile (indice de fuite → **frigoriste**). `[B]`

> **Contrôle d'étanchéité frigorifique et charge : frigoriste attesté F-Gaz.** `[A]`

## Cadre
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [controler-chambre-froide-positive](../../professions/froid/cards/controler-chambre-froide-positive.md).
- **Tags** : `metier:froid famille:fluides sous-famille:froid-commercial type:checklist cluster:maintenance cluster:entretien cluster:controle securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
