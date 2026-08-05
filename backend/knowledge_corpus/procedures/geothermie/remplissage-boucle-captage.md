# Remplissage de la boucle de captage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplissage-boucle-captage` |
| Titre | Remplissage de la boucle de captage |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Remplir le circuit de captage avec le fluide caloporteur dosé, sans air. `[C]`

## Étapes
1. Préparer le **caloporteur** au bon **taux d'antigel**. `[C]` ⟦taux à confirmer⟧
2. Remplir via pompe de remplissage ; **purger** l'air. `[C]`
3. Régler la **pression** ; équilibrer les boucles. `[C]`
4. Contrôler l'étanchéité ; consigner. `[C]`

> Rejet du fluide à l'environnement **interdit** (récupération/traitement).

## Cadre
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-fluide-caloporteur](../../professions/geothermie/cards/controler-fluide-caloporteur.md).
- **Tags** : `metier:geothermie equipement:caloporteur famille:fluides sous-famille:captage intervention:remplir cluster:fluide-caloporteur cluster:mise-en-service cluster:captage type:procedure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
