# Diagnostic amiante avant dépose d'un ancien sol

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostic-amiante-depose-ancien-sol` |
| Titre | Diagnostic amiante avant dépose d'un ancien sol |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Vérifier, **avant toute dépose** d'un ancien sol, l'absence d'amiante — sans jamais réaliser de retrait. `[A]`

## Étapes
1. Bâti **ancien** : exiger/consulter le **diagnostic amiante avant travaux** (opérateur certifié). `[A]` ⟦cadre exact à confirmer⟧
2. Matériaux **suspects** : anciennes **dalles vinyle-amiante**, **colles bitumineuses** noires → **ne pas déposer/poncer/gratter**. `[A]`
3. En présence d'amiante : **arrêt** ; retrait par une **entreprise certifiée**. `[A]` `relation:desamiantage`
4. Reprendre la pose **après** levée du risque (ou recouvrement encadré). `[C]` → [preparer-support-sol](../../professions/revetements-sol/cards/preparer-support-sol.md)

> Le **retrait d'amiante n'est jamais réalisé en pose de sol** — interface/diagnostic uniquement. `[A]`

## Cadre
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [preparer-support-sol](../../professions/revetements-sol/cards/preparer-support-sol.md).
- **Tags** : `metier:revetements-sol famille:finition sous-famille:securite intervention:controler cluster:preparation-des-supports cluster:reglementation type:procedure securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
