# Sol glissant / encrassé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `sol-glissant-encrasse` |
| Titre | Sol glissant / encrassé |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Sol **glissant** (film gras/produit mal rincé), **encrassé**, collant, aspect terne. `[C]`

> Sol glissant = **risque de chute** → baliser pendant le nettoyage humide, laisser sécher. `[A]`

## Causes probables
1. **Produit mal dosé/rincé** (film résiduel). `[C]` → [depoussierer-nettoyer-courant](../../professions/nettoyage/cards/depoussierer-nettoyer-courant.md)
2. **Méthode inadaptée** (encrassement progressif). `[C]` → [nettoyer-sols](../../professions/nettoyage/cards/nettoyer-sols.md)
3. Revêtement demandant un entretien spécifique (Solier). `[C]`

## Résolution
- Rincer/neutraliser le film, adapter la méthode et le produit au revêtement, baliser ; sans mélange de produits. `[C]`

## Cadre
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [nettoyer-sols](../../professions/nettoyage/cards/nettoyer-sols.md).
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage probleme:glissance cluster:nettoyage-sols cluster:diagnostic type:diagnostic securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
