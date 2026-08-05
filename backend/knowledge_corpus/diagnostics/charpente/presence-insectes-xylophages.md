# Présence d'insectes xylophages

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `presence-insectes-xylophages` |
| Titre | Présence d'insectes xylophages |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:traitement-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Trous**, **vermoulure** (sciure), bruit de grignotement, galeries. `[C]`

## Causes probables
1. **Capricorne / vrillette** (larves xylophages). `[C]` ⟦espèce à confirmer⟧
2. **Termites** (cadre réglementaire spécifique, déclaration). `[D]` ⟦selon zone à confirmer⟧

## Résolution
- Évaluer l'étendue et l'atteinte structurelle, **traiter** ; renforcer si porteur atteint. `[C]` → [traiter-charpente-bois](../../professions/charpente/cards/traiter-charpente-bois.md)

## Cadre
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [diagnostiquer-attaque-bois](../../professions/charpente/cards/diagnostiquer-attaque-bois.md).
- **Tags** : `metier:charpente famille:enveloppe sous-famille:traitement-bois probleme:insectes cluster:traitement-du-bois cluster:diagnostic type:diagnostic securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
