# Remplacer un disjoncteur divisionnaire

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-disjoncteur` |
| Titre | Remplacer un disjoncteur divisionnaire |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:tableau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer un disjoncteur défectueux au tableau — **opération réservée à un électricien habilité**. `[C]`
- **Résumé** : consigner l'installation, déposer le disjoncteur défectueux, poser un modèle équivalent (calibre/courbe), rerepérer, déconsigner et contrôler. `[C]` ⟦calibre/courbe selon circuit à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Consigner** l'installation. `[A]` → [consignation-electrique](../../../procedures/electricite-generale/consignation-electrique.md)
  2. Vérifier l'**absence de tension** (VAT). `[A]`
  3. Déposer le disjoncteur (peigne/bornes) ; noter calibre et courbe. `[C]`
  4. Poser un disjoncteur **équivalent** (calibre, courbe, pouvoir de coupure). `[B]` ⟦à confirmer⟧
  5. Rerepérer, déconsigner, contrôler le fonctionnement. `[C]` → [controler-tableau-electrique](controler-tableau-electrique.md)
- **Points critiques** : calibre/courbe/pouvoir de coupure **équivalents** ; serrage des bornes ; repérage.
- **Sécurité** : circuit consigné, VAT obligatoire. **Intervention sur installation électrique : **consignation** et **habilitation électrique** requises (NF C 18-510) ; **vérifier l'absence de tension (VAT)** avant tout contact. Une opération au **tableau**, un **raccordement** ou toute opération **sous tension** relèvent d'un professionnel **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [disjoncteur-qui-saute](../../../diagnostics/electricite-generale/disjoncteur-qui-saute.md)

## Relations & tags
- **Tags** : `metier:electricite-generale equipement:disjoncteur famille:electricite sous-famille:tableau intervention:remplacer cluster:tableau cluster:protections cluster:disjoncteurs complexite:moyenne type:reparation securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
