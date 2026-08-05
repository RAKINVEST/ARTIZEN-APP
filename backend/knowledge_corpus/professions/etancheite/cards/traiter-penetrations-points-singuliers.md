# Traiter pénétrations, évacuations EP et joints

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-penetrations-points-singuliers` |
| Titre | Traiter pénétrations, évacuations EP et joints |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : traiter les points singuliers d'une étanchéité : **pénétrations**, **évacuations EP**, **joints** de dilatation. `[C]`
- **Résumé** : raccorder l'étanchéité aux **pénétrations** (sorties, crémaillères) par manchons/platines, poser/raccorder les **évacuations EP** (naissances, moignons, trop-pleins), et traiter les **joints de dilatation** — en interface zinguerie pour l'évacuation aval. `[C]` ⟦accessoires selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Pénétrations** : platine/manchon étanche raccordé. `[C]`
  2. **Évacuations EP** : naissance/moignon + trop-plein ; sens d'écoulement. `[C]` → [poser-descente-ep](../../../professions/zinguerie/cards/poser-descente-ep.md)
  3. **Joints de dilatation** : dispositif adapté (à recouvrement). `[C]`
  4. Contrôler l'étanchéité des raccords. `[C]` → [rechercher-fuite-etancheite](rechercher-fuite-etancheite.md)
- **Points critiques** : les points singuliers = **origine majeure des fuites** ; évacuations dimensionnées + trop-plein ; interface zinguerie (aval).
- **Sécurité** : hauteur ; produits/chalumeau ; glissade. **Travail en **hauteur** (toiture-terrasse, **acrotère**) : risque de **chute** — protections **collectives** (garde-corps/acrotère, filet) prioritaires, EPI antichute, **stabilité des supports** vérifiée. **Produits chimiques** (résines/SEL, primaires, solvants) et **chalumeau** (bitume soudé) : brûlure/incendie/inhalation → EPI, **extincteur**, ventilation, pas de flamme près d'inflammable. **Glissade** (membrane humide/gelée) : semelles adaptées. **Météo** (pluie/gel/rosée/vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention d'étanchéité relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Émergences (couverture)** : `cite-carte` → [traiter-noues-emergences](../../../professions/couverture/cards/traiter-noues-emergences.md)

## Relations & tags
- **Tags** : `metier:etancheite famille:enveloppe sous-famille:etancheite intervention:realiser cluster:penetrations cluster:evacuations-ep cluster:joints cluster:points-singuliers complexite:avancee type:installation securite:hauteur relation:zinguerie relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
