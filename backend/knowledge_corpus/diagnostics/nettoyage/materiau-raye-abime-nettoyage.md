# Matériau rayé / abîmé par un nettoyage inadapté

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `materiau-raye-abime-nettoyage` |
| Titre | Matériau rayé / abîmé par un nettoyage inadapté |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Surface **rayée**, **ternie**, brûlée par un produit, sol **décollé/gondolé**, joint attaqué. `[C]`

> Un produit/outil trop **agressif** dégrade définitivement : toujours **tester** sur zone discrète et respecter le support. `[A]`

## Causes probables
1. **Produit inadapté** (acide/abrasif) au support. `[C]` → [comprendre-produits-facades](../../professions/nettoyage/cards/comprendre-produits-facades.md)
2. **Méthode** trop agressive (monobrosse/abrasif). `[C]` → [nettoyer-sols](../../professions/nettoyage/cards/nettoyer-sols.md)
3. Excès d'eau sur sol sensible (parquet/PVC). `[C]` → [entretenir-reprendre-sol](../../professions/revetements-sol/cards/entretenir-reprendre-sol.md)

## Résolution
- Adapter produit/méthode au support (test), stopper l'agression ; remise en état technique = corps d'état concerné (Solier/Peintre). `[C]`

## Cadre
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [nettoyer-sols](../../professions/nettoyage/cards/nettoyer-sols.md).
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage probleme:degradation cluster:protection-materiaux cluster:diagnostic type:diagnostic securite:produits-chimiques relation:revetements-sol`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
