# Principe des stores & pergolas (protection solaire, structures extérieures)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-stores-pergolas` |
| Titre | Principe des stores & pergolas (protection solaire, structures extérieures) |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les familles de protection solaire (stores, BSO) et de structures extérieures (pergolas) et leurs enjeux (fixation, vent, motorisation). `[C]`
- **Résumé** : protection solaire et structures extérieures : **stores** (bannes, verticaux, de toiture), **brise-soleil orientables (BSO)** et **pergolas** (bioclimatiques, adossées, autoportées) ; enjeux communs : **fixation/ancrage** au support, **tenue au vent** (charges), **motorisation & capteurs**. `[C]` ⟦classe de résistance au vent selon produit à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Stores** (banne, vertical, toiture). `[C]` → [poser-store-banne](poser-store-banne.md)
  2. **BSO** (lames orientables). `[C]` → [poser-brise-soleil-orientable](poser-brise-soleil-orientable.md)
  3. **Pergolas** (bioclimatique / adossée / autoportée). `[C]` → [installer-pergola](installer-pergola.md)
  4. **Fixation au support** : façade/bardage (frontière). `[C]` → [diagnostiquer-facade](../../../professions/facade/cards/diagnostiquer-facade.md)
- **Points critiques** : **ancrage** dimensionné (arrachement au vent) ; **charges** vent/neige ; motorisation = raccordement électricité ; ne pas empiéter Façade/Bardage/Électricité.
- **Sécurité** : hauteur ; manutention ; fixation/vent ; électricité (motorisation). **Travail en **hauteur** (pose en façade) : protections collectives / EPI. **Manutention** de structures lourdes (armature de store banne **sous tension**, poteaux de pergola) : risque d'écrasement — levage/binôme. **Fixation & stabilité** : un ancrage sous-dimensionné = **arrachement au vent** (danger majeur) → fixation adaptée au support et aux **charges** (vent/neige). **Motorisation / capteurs** : raccordement électrique **réservé à un professionnel** (voir Électricité). **Pincement** (mécanisme articulé, lames orientables). **Météo** (vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Motorisation & capteurs** : `cite-carte` → [motoriser-regler-store-pergola](motoriser-regler-store-pergola.md)

## Relations & tags
- **Tags** : `metier:stores-pergolas famille:enveloppe sous-famille:stores-pergolas intervention:comprendre cluster:stores-bannes cluster:stores-verticaux cluster:brise-soleil-orientables cluster:pergolas-bioclimatiques cluster:motorisations type:principe securite:hauteur relation:facade relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
