# Consignation et sécurité avant intervention (personnel habilité)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `consignation-securite-avant-intervention-ascenseur` |
| Titre | Consignation et sécurité avant intervention (personnel habilité) |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Rappeler le cadre de sécurité avant toute intervention d'ascenseur — **opérations réservées aux habilités**, non décrites pas à pas. `[A]`

## Cadre (rappel de principe)
1. **Habilitation** : seul un ascensoriste **formé/habilité** intervient en gaine, machinerie, sur les sécurités. `[A]`
2. **Consignation** électrique **et** mécanique : couper/condamner l'alimentation, immobiliser la cabine, protéger contre le mouvement du contrepoids. `[A]`
3. **Raccordement électrique** = **interface** Électricité (jamais réalisé ici). `[A]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)
4. **Personnes bloquées** : dégagement par procédure stricte / personnel formé. `[A]`
5. **Modernisation** d'appareils anciens → **diagnostic amiante** ; suspect → **arrêt**, retrait = **certifié**. `[A]` `relation:desamiantage`

> Aucun **pas à pas** d'opération réservée n'est fourni : ce contenu cadre, il n'exécute pas. `[A]`

## Cadre
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [comprendre-dispositifs-securite](../../professions/ascenseur/cards/comprendre-dispositifs-securite.md).
- **Tags** : `metier:ascenseur famille:specialises sous-famille:securite intervention:securiser cluster:machinerie cluster:reglementation type:procedure securite:ecrasement securite:amiante relation:desamiantage relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
