# Affaissement / déformation de charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `affaissement-charpente` |
| Titre | Affaissement / déformation de charpente |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Flèche**, déversement, fissures, ligne de faîtage déformée. `[C]`

> **Danger potentiel : évaluer la stabilité, étayer/évacuer si nécessaire, faire appel à une étude structurelle.** `[A]`

## Causes probables
1. Surcharge / modification (dépose d'un porteur). `[C]`
2. **Attaque du bois** (insectes/champignon) affaiblissant un porteur. `[C]` → [diagnostiquer-attaque-bois](../../professions/charpente/cards/diagnostiquer-attaque-bois.md)
3. Assemblage/appui défaillant. `[C]` → [controler-assemblages](../../professions/charpente/cards/controler-assemblages.md)

## Résolution
- **Étude structurelle** puis étaiement + renforcement/remplacement. `[A]` → [renforcer-panne-ferme](../../professions/charpente/cards/renforcer-panne-ferme.md)

## Cadre
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [renforcer-panne-ferme](../../professions/charpente/cards/renforcer-panne-ferme.md).
- **Tags** : `metier:charpente famille:enveloppe sous-famille:charpente probleme:affaissement probleme:deformation cluster:diagnostic cluster:controle type:diagnostic securite:structure securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
