# Entretenir / contrôler une installation solaire

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-controler-solaire` |
| Titre | Entretenir / contrôler une installation solaire |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir et contrôler l'installation solaire (fluide, pression, capteurs, régulation, rendement). `[C]`
- **Résumé** : contrôler la **pression** du circuit et le **vase**, l'état du **fluide caloporteur** (antigel/pH), la propreté/intégrité des **capteurs**, le fonctionnement du **circulateur** et de la **régulation**, et vérifier le rendement/les températures ; détecter surchauffes et fuites. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler **pression** + vase d'expansion. `[C]` → [fuite-baisse-pression-primaire](../../../diagnostics/solaire-thermique/fuite-baisse-pression-primaire.md)
  2. Contrôler le **fluide** (antigel/pH) ; remplacer si dégradé. `[C]` → [remplacer-fluide-caloporteur](remplacer-fluide-caloporteur.md)
  3. Vérifier **capteurs** (propreté/intégrité) et **régulation**. `[C]`
  4. Contrôler rendement/températures. `[C]` → [controle-maintenance-solaire](../../../checklists/solaire-thermique/controle-maintenance-solaire.md)
- **Points critiques** : pression/vase ; fluide non dégradé ; capteurs propres ; détecter tôt surchauffe/fuite.
- **Sécurité** : toiture (capteurs) ; brûlures ; pression ; électricité. **Travail en toiture** : **risque de chute** — protections collectives / EPI antichute, **manutention des capteurs** (lourds, prise au vent) à plusieurs, météo. **Brûlures** : le **fluide caloporteur** et les capteurs atteignent de **hautes températures** (surchauffe/**stagnation**) → risque de brûlure et de **surpression** ; **purger/refroidir avant intervention**, ne jamais ouvrir un circuit chaud/sous pression. **Pression du circuit** : soupape/vase d'expansion, contrôle avant intervention. **Fluide caloporteur** (glycol) : EPI, élimination tracée. **Raccordement électrique de la régulation** : **réservé** à un professionnel. **Arrêt immédiat en cas de danger.** Interventions réservées à un **installateur qualifié (RGE)**.** `[A]`

## Cadre & suites
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-solaire-thermique](../../../kits/solaire-thermique/kit-solaire-thermique.md)

## Relations & tags
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:controle complexite:moyenne type:entretien securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
