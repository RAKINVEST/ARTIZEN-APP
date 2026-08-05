# Contrôler / remplacer le joint de porte d'une chambre froide

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-joint-porte-chambre-froide` |
| Titre | Contrôler / remplacer le joint de porte d'une chambre froide |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'étanchéité d'une porte de chambre froide (joint, fermeture) pour éviter pertes et givrage. `[C]`
- **Résumé** : contrôler l'état du joint et la fermeture, nettoyer, remplacer le joint si abimé, vérifier charnières et système de fermeture. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler l'état du **joint** (souplesse, coupures) et la fermeture. `[C]`
  2. Nettoyer joint et feuillure (hygiène). `[C]`
  3. Remplacer le joint si abimé (modèle compatible). `[C]` ⟦référence selon porte⟧
  4. Vérifier charnières, crémaillère et **sécurité d'ouverture intérieure**. `[B]`
- **Points critiques** : joint HS = pertes/givrage/condensation ; **sécurité d'ouverture de l'intérieur** obligatoire.
- **Sécurité** : sécurité d'ouverture intérieure (personne enfermée) ; hygiène ;  **Toute manipulation du circuit frigorifique (compresseur, détendeur, charge, récupération, brasage) est **réservée à un frigoriste disposant de l'attestation de capacité F-Gaz**. Ne jamais ouvrir le circuit sans qualification.** `[A]`

## Cadre & suites
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-froid-commercial](../../../checklists/froid/controle-maintenance-froid-commercial.md)

## Relations & tags
- **Tags** : `metier:froid equipement:chambre-froide equipement:porte famille:fluides sous-famille:froid-commercial intervention:controler intervention:remplacer cluster:chambres-froides-positives cluster:entretien probleme:etancheite complexite:simple type:entretien securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
