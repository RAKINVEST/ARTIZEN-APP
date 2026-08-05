# Un secteur n'arrose plus

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `secteur-narrose-plus` |
| Titre | Un secteur n'arrose plus |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un **secteur** ne se déclenche plus (les autres fonctionnent), pas d'eau à l'heure programmée. `[C]`

## Causes probables
1. **Électrovanne** (bobine HS, câble commandé coupé, membrane bloquée). `[C]` → [installer-electrovannes-programmateur](../../professions/arrosage/cards/installer-electrovannes-programmateur.md)
2. **Programmateur** (voie/programme mal réglé, pile, sonde pluie active). `[C]` → [essayer-regler-mettre-en-service](../../professions/arrosage/cards/essayer-regler-mettre-en-service.md)
3. **Alimentation électrique** coupée (→ Électricité, interface). `[C]` → [remplacer-prise-courant](../../professions/electricite-generale/cards/remplacer-prise-courant.md)

## Résolution
- Tester bobine/câble d'électrovanne, vérifier programme/sonde, contrôler l'alimentation (électricien si besoin). `[C]`

## Cadre
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [installer-electrovannes-programmateur](../../professions/arrosage/cards/installer-electrovannes-programmateur.md).
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage probleme:secteur cluster:electrovannes cluster:diagnostic type:diagnostic securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
