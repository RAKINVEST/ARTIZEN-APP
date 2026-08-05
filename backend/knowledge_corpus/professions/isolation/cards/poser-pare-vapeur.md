# Poser un pare-vapeur / frein-vapeur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-pare-vapeur` |
| Titre | Poser un pare-vapeur / frein-vapeur |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un **pare-vapeur** ou **frein-vapeur** côté chaud pour gérer la migration de vapeur et l'étanchéité à l'air. `[C]`
- **Résumé** : poser la membrane (pare-vapeur étanche ou frein-vapeur hygro-variable) côté intérieur/chaud, assurer la **continuité** (lés recouverts, adhésifs, traitement des points singuliers), en cohérence avec la **ventilation**. `[C]` ⟦type de membrane selon paroi à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir **pare-vapeur** (étanche) ou **frein-vapeur** (hygro-variable) selon paroi. `[C]` ⟦à confirmer⟧
  2. Poser côté **chaud** (intérieur), lés recouverts. `[C]`
  3. Assurer la **continuité** (adhésifs, passages de réseaux, jonctions). `[C]` → [controle-continuite-isolation](../../../procedures/isolation/controle-continuite-isolation.md)
  4. Cohérence avec la **ventilation** (renouvellement d'air). `[C]` → [entretenir-vmc-simple-flux](../../../professions/ventilation/cards/entretenir-vmc-simple-flux.md)
- **Points critiques** : membrane **côté chaud** ; continuité sans déchirure ; sans ventilation adaptée, l'étanchéité à l'air dégrade la qualité d'air.
- **Sécurité** : poussières/fibres ; découpe ; hauteur selon paroi. **Poussières et fibres** (laines minérales/bois, ouate) : risque **respiratoire** — **EPI adaptés** (masque FFP adapté, combinaison, gants, lunettes), ventilation du chantier. **Travail en hauteur** (combles, murs) : **stabilité des supports** (circuler uniquement sur zones porteuses — risque de **chute à travers le plafond**). **Humidité / moisissures** : traiter la cause **avant** d'isoler (jamais isoler sur support humide/moisi). **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Condensation** : `traite-diagnostic` → [condensation-moisissure-isolation](../../../diagnostics/isolation/condensation-moisissure-isolation.md)

## Relations & tags
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation intervention:poser cluster:pare-vapeur cluster:frein-vapeur cluster:continuite-de-l-isolation complexite:avancee type:installation securite:respiratoire relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
