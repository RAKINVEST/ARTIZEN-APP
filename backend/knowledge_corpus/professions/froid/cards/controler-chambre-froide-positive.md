# Contrôler une chambre froide positive

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-chambre-froide-positive` |
| Titre | Contrôler une chambre froide positive |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler le bon fonctionnement d'une chambre froide **positive** (0 à +8 °C environ) hors circuit frigorifique. `[C]` ⟦plage exacte selon denrées à confirmer⟧
- **Résumé** : vérifier la température de consigne/relevée, l'étanchéité de la porte, l'état de l'évaporateur (givre), l'évacuation des condensats et la régulation, sans intervenir sur le fluide. `[C]`

## Réalisation
- **Étapes** :
  1. Relever température **consigne vs réelle** ; contrôler la sonde. `[C]`
  2. Vérifier le **joint de porte** et la fermeture. `[C]` → [controler-joint-porte-chambre-froide](controler-joint-porte-chambre-froide.md)
  3. Contrôler l'évaporateur (givre) et l'évacuation des condensats. `[C]` → [controler-evacuation-condensats-froid](controler-evacuation-condensats-froid.md)
  4. Contrôler la régulation et le cycle de **dégivrage**. `[C]`
- **Points critiques** : chaîne du froid (denrées) ; ne pas ouvrir le circuit frigorifique.
- **Sécurité** : hygiène (denrées) ; électrique ;  **Toute manipulation du circuit frigorifique (compresseur, détendeur, charge, récupération, brasage) est **réservée à un frigoriste disposant de l'attestation de capacité F-Gaz**. Ne jamais ouvrir le circuit sans qualification.** `[A]`

## Cadre & suites
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [chambre-froide-ne-tient-pas-temperature](../../../diagnostics/froid/chambre-froide-ne-tient-pas-temperature.md)

## Relations & tags
- **Tags** : `metier:froid equipement:chambre-froide famille:fluides sous-famille:froid-commercial intervention:controler cluster:chambres-froides-positives cluster:controle cluster:regulation complexite:moyenne type:controle securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
