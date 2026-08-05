# Entretenir une chaudière

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-chaudiere` |
| Titre | Entretenir une chaudière |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:generation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser l'entretien annuel d'une chaudière (obligatoire) pour la sécurité, le rendement et la longevité. `[C]`
- **Résumé** : contrôler la combustion et les organes de sécurité, nettoyer le corps de chauffe et le brûleur, vérifier le conduit d'évacuation, la pression et l'étanchéité, puis délivrer l'attestation. `[C]` ⟦procédure détaillée selon type/fabricant à valider⟧

## Réalisation
- **Étapes** :
  1. Consigner (coupure combustible/électricité) et laisser refroidir. `[A]`
  2. Nettoyer corps de chauffe, brûleur, veilleuse ; contrôler l'allumage. `[C]` ⟦selon type⟧
  3. Vérifier le **conduit d'évacuation** des fumées et l'aération du local. `[B]`
  4. Contrôler pression du circuit, vase d'expansion, soupape. `[B]` → [controler-regonfler-vase-expansion](controler-regonfler-vase-expansion.md)
  5. Mesurer la combustion (le cas échéant) ; consigner et **remettre en service**. `[C]` → [mise-en-service-chauffage](../../../procedures/chauffage/mise-en-service-chauffage.md)
- **Points critiques** : évacuation des fumées libre ; organes de sécurité fonctionnels ; **entretien annuel obligatoire**. `[B]` ⟦cadre réglementaire à préciser⟧
- **Sécurité** : risque **CO** (monoxyde), combustible (gaz/fioul), électricité, brûlure — intervenant qualifié. `[A]`

## Cadre & suites
- **Normes** : conduits de fumée **DTU 24.1** ; chaudière gaz **DTU 61.1** ; sécurité chauffage **DTU 65.11** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [chaudiere-en-securite](../../../diagnostics/chauffage/chaudiere-en-securite.md)
- **Kit** : `utilise-kit` → [kit-entretien-chaudiere](../../../kits/chauffage/kit-entretien-chaudiere.md)
- **Conseil** : `cite-phrase` → [conseil-entretien-chaudiere-annuel](../../../phrases/chauffage/conseil-entretien-chaudiere-annuel.md)

## Relations & tags
- **Tags** : `metier:chauffage famille:fluides sous-famille:generation intervention:entretenir equipement:chaudiere probleme:usure complexite:avancee type:entretien securite:combustion`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
