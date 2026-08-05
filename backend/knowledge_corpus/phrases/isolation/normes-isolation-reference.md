# Phrase — références normatives isolation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-isolation-reference` |
| Titre | Phrase — références normatives isolation |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos travaux d'isolation respectent les règles de l'art, notamment le **DTU 45.10** et le **DTU 45.11** (isolation des combles) et le **DTU 25.41** (doublage intérieur). » `[C]` ⟦versions exactes à valider par un expert⟧

> **Réglementation** : performances visées selon la **RE2020** (neuf) / réglementation énergétique existant ; aides (**MaPrimeRénov'**) conditionnées à des critères de R et à un artisan **RGE**. `[C]` ⟦critères à confirmer selon dispositif/année⟧

> **Relations inter-Livres** : l'isolation s'articule avec la **Façade** (ITE), la **Couverture** (combles/sous-toiture), l'**Étanchéité**, la **Charpente** (support) et surtout la **Ventilation** (indispensable dès qu'on étanchéifie à l'air) et le **Chauffage** (déperditions). `[C]`

## Cadre
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-vmc-simple-flux](../../professions/ventilation/cards/entretenir-vmc-simple-flux.md).
- **Tags** : `metier:isolation famille:enveloppe type:phrase usage:normes cluster:normes cluster:reglementation relation:facade relation:couverture relation:etancheite relation:charpente relation:ventilation relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
