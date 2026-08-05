# Entretenir un climatiseur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-climatiseur` |
| Titre | Entretenir un climatiseur |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser l'entretien courant d'un climatiseur (filtres, échangeurs, condensats) hors circuit frigorifère. `[C]`
- **Résumé** : nettoyer/remplacer les filtres, nettoyer les échangeurs accessibles, contrôler l'évacuation des condensats et l'unité extérieure, désinfecter si besoin ; confier le contrôle frigorifère à un attesté. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation électrique. `[A]`
  2. Nettoyer/remplacer les **filtres**. `[C]` → [remplacer-filtre-climatiseur](remplacer-filtre-climatiseur.md)
  3. Nettoyer les échangeurs accessibles et le bac à condensats ; désinfecter (hygiène). `[C]`
  4. Contrôler l'**évacuation des condensats** et l'unité extérieure. `[C]` → [controler-unite-exterieure-clim](controler-unite-exterieure-clim.md)
  5. Confier le **contrôle frigorifère** à un frigoriste attesté. `[A]` → [controler-circuit-frigorifique-clim](controler-circuit-frigorifique-clim.md)
- **Points critiques** : séparer domaine accessible / frigorifère réglementé ; hygiène (bio-contamination du bac). `[B]`
- **Sécurité** : électricité ; frigorifère réservé F-Gaz. **Le circuit frigorifère contient un fluide réglementé sous pression : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage dédié — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-entretien-climatiseur](../../../kits/climatisation/kit-entretien-climatiseur.md)
- **Normes** : `cite-phrase` → [normes-climatisation-reference](../../../phrases/climatisation/normes-climatisation-reference.md)

## Relations & tags
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation intervention:entretenir cluster:entretien cluster:maintenance complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
