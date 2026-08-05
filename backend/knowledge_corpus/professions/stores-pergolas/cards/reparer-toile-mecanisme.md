# Réparer une toile / un mécanisme

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reparer-toile-mecanisme` |
| Titre | Réparer une toile / un mécanisme |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réparer/remplacer une toile de store ou un élément mécanique (bras, lames, câbles) dégradé. `[C]`
- **Résumé** : diagnostiquer l'élément atteint, détendre/consigner le mécanisme (**bras sous tension**), remplacer la toile ou la pièce (bras, articulation, lame, câble) par une référence compatible, puis re-régler tension et fins de course. `[C]` ⟦pièce/toile selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Diagnostiquer (toile / bras / lames / câble). `[C]` → [toile-store-degradee](../../../diagnostics/stores-pergolas/toile-store-degradee.md)
  2. **Consigner/détendre** le mécanisme (bras sous tension — danger). `[A]`
  3. Remplacer toile/pièce par référence **compatible**. `[C]`
  4. Re-régler tension, aplomb, fins de course. `[C]` → [motoriser-regler-store-pergola](motoriser-regler-store-pergola.md)
- **Points critiques** : **bras sous tension = danger** (consigner avant) ; pièce compatible ; re-réglage complet après.
- **Sécurité** : **bras/ressort sous tension** (blessure grave) ; hauteur ; pincement. **Travail en **hauteur** (pose en façade) : protections collectives / EPI. **Manutention** de structures lourdes (armature de store banne **sous tension**, poteaux de pergola) : risque d'écrasement — levage/binôme. **Fixation & stabilité** : un ancrage sous-dimensionné = **arrachement au vent** (danger majeur) → fixation adaptée au support et aux **charges** (vent/neige). **Motorisation / capteurs** : raccordement électrique **réservé à un professionnel** (voir Électricité). **Pincement** (mécanisme articulé, lames orientables). **Météo** (vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-controler-store-pergola](entretenir-controler-store-pergola.md)

## Relations & tags
- **Tags** : `metier:stores-pergolas famille:enveloppe sous-famille:stores-pergolas intervention:reparer cluster:reparation cluster:stores-bannes complexite:avancee type:reparation securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
