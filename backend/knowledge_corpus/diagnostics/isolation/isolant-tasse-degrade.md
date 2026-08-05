# Isolant tassé / dégradé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `isolant-tasse-degrade` |
| Titre | Isolant tassé / dégradé |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Isolant de comble **tassé**, aplati, déplacé, ou dégradé (rongeurs, eau). `[C]`

## Causes probables
1. Vieillissement / **tassement** naturel (perte de R). `[C]`
2. **Humidité** (fuite de toiture) ayant dégradé l'isolant. `[C]` → [principe-couverture](../../professions/couverture/cards/principe-couverture.md)
3. Circulation/passage ayant écrasé l'isolant. `[C]`

## Résolution
- Traiter la cause (eau), **compléter/remplacer** l'isolant, rétablir la continuité. `[C]` → [isoler-combles](../../professions/isolation/cards/isoler-combles.md)

## Cadre
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [isoler-combles](../../professions/isolation/cards/isoler-combles.md).
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation probleme:tassement probleme:degradation cluster:diagnostic cluster:isolation-des-combles cluster:reparation type:diagnostic securite:respiratoire relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
