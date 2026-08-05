# Contrôle / maintenance de façade

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-facade` |
| Titre | Contrôle / maintenance de façade |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Absence de **fissures** évolutives. `[C]`
- [ ] Absence d'**infiltration**/humidité/salpêtre. `[C]`
- [ ] Revêtement adhérent (pas de creux/cloque). `[C]`
- [ ] Joints/points singuliers étanches. `[C]`
- [ ] Propreté (mousses/salissures) à traiter. `[C]`
- [ ] Bardage : ossature/lame d'air/fixations. `[C]`

> Accès en hauteur : **protections collectives + EPI** ; météo favorable.

## Cadre
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [diagnostiquer-facade](../../professions/facade/cards/diagnostiquer-facade.md).
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade type:checklist cluster:maintenance cluster:controle cluster:entretien securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
