# Bois pourri / humidité (ventilation)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `bois-pourri-humidite` |
| Titre | Bois pourri / humidité (ventilation) |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:terrasse-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Bois **noirci/mou**, **champignon**, lambourdes qui pourrissent, odeur d'humidité. `[C]`

## Causes probables
1. **Ventilation** de sous-face insuffisante (bois qui reste humide). `[C]` → [etudier-support-implanter](../../professions/terrasse-bois/cards/etudier-support-implanter.md)
2. **Drainage/pente** défaillant (eau stagnante). `[C]`
3. **Classe d'emploi** inadaptée (bois non durable au contact de l'eau). `[C]` → [choisir-essences-composite](../../professions/terrasse-bois/cards/choisir-essences-composite.md)

## Résolution
- Rétablir **ventilation + drainage/pente**, remplacer les éléments pourris par une **classe d'emploi** adaptée, surelever/désolidariser. `[C]`

## Cadre
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [etudier-support-implanter](../../professions/terrasse-bois/cards/etudier-support-implanter.md).
- **Tags** : `metier:terrasse-bois famille:specialises sous-famille:terrasse-bois probleme:pourriture cluster:drainage cluster:diagnostic type:diagnostic securite:manutention relation:charpente`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
