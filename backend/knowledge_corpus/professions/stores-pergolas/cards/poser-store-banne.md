# Poser un store banne

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-store-banne` |
| Titre | Poser un store banne |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un store banne (coffre/monobloc) sur façade avec un ancrage dimensionné pour la tenue au vent. `[C]`
- **Résumé** : repérer un support **structurellement capable**, poser les supports/platines avec des fixations adaptées (charges d'arrachement), monter l'armature (bras sous **forte tension**), régler l'aplomb, la **pente d'évacuation** et l'avancée, puis contrôler. `[C]` ⟦fixations/support selon charges et NF EN 13561 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler le **support** (capacité structurelle) → façade/maçonnerie. `[C]` → [diagnostiquer-facade](../../../professions/facade/cards/diagnostiquer-facade.md)
  2. Poser platines/supports (fixations **dimensionnées** à l'arrachement). `[A]` ⟦à confirmer⟧
  3. Monter l'armature (**bras sous tension** — danger) ; régler pente/avancée. `[A]`
  4. Contrôler manœuvre et évacuation d'eau. `[C]`
- **Points critiques** : **ancrage = point critique** (arrachement au vent) ; support capable ; bras sous forte tension (blessure) ; pente d'évacuation.
- **Sécurité** : manutention/**bras sous tension** ; hauteur ; fixation/vent. **Travail en **hauteur** (pose en façade) : protections collectives / EPI. **Manutention** de structures lourdes (armature de store banne **sous tension**, poteaux de pergola) : risque d'écrasement — levage/binôme. **Fixation & stabilité** : un ancrage sous-dimensionné = **arrachement au vent** (danger majeur) → fixation adaptée au support et aux **charges** (vent/neige). **Motorisation / capteurs** : raccordement électrique **réservé à un professionnel** (voir Électricité). **Pincement** (mécanisme articulé, lames orientables). **Météo** (vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Motorisation** : `cite-carte` → [motoriser-regler-store-pergola](motoriser-regler-store-pergola.md)

## Relations & tags
- **Tags** : `metier:stores-pergolas equipement:store-banne famille:enveloppe sous-famille:stores-pergolas intervention:poser cluster:stores-bannes complexite:avancee type:installation securite:hauteur relation:facade`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
