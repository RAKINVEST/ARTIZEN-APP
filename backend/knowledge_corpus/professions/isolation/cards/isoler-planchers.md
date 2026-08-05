# Isoler des planchers

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `isoler-planchers` |
| Titre | Isoler des planchers |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : isoler un plancher bas (sur cave/vide sanitaire) ou entre étages pour supprimer un pont thermique et améliorer le confort. `[C]`
- **Résumé** : identifier le type de plancher, poser l'isolant en sous-face (panneaux, projection) ou en surface (chape isolante), assurer la continuité avec l'isolation des murs et gérer les traversées de réseaux. `[C]` ⟦système/R selon plancher à confirmer⟧

## Réalisation
- **Étapes** :
  1. Identifier le plancher (bas sur cave/VS, ou intermédiaire). `[C]`
  2. Poser l'isolant en **sous-face** (panneaux/projection) ou surface (chape). `[C]`
  3. Assurer la **continuité** avec l'isolation des murs. `[C]` → [traiter-ponts-thermiques](traiter-ponts-thermiques.md)
  4. Traiter les traversées (réseaux) sans pont thermique. `[C]`
- **Points critiques** : continuité mur/plancher ; ne pas créer de point de condensation ; hauteur sous plafond conservée.
- **Sécurité** : poussières/fibres ; postures ; éventuel travail en sous-sol (ventilation). **Poussières et fibres** (laines minérales/bois, ouate) : risque **respiratoire** — **EPI adaptés** (masque FFP adapté, combinaison, gants, lunettes), ventilation du chantier. **Travail en hauteur** (combles, murs) : **stabilité des supports** (circuler uniquement sur zones porteuses — risque de **chute à travers le plafond**). **Humidité / moisissures** : traiter la cause **avant** d'isoler (jamais isoler sur support humide/moisi). **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic** : `cite-carte` → [diagnostiquer-isolation](diagnostiquer-isolation.md)

## Relations & tags
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation intervention:poser cluster:isolation-des-planchers cluster:ponts-thermiques cluster:panneaux-isolants complexite:moyenne type:installation securite:respiratoire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
