# Réparer / entretenir une menuiserie intérieure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reparer-entretenir-menuiserie` |
| Titre | Réparer / entretenir une menuiserie intérieure |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:menuiserie-interieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser des **reprises** (porte, quincaillerie, habillage) et l'**entretien** courant. `[C]`
- **Résumé** : diagnostiquer les défauts (porte qui frotte, jeu, quincaillerie usée, habillage abîmé), remplacer/reprendre les éléments (paumelles, serrure, plinthe), lubrifier la quincaillerie, re-régler l'ouvrant, et entretenir les finitions ; en rénovation d'ouvrages anciens, penser au **diagnostic amiante** (panneaux/colles). `[C]`

## Réalisation
- **Étapes** :
  1. Diagnostiquer (frottement/jeu/quincaillerie/habillage). `[C]` → [jeu-fixation-defaillante](../../../diagnostics/menuiserie-interieure/jeu-fixation-defaillante.md)
  2. Remplacer/reprendre (paumelles/serrure/plinthe). `[C]`
  3. Lubrifier la quincaillerie ; **re-régler** l'ouvrant. `[C]` → [regler-ouvrant-interieur](regler-ouvrant-interieur.md)
  4. Rénovation ancienne : **diagnostic amiante**. `[A]` → [reperage-reseaux-amiante-avant-pose](../../../procedures/menuiserie-interieure/reperage-reseaux-amiante-avant-pose.md)
- **Points critiques** : reprise avec pièces compatibles ; re-réglage ; quincaillerie lubrifiée ; **amiante** en rénovation.
- **Sécurité** : manutention/pincement ; poussières (reprise) ; amiante. **Manutention des portes / blocs-portes** (lourds, encombrants) : binôme/moyens de levage — risque d'**écrasement / pincement** (doigts, chute de l'ouvrage). **Machines électroportatives** (défonceuse, scie, visseuse) : capots/protection, contrôle. **Découpes / usinage** : coupures, projections ; **poussières de bois cancérogènes** → aspiration/masque. **Bruit** : protection auditive. **Fixation dans les supports** : chevilles adaptées (plaque de plâtre / maçonnerie), pattes — un bloc-porte mal fixé **tombe**. **Repérage des réseaux / risques électriques avant perçage** : repérer/consigner circuits et gaines avant de percer/visser (ne pas percer un câble sous tension) — NF C 15-100. **Amiante** : sur ouvrages/panneaux anciens, **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-menuisier-interieur](../../../kits/menuiserie-interieure/kit-menuisier-interieur.md)

## Relations & tags
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:menuiserie-interieure intervention:reparer intervention:entretenir cluster:reprises cluster:entretien cluster:maintenance complexite:moyenne type:entretien securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
