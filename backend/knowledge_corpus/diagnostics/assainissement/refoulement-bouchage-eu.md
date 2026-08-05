# Refoulement / bouchage EU

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `refoulement-bouchage-eu` |
| Titre | Refoulement / bouchage EU |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Refoulement** d'eaux usées, évacuation lente, débordement d'un regard. `[C]`

## Causes probables
1. **Bouchon** dans la canalisation (graisses, lingettes, racines). `[C]`
2. **Pente** insuffisante / contre-pente / affaissement. `[C]` → [poser-reseau-eu-ep](../../professions/assainissement/cards/poser-reseau-eu-ep.md)
3. Réseau/ANC aval saturé. `[C]` → [dysfonctionnement-anc](dysfonctionnement-anc.md)

## Résolution
- Localiser (caméra), **curer/déboucher** depuis les regards, corriger la pente si structurel ; côté intérieur → plomberie. `[C]` → [deboucher-evacuation-sanitaire](../../professions/plomberie/cards/deboucher-evacuation-sanitaire.md)

## Cadre
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [diagnostiquer-controler-assainissement](../../professions/assainissement/cards/diagnostiquer-controler-assainissement.md).
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement probleme:obstruction cluster:eaux-usees cluster:diagnostic type:diagnostic securite:biologique relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
