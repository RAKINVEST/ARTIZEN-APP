# Kit de mesure électricien

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-electricien` |
| Titre | Kit de mesure électricien |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:mesures` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **VAT** (vérificateur d'absence de tension) + dispositif de condamnation. `[A]`
- Multimètre / contrôleur de continuité ; mesureur de terre. `[B]`
- Tournevis isolés, pince à dénuder, EPI (gants isolants). `[B]`
- Testeur de prise, repères de circuits. `[C]`

## Cadre
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [mesurer-continuite-circuit](../../professions/electricite-generale/cards/mesurer-continuite-circuit.md).
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:mesures type:kit cluster:mesures cluster:securite equipement:multimetre`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
