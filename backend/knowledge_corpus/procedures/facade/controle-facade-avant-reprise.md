# Contrôle d'une façade avant réfection

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-facade-avant-reprise` |
| Titre | Contrôle d'une façade avant réfection |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier l'état et l'adhérence du support avant toute reprise. `[C]`

## Étapes
1. **Sonder** le revêtement (recherche du creux/non adhérent). `[C]`
2. Repérer fissures, infiltrations, salpêtre. `[C]` → [diagnostiquer-facade](../../professions/facade/cards/diagnostiquer-facade.md)
3. **Purger** les parties instables (protection de la zone). `[C]`
4. Vérifier la **compatibilité** du système de reprise avec le support. `[C]` ⟦à confirmer⟧

## Cadre
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [reprendre-enduit-facade](../../professions/facade/cards/reprendre-enduit-facade.md).
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade intervention:controler cluster:controle cluster:supports-maconnes cluster:diagnostic type:procedure securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
