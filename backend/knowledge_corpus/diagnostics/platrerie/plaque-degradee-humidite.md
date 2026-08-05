# Plaque dégradée / humidité

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `plaque-degradee-humidite` |
| Titre | Plaque dégradée / humidité |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Plaque **gonflée**, tachée, molle, moisissures (souvent pièce humide/fuite). `[C]`

## Causes probables
1. **Fuite** / infiltration / condensation. `[C]`
2. Plaque **standard** en zone humide (au lieu d'**hydrofuge**). `[C]` → [monter-cloison-seche](../../professions/platrerie/cards/monter-cloison-seche.md)
3. Défaut de ventilation. `[C]`

## Résolution
- **Traiter la cause d'eau** d'abord, remplacer la zone par plaque **hydrofuge**, jointoyer ; ne pas recouvrir un support humide. `[C]` → [poser-trappe-reparer](../../professions/platrerie/cards/poser-trappe-reparer.md)

## Cadre
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-trappe-reparer](../../professions/platrerie/cards/poser-trappe-reparer.md).
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie probleme:humidite cluster:reparations cluster:diagnostics type:diagnostic securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
