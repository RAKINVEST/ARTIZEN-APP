# Contrôle de réception d'un bardage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-reception-bardage` |
| Titre | Contrôle de réception d'un bardage |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier la conformité d'un bardage au fil de la pose (points d'arrêt). `[C]`

## Étapes
1. **Ossature** : aplomb, planéité, entraxes conformes. `[C]` → [poser-ossature-lame-air](../../professions/bardage/cards/poser-ossature-lame-air.md)
2. **Lame d'air ventilée** : continuité, grilles entrée/sortie. `[C]`
3. **Fixations** : type (inox), densité/implantation (vent) selon DTU/AT. `[C]` ⟦à confirmer⟧
4. **Points singuliers** (angles, baies, couronnement, soubassement) + calepinage. `[C]` → [traiter-points-singuliers-bardage](../../professions/bardage/cards/traiter-points-singuliers-bardage.md)

## Cadre
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-controler-bardage](../../professions/bardage/cards/entretenir-controler-bardage.md).
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage intervention:controler cluster:controle cluster:ossature cluster:points-singuliers type:procedure securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
