# Poser un interrupteur différentiel

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-interrupteur-differentiel` |
| Titre | Poser un interrupteur différentiel |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:tableau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer/remplacer un interrupteur différentiel de protection des personnes — **réservé à un électricien habilité**. `[C]`
- **Résumé** : consigner, poser le différentiel de sensibilité/type adaptés (30 mA pour la protection des personnes), câbler tête de groupe, déconsigner et **tester** au bouton test. `[C]` ⟦type (AC/A/F) selon circuits à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Consigner** + VAT. `[A]` → [consignation-electrique](../../../procedures/electricite-generale/consignation-electrique.md)
  2. Choisir la **sensibilité** (30 mA personnes) et le **type** (AC/A/F selon circuits). `[B]` ⟦à confirmer⟧
  3. Câbler en tête de groupe (amont des disjoncteurs protégés). `[C]`
  4. Déconsigner ; **tester** au bouton test ; contrôler le déclenchement. `[B]`
- **Points critiques** : sensibilité 30 mA (personnes) ; **type** adapté aux circuits (plaque/IH, bornes, VE…). `[B]`
- **Sécurité** : circuit consigné ; test de déclenchement obligatoire. **Intervention sur installation électrique : **consignation** et **habilitation électrique** requises (NF C 18-510) ; **vérifier l'absence de tension (VAT)** avant tout contact. Une opération au **tableau**, un **raccordement** ou toute opération **sous tension** relèvent d'un professionnel **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [differentiel-qui-declenche](../../../diagnostics/electricite-generale/differentiel-qui-declenche.md)

## Relations & tags
- **Tags** : `metier:electricite-generale equipement:differentiel famille:electricite sous-famille:tableau intervention:installer intervention:remplacer cluster:protections cluster:interrupteurs-differentiels cluster:tableau complexite:moyenne type:installation securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
