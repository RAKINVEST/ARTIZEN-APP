# Contrôle du support & repérage amiante avant pose

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-support-amiante-avant-pose` |
| Titre | Contrôle du support & repérage amiante avant pose |
| Profession | `metier:carrelage` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Vérifier l'aptitude du support et, en rénovation, l'absence d'amiante — sans jamais réaliser de retrait. `[A]`

## Étapes
1. **Support** : planéité, cohésion, humidité, âge/compatibilité ; **plancher chauffant** géré. `[C]` → [preparer-support-ragreage](../../professions/carrelage/cards/preparer-support-ragreage.md)
2. Rénovation (bâti ancien) : **diagnostic amiante avant travaux** — anciennes **colles/ragréages** suspects. `[A]` ⟦cadre exact à confirmer⟧
3. Matériau **suspect** → **ne pas gratter/poncer/déposer** ; **arrêt**. `[A]` `relation:desamiantage`
4. Retrait par une **entreprise certifiée** ; reprendre **après** levée du risque. `[A]`

> Le **désamiantage n'est jamais réalisé en carrelage** — interface/diagnostic uniquement. `[A]`

## Cadre
- **Normes** : pose collée des revêtements céramiques et pierres naturelles **DTU 52.2** ; pose scellée **DTU 52.1** ; électricité (plancher chauffant / zones équipées) **NF C 15-100** ; **CPT** CSTB (grands formats, SEL sous carrelage), classement **UPEC** et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [preparer-support-ragreage](../../professions/carrelage/cards/preparer-support-ragreage.md).
- **Tags** : `metier:carrelage famille:finition sous-famille:securite intervention:controler cluster:preparation-des-supports cluster:reglementation type:procedure securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
