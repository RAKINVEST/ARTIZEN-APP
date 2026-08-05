# Contrôle / maintenance réglementée ascenseur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-ascenseur` |
| Titre | Contrôle / maintenance réglementée ascenseur |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier (suivi gestionnaire)
- [ ] **Contrat d'entretien** en cours avec un ascensoriste. `[A]`
- [ ] **Visites périodiques** réalisées et consignées. `[C]`
- [ ] **Contrôle technique quinquennal** à jour. `[A]`
- [ ] **Registre/carnet** d'entretien tenu (traçabilité). `[C]`
- [ ] **Dispositifs de sécurité** non neutralisés (parachute/verrouillage). `[A]`
- [ ] **Modernisation** (SNEL) suivie ; appareils anciens : **amiante** vérifié. `[A]`

## Cadre
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [organiser-maintenance-depannage](../../professions/ascenseur/cards/organiser-maintenance-depannage.md).
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur type:checklist cluster:maintenance-reglementee cluster:modernisation securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
