# Poser des capteurs solaires thermiques

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-capteurs-solaires` |
| Titre | Poser des capteurs solaires thermiques |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser les capteurs solaires en toiture avec l'orientation/inclinaison optimales et une étanchéité maîtrisée. `[C]`
- **Résumé** : fixer les capteurs (surimposés ou intégrés) sur un support adapté, à l'**orientation** (sud) et l'**inclinaison** favorables, en assurant l'**étanchéité des traversées** de toiture (interface couverture) et la tenue au vent ; manutention lourde en hauteur. `[C]` ⟦orientation/inclinaison/fixation selon toiture à confirmer⟧

## Réalisation
- **Étapes** :
  1. Sécuriser la toiture (protections/EPI antichute). `[A]`
  2. Fixer les capteurs (support/tenue au vent) à l'orientation/inclinaison. `[C]` ⟦à confirmer⟧
  3. Assurer l'**étanchéité des traversées** (interface couverture). `[C]` → [poser-fenetre-de-toit](../../../professions/couverture/cards/poser-fenetre-de-toit.md)
  4. Raccorder au **circuit primaire**. `[C]` → [raccorder-circuit-primaire](raccorder-circuit-primaire.md)
- **Points critiques** : orientation/inclinaison ; **étanchéité des traversées** (interface couverture) ; tenue au vent ; manutention sécurisée.
- **Sécurité** : **toiture/chute** ; manutention capteurs ; météo. **Travail en toiture** : **risque de chute** — protections collectives / EPI antichute, **manutention des capteurs** (lourds, prise au vent) à plusieurs, météo. **Brûlures** : le **fluide caloporteur** et les capteurs atteignent de **hautes températures** (surchauffe/**stagnation**) → risque de brûlure et de **surpression** ; **purger/refroidir avant intervention**, ne jamais ouvrir un circuit chaud/sous pression. **Pression du circuit** : soupape/vase d'expansion, contrôle avant intervention. **Fluide caloporteur** (glycol) : EPI, élimination tracée. **Raccordement électrique de la régulation** : **réservé** à un professionnel. **Arrêt immédiat en cas de danger.** Interventions réservées à un **installateur qualifié (RGE)**.** `[A]`

## Cadre & suites
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Circuit primaire** : `cite-carte` → [raccorder-circuit-primaire](raccorder-circuit-primaire.md)

## Relations & tags
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique intervention:poser cluster:capteurs-solaires-thermiques complexite:avancee type:installation securite:hauteur relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
