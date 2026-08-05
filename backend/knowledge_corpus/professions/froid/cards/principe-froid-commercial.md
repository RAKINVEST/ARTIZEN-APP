# Principe d'une installation de froid commercial

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-froid-commercial` |
| Titre | Principe d'une installation de froid commercial |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les composants d'une installation frigorifique commerciale (compresseur, condenseur, détendeur, évaporateur, groupe). `[C]`
- **Résumé** : un groupe frigorifique fait circuler un fluide qui absorbe la chaleur à l'évaporateur (enceinte froide) et la rejette au condenseur ; **compresseur** et **détendeur** gèrent pression/débit. La partie fluide est **réglementée**. `[C]` ⟦schémas/valeurs selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Évaporateur** (enceinte froide) : absorbe la chaleur. `[C]`
  2. **Compresseur** + **condenseur** : élèvent puis rejettent la chaleur. `[C]`
  3. **Détendeur** : détend le fluide avant l'évaporateur. `[C]`
  4. Régulation (température, dégivrage) pilote l'ensemble. `[C]` → [parametrer-regulation-froid](parametrer-regulation-froid.md)
- **Points critiques** : distinguer parties **accessibles** (régulation, condenseur côté air, enceinte) et **circuit frigorifique** réservé.
- **Sécurité** : distinguer clairement le domaine **accessible** du **circuit frigorifique** réservé (F-Gaz). **Toute manipulation du circuit frigorifique (compresseur, détendeur, charge, récupération, brasage) est **réservée à un frigoriste disposant de l'attestation de capacité F-Gaz**. Ne jamais ouvrir le circuit sans qualification.** `[A]`

## Cadre & suites
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurité liée** : `a-checklist` → [securite-frigorifique-froid](../../../checklists/froid/securite-frigorifique-froid.md)
- **Relations Climatisation** : `cite-checklist` → [securite-frigorifique-clim](../../../checklists/climatisation/securite-frigorifique-clim.md)

## Relations & tags
- **Tags** : `metier:froid equipement:groupe-froid equipement:compresseur equipement:condenseur equipement:evaporateur equipement:detendeur famille:fluides sous-famille:froid-commercial intervention:comprendre cluster:principe cluster:groupes cluster:compresseurs cluster:evaporateurs cluster:condenseurs cluster:detendeurs type:principe securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
