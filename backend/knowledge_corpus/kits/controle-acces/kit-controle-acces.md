# Kit contrôle d'accès

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-controle-acces` |
| Titre | Kit contrôle d'accès |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Lecteurs (RFID/bio), claviers, contrôleur(s), **badges/cartes** + encodeur. `[C]`
- Organes : **gâches**, **ventouses électromagnétiques**, serrures ; **boutons de demande de sortie**/bris de glace. `[C]`
- **Alimentation secourue** (batterie), testeur, outil de programmation. `[C]`
- **EPI** électriques pour l'alimentation (réservée **habilité**). `[A]`

## Cadre
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [poser-organe-verrouillage](../../professions/controle-acces/cards/poser-organe-verrouillage.md).
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces type:kit cluster:ventouses-electromagnetiques cluster:badges-rfid equipement:controleur-acces`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
