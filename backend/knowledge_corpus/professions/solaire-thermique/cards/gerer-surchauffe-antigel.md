# Gérer surchauffe et antigel

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gerer-surchauffe-antigel` |
| Titre | Gérer surchauffe et antigel |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer la **protection contre la surchauffe** (stagnation) et la **protection antigel** du circuit solaire. `[C]`
- **Résumé** : prévoir la gestion de la **surchauffe/stagnation** (vase/soupape dimensionnés, dissipation, mise en sécurité, fluide résistant) et la **protection antigel** (fluide **glycol** à concentration adaptée au climat, ou système **auto-vidangeable/drain-back**) ; ces protections sont **essentielles** à la durabilité. `[C]` ⟦concentration/dispositifs selon climat à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Surchauffe** : vase/soupape dimensionnés, dissipation, sécurité. `[B]` → [surchauffe-stagnation-solaire](../../../diagnostics/solaire-thermique/surchauffe-stagnation-solaire.md)
  2. **Antigel** : glycol à concentration adaptée au **climat**. `[C]` ⟦à confirmer⟧
  3. Alternative : système **auto-vidangeable (drain-back)**. `[C]`
  4. Vérifier régulièrement (le glycol se dégrade). `[C]` → [remplacer-fluide-caloporteur](remplacer-fluide-caloporteur.md)
- **Points critiques** : surchauffe **anticipée** (stagnation dégrade le fluide) ; antigel adapté au climat ; protections = **durabilité**.
- **Sécurité** : brûlures (surchauffe) ; pression ; glycol. **Travail en toiture** : **risque de chute** — protections collectives / EPI antichute, **manutention des capteurs** (lourds, prise au vent) à plusieurs, météo. **Brûlures** : le **fluide caloporteur** et les capteurs atteignent de **hautes températures** (surchauffe/**stagnation**) → risque de brûlure et de **surpression** ; **purger/refroidir avant intervention**, ne jamais ouvrir un circuit chaud/sous pression. **Pression du circuit** : soupape/vase d'expansion, contrôle avant intervention. **Fluide caloporteur** (glycol) : EPI, élimination tracée. **Raccordement électrique de la régulation** : **réservé** à un professionnel. **Arrêt immédiat en cas de danger.** Interventions réservées à un **installateur qualifié (RGE)**.** `[A]`

## Cadre & suites
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fluide caloporteur** : `cite-carte` → [remplacer-fluide-caloporteur](remplacer-fluide-caloporteur.md)

## Relations & tags
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique intervention:controler cluster:protection-contre-la-surchauffe cluster:protection-antigel cluster:fluide-caloporteur complexite:avancee type:technique securite:brulure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
