# Arroseur qui ne sort pas / mauvaise portée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `arroseur-defaut-portee` |
| Titre | Arroseur qui ne sort pas / mauvaise portée |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Arroseur qui ne **s'escamote** pas, **portée** faible, zones sèches, goutteurs qui ne coulent plus. `[C]`

## Causes probables
1. **Pression/débit** insuffisant (trop d'arroseurs par secteur). `[C]` → [etudier-besoins-secteurs](../../professions/arrosage/cards/etudier-besoins-secteurs.md)
2. **Buse/goutteur colmaté** (défaut de **filtration**). `[C]` → [installer-goutte-a-goutte-filtration](../../professions/arrosage/cards/installer-goutte-a-goutte-filtration.md)
3. Arroseur enterré/mal réglé (hauteur, buse). `[C]` → [poser-arroseurs-escamotables](../../professions/arrosage/cards/poser-arroseurs-escamotables.md)

## Résolution
- Rééquilibrer le secteur (moins d'arroseurs), nettoyer/remplacer buses et filtres, régler hauteur/portée. `[C]`

## Cadre
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-arroseurs-escamotables](../../professions/arrosage/cards/poser-arroseurs-escamotables.md).
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage probleme:portee cluster:arroseurs-escamotables cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
