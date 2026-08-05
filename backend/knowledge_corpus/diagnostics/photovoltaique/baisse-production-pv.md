# Baisse de production PV

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `baisse-production-pv` |
| Titre | Baisse de production PV |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Production** inférieure aux attentes (monitoring), une chaîne/un module en retrait. `[C]`

## Causes probables
1. **Ombrage / salissure** (feuilles, poussière, fientes). `[C]` → [monitorer-diagnostiquer-controler](../../professions/photovoltaique/cards/monitorer-diagnostiquer-controler.md)
2. **Défaut de chaîne** (connectique, module HS, diode). `[C]` → [cabler-chaines-dc](../../professions/photovoltaique/cards/cabler-chaines-dc.md)
3. **Onduleur** bridé/en défaut / découplage. `[C]` → [onduleur-en-defaut](onduleur-en-defaut.md)

## Résolution
- Identifier (monitoring par module), nettoyer/désombrer, contrôler la chaîne/l'onduleur (habilité) ; toute intervention DC = **risque élevé**. `[A]`

## Cadre
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [monitorer-diagnostiquer-controler](../../professions/photovoltaique/cards/monitorer-diagnostiquer-controler.md).
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique probleme:production cluster:monitoring cluster:diagnostic type:diagnostic securite:dc`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
