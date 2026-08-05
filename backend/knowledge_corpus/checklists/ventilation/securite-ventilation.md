# Sécurité & réglementation ventilation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-ventilation` |
| Titre | Sécurité & réglementation ventilation |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Raccordement électrique** du caisson : intervenant **habilité** (NF C 15-100). `[A]`
- [ ] **Travail en hauteur** (combles/toiture) sécurisé. `[B]`
- [ ] **Ne jamais raccorder une VMC sur un conduit de fumée.** `[A]`
- [ ] Débits réglementaires (arrêté 24 mars 1982). `[B]` ⟦à confirmer⟧
- [ ] Hygiène : filtres et réseaux (qualité de l'air). `[B]`
- [ ] Rejet d'air correct (implantation). `[C]`

## Cadre
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-ventilation](../../professions/ventilation/cards/principe-ventilation.md).
- **Tags** : `metier:ventilation famille:fluides sous-famille:securite type:checklist cluster:securite cluster:reglementation cluster:normes securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
