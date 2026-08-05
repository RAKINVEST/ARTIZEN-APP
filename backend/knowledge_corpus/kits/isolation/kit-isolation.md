# Kit isolation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-isolation` |
| Titre | Kit isolation |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **EPI respiratoire** (masque FFP adapté), combinaison, gants, lunettes. `[A]`
- Cardeuse/souffleuse (vrac), couteau isolant, agrafeuse. `[C]`
- **Pare/frein-vapeur** + adhésifs/mastics de continuité. `[C]`
- Testeur d'humidité ; éventuelle caméra thermique (diagnostic). `[C]`

## Cadre
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [isoler-combles](../../professions/isolation/cards/isoler-combles.md).
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation type:kit cluster:isolation-des-combles cluster:pare-vapeur equipement:souffleuse`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
