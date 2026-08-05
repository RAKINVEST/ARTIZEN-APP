# Contrôle / maintenance assainissement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-assainissement` |
| Titre | Contrôle / maintenance assainissement |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Écoulement** libre (pas de refoulement/lenteur). `[C]`
- [ ] **Ventilation** primaire/secondaire fonctionnelle (odeurs). `[C]`
- [ ] **Regards** accessibles, tampons à niveau. `[C]`
- [ ] **ANC** : fosse (niveau de boues), épandage, microstation entretenus. `[C]`
- [ ] **Poste de relevage** : pompes/flotteurs/alarme testés. `[C]`
- [ ] **Vidange** planifiée (vidangeur agréé). `[C]`

> **Espace confiné** : contrôle **depuis la surface** ; jamais de descente sans procédure (H₂S).

## Cadre
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [diagnostiquer-controler-assainissement](../../professions/assainissement/cards/diagnostiquer-controler-assainissement.md).
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement type:checklist cluster:controle cluster:assainissement-non-collectif securite:confine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
