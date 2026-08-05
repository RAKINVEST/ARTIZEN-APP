# Pression basse du circuit de captage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `captage-pression-basse` |
| Titre | Pression basse du circuit de captage |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- La pression du circuit de captage **baisse** (appoints fréquents). `[C]`

## Causes probables
1. **Air** non purgé (après remplissage). `[C]`
2. **Micro-fuite** sur collecteur/raccords. `[C]` → [controler-collecteur-geothermie](../../professions/geothermie/cards/controler-collecteur-geothermie.md)
3. Vase d'expansion du captage inadapté. `[C]`

## Résolution
- Purger, rechercher les fuites, appoint de caloporteur. `[C]` → [controler-fluide-caloporteur](../../professions/geothermie/cards/controler-fluide-caloporteur.md)

## Cadre
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-champ-de-captage](../../professions/geothermie/cards/controler-champ-de-captage.md).
- **Tags** : `metier:geothermie equipement:sonde-geothermique famille:fluides sous-famille:captage probleme:pression probleme:fuite cluster:diagnostic cluster:depannage cluster:captage type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
