# Contrôle de réception d'un ETICS

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-reception-ite` |
| Titre | Contrôle de réception d'un ETICS |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier la conformité d'un système ITE au fil de la pose (points d'arrêt). `[C]`

## Étapes
1. **Support** : propreté, planéité, cohésion (support maçonné). `[C]`
2. **Fixation** : encollage + **densité/implantation de chevilles** conformes ATec. `[C]` → [fixer-isolant-ite](../../professions/isolation-exterieure/cards/fixer-isolant-ite.md)
3. **Sous-enduit armé** : treillis noyé, recouvrements, renforts d'angle. `[C]` → [realiser-sous-enduit-arme](../../professions/isolation-exterieure/cards/realiser-sous-enduit-arme.md)
4. **Points singuliers** (tableaux, soubassement, débord) et finition. `[C]` ⟦critères ATec à confirmer⟧

## Cadre
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [diagnostiquer-controler-ite](../../professions/isolation-exterieure/cards/diagnostiquer-controler-ite.md).
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure intervention:controler cluster:controle cluster:etics cluster:points-singuliers type:procedure securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
