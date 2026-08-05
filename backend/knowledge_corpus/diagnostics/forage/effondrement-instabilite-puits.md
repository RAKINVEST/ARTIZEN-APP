# Effondrement / instabilité de puits ou forage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `effondrement-instabilite-puits` |
| Titre | Effondrement / instabilité de puits ou forage |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Paroi de **puits** qui se dégrade/s'éboule, tubage écrasé, affaissement en surface. `[C]`

> **DANGER VITAL** (chute + ensevelissement + espace confiné). Interdire l'accès ; **jamais** de descente sans procédure. `[A]`

## Causes probables
1. **Tubage/soutènement** insuffisant ou dégradé. `[C]` → [tuber-equiper-forage](../../professions/forage/cards/tuber-equiper-forage.md)
2. Terrain instable / venue d'eau. `[C]`
3. Ouvrage ancien non entretenu. `[C]`

## Résolution
- **Sécuriser** (couvrir/baliser) ; reprise/rebouchage par une **entreprise qualifiée**. `[A]` → [reboucher-abandonner-forage](../../professions/forage/cards/reboucher-abandonner-forage.md)

## Cadre
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [reboucher-abandonner-forage](../../professions/forage/cards/reboucher-abandonner-forage.md).
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage probleme:effondrement cluster:puits-traditionnel cluster:tubage cluster:diagnostic type:diagnostic securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
