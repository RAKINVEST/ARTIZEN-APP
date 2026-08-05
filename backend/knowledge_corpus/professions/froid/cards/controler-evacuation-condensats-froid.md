# Contrôler l'évacuation des condensats (froid)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-evacuation-condensats-froid` |
| Titre | Contrôler l'évacuation des condensats (froid) |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'évacuation des eaux de condensation/dégivrage d'un évaporateur (bac, siphon, cordon chauffant). `[C]`
- **Résumé** : nettoyer le bac et la ligne, contrôler la pente/siphon et le cordon chauffant anti-gel (froid négatif), tester l'écoulement. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation électrique. `[A]`
  2. Nettoyer le **bac** et la ligne d'évacuation. `[C]`
  3. Contrôler pente/siphon et **cordon chauffant** anti-gel (négatif). `[C]`
  4. Tester l'écoulement (eau versée). `[C]`
- **Points critiques** : ligne gelée/bouchée = débordement/givrage ; cordon chauffant indispensable en négatif.
- **Sécurité** : électrique coupé ; hygiène ;  **Toute manipulation du circuit frigorifique (compresseur, détendeur, charge, récupération, brasage) est **réservée à un frigoriste disposant de l'attestation de capacité F-Gaz**. Ne jamais ouvrir le circuit sans qualification.** `[A]`

## Cadre & suites
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [givrage-excessif-evaporateur](../../../diagnostics/froid/givrage-excessif-evaporateur.md)

## Relations & tags
- **Tags** : `metier:froid equipement:evaporateur equipement:bac-condensats famille:fluides sous-famille:froid-commercial intervention:controler intervention:entretenir cluster:evaporateurs cluster:entretien cluster:degivrage probleme:condensats complexite:simple type:entretien securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
