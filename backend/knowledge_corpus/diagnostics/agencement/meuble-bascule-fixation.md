# Meuble qui bascule / fixation défaillante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `meuble-bascule-fixation` |
| Titre | Meuble qui bascule / fixation défaillante |
| Profession | `metier:agencement` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:agencement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Dressing/bibliothèque qui **penche**, bascule, ancrage qui cède. `[C]`

> **DANGER de basculement** (meuble haut chargé = très lourd, risque pour les **enfants**) → sécuriser immédiatement. `[A]`

## Causes probables
1. **Absence d'ancrage** mural anti-basculement. `[C]` → [poser-bibliotheque-meuble-integre](../../professions/agencement/cards/poser-bibliotheque-meuble-integre.md)
2. **Ancrage inadapté** au support (cheville sur plaque de plâtre sans renfort). `[C]` → [fabriquer-poser-caissons-dressing](../../professions/agencement/cards/fabriquer-poser-caissons-dressing.md)
3. Surcharge en hauteur / centre de gravité haut. `[C]`

## Résolution
- **Sécuriser**, poser/reprendre l'**ancrage anti-basculement** (fixation adaptée au support), répartir la charge. `[A]`

## Cadre
- **Normes** : menuiseries intérieures / meubles en bois **DTU 36.2**, **DTU 36.1** ; électricité (éclairage intégré / percement, **interface**) **NF C 15-100** ; stabilité des meubles de rangement (**EN 14749**), anti-basculement et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-bibliotheque-meuble-integre](../../professions/agencement/cards/poser-bibliotheque-meuble-integre.md).
- **Tags** : `metier:agencement famille:finition sous-famille:agencement probleme:basculement cluster:bibliotheques cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
