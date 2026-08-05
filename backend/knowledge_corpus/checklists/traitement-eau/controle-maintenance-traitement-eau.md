# Contrôle / maintenance traitement d'eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-traitement-eau` |
| Titre | Contrôle / maintenance traitement d'eau |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Cartouches/préfiltres** dans les délais (pas de colmatage). `[C]`
- [ ] **Sel** de l'adoucisseur / régénération OK ; **TH** de sortie correct. `[C]`
- [ ] **Membrane** osmose / **lampe UV** dans les échéances. `[C]`
- [ ] **Protection retours d'eau** (disconnecteur/clapet) en place. `[A]`
- [ ] **Pression** correcte (réducteur) ; pas de fuite. `[C]`
- [ ] **Analyse d'eau** à jour (qualité sanitaire). `[A]`

> Entretien = **qualité sanitaire** ; un consommable saturé dégrade l'eau.

## Cadre
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-controler-traitement-eau](../../professions/traitement-eau/cards/entretenir-controler-traitement-eau.md).
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau type:checklist cluster:controle cluster:maintenance cluster:analyses securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
