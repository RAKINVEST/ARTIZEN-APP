# Phrase — références normatives charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-charpente-reference` |
| Titre | Phrase — références normatives charpente |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (cluster « Normes »)
> « Nos ouvrages de charpente respectent les règles de l'art, notamment le **DTU 31.1** (charpente et escaliers en bois), le **DTU 31.3** (charpentes assemblées par connecteurs) et l'**Eurocode 5 (NF EN 1995)** pour le calcul. » `[C]` ⟦versions exactes à valider par un expert⟧

> **Relations inter-Livres** : la charpente supporte la **Couverture** (⟦relation:couverture⟧) et la **Zinguerie** (⟦relation:zinguerie⟧) ; l'humidité/condensation des combles concerne l'**Étanchéité** et la **Ventilation**. `[C]`

## Cadre
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-vmc-simple-flux](../../professions/ventilation/cards/entretenir-vmc-simple-flux.md).
- **Tags** : `metier:charpente famille:enveloppe type:phrase usage:normes cluster:normes relation:couverture relation:zinguerie relation:etancheite relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
