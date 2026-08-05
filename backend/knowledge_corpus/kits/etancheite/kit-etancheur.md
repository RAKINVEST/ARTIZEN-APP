# Kit étancheur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-etancheur` |
| Titre | Kit étancheur |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Chalumeau** + bouteille (bitume soudé) ou **pistolet air chaud** (synthétique). `[C]`
- Primaire (EIF), résine/SEL + armature, mastics/colles selon système. `[C]`
- Crapaudines, moignons, accessoires de points singuliers. `[C]`
- **EPI** (antichute, gants, protection respiratoire produits) + **extincteur**. `[A]`

## Cadre
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [entretenir-controler-etancheite](../../professions/etancheite/cards/entretenir-controler-etancheite.md).
- **Tags** : `metier:etancheite famille:enveloppe sous-famille:etancheite type:kit cluster:entretien cluster:reparation equipement:chalumeau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
