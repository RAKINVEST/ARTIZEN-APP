# Scénario au comportement anormal

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `scenario-comportement-anormal` |
| Titre | Scénario au comportement anormal |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un **scénario** se déclenche mal, au mauvais moment, ou crée une **gêne/danger**. `[C]`

> Un scénario ne doit **jamais** créer de situation dangereuse (issue bloquée, chauffage coupé en gel) → **repli sûr**. `[A]`

## Causes probables
1. **Condition/déclencheur** mal défini (capteur, horaire). `[C]` → [creer-scenarios-pilotage](../../professions/domotique/cards/creer-scenarios-pilotage.md)
2. **Conflit** entre scénarios / priorités. `[C]`
3. Faux positif d'un **capteur** (emplacement). `[C]` → [poser-capteurs-domotique](../../professions/domotique/cards/poser-capteurs-domotique.md)

## Résolution
- Revoir conditions/priorités, tester les cas limites, garantir le **repli sûr**. `[A]`

## Cadre
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [creer-scenarios-pilotage](../../professions/domotique/cards/creer-scenarios-pilotage.md).
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique probleme:scenario cluster:scenarios cluster:diagnostic type:diagnostic securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
