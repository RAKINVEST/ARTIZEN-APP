# Contrôle de conformité (points clés)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-conformite-installation` |
| Titre | Contrôle de conformité (points clés) |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:conformite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier ⟦exigences exactes NF C 15-100 à confirmer par le validateur⟧
- [ ] Présence d'une **prise de terre** et liaisons équipotentielles. `[B]`
- [ ] **Différentiels 30 mA** en protection des personnes. `[B]`
- [ ] Protection de chaque circuit par disjoncteur adapté. `[B]`
- [ ] Circuits spécialisés (plaque, four, lave-linge…) dédiés. `[C]`
- [ ] Volumes de la **salle d'eau** respectés. `[B]`
- [ ] Repérage et GTL/tableau accessibles. `[C]`

> Contrôle indicatif ; un **diagnostic/consuel** relève d'un organisme/pro habilité.

## Cadre
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md).
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:conformite type:checklist cluster:conformite cluster:controle cluster:normes cluster:mise-a-la-terre securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
