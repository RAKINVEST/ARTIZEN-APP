# Sécurité avant intervention électrique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-avant-intervention-electrique` |
| Titre | Sécurité avant intervention électrique |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Habilitation électrique** de l'intervenant adaptée à l'opération (NF C 18-510). `[A]`
- [ ] Installation **consignée** (séparer / condamner / identifier). `[A]`
- [ ] **VAT** réalisée au point de travail. `[A]`
- [ ] EPI adaptés (gants isolants si requis), outillage isolé. `[B]`
- [ ] Zone balisée ; tiers écartés. `[C]`

> **Aucune opération sous tension ni au tableau sans habilitation.** `[A]`

## Cadre
- **Normes** : opérations sur ouvrages électriques **NF C 18-510** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [consignation-electrique](../../procedures/electricite-generale/consignation-electrique.md).
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:securite type:checklist cluster:securite cluster:consignation securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
