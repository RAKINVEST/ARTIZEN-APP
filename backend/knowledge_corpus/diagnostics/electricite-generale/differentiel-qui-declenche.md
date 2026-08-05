# Différentiel qui déclenche

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `differentiel-qui-declenche` |
| Titre | Différentiel qui déclenche |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:tableau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un interrupteur **différentiel** déclenche (coupe plusieurs circuits). `[C]`

## Causes probables
1. **Défaut d'isolement** (fuite à la terre) sur un circuit/appareil. `[C]`
2. Appareil défectueux (humidité, chauffe-eau, lave-linge). `[C]`
3. Différentiel de **type** inadapté / défectueux. `[C]` → [poser-interrupteur-differentiel](../../professions/electricite-generale/cards/poser-interrupteur-differentiel.md)

## Démarche
- Réarmer circuits un à un pour isoler le défaut ; mesure d'isolement **par un qualifié**. `[C]`

> Défaut d'isolement = **risque électrique** : électricien habilité.

## Cadre
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-interrupteur-differentiel](../../professions/electricite-generale/cards/poser-interrupteur-differentiel.md).
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:tableau probleme:declenchement probleme:defaut-isolement cluster:diagnostic cluster:depannage cluster:interrupteurs-differentiels type:diagnostic securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
