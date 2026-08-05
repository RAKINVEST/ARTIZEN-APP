# Nettoyer / remplacer les filtres d'un climatiseur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-filtre-climatiseur` |
| Titre | Nettoyer / remplacer les filtres d'un climatiseur |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : restaurer le débit d'air et la qualité de filtration en nettoyant ou remplaçant les filtres de l'unité intérieure. `[C]`
- **Résumé** : déposer les filtres, les nettoyer (ou remplacer selon type), vérifier/nettoyer les filtres additionnels, remonter et contrôler. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation ; ouvrir la façade de l'unité intérieure. `[A]`
  2. Déposer les **filtres** ; nettoyer à l'eau tiède (ou remplacer). `[C]`
  3. Nettoyer les filtres additionnels (charbon/photocatalytique) ou remplacer. `[C]` ⟦selon modèle⟧
  4. Sécher, remonter, contrôler le débit et l'absence de bruit. `[C]`
- **Points critiques** : filtres **secs** avant remontage ; périodicité selon usage (qualité d'air). `[C]`
- **Sécurité** : électricité coupée ; hygiène. `[B]`

## Cadre & suites
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-climatiseur](entretenir-climatiseur.md)
- **Diagnostics liés** : `traite-diagnostic` → [clim-ne-refroidit-pas](../../../diagnostics/climatisation/clim-ne-refroidit-pas.md)

## Relations & tags
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation intervention:entretenir intervention:nettoyer cluster:entretien cluster:unite-interieure equipement:filtre complexite:simple type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
