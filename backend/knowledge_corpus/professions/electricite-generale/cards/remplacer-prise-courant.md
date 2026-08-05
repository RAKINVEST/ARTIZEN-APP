# Remplacer une prise de courant

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-prise-courant` |
| Titre | Remplacer une prise de courant |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:appareillage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer une prise de courant défectueuse en sécurité (coupure + VAT obligatoires). `[C]`
- **Résumé** : couper le circuit au disjoncteur, vérifier l'absence de tension, déposer l'ancienne prise, recabler la neuve (phase/neutre/terre), remonter et contrôler. `[C]`

## Réalisation
- **Étapes** :
  1. Couper le **circuit** au disjoncteur ; **VAT**. `[A]`
  2. Déposer l'ancienne prise ; repérer phase/neutre/**terre**. `[C]`
  3. Recabler la prise neuve (bornes serrées, terre raccordée). `[B]`
  4. Remonter, rétablir, contrôler (testeur). `[C]` → [prise-sans-courant](../../../diagnostics/electricite-generale/prise-sans-courant.md)
- **Points critiques** : **terre** obligatoire ; serrage des bornes ; sens phase/neutre selon usage.
- **Sécurité** : coupure au disjoncteur + VAT ; si doute sur le circuit → électricien habilité. **Intervention sur installation électrique : **consignation** et **habilitation électrique** requises (NF C 18-510) ; **vérifier l'absence de tension (VAT)** avant tout contact. Une opération au **tableau**, un **raccordement** ou toute opération **sous tension** relèvent d'un professionnel **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-conformite-installation](../../../checklists/electricite-generale/controle-conformite-installation.md)

## Relations & tags
- **Tags** : `metier:electricite-generale equipement:prise famille:electricite sous-famille:appareillage intervention:remplacer cluster:circuits-prises complexite:simple type:reparation securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
