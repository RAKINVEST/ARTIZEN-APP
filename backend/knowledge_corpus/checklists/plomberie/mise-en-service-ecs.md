# Mise en service ECS

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mise-en-service-ecs` |
| Titre | Mise en service ECS |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Consignation levée en sécurité. `[B]`
- [ ] Cuve pleine et **air purgé**. `[C]`
- [ ] **Groupe de sécurité** fonctionnel et évacué. `[B]`
- [ ] Chauffe contrôlée. `[C]`
- [ ] Étanchéité OK. `[C]`

## Cadre
- **Normes** : installation sanitaire — **DTU 65.10** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-chauffe-eau-electrique](../../professions/plomberie/cards/entretenir-chauffe-eau-electrique.md).
- **Tags** : `metier:plomberie famille:fluides sous-famille:ecs type:checklist controle:mise-en-service`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
