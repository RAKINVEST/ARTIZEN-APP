# Contrôle des débits de ventilation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-debits-ventilation` |
| Titre | Contrôle des débits de ventilation |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier que les débits d'air respectent les valeurs réglementaires. `[C]`

## Étapes
1. Mesurer les débits à chaque **bouche** (anémomètre/débitmètre). `[C]`
2. Comparer aux **valeurs réglementaires** (arrêté 24 mars 1982). `[B]` ⟦valeurs à confirmer⟧
3. Équilibrer si nécessaire. `[C]`
4. Consigner les relevés. `[C]`

## Cadre
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [equilibrer-debits-ventilation](../../professions/ventilation/cards/equilibrer-debits-ventilation.md).
- **Tags** : `metier:ventilation famille:fluides sous-famille:ventilation intervention:controler cluster:controle cluster:equilibrage cluster:mise-en-service type:procedure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
