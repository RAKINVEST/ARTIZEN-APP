# Mettre en service une PAC air/eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mettre-en-service-pac-air-eau` |
| Titre | Mettre en service une PAC air/eau |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac-air-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : mettre en service la partie **hydraulique** d'une PAC air/eau (le circuit frigorifère étant du ressort d'un frigoriste qualifié). `[C]`
- **Résumé** : contrôler le remplissage/purge du circuit hydraulique, la pression, le débit et l'équilibrage, vérifier les paramètres de régulation, puis contrôler la montée en température. `[C]` ⟦paramétrage selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier le raccordement hydraulique et l'absence de fuite. `[C]`
  2. Remplir et **purger** le circuit (côté émission). `[C]` → [mise-en-service-chauffage](../../../procedures/chauffage/mise-en-service-chauffage.md)
  3. Contrôler pression, débit et **équilibrage** du circuit. `[B]`
  4. Vérifier les paramètres de régulation (loi d'eau) selon fabricant. `[C]` ⟦à confirmer⟧
  5. Contrôler la montée en température et les sécurités. `[C]` → [controle-avant-mise-en-service-pac](../../../checklists/chauffage/controle-avant-mise-en-service-pac.md)
- **Points critiques** : débit hydraulique suffisant (protection PAC) ; équilibrage ; loi d'eau adaptée à l'émission. `[B]`
- **Sécurité** : hydraulique sous pression + fluide frigorigène côté groupe. **Le circuit frigorifère est sous pression et contient un fluide réglementé : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage adapté — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : installations de PAC **DTU 65.16** ; côté hydraulique **DTU 65.11** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Relations Chauffage** : `cite-carte` → [desembouer-circuit-pac-air-eau](desembouer-circuit-pac-air-eau.md)
- **Diagnostics liés** : `traite-diagnostic` → [pac-ne-chauffe-pas](../../../diagnostics/chauffage/pac-ne-chauffe-pas.md)

## Relations & tags
- **Tags** : `metier:chauffage equipement:pac famille:fluides sous-famille:pac-air-eau intervention:mettre-en-service cluster:hydraulique cluster:mise-en-service complexite:avancee type:mise-en-service`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
