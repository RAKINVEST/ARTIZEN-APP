# Fuite / surconsommation du réseau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fuite-surconsommation-reseau` |
| Titre | Fuite / surconsommation du réseau |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Surconsommation** d'eau, zone détrempée, réseau qui coule **en permanence**, chute de pression. `[C]`

## Causes probables
1. **Fuite** sur PE/raccord (tranchée, coude, purge). `[C]` → [poser-reseau-pe-enterre](../../professions/arrosage/cards/poser-reseau-pe-enterre.md)
2. **Électrovanne qui reste ouverte** (impureté, membrane). `[C]` → [installer-electrovannes-programmateur](../../professions/arrosage/cards/installer-electrovannes-programmateur.md)
3. Programme redondant / arrosage permanent. `[C]` → [essayer-regler-mettre-en-service](../../professions/arrosage/cards/essayer-regler-mettre-en-service.md)

## Résolution
- Localiser/reprendre la fuite PE, nettoyer/remplacer l'électrovanne, corriger la programmation ; vérifier la **protection anti-retour**. `[C]`

## Cadre
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-reseau-pe-enterre](../../professions/arrosage/cards/poser-reseau-pe-enterre.md).
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage probleme:fuite cluster:reseau-enterre cluster:diagnostic type:diagnostic securite:eau relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
