# Repérage réseaux, ancrage & amiante avant pose d'agencement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reperage-fixation-amiante-avant-pose-agencement` |
| Titre | Repérage réseaux, ancrage & amiante avant pose d'agencement |
| Profession | `metier:agencement` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser la pose (ancrage anti-basculement + réseaux) et, en rénovation, l'amiante — sans retrait ni raccordement réglementé. `[A]`

## Étapes
1. **Repérer les réseaux** (élec/gaines) avant de percer/fixer. `[A]` → [remplacer-prise-courant](../../professions/electricite-generale/cards/remplacer-prise-courant.md)
2. **Ancrage anti-basculement** : choisir la fixation adaptée au support (plaque de plâtre ≠ maçonnerie) — obligatoire pour les meubles hauts/dressings/bibliothèques. `[A]`
3. **Raccordement électrique** (éclairage intégré) = **interface** → Électricité (jamais réalisé ici). `[A]`
4. Ouvrages **anciens** : **diagnostic amiante avant travaux** ; suspect → **arrêt**, retrait par **entreprise certifiée**. `[A]` `relation:desamiantage`

> **Retrait d'amiante** et **raccordement électrique** ne sont **jamais** réalisés en agencement. `[A]`

## Cadre
- **Normes** : menuiseries intérieures / meubles en bois **DTU 36.2**, **DTU 36.1** ; électricité (éclairage intégré / percement, **interface**) **NF C 15-100** ; stabilité des meubles de rangement (**EN 14749**), anti-basculement et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [fabriquer-poser-caissons-dressing](../../professions/agencement/cards/fabriquer-poser-caissons-dressing.md).
- **Tags** : `metier:agencement famille:finition sous-famille:securite intervention:controler cluster:rangements-fixes cluster:reglementation type:procedure securite:electrique securite:amiante relation:desamiantage relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
