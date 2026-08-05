# Remplir une installation de chauffage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplir-installation-chauffage` |
| Titre | Remplir une installation de chauffage |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:reseau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Remplir un circuit de chauffage à la bonne pression, sans air. `[C]`

## Étapes
1. Vérifier le vase d'expansion et la soupape. `[B]`
2. Ouvrir le robinet de remplissage **progressivement** jusqu'à la pression à froid (~1–1,5 bar). `[B]` ⟦valeur selon installation⟧
3. **Purger** l'ensemble des émetteurs, du plus proche au plus éloigné. `[C]` → [purger-radiateur](../../professions/chauffage/cards/purger-radiateur.md)
4. Réajuster la pression après purge ; **fermer** le robinet de remplissage. `[B]`

## Cadre
- **Normes** : sécurité chauffage central **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [mise-en-service-chauffage](mise-en-service-chauffage.md).
- **Tags** : `metier:chauffage famille:fluides sous-famille:reseau intervention:remplir type:procedure equipement:circuit`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
