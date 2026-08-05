# Phrase — références normatives façade

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-facade-reference` |
| Titre | Phrase — références normatives façade |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos travaux de façade respectent les règles de l'art, notamment le **DTU 26.1** (enduits de mortiers), le **DTU 42.1** (réfection par revêtements d'imperméabilité) et le **DTU 20.1** (maçonnerie). » `[C]` ⟦versions exactes à valider par un expert⟧

> **Réglementation** : une modification d'aspect extérieur peut requérir une **déclaration préalable** (urbanisme) et, en rénovation énergétique, relever de la **RE2020**/aides. `[C]` ⟦à confirmer selon commune/projet⟧

> **Relations inter-Livres** : la façade s'articule avec l'**Étanchéité**, la **Zinguerie** (points singuliers), la **Charpente** (ossatures), la **Couverture** (jonctions) et l'**Isolation** (ITE, `relation:isolation`). `[C]`

## Cadre
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [realiser-solin-abergement](../../professions/zinguerie/cards/realiser-solin-abergement.md).
- **Tags** : `metier:facade famille:enveloppe type:phrase usage:normes cluster:normes cluster:reglementation relation:etancheite relation:zinguerie relation:charpente relation:couverture relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
