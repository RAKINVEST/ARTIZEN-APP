# Sécurité avant intervention

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-avant-intervention` |
| Titre | Sécurité avant intervention |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] Eau coupée et **pression purgée**. `[B]`
- [ ] Électricité **consignée** si équipement électrique. `[A]`
- [ ] EPI adaptés. `[B]`
- [ ] Zone protégée. `[C]`

> Barrière de sécurité commune à toutes les cartes plomberie.

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [consignation-eau](../../procedures/plomberie/consignation-eau.md).
- **Tags** : `metier:plomberie famille:fluides type:checklist cluster:securite controle:consignation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
