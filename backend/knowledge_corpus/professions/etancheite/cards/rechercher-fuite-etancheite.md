# Rechercher une fuite d'étanchéité

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `rechercher-fuite-etancheite` |
| Titre | Rechercher une fuite d'étanchéité |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : localiser l'origine d'une infiltration sur une étanchéité (toiture-terrasse/balcon), souvent décalée du point d'apparition. `[C]`
- **Résumé** : analyser le cheminement de l'eau (rarement à l'aplomb de la tache), inspecter en priorité les **points singuliers**, recourir si besoin à un **test de mise en eau** ou méthode adaptée, puis réparer dans le respect du système. `[C]` ⟦méthode (fumée/traceur/électrique) à confirmer⟧

## Réalisation
- **Étapes** :
  1. Analyser le **cheminement** de l'eau (décalage tache/entrée). `[C]`
  2. Inspecter en priorité **relevés, évacuations, pénétrations, joints**. `[C]` → [infiltration-toiture-terrasse](../../../diagnostics/etancheite/infiltration-toiture-terrasse.md)
  3. **Test de mise en eau** / méthode adaptée si besoin. `[C]` → [test-mise-en-eau-etancheite](../../../procedures/etancheite/test-mise-en-eau-etancheite.md)
  4. Réparer dans le respect du système (matériaux compatibles). `[C]`
- **Points critiques** : l'entrée d'eau est **rarement à l'aplomb** de la tache ; commencer par les points singuliers ; ne pas masquer la cause.
- **Sécurité** : hauteur ; glissade ; produits ; stabilité du support (zone dégradée). **Travail en **hauteur** (toiture-terrasse, **acrotère**) : risque de **chute** — protections **collectives** (garde-corps/acrotère, filet) prioritaires, EPI antichute, **stabilité des supports** vérifiée. **Produits chimiques** (résines/SEL, primaires, solvants) et **chalumeau** (bitume soudé) : brûlure/incendie/inhalation → EPI, **extincteur**, ventilation, pas de flamme près d'inflammable. **Glissade** (membrane humide/gelée) : semelles adaptées. **Météo** (pluie/gel/rosée/vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention d'étanchéité relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [cloque-poche-eau-membrane](../../../diagnostics/etancheite/cloque-poche-eau-membrane.md)

## Relations & tags
- **Tags** : `metier:etancheite famille:enveloppe sous-famille:etancheite intervention:diagnostiquer intervention:reparer cluster:recherche-de-fuite cluster:infiltrations cluster:reparation complexite:avancee type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
