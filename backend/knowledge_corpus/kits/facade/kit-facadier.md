# Kit façadier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-facadier` |
| Titre | Kit façadier |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Outils d'enduit (taloche, platoir, règle) ; marteau/burin pour purge. `[C]`
- Produits (mortier, imperméabilité, hydrofuge, traitement mousses) `[C]` ⟦selon support à confirmer⟧
- Testeur d'humidité, sonde (recherche du creux). `[C]`
- **EPI** (antichute, gants, protection respiratoire pour produits). `[A]`

## Cadre
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [reprendre-enduit-facade](../../professions/facade/cards/reprendre-enduit-facade.md).
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade type:kit cluster:entretien cluster:nettoyage cluster:reparation equipement:enduit`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
