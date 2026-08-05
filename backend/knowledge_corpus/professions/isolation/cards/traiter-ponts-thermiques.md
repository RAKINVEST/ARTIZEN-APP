# Traiter les ponts thermiques (continuité)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-ponts-thermiques` |
| Titre | Traiter les ponts thermiques (continuité) |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : identifier et traiter les ponts thermiques pour assurer la **continuité** de l'isolation. `[C]`
- **Résumé** : repérer les ponts thermiques (liaisons planchers/refends/menuiseries), assurer la continuité de l'isolant et de l'étanchéité à l'air aux liaisons, l'ITE traitant nativement mieux les ponts que l'ITI. `[C]` ⟦traitement selon liaison à confirmer⟧

## Réalisation
- **Étapes** :
  1. Repérer les ponts thermiques (liaisons, tableaux, planchers). `[C]` → [deperdition-pont-thermique](../../../diagnostics/isolation/deperdition-pont-thermique.md)
  2. Assurer la **continuité** de l'isolant aux liaisons. `[C]`
  3. Traiter les tableaux de menuiseries, about de plancher. `[C]`
  4. Réduction des déperditions → confort et **bésoin de chauffage** moindre. `[C]` → [entretenir-chaudiere](../../../professions/chauffage/cards/entretenir-chaudiere.md)
- **Points critiques** : **continuité** prioritaire (un pont thermique = condensation + perte) ; cohérence ITI/ITE.
- **Sécurité** : poussières/fibres ; hauteur ; humidité aux liaisons. **Poussières et fibres** (laines minérales/bois, ouate) : risque **respiratoire** — **EPI adaptés** (masque FFP adapté, combinaison, gants, lunettes), ventilation du chantier. **Travail en hauteur** (combles, murs) : **stabilité des supports** (circuler uniquement sur zones porteuses — risque de **chute à travers le plafond**). **Humidité / moisissures** : traiter la cause **avant** d'isoler (jamais isoler sur support humide/moisi). **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Façade (ITE)** : `cite-carte` → [controler-ite-facade](../../../professions/facade/cards/controler-ite-facade.md)

## Relations & tags
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation intervention:reparer cluster:ponts-thermiques cluster:continuite-de-l-isolation cluster:reparation complexite:avancee type:technique securite:respiratoire relation:chauffage relation:facade`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
