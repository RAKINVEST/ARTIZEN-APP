# Remplacer un circulateur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-circulateur` |
| Titre | Remplacer un circulateur |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:reseau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer un circulateur (pompe) défaillant pour rétablir la circulation du circuit de chauffage. `[C]`
- **Résumé** : consigner et isoler le circulateur (vannes), vidanger localement, déposer l'ancien, poser le neuf (sens de circulation), remettre en eau, purger, régler la vitesse et contrôler. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'électricité du circulateur et isoler par les vannes. `[A]`
  2. Vidanger localement entre les vannes. `[C]`
  3. Déposer l'ancien circulateur ; nettoyer les portées. `[C]`
  4. Poser le neuf en respectant le **sens de circulation** (flèche) et l'axe moteur horizontal. `[B]`
  5. Remettre en eau, **purger** l'air, régler la vitesse. `[C]` → [purger-radiateur](purger-radiateur.md)
  6. Contrôler débit, bruit et étanchéité. `[C]` → [mise-en-service-chauffage](../../../procedures/chauffage/mise-en-service-chauffage.md)
- **Points critiques** : sens de circulation ; axe moteur **horizontal** ; purge de l'air ; étanchéité des raccords. `[B]`
- **Sécurité** : électricité (consignation), eau chaude, charges. `[B]`

## Cadre & suites
- **Normes** : sécurité chauffage central **DTU 65.11** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [circulateur-bruyant](../../../diagnostics/chauffage/circulateur-bruyant.md)
- **Interventions liées** : `cite-carte` → [desembouer-circuit-chauffage](desembouer-circuit-chauffage.md)

## Relations & tags
- **Tags** : `metier:chauffage famille:fluides sous-famille:reseau intervention:remplacer equipement:circulateur probleme:panne complexite:moyenne type:remplacement securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
