# Absence d'eau chaude

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `absence-eau-chaude` |
| Titre | Absence d'eau chaude |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Plus d'eau chaude au(x) point(s) de puisage. `[C]`

## Causes probables
1. Entretien nécessaire (tartre / anode). `[C]`
2. Thermostat / résistance. `[D]` ⟦à vérifier⟧
3. Alimentation électrique. `[D]` ⟦partie électrique : selon cas, relève de l'électricien⟧

## Résolution
- Entretien du chauffe-eau électrique. → [entretenir-chauffe-eau-electrique](../../professions/plomberie/cards/entretenir-chauffe-eau-electrique.md)

## Cadre
- **Normes** : installation sanitaire — **DTU 65.10** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-chauffe-eau-electrique](../../professions/plomberie/cards/entretenir-chauffe-eau-electrique.md).
- **Tags** : `metier:plomberie famille:fluides sous-famille:ecs probleme:absence-eau-chaude equipement:chauffe-eau type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
