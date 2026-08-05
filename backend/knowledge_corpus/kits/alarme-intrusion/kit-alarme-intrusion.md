# Kit alarme intrusion

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-alarme-intrusion` |
| Titre | Kit alarme intrusion |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Centrale + claviers, **détecteurs** (contacts, volumétriques double techno). `[C]`
- Sirènes (ext. autoprotégée), **transmetteur** (GSM/IP), badges/télécommandes. `[C]`
- **Batteries de secours**/piles, testeur, outil de programmation. `[C]`
- **EPI** électriques pour la partie alimentation (réservée **habilité**). `[A]`

## Cadre
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [installer-centrale-clavier](../../professions/alarme-intrusion/cards/installer-centrale-clavier.md).
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion type:kit cluster:detecteurs cluster:sirenes equipement:centrale-alarme`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
