# Porte palière en défaut

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `porte-paliere-defaut` |
| Titre | Porte palière en défaut |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Porte palière qui **ne verrouille pas**, ne s'ouvre/ferme pas, jeu, appareil bloqué par la porte. `[C]`

> **Sécurité vitale** : une porte palière déverrouillée = **risque de chute en gaine**. Ne jamais neutraliser le verrouillage ; mettre hors service et appeler l'ascensoriste. `[A]`

## Causes probables (à confirmer par l'habilité)
1. **Verrouillage** (serrure de porte palière) déréglé/usé. `[A]` → [comprendre-portes-palieres](../../professions/ascenseur/cards/comprendre-portes-palieres.md)
2. **Cinématique** (galets/patins/opérateur de porte). `[C]`
3. Contact de sécurité défaillant. `[C]` → [comprendre-dispositifs-securite](../../professions/ascenseur/cards/comprendre-dispositifs-securite.md)

## Conduite à tenir
- Mettre hors service, baliser, **appeler l'ascensoriste** ; intervention **réservée**. `[A]`

## Cadre
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [comprendre-portes-palieres](../../professions/ascenseur/cards/comprendre-portes-palieres.md).
- **Tags** : `metier:ascenseur famille:specialises sous-famille:securite probleme:verrouillage cluster:portes-palieres cluster:diagnostic type:diagnostic securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
