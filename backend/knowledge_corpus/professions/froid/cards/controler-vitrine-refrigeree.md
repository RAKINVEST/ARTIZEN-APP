# Contrôler une vitrine / un meuble frigorifique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-vitrine-refrigeree` |
| Titre | Contrôler une vitrine / un meuble frigorifique |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler le bon fonctionnement d'une vitrine réfrigérée ou d'un meuble frigorifique (température, évaporateur, condensats) hors circuit frigorifique. `[C]`
- **Résumé** : vérifier la température et la répartition, l'état de l'évaporateur (givre), l'évacuation des condensats, la ligne de nuit / rideau, sans toucher au fluide. `[C]`

## Réalisation
- **Étapes** :
  1. Relever la température (et sa répartition dans le meuble). `[C]`
  2. Contrôler l'évaporateur (givre) et le **dégivrage**. `[C]`
  3. Contrôler l'évacuation des **condensats** et le bac. `[C]` → [controler-evacuation-condensats-froid](controler-evacuation-condensats-froid.md)
  4. Vérifier rideau de nuit / éclairage / étanchéité. `[C]`
- **Points critiques** : respect de la température des denrées ; chargement correct (ligne de charge). 
- **Sécurité** : électrique ; hygiène ;  **Toute manipulation du circuit frigorifique (compresseur, détendeur, charge, récupération, brasage) est **réservée à un frigoriste disposant de l'attestation de capacité F-Gaz**. Ne jamais ouvrir le circuit sans qualification.** `[A]`

## Cadre & suites
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [chambre-froide-ne-tient-pas-temperature](../../../diagnostics/froid/chambre-froide-ne-tient-pas-temperature.md)

## Relations & tags
- **Tags** : `metier:froid equipement:vitrine-refrigeree equipement:meuble-frigorifique famille:fluides sous-famille:froid-commercial intervention:controler cluster:vitrines-refrigerees cluster:meubles-frigorifiques cluster:controle complexite:moyenne type:controle securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
