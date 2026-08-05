# Inspection / contrôle de charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `inspection-controle-charpente` |
| Titre | Inspection / contrôle de charpente |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Déformations (flèche, déversement, faîtage). `[C]`
- [ ] Humidité / traces d'infiltration. `[C]`
- [ ] **Attaque du bois** (insectes / champignon). `[C]`
- [ ] État des **assemblages**, appuis, sablières. `[C]`
- [ ] État liteaux/voliges (support couverture). `[C]`
- [ ] Absence de surcharge / modification non étudiée. `[C]`

> Tout doute **structurel** → étude ; danger → **étaiement/évacuation**. `[A]`

## Cadre
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [inspecter-charpente](../../professions/charpente/cards/inspecter-charpente.md).
- **Tags** : `metier:charpente famille:enveloppe sous-famille:charpente type:checklist cluster:inspection cluster:controle cluster:maintenance securite:structure securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
