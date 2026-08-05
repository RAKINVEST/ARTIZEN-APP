# Kit de nettoyage bâtiment (matériel, pas dosages)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-nettoyage-batiment` |
| Titre | Kit de nettoyage bâtiment (matériel, pas dosages) |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (**matériel** — aucun dosage ni mélange de produits)
- **Aspirateur** (filtration HEPA pour poussières fines), microfibres, balais/raclettes, seaux bicompartiment. `[C]`
- **Autolaveuse / monobrosse** (sols), perche et raclette à vitres, chariot de ménage. `[C]`
- **Protections** (films/cartons/adhésifs non agressifs), balisage « sol glissant », sacs/contenants de tri des **déchets**. `[C]`
- **EPI** : gants adaptés, lunettes, masque (poussières), chaussures ; **FDS** des produits à disposition. `[A]`

> **Aucun produit n'est dosé ni mélangé ici** : suivre strictement les **FDS/étiquettes** ; ne jamais mélanger. `[A]`

## Cadre
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [depoussierer-nettoyer-courant](../../professions/nettoyage/cards/depoussierer-nettoyer-courant.md).
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage type:kit cluster:depoussierage cluster:nettoyage-sols equipement:aspirateur-hepa`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
