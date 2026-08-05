# Fissure d'un mur maçonné

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fissure-mur-maconnerie` |
| Titre | Fissure d'un mur maçonné |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Fissure** dans un mur : fine, en escalier (joints), ou traversante. `[C]`

> Une fissure **large / en escalier / évolutive** peut être **structurelle** → pose de témoins + **étude** (ne pas masquer). `[B]`

## Causes probables
1. Retrait / vieillissement (fine, stable). `[C]`
2. **Tassement** de fondation / mouvement de sol. `[C]` ⟦à confirmer par étude⟧
3. Surcharge / linteau-chaînage défaillant. `[C]` → [affaissement-desordre-porteur](affaissement-desordre-porteur.md)

## Résolution
- Qualifier (témoins), traiter la cause si structurel (étude), puis reprendre. `[C]` → [jointoyer-reprendre-maconnerie](../../professions/maconnerie/cards/jointoyer-reprendre-maconnerie.md)

## Cadre
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [jointoyer-reprendre-maconnerie](../../professions/maconnerie/cards/jointoyer-reprendre-maconnerie.md).
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie probleme:fissure cluster:diagnostic cluster:reparations type:diagnostic securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
