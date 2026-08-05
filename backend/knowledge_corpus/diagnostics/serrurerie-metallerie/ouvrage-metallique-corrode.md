# Ouvrage métallique corrodé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `ouvrage-metallique-corrode` |
| Titre | Ouvrage métallique corrodé |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:metallerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Rouille**, corrosion, cloquage de peinture, gonflement aux fixations/soudures. `[C]`

## Causes probables
1. **Traitement anti-corrosion** défaillant ou absent. `[C]` → [fabriquer-ouvrage-metallique](../../professions/serrurerie-metallerie/cards/fabriquer-ouvrage-metallique.md)
2. **Point de rétention d'eau** / soudure non protégée. `[C]`
3. Corrosion **galvanique** (métaux différents en contact). `[C]`

## Résolution
- Décaper/brosser, traiter (convertisseur/apprêt), reprendre la **protection** (galva à froid/laquage) ; éliminer les rétentions d'eau. `[C]`

> Corrosion avancée sur **garde-corps/structure** = **tenue** à vérifier (sécurité). `[A]`

## Cadre
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [fabriquer-ouvrage-metallique](../../professions/serrurerie-metallerie/cards/fabriquer-ouvrage-metallique.md).
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:metallerie probleme:corrosion cluster:traitement-surface cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
