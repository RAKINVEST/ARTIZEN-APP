# Remplacer un vitrage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-vitrage` |
| Titre | Remplacer un vitrage |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer un vitrage (cassé, embué) par un vitrage isolant équivalent, selon le **DTU 39**. `[C]`
- **Résumé** : identifier le vitrage (double/triple, dimensions, gaz/traitement), déposer en sécurité (verre cassé), poser le vitrage équivalent avec cales et parcloses, en assurant le calage et l'étanchéité du **feuillure/joint**. `[C]` ⟦composition (4/16/4, gaz, ITR) à confirmer⟧

## Réalisation
- **Étapes** :
  1. Identifier le vitrage (composition, dimensions). `[C]` → [condensation-buee-vitrage](../../../diagnostics/menuiserie-exterieure/condensation-buee-vitrage.md)
  2. Déposer (verre cassé : sécurité **coupure**) ; retirer parcloses. `[A]`
  3. Poser le vitrage équivalent avec **cales** (calage périphérique). `[C]`
  4. Reposer parcloses ; étanchéité (joint/mastic) ; contrôle. `[C]`
- **Points critiques** : vitrage **équivalent** (performance/sécurité) ; **calage** correct (pas de contrainte sur le verre) ; étanchéité de feuillure.
- **Sécurité** : **coupure** (verre) ; manutention/poids ; hauteur. **Manutention** de menuiseries/**vitrages lourds** : risque d'écrasement / **coupure** (verre) — moyens de levage, gants anti-coupure, travail en binôme. **Travail en **hauteur** (baies d'étage, dépose) : protections collectives / EPI. **Produits** (mousse PU, mastics, solvants) : EPI / ventilation. **Motorisation de volet** : le **raccordement électrique** relève d'un professionnel (voir Électricité). **Stabilité** du support/de la baie vérifiée avant dépose. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-menuiserie](../../../checklists/menuiserie-exterieure/controle-maintenance-menuiserie.md)

## Relations & tags
- **Tags** : `metier:menuiserie-exterieure equipement:vitrage famille:enveloppe sous-famille:menuiserie-exterieure intervention:remplacer cluster:vitrages cluster:remplacement complexite:avancee type:remplacement securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
