# Store / motorisation qui ne fonctionne plus

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `store-ne-fonctionne-plus` |
| Titre | Store / motorisation qui ne fonctionne plus |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Store/BSO/pergola qui **ne répond plus** à la commande, ou s'arrête mal. `[C]`

## Causes probables
1. **Alimentation / raccordement électrique** (réservé → Électricité). `[C]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)
2. **Fins de course** déréglées / télécommande désappairée. `[C]` → [motoriser-regler-store-pergola](../../professions/stores-pergolas/cards/motoriser-regler-store-pergola.md)
3. **Capteur** (vent/pluie) en sécurité ou défaillant. `[C]`

## Résolution
- Vérifier alimentation (électricien), re-régler fins de course/capteurs, appairer la commande. `[C]`

## Cadre
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [motoriser-regler-store-pergola](../../professions/stores-pergolas/cards/motoriser-regler-store-pergola.md).
- **Tags** : `metier:stores-pergolas famille:enveloppe sous-famille:stores-pergolas probleme:panne cluster:motorisations cluster:diagnostic type:diagnostic securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
