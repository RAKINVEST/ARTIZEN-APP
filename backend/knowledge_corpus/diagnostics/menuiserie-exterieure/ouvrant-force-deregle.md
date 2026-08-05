# Ouvrant qui force / déréglé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `ouvrant-force-deregle` |
| Titre | Ouvrant qui force / déréglé |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Ouvrant qui **frotte**, ferme mal, ne verrouille plus, ou **affaissé**. `[C]`

## Causes probables
1. **Quincaillerie déréglée** / paumelles à reprendre. `[C]` → [regler-ouvrant-quincaillerie](../../professions/menuiserie-exterieure/cards/regler-ouvrant-quincaillerie.md)
2. Affaissement de l'ouvrant (poids du vitrage, calage). `[C]`
3. Dilatation (matériau) / gonflement (bois humide). `[C]`

## Résolution
- **Régler** gonds/quincaillerie, reprendre le calage du vitrage si affaissement ; ne pas forcer. `[C]`

## Cadre
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [regler-ouvrant-quincaillerie](../../professions/menuiserie-exterieure/cards/regler-ouvrant-quincaillerie.md).
- **Tags** : `metier:menuiserie-exterieure equipement:quincaillerie famille:enveloppe sous-famille:menuiserie-exterieure probleme:dereglage cluster:reglages cluster:quincaillerie cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
