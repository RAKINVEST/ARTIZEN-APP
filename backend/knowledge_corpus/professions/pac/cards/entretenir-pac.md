# Entretenir une PAC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-pac` |
| Titre | Entretenir une PAC |
| Profession | `metier:pac` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser l'entretien périodique d'une PAC (partie accessible, hors frigorifère réglementé). `[C]`
- **Résumé** : nettoyer les échangeurs accessibles et filtres, contrôler l'hydraulique et l'électrique visible, vérifier condensats et dégivrage, et confier le **contrôle frigorifère** à un attesté F-Gaz. `[C]`

## Réalisation
- **Étapes** :
  1. Consigner (électricité) ; nettoyer filtres/échangeurs accessibles. `[C]`
  2. Contrôler l'hydraulique (pression, débit, filtre magnétique). `[C]` → [desembouer-circuit-pac-air-eau](desembouer-circuit-pac-air-eau.md)
  3. Vérifier condensats, dégivrage, unité extérieure. `[C]` → [controler-unite-exterieure-pac](controler-unite-exterieure-pac.md)
  4. Confier le **contrôle frigorifère** à un frigoriste attesté. `[A]` → [controler-circuit-frigorifique-pac](controler-circuit-frigorifique-pac.md)
- **Points critiques** : séparer clairement le domaine accessible du domaine **frigorifère réglementé**. `[B]`
- **Sécurité** : électricité ; frigorifère réservé F-Gaz. **Le circuit frigorifère est sous pression et contient un fluide réglementé : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage adapté — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-entretien-pac](../../../kits/pac/kit-entretien-pac.md)
- **Conseil** : `cite-phrase` → [normes-pac-reference](../../../phrases/pac/normes-pac-reference.md)

## Relations & tags
- **Tags** : `metier:pac equipement:pac famille:fluides sous-famille:pac intervention:entretenir cluster:entretien cluster:maintenance equipement:pac complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
