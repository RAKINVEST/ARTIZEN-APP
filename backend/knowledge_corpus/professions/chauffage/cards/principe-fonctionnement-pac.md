# Principe de fonctionnement d'une PAC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-fonctionnement-pac` |
| Titre | Principe de fonctionnement d'une PAC |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le cycle thermodynamique d'une pompe à chaleur pour décrire les 3 grands types (air/air, air/eau, géothermique). `[C]`
- **Résumé** : une PAC prélève de la chaleur à une source (air, eau, sol), l'élève en température via un cycle frigorifique (compression/détente) et la restitue à l'émission. Le COP mesure l'efficacité. `[C]` ⟦valeurs/rendements selon matériel à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Source** : air extérieur (air/air, air/eau) ou sol/eau (géothermique). `[C]`
  2. **Cycle frigorifère** : évaporation → compression → condensation → détente. `[C]`
  3. **Émission** : air soufflé (air/air) ou circuit hydraulique (air/eau, géo). `[C]`
  4. Pour l'air/eau, l'émission alimente un circuit de chauffage. → [mettre-en-service-pac-air-eau](../../chauffage/cards/mettre-en-service-pac-air-eau.md)
- **Points critiques** : ne pas confondre les types ; le dimensionnement conditionne le rendement (COP). `[C]`
- **Sécurité** : sous pression + fluide frigorigène. **Le circuit frigorifère est sous pression et contient un fluide réglementé : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage adapté — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Types liés** : `cite-carte` → [controler-pac-geothermique](../../geothermie/cards/controler-pac-geothermique.md) ; `cite-carte` → [controler-circuit-frigorifique-clim](../../climatisation/cards/controler-circuit-frigorifique-clim.md)

## Relations & tags
- **Tags** : `metier:chauffage equipement:pac famille:fluides sous-famille:pac intervention:comprendre type:principe cluster:principe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
