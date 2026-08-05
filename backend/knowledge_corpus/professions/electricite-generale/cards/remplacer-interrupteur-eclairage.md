# Remplacer un interrupteur d'éclairage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-interrupteur-eclairage` |
| Titre | Remplacer un interrupteur d'éclairage |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:appareillage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer un interrupteur d'éclairage défectueux en sécurité. `[C]`
- **Résumé** : couper le circuit éclairage, VAT, repérer le câblage (simple allumage / va-et-vient), poser le neuf, remonter et contrôler. `[C]`

## Réalisation
- **Étapes** :
  1. Couper le **circuit éclairage** au disjoncteur ; **VAT**. `[A]`
  2. Repérer le câblage (simple allumage, **va-et-vient**, télérupteur). `[C]`
  3. Poser l'interrupteur neuf en respectant le câblage. `[C]`
  4. Remonter, rétablir, contrôler l'allumage. `[C]`
- **Points critiques** : identifier le type de commande ; ne pas inverser va-et-vient ; serrage des bornes.
- **Sécurité** : coupure + VAT ; si circuit non identifié → électricien habilité. **Intervention sur installation électrique : **consignation** et **habilitation électrique** requises (NF C 18-510) ; **vérifier l'absence de tension (VAT)** avant tout contact. Une opération au **tableau**, un **raccordement** ou toute opération **sous tension** relèvent d'un professionnel **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-conformite-installation](../../../checklists/electricite-generale/controle-conformite-installation.md)

## Relations & tags
- **Tags** : `metier:electricite-generale equipement:interrupteur famille:electricite sous-famille:appareillage intervention:remplacer cluster:circuits-eclairage complexite:simple type:reparation securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
