# Contrôle / maintenance automatisme de portail

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-automatisme` |
| Titre | Contrôle / maintenance automatisme de portail |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Consignation** effectuée avant intervention. `[A]`
- [ ] **Cellules / bords sensibles / feu** : propres, alignés, fonctionnels. `[A]`
- [ ] **Limitation d'effort** conforme (**mesure d'effort**). `[A]`
- [ ] **Déverrouillage manuel** de secours opérationnel. `[A]`
- [ ] **Mécanique** (crémaillère/vérins/galets/butées) ; batterie de secours. `[C]`
- [ ] **Interfaces** : alimentation (Élec), clavier (Contrôle d'accès), interphone (Interphonie) OK ; rénovation : **amiante**. `[C]`

## Cadre
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-diagnostiquer-automatisme](../../professions/automatismes-portails/cards/entretenir-diagnostiquer-automatisme.md).
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes type:checklist cluster:maintenance cluster:essais securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
