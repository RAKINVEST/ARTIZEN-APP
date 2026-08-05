# Régler la régulation solaire

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `regler-regulation-solaire` |
| Titre | Régler la régulation solaire |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : régler la **régulation différentielle** (sondes, seuils) — le raccordement électrique relève d'un professionnel. `[C]`
- **Résumé** : positionner les **sondes** (capteur / bas de ballon), paramétrer le **différentiel** de marche/arrêt du circulateur, les sécurités (surchauffe capteur/ballon) et les priorités (SSC) ; le **raccordement électrique** de la régulation est **réservé à un professionnel**. `[C]` ⟦seuils/différentiel selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Positionner les **sondes** (capteur / ballon). `[C]`
  2. Régler le **différentiel** (marche/arrêt circulateur). `[C]` ⟦à confirmer⟧
  3. Régler les **sécurités** (surchauffe capteur/ballon). `[C]`
  4. **Raccordement électrique** = **professionnel**. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
- **Points critiques** : sondes bien placées ; différentiel correct (évite cycles courts) ; sécurités surchauffe ; **élec réservée**.
- **Sécurité** : électricité (régulation) ; brûlures ; toiture (sonde capteur). **Travail en toiture** : **risque de chute** — protections collectives / EPI antichute, **manutention des capteurs** (lourds, prise au vent) à plusieurs, météo. **Brûlures** : le **fluide caloporteur** et les capteurs atteignent de **hautes températures** (surchauffe/**stagnation**) → risque de brûlure et de **surpression** ; **purger/refroidir avant intervention**, ne jamais ouvrir un circuit chaud/sous pression. **Pression du circuit** : soupape/vase d'expansion, contrôle avant intervention. **Fluide caloporteur** (glycol) : EPI, élimination tracée. **Raccordement électrique de la régulation** : **réservé** à un professionnel. **Arrêt immédiat en cas de danger.** Interventions réservées à un **installateur qualifié (RGE)**.** `[A]`

## Cadre & suites
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pas de production** : `traite-diagnostic` → [pas-de-production-solaire](../../../diagnostics/solaire-thermique/pas-de-production-solaire.md)

## Relations & tags
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique intervention:regler cluster:regulation complexite:avancee type:reglage securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
