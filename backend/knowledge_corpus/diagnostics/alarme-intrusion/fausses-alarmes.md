# Fausses alarmes / déclenchements intempestifs

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fausses-alarmes` |
| Titre | Fausses alarmes / déclenchements intempestifs |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Déclenchements intempestifs** sans intrusion réelle. `[C]`

## Causes probables
1. **Détecteur volumétrique** mal placé (soleil, chauffage, **animaux**, courants d'air). `[C]` → [poser-detecteurs-volumetriques](../../professions/alarme-intrusion/cards/poser-detecteurs-volumetriques.md)
2. **Contact d'ouverture** mal réglé (entrefer, vibration). `[C]` → [poser-detecteurs-ouverture](../../professions/alarme-intrusion/cards/poser-detecteurs-ouverture.md)
3. **Pile faible** (radio) / interférence. `[C]` → [defaut-alimentation-batterie](defaut-alimentation-batterie.md)

## Résolution
- Repositionner/régler le détecteur, choisir une **immunité animaux/double techno**, remplacer les piles, retester. `[C]`

## Cadre
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [essayer-maintenir-alarme](../../professions/alarme-intrusion/cards/essayer-maintenir-alarme.md).
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion probleme:faux-declenchement cluster:detecteurs-volumetriques cluster:diagnostic type:diagnostic securite:autoprotection`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
