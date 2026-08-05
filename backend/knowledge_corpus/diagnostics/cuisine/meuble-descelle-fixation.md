# Meuble haut descellé / fixation défaillante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `meuble-descelle-fixation` |
| Titre | Meuble haut descellé / fixation défaillante |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Meuble haut qui **descend**, se décolle du mur, rail qui cède. `[C]`

> **DANGER de chute** (meuble chargé = très lourd) → vider/sécuriser immédiatement. `[A]`

## Causes probables
1. **Fixation** inadaptée au support (cheville sur plaque de plâtre sans renfort). `[C]` → [poser-meubles-hauts](../../professions/cuisine/cards/poser-meubles-hauts.md)
2. **Surcharge** / rail sous-dimensionné. `[C]`
3. Support dégradé. `[C]`

## Résolution
- **Sécuriser**, reprendre la fixation (chevilles/rail adaptés au support et à la charge), répartir la charge. `[A]`

## Cadre
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-meubles-hauts](../../professions/cuisine/cards/poser-meubles-hauts.md).
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine probleme:fixation cluster:meubles-hauts cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
