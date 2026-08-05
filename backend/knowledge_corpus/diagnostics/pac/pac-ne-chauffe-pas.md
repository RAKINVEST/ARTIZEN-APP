# PAC qui ne chauffe pas (ou peu)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pac-ne-chauffe-pas` |
| Titre | PAC qui ne chauffe pas (ou peu) |
| Profession | `metier:pac` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac-air-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- La PAC fonctionne mais le chauffage est **insuffisant**. `[C]`

## Causes probables
1. Débit hydraulique/**désembouage** insuffisant (air/eau). `[C]` → [desembouer-circuit-pac-air-eau](../../professions/pac/cards/desembouer-circuit-pac-air-eau.md)
2. Loi d'eau / paramétrage inadapté. `[C]` ⟦selon fabricant⟧
3. Dégivrage fréquent / unité ext. encrassée. `[C]` → [controler-unite-exterieure-pac](../../professions/pac/cards/controler-unite-exterieure-pac.md)
4. Défaut frigorifère (charge) → **frigoriste F-Gaz**. `[D]`

## Résolution
- Vérifier hydraulique/paramètres/unité ext. ; frigorifère → qualifié. `[C]`

## Cadre
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [mettre-en-service-pac-air-eau](../../professions/pac/cards/mettre-en-service-pac-air-eau.md).
- **Tags** : `metier:pac equipement:pac famille:fluides sous-famille:pac-air-eau probleme:chauffage-insuffisant cluster:diagnostic cluster:pannes type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
