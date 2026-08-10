# Principe de la climatisation (split / réversible)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-climatisation` |
| Titre | Principe de la climatisation (split / réversible) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le fonctionnement d'un climatiseur à détente directe (split) et sa variante **réversible**. `[C]`
- **Résumé** : un split transfère la chaleur via un cycle frigorifère entre une unité intérieure et une unité extérieure ; en **réversible**, il chauffe aussi (fonction pompe à chaleur air/air). `[C]` ⟦performances selon matériel à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Unité intérieure** (mural, cassette, gainable, console) diffuse l'air traité. `[C]`
  2. **Unité extérieure** échange avec l'air extérieur. `[C]`
  3. **Cycle frigorifère** entre les deux (réservé qualifié). `[C]` → [controler-circuit-frigorifique-clim](controler-circuit-frigorifique-clim.md)
  4. En **réversible** = PAC air/air (chauffe et refroidit). `[C]` → [principe-fonctionnement-pac](../../../professions/chauffage/cards/principe-fonctionnement-pac.md)
- **Points critiques** : dimensionnement selon volume/apports ; le réversible partage la technologie PAC. `[C]`
- **Sécurité** : sous pression + fluide frigorigène. **Le circuit frigorifère contient un fluide réglementé sous pression : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage dédié — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Mise en service** : `cite-carte` → [mettre-en-service-split](mettre-en-service-split.md)

## Relations & tags
- **Tags** : `metier:climatisation equipement:climatiseur equipement:pac famille:fluides sous-famille:climatisation intervention:comprendre cluster:principe type:principe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
