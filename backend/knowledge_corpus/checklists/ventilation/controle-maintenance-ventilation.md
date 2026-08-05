# Contrôle / maintenance ventilation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-ventilation` |
| Titre | Contrôle / maintenance ventilation |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Bouches d'extraction propres, débit correct. `[C]`
- [ ] Entrées d'air dégagées. `[C]`
- [ ] Filtres (double flux) propres/remplacés. `[C]`
- [ ] Caisson : roue propre, fixations antivibratiles OK. `[C]`
- [ ] Réseau étanche, isolé en volume non chauffé. `[C]`
- [ ] **Débits réglementaires** respectés. `[B]`

> Raccordement électrique : **habilité** ; travail en hauteur sécurisé.

## Cadre
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-vmc-simple-flux](../../professions/ventilation/cards/entretenir-vmc-simple-flux.md).
- **Tags** : `metier:ventilation famille:fluides sous-famille:ventilation type:checklist cluster:maintenance cluster:entretien cluster:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
