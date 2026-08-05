# Contrôle / maintenance de bardage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-bardage` |
| Titre | Contrôle / maintenance de bardage |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Éléments sains (pas de gauchissement/pourriture/corrosion). `[C]`
- [ ] **Fixations** en place (inox), rien qui bouge/claque. `[C]`
- [ ] **Ventilation** de lame d'air : grilles bas/haut dégagées. `[C]`
- [ ] **Points singuliers** étanches (angles, baies, couronnement). `[C]`
- [ ] **Soubassement** : garde au sol, pas de remontée d'humidité. `[C]`
- [ ] Entretien adapté au matériau réalisé. `[C]`

> Accès **échafaudage** + EPI ; découpe = poussières/**silice** (fibres-ciment) ; météo.

## Cadre
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-controler-bardage](../../professions/bardage/cards/entretenir-controler-bardage.md).
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage type:checklist cluster:controle cluster:maintenance cluster:entretien securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
