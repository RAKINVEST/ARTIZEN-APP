# Portail / grille qui grince ou s'affaisse

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `portail-grince-affaisse` |
| Titre | Portail / grille qui grince ou s'affaisse |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:metallerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Portail qui **grince**, **frotte**, **s'affaisse**, vantail qui ne ferme plus, jeu aux gonds. `[C]`

## Causes probables
1. **Gonds/roulettes** usés ou non lubrifiés. `[C]` → [poser-portail-grille-metallique](../../professions/serrurerie-metallerie/cards/poser-portail-grille-metallique.md)
2. **Poteau/scellement** qui a bougé (affaissement). `[C]`
3. Vantail **déformé** (choc/corrosion). `[C]` → [ouvrage-metallique-corrode](ouvrage-metallique-corrode.md)

## Résolution
- Régler/lubrifier ou remplacer gonds/roulettes, reprendre le scellement/l'aplomb, redresser/renforcer le vantail. `[C]`

> Si **motorisé** : le réglage de l'automatisme relève d'un métier distinct (Automatismes-portails). `[C]`

## Cadre
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-portail-grille-metallique](../../professions/serrurerie-metallerie/cards/poser-portail-grille-metallique.md).
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:metallerie probleme:affaissement cluster:portail cluster:diagnostic type:diagnostic securite:ecrasement relation:automatismes-portails`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
