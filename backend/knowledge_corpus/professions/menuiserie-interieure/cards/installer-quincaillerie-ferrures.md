# Installer quincaillerie et ferrures

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-quincaillerie-ferrures` |
| Titre | Installer quincaillerie et ferrures |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:menuiserie-interieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer la **quincaillerie** : **paumelles/ferrures**, **serrures/béquilles** et **poignées**. `[C]`
- **Résumé** : poser les **paumelles/fiches** (portage de l'ouvrant), la **serrure** (à larder/en applique) avec sa gâche, les **poignées/béquilles**, en respectant les entraxes et l'alignement, et vérifier la manœuvre ; adapter aux exigences (feu/acoustique) le cas échéant. `[C]` ⟦type de serrure/ferrures selon porte à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser **paumelles/fiches** (nombre/portage). `[C]`
  2. Poser **serrure** + gâche (entraxe/alignement). `[C]`
  3. Poser **poignées/béquilles** ; vérifier la manœuvre. `[C]` → [quincaillerie-usee-bloquee](../../../diagnostics/menuiserie-interieure/quincaillerie-usee-bloquee.md)
  4. Exigences feu/acoustique le cas échéant. `[C]` ⟦à confirmer⟧
- **Points critiques** : portage (nb de paumelles) ; alignement serrure/gâche ; manœuvre douce ; exigences (feu/acoustique) si requises.
- **Sécurité** : pincement ; machines (perçage) ; — **Manutention des portes / blocs-portes** (lourds, encombrants) : binôme/moyens de levage — risque d'**écrasement / pincement** (doigts, chute de l'ouvrage). **Machines électroportatives** (défonceuse, scie, visseuse) : capots/protection, contrôle. **Découpes / usinage** : coupures, projections ; **poussières de bois cancérogènes** → aspiration/masque. **Bruit** : protection auditive. **Fixation dans les supports** : chevilles adaptées (plaque de plâtre / maçonnerie), pattes — un bloc-porte mal fixé **tombe**. **Repérage des réseaux / risques électriques avant perçage** : repérer/consigner circuits et gaines avant de percer/visser (ne pas percer un câble sous tension) — NF C 15-100. **Amiante** : sur ouvrages/panneaux anciens, **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réglage** : `cite-carte` → [regler-ouvrant-interieur](regler-ouvrant-interieur.md)

## Relations & tags
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:menuiserie-interieure intervention:poser cluster:quincaillerie cluster:poignees cluster:ferrures complexite:moyenne type:installation securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
