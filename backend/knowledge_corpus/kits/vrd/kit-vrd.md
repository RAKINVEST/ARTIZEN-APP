# Kit VRD / préparation de chantier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-vrd` |
| Titre | Kit VRD / préparation de chantier |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (organisationnelle + sécurité)
- **Récépissés DICT** + plans réseaux + **AIPR** ; autorisations de voirie. `[A]`
- **Blindage** de tranchée ; niveau laser/topo ; grillages avertisseurs, fourreaux. `[C]`
- **Signalisation temporaire** (panneaux, balises, séparateurs). `[A]`
- **EPI** (casque, gilet HV, chaussures S3) ; moyens de pompage/levage. `[A]`

## Cadre
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [ouvrir-tranchee-technique](../../professions/vrd/cards/ouvrir-tranchee-technique.md).
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd type:kit cluster:tranchees-techniques cluster:reseaux-secs equipement:signalisation-temporaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
