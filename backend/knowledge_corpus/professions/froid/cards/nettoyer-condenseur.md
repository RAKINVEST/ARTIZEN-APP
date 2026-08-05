# Nettoyer un condenseur (côté air)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `nettoyer-condenseur` |
| Titre | Nettoyer un condenseur (côté air) |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : restaurer l'échange thermique d'un condenseur en nettoyant sa partie air (ailettes, ventilateurs) hors circuit frigorifique. `[C]`
- **Résumé** : couper l'alimentation, nettoyer l'échangeur à ailettes et les ventilateurs, dégager l'implantation, sans ouvrir ni toucher le circuit frigorifique. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation électrique du groupe. `[A]`
  2. Nettoyer l'**échangeur** (ailettes) sans les déformer. `[C]`
  3. Vérifier/nettoyer les **ventilateurs** et dégager l'implantation. `[C]`
  4. Contrôler l'absence de trace d'huile (indice de fuite → frigoriste). `[C]` → [groupe-froid-en-defaut](../../../diagnostics/froid/groupe-froid-en-defaut.md)
- **Points critiques** : condenseur encrassé = haute pression/consommation ; ailettes fragiles ; trace d'huile = fuite → frigoriste.
- **Sécurité** : électrique coupé ;  **Toute manipulation du circuit frigorifique (compresseur, détendeur, charge, récupération, brasage) est **réservée à un frigoriste disposant de l'attestation de capacité F-Gaz**. Ne jamais ouvrir le circuit sans qualification.** `[A]`

## Cadre & suites
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-maintenance-froid](../../../kits/froid/kit-maintenance-froid.md)

## Relations & tags
- **Tags** : `metier:froid equipement:condenseur famille:fluides sous-famille:froid-commercial intervention:entretenir intervention:nettoyer cluster:condenseurs cluster:entretien cluster:maintenance complexite:simple type:entretien securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
