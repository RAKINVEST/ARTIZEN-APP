# Surface tachée / résidus de chantier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `surface-tachee-residus` |
| Titre | Surface tachée / résidus de chantier |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Taches**, **laitance**, résidus de colle/peinture/adhésifs, voile blanc après chantier. `[C]`

## Causes probables
1. **Résidus de pose** (laitance de carrelage, colle) à retirer par la bonne méthode. `[C]` → [organiser-nettoyage-fin-chantier](../../professions/nettoyage/cards/organiser-nettoyage-fin-chantier.md)
2. **Produit inadapté au support** (voile, trace). `[C]` → [comprendre-produits-facades](../../professions/nettoyage/cards/comprendre-produits-facades.md)
3. Laitance de carrelage → relance du **Carreleur** si tenace. `[C]` → [principe-carrelage](../../professions/carrelage/cards/principe-carrelage.md)

## Résolution
- Identifier la nature du résidu et du support, choisir la méthode **adaptée** (test préalable), **sans mélange** de produits. `[C]`

## Cadre
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [comprendre-produits-facades](../../professions/nettoyage/cards/comprendre-produits-facades.md).
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage probleme:residus cluster:fin-de-chantier cluster:diagnostic type:diagnostic securite:produits-chimiques relation:carrelage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
