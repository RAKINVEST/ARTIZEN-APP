# Entretenir / contrôler un store ou une pergola

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-controler-store-pergola` |
| Titre | Entretenir / contrôler un store ou une pergola |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir et contrôler un store/une pergola (fixations, mécanisme, toile/lames, capteurs, évacuation). `[C]`
- **Résumé** : contrôler la tenue des **fixations/ancrages**, l'état de la toile/des lames, le mécanisme (bras, articulations), le bon fonctionnement des **capteurs** (surtout vent) et l'évacuation d'eau (pergola), puis nettoyer/lubrifier. `[C]`

## Réalisation
- **Étapes** :
  1. Vérifier **fixations/ancrages** (tenue au vent). `[C]` → [pergola-instable-evacuation](../../../diagnostics/stores-pergolas/pergola-instable-evacuation.md)
  2. Contrôler toile/lames et mécanisme ; nettoyer/lubrifier. `[C]`
  3. Tester les **capteurs** (vent = sécurité) et la manœuvre. `[C]`
  4. Pergola : dégager l'**évacuation d'eau** (chenaux/descentes). `[C]`
- **Points critiques** : fixations/ancrages surveillés (sécurité) ; capteur vent fonctionnel ; évacuation dégagée (pergola).
- **Sécurité** : hauteur ; manutention ; pincement ; électricité (essais). **Travail en **hauteur** (pose en façade) : protections collectives / EPI. **Manutention** de structures lourdes (armature de store banne **sous tension**, poteaux de pergola) : risque d'écrasement — levage/binôme. **Fixation & stabilité** : un ancrage sous-dimensionné = **arrachement au vent** (danger majeur) → fixation adaptée au support et aux **charges** (vent/neige). **Motorisation / capteurs** : raccordement électrique **réservé à un professionnel** (voir Électricité). **Pincement** (mécanisme articulé, lames orientables). **Météo** (vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-store-pergola](../../../kits/stores-pergolas/kit-store-pergola.md)

## Relations & tags
- **Tags** : `metier:stores-pergolas famille:enveloppe sous-famille:stores-pergolas intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:controle complexite:simple type:entretien securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
