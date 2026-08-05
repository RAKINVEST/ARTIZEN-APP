# Sécurité — gaine, consignation & habilitation (ascenseur)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-gaine-consignation-ascenseur` |
| Titre | Sécurité — gaine, consignation & habilitation (ascenseur) |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Habilitation** : intervenant formé/habilité (opérations réservées). `[A]`
- [ ] **Consignation** électrique **et** mécanique avant accès (cabine immobilisée). `[A]`
- [ ] **Gaine** : risque de **chute** (cuvette/vide) et d'**écrasement** (contrepoids). `[A]`
- [ ] **Câbles/poulies** : **happement** ; EPI adaptés. `[A]`
- [ ] **Électrique** : alimentation/armoire = **interface** Électricité. `[A]`
- [ ] **Amiante** (modernisation appareils anciens) : diagnostic ; retrait = **certifié** (jamais ici). `[A]`

## Cadre
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [consignation-securite-avant-intervention-ascenseur](../../procedures/ascenseur/consignation-securite-avant-intervention-ascenseur.md).
- **Tags** : `metier:ascenseur famille:specialises sous-famille:securite type:checklist cluster:machinerie securite:ecrasement securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
