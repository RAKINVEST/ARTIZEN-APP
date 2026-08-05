# Contrôle de réception d'une menuiserie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-reception-menuiserie` |
| Titre | Contrôle de réception d'une menuiserie |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier la conformité d'une menuiserie posée (points d'arrêt). `[C]`

## Étapes
1. **Aplomb / niveau / équerrage** du dormant. `[C]`
2. **Étanchéité AEV** : calfeutrement extérieur + étanchéité à l'air intérieure. `[C]` → [calfeutrer-etancheite-menuiserie](../../professions/menuiserie-exterieure/cards/calfeutrer-etancheite-menuiserie.md)
3. **Drainage** dégagé (trous d'évacuation). `[C]`
4. **Fonctionnement** ouvrant/quincaillerie/volet ; joints de frappe. `[C]` → [regler-ouvrant-quincaillerie](../../professions/menuiserie-exterieure/cards/regler-ouvrant-quincaillerie.md)

## Cadre
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-fenetre-porte](../../professions/menuiserie-exterieure/cards/poser-fenetre-porte.md).
- **Tags** : `metier:menuiserie-exterieure famille:enveloppe sous-famille:menuiserie-exterieure intervention:controler cluster:controle cluster:reglages cluster:joints type:procedure securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
