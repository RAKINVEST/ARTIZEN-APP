# Isoler des murs par l'intérieur (ITI)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `isoler-murs-interieur` |
| Titre | Isoler des murs par l'intérieur (ITI) |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : isoler des murs par l'intérieur (doublage collé ou sur ossature) en gérant la vapeur d'eau et les ponts thermiques. `[C]`
- **Résumé** : diagnostiquer l'état du mur (humidité), poser l'isolant (doublage collé ou **ossature métallique + isolant**), intégrer le **pare/frein-vapeur** côté chaud, traiter les ponts thermiques de liaison, puis fermer par le parement (**DTU 25.41**). `[C]` ⟦système/R selon paroi à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler l'état du mur : **humidité** traitée avant d'isoler. `[C]` → [condensation-moisissure-isolation](../../../diagnostics/isolation/condensation-moisissure-isolation.md)
  2. Poser l'isolant (doublage collé ou **ossature** + laine). `[C]`
  3. Intégrer **pare/frein-vapeur** continu côté chaud. `[C]` → [poser-pare-vapeur](poser-pare-vapeur.md)
  4. Traiter les **ponts thermiques** (planchers, refends) ; parement (**DTU 25.41**). `[C]` → [traiter-ponts-thermiques](traiter-ponts-thermiques.md)
- **Points critiques** : **jamais isoler sur mur humide** ; gestion de la vapeur (risque de condensation dans la paroi) ; ponts thermiques de liaison.
- **Sécurité** : poussières/fibres (respiratoire) ; humidité/moisissure ; découpe (coupure). **Poussières et fibres** (laines minérales/bois, ouate) : risque **respiratoire** — **EPI adaptés** (masque FFP adapté, combinaison, gants, lunettes), ventilation du chantier. **Travail en hauteur** (combles, murs) : **stabilité des supports** (circuler uniquement sur zones porteuses — risque de **chute à travers le plafond**). **Humidité / moisissures** : traiter la cause **avant** d'isoler (jamais isoler sur support humide/moisi). **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Continuité de l'air** : `cite-carte` → [poser-pare-vapeur](poser-pare-vapeur.md)

## Relations & tags
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation intervention:poser intervention:realiser cluster:isolation-des-murs cluster:isolation-interieure cluster:panneaux-isolants cluster:pare-vapeur complexite:avancee type:installation securite:respiratoire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
