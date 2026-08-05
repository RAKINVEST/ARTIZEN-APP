# Kit inspection charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-inspection-charpente` |
| Titre | Kit inspection charpente |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Humidimètre** (bois) ; lampe ; pointe/poinçon de sondage. `[C]`
- Appareil photo, mètre, niveau/fil à plomb (déformations). `[C]`
- **EPI antichute** + accès sécurisé. `[A]`
- (Traitement) EPI produits biocides. `[B]`

## Cadre
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [inspecter-charpente](../../professions/charpente/cards/inspecter-charpente.md).
- **Tags** : `metier:charpente famille:enveloppe sous-famille:charpente type:kit cluster:inspection cluster:controle equipement:humidimetre`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
