# Kit ascensoriste

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-ascensoriste` |
| Titre | Kit ascensoriste |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (usage par personnel habilité)
- Moyens de **consignation** (cadenas/étiquettes), dispositifs d'**immobilisation** de cabine. `[A]`
- Outillage de mesure (dynamomètre de tension câbles, contrôle de vitesse), instruments d'essai des sécurités. `[C]`
- Documentation d'appareil (notice, schémas), registre d'entretien. `[C]`
- **EPI** : harnais/antichute (gaine), casque, gants, chaussures, éclairage. `[A]`

> Kit **réservé** aux intervenants formés/habilités ; ne légitime aucune opération hors habilitation. `[A]`

## Cadre
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [consignation-securite-avant-intervention-ascenseur](../../procedures/ascenseur/consignation-securite-avant-intervention-ascenseur.md).
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur type:kit cluster:machinerie cluster:dispositifs-securite equipement:consignation-cabine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
