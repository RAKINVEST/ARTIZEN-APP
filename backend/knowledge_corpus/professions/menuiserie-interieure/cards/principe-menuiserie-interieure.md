# Principe de la menuiserie intérieure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-menuiserie-interieure` |
| Titre | Principe de la menuiserie intérieure |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:menuiserie-interieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les ouvrages de menuiserie intérieure (blocs-portes, huisseries, habillages, finitions) et leurs poses. `[C]`
- **Résumé** : la menuiserie intérieure met en œuvre les **blocs-portes** (**huisserie** + ouvrant), les **portes** (battantes/**coulissantes**), leur **habillage** (ébrasements, chambranles) et les finitions (**plinthes**, moulures), avec la **quincaillerie** ; elle intervient après le gros œuvre/plâtrerie et avant/avec la **peinture** (finition des boiseries). `[C]` ⟦type de porte/finition selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Bloc-porte** (huisserie + ouvrant). `[C]` → [poser-bloc-porte](poser-bloc-porte.md)
  2. **Habillage** (ébrasement/chambranle). `[C]` → [poser-huisserie-ebrasement-chambranle](poser-huisserie-ebrasement-chambranle.md)
  3. **Finitions** (plinthes/moulures). `[C]` → [poser-plinthes-moulures](poser-plinthes-moulures.md)
  4. **Finition boiseries** (peinture/laque) = métier voisin. `[C]` → [peindre-boiseries-laques](../../../professions/peinture/cards/peindre-boiseries-laques.md)
- **Points critiques** : aplomb/jeux ; **fixation** au support ; accessibilité (largeur de passage) ; interface **Peinture** (finition).
- **Sécurité** : manutention (blocs-portes) ; poussières de bois ; électricité (perçage). **Manutention des portes / blocs-portes** (lourds, encombrants) : binôme/moyens de levage — risque d'**écrasement / pincement** (doigts, chute de l'ouvrage). **Machines électroportatives** (défonceuse, scie, visseuse) : capots/protection, contrôle. **Découpes / usinage** : coupures, projections ; **poussières de bois cancérogènes** → aspiration/masque. **Bruit** : protection auditive. **Fixation dans les supports** : chevilles adaptées (plaque de plâtre / maçonnerie), pattes — un bloc-porte mal fixé **tombe**. **Repérage des réseaux / risques électriques avant perçage** : repérer/consigner circuits et gaines avant de percer/visser (ne pas percer un câble sous tension) — NF C 15-100. **Amiante** : sur ouvrages/panneaux anciens, **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / contrôle** : `cite-carte` → [reparer-entretenir-menuiserie](reparer-entretenir-menuiserie.md)

## Relations & tags
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:menuiserie-interieure intervention:comprendre cluster:blocs-portes cluster:portes-interieures cluster:huisseries cluster:plinthes cluster:moulures type:principe securite:manutention relation:peinture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
