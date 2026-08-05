# Kit arrosage automatique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-arrosage-automatique` |
| Titre | Kit arrosage automatique |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Détecteur de réseaux**, bêche/tranchéeuse, coupe-tube PE, outillage de raccords (compression/électrosoudure). `[C]`
- Manomètre, **compresseur** (soufflage/hivernage), pince à sertir, clés d'électrovanne. `[C]`
- Regards, filtres, régulateur de pression, buses/goutteurs, câble de commande, sonde pluie. `[C]`
- **EPI** : gants, lunettes, chaussures ; consignation électrique (interface). `[A]`

## Cadre
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [poser-reseau-pe-enterre](../../professions/arrosage/cards/poser-reseau-pe-enterre.md).
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage type:kit cluster:reseau-enterre cluster:filtration equipement:compresseur-soufflage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
