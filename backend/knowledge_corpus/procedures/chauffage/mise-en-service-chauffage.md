# Mise en service d'une installation de chauffage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mise-en-service-chauffage` |
| Titre | Mise en service d'une installation de chauffage |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Objet
Remettre en service un circuit de chauffage après intervention, en sécurité et avec un bon équilibre thermique. `[C]`

## Étapes
1. Vérifier le remplissage et la **pression à froid** (~1–1,5 bar selon installation). `[B]` ⟦à confirmer⟧
2. Purger l'ensemble des radiateurs, du plus proche au plus éloigné. `[C]` → [purger-radiateur](../../professions/chauffage/cards/purger-radiateur.md)
3. Mettre en route circulateur et générateur ; contrôler l'absence de fuite. `[C]`
4. Contrôler l'écart départ/retour et l'homogénéité des émetteurs. `[C]`
5. Rétablir la pression si nécessaire après purge. `[B]`

## Points critiques
- Ne pas démarrer sans eau/pression suffisante ; purge complète. `[B]`

## Cadre
- **Normes** : sécurité des installations de chauffage central — **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `a-checklist` → [controle-avant-saison-chauffe](../../checklists/chauffage/controle-avant-saison-chauffe.md) ; `cite-phrase` → [conseil-entretien-chaudiere-annuel](../../phrases/chauffage/conseil-entretien-chaudiere-annuel.md).
- **Tags** : `metier:chauffage famille:fluides intervention:mettre-en-service type:procedure equipement:circuit`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
