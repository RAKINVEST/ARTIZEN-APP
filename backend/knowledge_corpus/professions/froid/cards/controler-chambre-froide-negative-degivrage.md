# Contrôler une chambre froide négative et son dégivrage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-chambre-froide-negative-degivrage` |
| Titre | Contrôler une chambre froide négative et son dégivrage |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler une chambre froide **négative** (températures < 0 °C) et le bon fonctionnement du **dégivrage** (électrique/gaz chaud). `[C]` ⟦consignes selon denrées à confirmer⟧
- **Résumé** : vérifier la température, l'état du dégivrage (résistances, sonde de fin, horloge), l'évacuation des eaux de dégivrage (cordon chauffant anti-gel) et l'étanchéité. `[C]`

## Réalisation
- **Étapes** :
  1. Relever la température ; contrôler la sonde. `[C]`
  2. Vérifier le **cycle de dégivrage** (fréquence, durée, sonde de fin). `[C]`
  3. Contrôler l'**évacuation des eaux de dégivrage** (pente, cordon chauffant). `[C]`
  4. Contrôler joints et fermeture (givrage). `[C]` → [givrage-excessif-evaporateur](../../../diagnostics/froid/givrage-excessif-evaporateur.md)
- **Points critiques** : dégivrage insuffisant = **givrage** → perte de performance ; évacuation anti-gel indispensable.
- **Sécurité** : électrique (résistances de dégivrage) ; hygiène ;  **Toute manipulation du circuit frigorifique (compresseur, détendeur, charge, récupération, brasage) est **réservée à un frigoriste disposant de l'attestation de capacité F-Gaz**. Ne jamais ouvrir le circuit sans qualification.** `[A]`

## Cadre & suites
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [givrage-excessif-evaporateur](../../../diagnostics/froid/givrage-excessif-evaporateur.md)

## Relations & tags
- **Tags** : `metier:froid equipement:chambre-froide equipement:evaporateur famille:fluides sous-famille:froid-commercial intervention:controler cluster:chambres-froides-negatives cluster:degivrage cluster:evaporateurs cluster:controle complexite:avancee type:controle securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
