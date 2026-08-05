# Climatiseur qui ne refroidit pas (ou peu)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `clim-ne-refroidit-pas` |
| Titre | Climatiseur qui ne refroidit pas (ou peu) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le climatiseur tourne mais **refroidit mal**. `[C]`

## Causes probables
1. **Filtres** encrassés / débit d'air réduit. `[C]` → [remplacer-filtre-climatiseur](../../professions/climatisation/cards/remplacer-filtre-climatiseur.md)
2. Unité extérieure encrassée / mal implantée. `[C]` → [controler-unite-exterieure-clim](../../professions/climatisation/cards/controler-unite-exterieure-clim.md)
3. Charge/défaut **frigorifère** → **frigoriste F-Gaz**. `[D]`
4. Paramétrage/consigne inadapté. `[C]`

## Résolution
- Nettoyer filtres et unité ext. ; frigorifère → qualifié. `[C]`

## Cadre
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-climatiseur](../../professions/climatisation/cards/entretenir-climatiseur.md).
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation probleme:refroidissement-insuffisant cluster:diagnostic cluster:pannes type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
