# Traitement inefficace / contamination

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traitement-inefficace-contamination` |
| Titre | Traitement inefficace / contamination |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Analyse **non conforme** (bactério) malgré le traitement ; eau dégradée après l'installation. `[C]`

> Un traitement **mal entretenu** peut **dégrader** l'eau (niche microbiologique). Ne pas consommer une eau non conforme. `[A]`

## Causes probables
1. **Cartouche/charbon saturé** (niche bactérienne). `[C]` → [installer-charbon-actif](../../professions/traitement-eau/cards/installer-charbon-actif.md)
2. **UV** : lampe HS / eau trouble / électrique. `[C]` → [installer-traitement-uv](../../professions/traitement-eau/cards/installer-traitement-uv.md)
3. **By-pass** ouvert / défaut de protection retours d'eau. `[C]`

## Résolution
- Remplacer les consommables, **désinfecter**, rétablir l'UV, refaire analyser ; usage restreint tant que non conforme. `[A]`

## Cadre
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [mise-en-service-desinfection-traitement](../../procedures/traitement-eau/mise-en-service-desinfection-traitement.md).
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau probleme:contamination cluster:desinfection cluster:diagnostic type:diagnostic securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
