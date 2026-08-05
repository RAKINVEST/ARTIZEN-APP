# Infiltration air / eau sur menuiserie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `infiltration-air-eau-menuiserie` |
| Titre | Infiltration air / eau sur menuiserie |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Courant d'air, **infiltration d'eau** à l'appui ou en périphérie, sifflement au vent. `[C]`

## Causes probables
1. **Calfeutrement AEV** défaillant (joint/mastic HS). `[C]` → [calfeutrer-etancheite-menuiserie](../../professions/menuiserie-exterieure/cards/calfeutrer-etancheite-menuiserie.md)
2. **Drainage bouché** (trous de buée obstrués) → rétention. `[C]`
3. **Joint de frappe** écrasé/durci ou ouvrant mal réglé. `[C]` → [regler-ouvrant-quincaillerie](../../professions/menuiserie-exterieure/cards/regler-ouvrant-quincaillerie.md)

## Résolution
- Rétablir l'AEV (calfeutrement/joints), dégager le drainage, régler l'ouvrant. `[C]`

## Cadre
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [calfeutrer-etancheite-menuiserie](../../professions/menuiserie-exterieure/cards/calfeutrer-etancheite-menuiserie.md).
- **Tags** : `metier:menuiserie-exterieure famille:enveloppe sous-famille:menuiserie-exterieure probleme:infiltration cluster:joints cluster:diagnostic type:diagnostic securite:manutention relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
