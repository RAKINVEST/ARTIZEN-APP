# L'alarme ne déclenche pas

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `alarme-ne-declenche-pas` |
| Titre | L'alarme ne déclenche pas |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Une intrusion/ouverture **ne déclenche pas** l'alarme (protection illusoire). `[C]`

> Une alarme qui ne déclenche pas = **fausse sécurité** → tester systématiquement. `[A]`

## Causes probables
1. **Détecteur HS** / mal appairé / zone **inhibée**. `[C]` → [essai-reception-alarme](../../procedures/alarme-intrusion/essai-reception-alarme.md)
2. **Sabotage** / autoprotection contournée / câble coupé. `[C]`
3. Mauvaise affectation de zone / scénario d'armement. `[C]` → [configurer-badges-telecommandes-armement](../../professions/alarme-intrusion/cards/configurer-badges-telecommandes-armement.md)

## Résolution
- **Tester chaque détecteur/zone**, vérifier autoprotection et scénarios, réparer/reprogrammer. `[C]`

## Cadre
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [essai-reception-alarme](../../procedures/alarme-intrusion/essai-reception-alarme.md).
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion probleme:non-declenchement cluster:detecteurs cluster:diagnostic type:diagnostic securite:autoprotection`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
