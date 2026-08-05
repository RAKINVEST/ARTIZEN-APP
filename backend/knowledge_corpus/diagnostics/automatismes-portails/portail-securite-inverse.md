# Portail qui se rouvre / s'arrête seul

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `portail-securite-inverse` |
| Titre | Portail qui se rouvre / s'arrête seul |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le portail **se rouvre**, **s'arrête** ou refuse de fermer sans commande. `[C]`

> Ne **jamais** neutraliser une sécurité pour « faire fonctionner » : c'est elle qui évite l'écrasement. `[A]`

## Causes probables
1. **Cellules** désalignées/sales/obstacle dans le faisceau. `[C]` → [installer-dispositifs-securite](../../professions/automatismes-portails/cards/installer-dispositifs-securite.md)
2. **Bord sensible** déclenché (contact/frottement). `[C]`
3. **Effort** mal réglé (détection d'obstacle abusive). `[C]` → [regler-essayer-motorisation](../../professions/automatismes-portails/cards/regler-essayer-motorisation.md)

## Résolution
- Nettoyer/aligner les cellules, lever l'obstacle, régler l'effort puis **re-tester** (mesure d'effort) — sans jamais supprimer une sécurité. `[A]`

## Cadre
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [installer-dispositifs-securite](../../professions/automatismes-portails/cards/installer-dispositifs-securite.md).
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:securite probleme:securite cluster:dispositifs-securite cluster:diagnostic type:diagnostic securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
