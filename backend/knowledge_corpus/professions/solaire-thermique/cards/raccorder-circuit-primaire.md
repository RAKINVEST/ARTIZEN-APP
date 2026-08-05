# Raccorder le circuit primaire (circulateur, vase, fluide)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `raccorder-circuit-primaire` |
| Titre | Raccorder le circuit primaire (circulateur, vase, fluide) |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser le circuit primaire glycolé : circulateur, **vase d'expansion**, soupape, fluide caloporteur. `[C]`
- **Résumé** : raccorder les capteurs au ballon via le **circulateur** (ou station solaire), dimensionner et monter le **vase d'expansion** et la **soupape** (surpression/surchauffe), calorifuger les tuyauteries résistantes à la température, puis remplir avec le **fluide caloporteur** (glycol) à la bonne concentration. `[C]` ⟦vase/pression/concentration glycol selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Monter le **circulateur**/station solaire. `[C]` → [remplacer-circulateur](../../../professions/chauffage/cards/remplacer-circulateur.md)
  2. Dimensionner **vase d'expansion** + **soupape** (surchauffe). `[B]` → [controler-regonfler-vase-expansion](../../../professions/chauffage/cards/controler-regonfler-vase-expansion.md)
  3. Calorifuger (isolant **résistant à la température**/UV). `[C]`
  4. Remplir en **fluide caloporteur** (glycol, concentration). `[C]` → [mise-en-service-solaire](../../../procedures/solaire-thermique/mise-en-service-solaire.md)
- **Points critiques** : **vase adapté à la surchauffe** (stagnation = vaporisation) ; soupape ; calorifuge haute température ; concentration glycol correcte.
- **Sécurité** : brûlures/**pression** (circuit chaud) ; glycol (EPI) ; toiture. **Travail en toiture** : **risque de chute** — protections collectives / EPI antichute, **manutention des capteurs** (lourds, prise au vent) à plusieurs, météo. **Brûlures** : le **fluide caloporteur** et les capteurs atteignent de **hautes températures** (surchauffe/**stagnation**) → risque de brûlure et de **surpression** ; **purger/refroidir avant intervention**, ne jamais ouvrir un circuit chaud/sous pression. **Pression du circuit** : soupape/vase d'expansion, contrôle avant intervention. **Fluide caloporteur** (glycol) : EPI, élimination tracée. **Raccordement électrique de la régulation** : **réservé** à un professionnel. **Arrêt immédiat en cas de danger.** Interventions réservées à un **installateur qualifié (RGE)**.** `[A]`

## Cadre & suites
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Surchauffe / antigel** : `cite-carte` → [gerer-surchauffe-antigel](gerer-surchauffe-antigel.md)

## Relations & tags
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique intervention:poser cluster:circulateurs cluster:fluide-caloporteur cluster:vase-d-expansion complexite:avancee type:installation securite:brulure relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
