# Phrase — normes & réglementation solaire thermique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-solaire` |
| Titre | Phrase — normes & réglementation solaire thermique |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos installations solaires thermiques respectent les règles de l'art : capteurs à circulation de liquide (**DTU 65.12**), électricité de la régulation (**NF C 15-100**), capteurs/systèmes certifiés (**NF EN 12975/12976**, **Solar Keymark**). » `[C]` ⟦versions/certifications exactes à valider par un expert⟧

> **Réglementation / aides** : performances et éligibilité aux aides (**MaPrimeRénov'**) via un installateur **RGE (QualiSol)** ; déclaration préalable d'urbanisme possible (aspect toiture, **ABF**). `[C]` ⟦à confirmer selon dispositif/commune⟧

> **Relations inter-Livres** : le solaire thermique s'articule avec le **Chauffage** (SSC, vase/circulateur/appoint), la **Plomberie** (ECS/ballon), la **Couverture** (pose/étanchéité en toiture) et l'**Électricité** (régulation, réservée). `[C]`

## Cadre
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-chaudiere](../../professions/chauffage/cards/entretenir-chaudiere.md).
- **Tags** : `metier:solaire-thermique famille:fluides type:phrase usage:normes cluster:normes cluster:reglementation relation:chauffage relation:plomberie relation:couverture relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
