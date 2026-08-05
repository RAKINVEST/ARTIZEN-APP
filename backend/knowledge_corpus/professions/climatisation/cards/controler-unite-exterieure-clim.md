# Contrôler l'unité extérieure d'un climatiseur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-unite-exterieure-clim` |
| Titre | Contrôler l'unité extérieure d'un climatiseur |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler et nettoyer l'unité extérieure (échangeur, ventilateur, implantation) hors circuit frigorifère. `[C]`
- **Résumé** : nettoyer l'échangeur à ailettes, vérifier le ventilateur, l'implantation dégagée et les fixations, sans ouvrir le circuit frigorifère. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation électrique de l'unité. `[A]`
  2. Nettoyer l'**échangeur** (ailettes) sans les déformer. `[C]`
  3. Vérifier le **ventilateur** et l'implantation (dégagement, fixations). `[C]`
  4. Contrôler l'absence de trace d'huile (indice de fuite → frigoriste). `[C]` → [clim-en-defaut](../../../diagnostics/climatisation/clim-en-defaut.md)
- **Points critiques** : ailettes fragiles ; **ne pas ouvrir** le circuit frigorifère ; trace d'huile = suspicion de fuite. `[B]`
- **Sécurité** : électricité ; frigorifère non ouvert. **Le circuit frigorifère contient un fluide réglementé sous pression : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage dédié — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Frigorifère** : `cite-carte` → [controler-circuit-frigorifique-clim](controler-circuit-frigorifique-clim.md)

## Relations & tags
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation intervention:controler intervention:entretenir cluster:unite-exterieure cluster:controle equipement:unite-exterieure complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
