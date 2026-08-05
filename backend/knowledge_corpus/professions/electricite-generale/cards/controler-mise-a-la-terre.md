# Contrôler la mise à la terre

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-mise-a-la-terre` |
| Titre | Contrôler la mise à la terre |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:mesures` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : vérifier la présence et la qualité de la mise à la terre (prise de terre, liaisons équipotentielles) — **mesures par un électricien qualifié**. `[C]`
- **Résumé** : contrôler la continuité des conducteurs de protection et, avec l'appareil adapté, la **valeur de la prise de terre** en cohérence avec le calibre du différentiel. `[C]` ⟦valeurs seuils à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier la présence du **conducteur de terre** aux points d'usage. `[C]`
  2. Contrôler la **continuité** des conducteurs de protection. `[B]` → [mesurer-continuite-circuit](mesurer-continuite-circuit.md)
  3. Mesurer la **valeur de la prise de terre** (appareil adapté). `[B]` ⟦seuil selon différentiel à confirmer⟧
  4. Vérifier les **liaisons équipotentielles** (salle d'eau). `[C]`
- **Points critiques** : cohérence valeur de terre / sensibilité différentiel ; liaisons équipotentielles des locaux humides. `[B]`
- **Sécurité** : mesures sur installation ; appareillage et **qualification** requis. **Intervention sur installation électrique : **consignation** et **habilitation électrique** requises (NF C 18-510) ; **vérifier l'absence de tension (VAT)** avant tout contact. Une opération au **tableau**, un **raccordement** ou toute opération **sous tension** relèvent d'un professionnel **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-conformite-installation](../../../checklists/electricite-generale/controle-conformite-installation.md)

## Relations & tags
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:mesures intervention:controler cluster:mise-a-la-terre cluster:continuite cluster:mesures cluster:controle complexite:avancee type:controle securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
