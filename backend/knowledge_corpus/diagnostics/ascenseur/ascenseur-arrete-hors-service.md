# Ascenseur à l'arrêt / hors service

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `ascenseur-arrete-hors-service` |
| Titre | Ascenseur à l'arrêt / hors service |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Ascenseur **immobilisé**, hors service, n'appelle plus, arrêt entre niveaux. `[C]`

> **Ne pas intervenir soi-même** : métier réservé. En cas de **personne bloquée**, suivre la procédure d'appel d'urgence ; le dégagement est fait par personnel **formé**. `[A]`

## Causes probables (à confirmer par l'ascensoriste)
1. **Sécurité déclenchée** (survitesse, porte, contact) — protection normale. `[A]` → [comprendre-dispositifs-securite](../../professions/ascenseur/cards/comprendre-dispositifs-securite.md)
2. **Alimentation électrique** / armoire (→ Électricité, interface). `[C]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)
3. Panne machinerie/variateur (réservé). `[C]`

## Conduite à tenir
- **Mettre hors service**, baliser, et **appeler l'ascensoriste** (contrat d'entretien) ; ne jamais forcer les portes. `[A]`

## Cadre
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [organiser-maintenance-depannage](../../professions/ascenseur/cards/organiser-maintenance-depannage.md).
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur probleme:panne cluster:depannage cluster:diagnostic type:diagnostic securite:ecrasement relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
