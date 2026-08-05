# Diagnostic amiante avant rénovation (interface)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostic-amiante-avant-renovation` |
| Titre | Diagnostic amiante avant rénovation (interface) |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- S'assurer, **avant toute dépose** en rénovation, de l'absence d'amiante — sans jamais réaliser de retrait. `[A]`

## Étapes
1. Bâti **ancien** : exiger/consulter le **diagnostic amiante avant travaux** (opérateur certifié). `[A]` ⟦cadre exact à confirmer⟧
2. Matériaux **suspects** (anciens plâtres, colles, flocages, dalles) → **ne pas découper/poncer**. `[A]`
3. En présence d'amiante : **arrêt** ; retrait par une **entreprise certifiée** (Désamiantage). `[A]` `relation:desamiantage`
4. Reprendre la plâtrerie **seulement** après levée du risque. `[C]`

> Le **désamiantage n'est jamais réalisé en plâtrerie** — interface/diagnostic uniquement. `[A]`

## Cadre
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [diagnostiquer-controler-platrerie](../../professions/platrerie/cards/diagnostiquer-controler-platrerie.md).
- **Tags** : `metier:platrerie famille:finition sous-famille:securite intervention:controler cluster:diagnostics cluster:reglementation type:procedure securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
