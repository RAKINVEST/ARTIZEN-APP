# Poser plinthes et moulures

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-plinthes-moulures` |
| Titre | Poser plinthes et moulures |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:menuiserie-interieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser les **plinthes** (raccord sol/mur) et **moulures** (corniches, cimaises) de finition. `[C]`
- **Résumé** : découper et poser les **plinthes** alignées (coupes d'onglet aux angles, fixation collée/clouée), les **moulures**/corniches en soignant les raccords, en tenant compte du revêtement de sol (jeu du parquet flottant) et de la finition (à peindre/vernir). `[C]` ⟦type/fixation selon sol et style à confirmer⟧

## Réalisation
- **Étapes** :
  1. Découper/poser les **plinthes** (onglets, fixation). `[C]`
  2. Adapter au sol (jeu **parquet** flottant : plinthe non solidaire du sol). `[C]` → [reparer-entretenir-parquet](../../../professions/parquet/cards/reparer-entretenir-parquet.md)
  3. Poser **moulures**/corniches (raccords). `[C]`
  4. Prêt à finir (peinture/vernis). `[C]` → [peindre-boiseries-laques](../../../professions/peinture/cards/peindre-boiseries-laques.md)
- **Points critiques** : onglets propres ; fixation adaptée ; **jeu du parquet flottant** (plinthe non solidaire) ; finition.
- **Sécurité** : poussières de bois ; coupures/machines ; — **Manutention des portes / blocs-portes** (lourds, encombrants) : binôme/moyens de levage — risque d'**écrasement / pincement** (doigts, chute de l'ouvrage). **Machines électroportatives** (défonceuse, scie, visseuse) : capots/protection, contrôle. **Découpes / usinage** : coupures, projections ; **poussières de bois cancérogènes** → aspiration/masque. **Bruit** : protection auditive. **Fixation dans les supports** : chevilles adaptées (plaque de plâtre / maçonnerie), pattes — un bloc-porte mal fixé **tombe**. **Repérage des réseaux / risques électriques avant perçage** : repérer/consigner circuits et gaines avant de percer/visser (ne pas percer un câble sous tension) — NF C 15-100. **Amiante** : sur ouvrages/panneaux anciens, **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Finitions boiseries** : `relation:peinture`

## Relations & tags
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:menuiserie-interieure intervention:poser cluster:plinthes cluster:moulures complexite:moyenne type:installation securite:poussieres relation:parquet relation:peinture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
