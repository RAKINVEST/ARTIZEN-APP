# Repérage réseaux & amiante avant pose/perçage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reperage-reseaux-amiante-avant-pose` |
| Titre | Repérage réseaux & amiante avant pose/perçage |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser les perçages/fixations (réseaux) et, en rénovation, l'amiante — sans jamais réaliser de retrait. `[A]`

## Étapes
1. **Repérer les réseaux** (élec/gaines/eau) avant de percer/visser dans une cloison. `[A]` → [remplacer-prise-courant](../../professions/electricite-generale/cards/remplacer-prise-courant.md)
2. **Consigner** si intervention à proximité des courants forts (habilité). `[A]`
3. Ouvrages **anciens** : **diagnostic amiante avant travaux** (panneaux, colles). `[A]` `relation:desamiantage`
4. Matériau **suspect** → **ne pas déposer/poncer** ; **arrêt** ; retrait par **entreprise certifiée**. `[A]`

> Percer sans repérer = risque électrique ; le **retrait d'amiante** n'est jamais réalisé en menuiserie. `[A]`

## Cadre
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-bloc-porte](../../professions/menuiserie-interieure/cards/poser-bloc-porte.md).
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:securite intervention:controler cluster:blocs-portes cluster:reglementation type:procedure securite:electrique securite:amiante relation:desamiantage relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
