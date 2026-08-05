# Fissure de joint (plâtrerie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fissure-joint-platrerie` |
| Titre | Fissure de joint (plâtrerie) |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Fissure** à un joint de plaques ou dans un angle (visible après peinture). `[C]`

## Causes probables
1. **Bande** mal marouflée / joint sous-enrobé. `[C]` → [realiser-bandes-jointoiement](../../professions/platrerie/cards/realiser-bandes-jointoiement.md)
2. **Mouvement** de l'ossature/du support (dilatation, absence de joint de fractionnement). `[C]`
3. Angle sans **bande armée** / raccord de matériaux différents. `[C]`

## Résolution
- Ouvrir/reprendre le joint (bande armée si angle), traiter la cause de mouvement ; poncer, prêt à peindre. `[C]`

## Cadre
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [realiser-bandes-jointoiement](../../professions/platrerie/cards/realiser-bandes-jointoiement.md).
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie probleme:fissure cluster:bandes cluster:diagnostics type:diagnostic securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
