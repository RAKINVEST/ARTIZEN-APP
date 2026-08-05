# Contrôle de couverture après tempête

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-couverture-apres-tempete` |
| Titre | Contrôle de couverture après tempête |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier l'état de la couverture après un événement climatique. `[C]`

## Étapes
1. **Sécuriser** : évaluer les dangers (éléments instables) avant de monter. `[A]`
2. Depuis les combles/sol : repérer éléments manquants/déplacés, jour. `[C]`
3. Contrôler faîtage, rives, noues, émergences. `[C]` → [controle-maintenance-couverture](../../checklists/couverture/controle-maintenance-couverture.md)
4. Remplacer/refixer les éléments ; **protéger provisoirement** si besoin (bâche). `[C]`

## Cadre
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [remplacer-tuiles-ardoises](../../professions/couverture/cards/remplacer-tuiles-ardoises.md).
- **Tags** : `metier:couverture famille:enveloppe sous-famille:couverture intervention:controler cluster:controle cluster:diagnostic cluster:maintenance type:procedure securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
