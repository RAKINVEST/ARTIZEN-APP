# Principe du solaire thermique (CESI / SSC)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-solaire-thermique` |
| Titre | Principe du solaire thermique (CESI / SSC) |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le solaire thermique : capter l'énergie solaire pour l'ECS (**CESI**) ou l'ECS+chauffage (**SSC**). `[C]`
- **Résumé** : les **capteurs** chauffent un **fluide caloporteur** (circuit primaire glycolé) qui cède sa chaleur, via un **échangeur**, à un **ballon solaire** ; en **CESI** pour l'ECS, en **SSC** pour l'ECS + chauffage, avec un **appoint** (chaudière/électrique) et une **régulation différentielle**. `[C]` ⟦dimensionnement (surface/ballon) selon besoins et ensoleillement à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Capteurs** en toiture (orientation/inclinaison). `[C]` → [poser-capteurs-solaires](poser-capteurs-solaires.md)
  2. **Circuit primaire** glycolé (circulateur/vase/fluide). `[C]` → [raccorder-circuit-primaire](raccorder-circuit-primaire.md)
  3. **Ballon solaire + échangeur** + **appoint**. `[C]` → [installer-ballon-solaire-echangeur](installer-ballon-solaire-echangeur.md)
  4. **Appoint** (SSC) côté chauffage. `[C]` → [entretenir-chaudiere](../../../professions/chauffage/cards/entretenir-chaudiere.md)
- **Points critiques** : dimensionnement (surface/ballon) ; gestion **surchauffe/antigel** ; régulation différentielle ; appoint coordonné.
- **Sécurité** : toiture/chute ; brûlures (fluide chaud) ; pression. **Travail en toiture** : **risque de chute** — protections collectives / EPI antichute, **manutention des capteurs** (lourds, prise au vent) à plusieurs, météo. **Brûlures** : le **fluide caloporteur** et les capteurs atteignent de **hautes températures** (surchauffe/**stagnation**) → risque de brûlure et de **surpression** ; **purger/refroidir avant intervention**, ne jamais ouvrir un circuit chaud/sous pression. **Pression du circuit** : soupape/vase d'expansion, contrôle avant intervention. **Fluide caloporteur** (glycol) : EPI, élimination tracée. **Raccordement électrique de la régulation** : **réservé** à un professionnel. **Arrêt immédiat en cas de danger.** Interventions réservées à un **installateur qualifié (RGE)**.** `[A]`

## Cadre & suites
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Régulation** : `cite-carte` → [regler-regulation-solaire](regler-regulation-solaire.md)

## Relations & tags
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique intervention:comprendre cluster:capteurs-solaires-thermiques cluster:chauffe-eau-solaire-individuel cluster:systeme-solaire-combine cluster:ballon-solaire cluster:echangeurs type:principe securite:hauteur relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
