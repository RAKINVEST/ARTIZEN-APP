# Diagnostiquer une fuite sous évier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Confiance : A normes/fabricant · B technique · C terrain · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-fuite-sous-evier` |
| Titre | Diagnostiquer une fuite sous évier |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:sanitaire` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : Localiser l'origine exacte d'une fuite sous évier avant toute réparation (méthode d'élimination). `[C]`
- **Résumé** : Sécher, isoler les sources possibles (arrivées EF/ECS, flexibles, bonde, siphon, joint), mettre en eau/observer, remonter à la source, décider du geste. `[C]`
- **Difficulté** : `simple` `[C]`
- **Temps moyen** : ~15–30 min `[C]`

## Réalisation (méthode de diagnostic)
- **Étapes** :
  1. Sécher entièrement la zone ; poser du papier absorbant repère. `[C]`
  2. Vérifier séparément : **arrivées** (EF/ECS) → **flexibles/raccords** → **bonde** → **siphon** → **joints**. `[C]`
  3. Mettre en eau et **observer** (statique puis en écoulement). `[C]`
  4. Remonter à la **source unique** ; distinguer condensation vs fuite réelle. `[C]`
  5. Orienter vers le geste : `remplacer-flexible-alimentation`, resserrage bonde/siphon, joint. `[C]`
- **Points critiques** : ne pas confondre **condensation** et fuite ; vérifier en statique **et** en écoulement. `[C]`
- **Sécurité** : couper l'eau avant démontage ; produits/eaux usées → EPI. `[B]`

## Cadre & suites
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [fuite-sous-evier](../../../diagnostics/plomberie/fuite-sous-evier.md)
- **Gestes possibles** : [remplacer-flexible-alimentation](remplacer-flexible-alimentation.md), [remplacer-cartouche-mitigeur](remplacer-cartouche-mitigeur.md)
- **Contrôle final** : `a-checklist` → [controle-etancheite](../../../checklists/plomberie/controle-etancheite.md)

## Relations & tags
- **Relations** : `traite-diagnostic`, `a-checklist`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:sanitaire intervention:diagnostiquer probleme:fuite equipement:evier equipement:mitigeur piece:cuisine complexite:simple type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-02 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
