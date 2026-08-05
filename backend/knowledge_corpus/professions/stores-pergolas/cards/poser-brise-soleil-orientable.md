# Poser un brise-soleil orientable (BSO)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-brise-soleil-orientable` |
| Titre | Poser un brise-soleil orientable (BSO) |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un brise-soleil orientable (lames orientables) sur façade/baie, souvent motorisé. `[C]`
- **Résumé** : fixer les coulisses latérales et le coffre d'aplomb sur le support (façade/**bardage/ITE**), monter le tablier à **lames orientables**, régler orientation, fins de course et **remontée de sécurité au vent** ; motorisation raccordée par un professionnel. `[C]` ⟦support/fixation sur façade ventilée à confirmer⟧

## Réalisation
- **Étapes** :
  1. Fixer coulisses + coffre d'aplomb (support façade/**bardage**). `[C]` → [poser-ossature-lame-air](../../../professions/bardage/cards/poser-ossature-lame-air.md)
  2. Monter le tablier à **lames orientables**. `[C]`
  3. Régler orientation, fins de course, **sécurité vent**. `[C]`
  4. Motorisation : raccordement **réservé** → Électricité. `[C]` → [motoriser-regler-store-pergola](motoriser-regler-store-pergola.md)
- **Points critiques** : fixation sur façade **ventilée/ITE** sans percer l'étanchéité/l'isolant à tort ; sécurité vent (remontée auto).
- **Sécurité** : hauteur ; manutention ; électricité (motorisation → pro). **Travail en **hauteur** (pose en façade) : protections collectives / EPI. **Manutention** de structures lourdes (armature de store banne **sous tension**, poteaux de pergola) : risque d'écrasement — levage/binôme. **Fixation & stabilité** : un ancrage sous-dimensionné = **arrachement au vent** (danger majeur) → fixation adaptée au support et aux **charges** (vent/neige). **Motorisation / capteurs** : raccordement électrique **réservé à un professionnel** (voir Électricité). **Pincement** (mécanisme articulé, lames orientables). **Météo** (vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle réception** : `cite-procedure` → [controle-reception-store-pergola](../../../procedures/stores-pergolas/controle-reception-store-pergola.md)

## Relations & tags
- **Tags** : `metier:stores-pergolas equipement:bso famille:enveloppe sous-famille:stores-pergolas intervention:poser cluster:brise-soleil-orientables cluster:motorisations complexite:avancee type:installation securite:hauteur relation:bardage relation:isolation-exterieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
