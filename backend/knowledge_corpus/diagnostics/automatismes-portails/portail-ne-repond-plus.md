# Portail motorisé qui ne répond plus

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `portail-ne-repond-plus` |
| Titre | Portail motorisé qui ne répond plus |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le portail ne s'ouvre/ferme plus, aucune réaction à la télécommande. `[C]`

> **Consigner** avant toute intervention (démarrage automatique possible). `[A]`

## Causes probables
1. **Alimentation** coupée / disjonction (→ **Électricité**, interface). `[C]` → [poser-interrupteur-differentiel](../../professions/electricite-generale/cards/poser-interrupteur-differentiel.md)
2. **Télécommande/récepteur** (pile, programmation). `[C]` → [installer-accessoires-commandes](../../professions/automatismes-portails/cards/installer-accessoires-commandes.md)
3. **Sécurité en défaut** (cellule masquée = blocage volontaire). `[C]` → [portail-securite-inverse](portail-securite-inverse.md)

## Résolution
- Vérifier l'alimentation (électricien si besoin), la commande, les sécurités ; utiliser le **déverrouillage manuel** si urgence. `[C]`

## Cadre
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-diagnostiquer-automatisme](../../professions/automatismes-portails/cards/entretenir-diagnostiquer-automatisme.md).
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes probleme:panne cluster:diagnostic cluster:maintenance type:diagnostic securite:ecrasement relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
