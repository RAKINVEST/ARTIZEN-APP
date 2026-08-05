# Phrase — normes & réglementation assainissement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-assainissement` |
| Titre | Phrase — normes & réglementation assainissement |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos installations d'assainissement respectent les règles de l'art : **DTU 64.1** (assainissement non collectif), **DTU 60.11** (évacuation EU/EP), **NF EN 1610** (essais des collecteurs), la réglementation **ANC** (**arrêté du 7 sept. 2009**) et le **contrôle SPANC**. » `[C]` ⟦versions/prescriptions exactes à valider par un expert⟧

> **Sécurité réglementaire** : **espace confiné** (Code du travail, détection/ventilation/surveillant), **vidange** par vidangeur **agréé** (élimination tracée). `[C]` ⟦à confirmer selon chantier⟧

> **Relations inter-Livres** : le réseau enterré est posé avec la **VRD** (tranchées) et le **Terrassement** (fouilles/épandage) ; les évacuations intérieures viennent de la **Plomberie** ; alimentation des postes/microstations → **Électricité** (réservé). `[C]`

## Cadre
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-reseau-humide](../../professions/vrd/cards/poser-reseau-humide.md).
- **Tags** : `metier:assainissement famille:gros-oeuvre type:phrase usage:normes cluster:normes cluster:reglementation relation:vrd relation:terrassement relation:plomberie relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
