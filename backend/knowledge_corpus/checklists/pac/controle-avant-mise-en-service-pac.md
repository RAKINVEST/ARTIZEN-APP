# Contrôle avant mise en service PAC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-avant-mise-en-service-pac` |
| Titre | Contrôle avant mise en service PAC |
| Profession | `metier:pac` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Implantation unité extérieure dégagée, évacuation condensats OK. `[C]`
- [ ] Raccordement hydraulique étanche, circuit rempli et **purgé**. `[C]`
- [ ] Filtre magnétique posé (protection échangeur). `[B]`
- [ ] Raccordement électrique conforme (par intervenant habilité). `[A]`
- [ ] **Contrôle d'étanchéité frigorifère** par un attesté F-Gaz. `[A]`
- [ ] Paramètres de régulation renseignés. `[C]` ⟦selon fabricant⟧

## Cadre
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [mettre-en-service-pac-air-eau](../../professions/chauffage/cards/mettre-en-service-pac-air-eau.md).
- **Tags** : `metier:pac equipement:pac famille:fluides sous-famille:pac type:checklist cluster:mise-en-service cluster:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
