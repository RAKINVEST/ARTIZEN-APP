# Onduleur en défaut

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `onduleur-en-defaut` |
| Titre | Onduleur en défaut |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Onduleur **en défaut** / arrêté, code d'erreur, plus d'injection. `[C]`

## Causes probables
1. **Découplage réseau** (tension/fréquence hors plage). `[C]` → [raccorder-autoconsommation-reseau](../../professions/photovoltaique/cards/raccorder-autoconsommation-reseau.md)
2. **Défaut d'isolement** DC (voir arc). `[C]` → [defaut-isolement-arc-dc](defaut-isolement-arc-dc.md)
3. Surchauffe / défaut interne / configuration. `[C]`

## Résolution
- Lire le code défaut, vérifier réseau/DC/ventilation ; reprise par un **professionnel** (AC habilité). `[C]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)

## Cadre
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [monitorer-diagnostiquer-controler](../../professions/photovoltaique/cards/monitorer-diagnostiquer-controler.md).
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique probleme:onduleur cluster:onduleurs cluster:diagnostic type:diagnostic securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
