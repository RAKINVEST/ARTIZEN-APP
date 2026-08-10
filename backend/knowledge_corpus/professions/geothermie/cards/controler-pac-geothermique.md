# Contrôler une PAC géothermique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-pac-geothermique` |
| Titre | Contrôler une PAC géothermique |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac-geothermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler les paramètres d'une PAC géothermique (capteurs, circuit de captage, hydraulique). `[C]`
- **Résumé** : vérifier la pression/débit du **circuit de captage** (glycol) et du circuit émission, les températures source/émission et l'absence de fuite. `[C]` ⟦valeurs selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler la pression et le **taux de glycol** du circuit de captage. `[C]` ⟦à confirmer⟧
  2. Vérifier les débits capteur et émission. `[C]`
  3. Relever les températures source/émission (cohérence). `[C]`
  4. Contrôler l'étanchéité et les sécurités. `[C]` → [pac-en-defaut](../../../diagnostics/chauffage/pac-en-defaut.md)
- **Points critiques** : le captage (forage/horizontal) relève d'un domaine spécifique ; ne pas altérer le glycol. `[C]`
- **Sécurité** : hydraulique + fluide frigorigène. **Le circuit frigorifère est sous pression et contient un fluide réglementé : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage adapté — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Principe** : `cite-carte` → [principe-fonctionnement-pac](../../chauffage/cards/principe-fonctionnement-pac.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:pac famille:fluides sous-famille:pac-geothermique intervention:controler cluster:geothermique cluster:controle complexite:avancee type:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
