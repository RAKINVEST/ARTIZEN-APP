# Principe de la terrasse bois

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-terrasse-bois` |
| Titre | Principe de la terrasse bois |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:terrasse-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la structure d'une terrasse bois (support → plots/lambourdes → lames) et ses frontières avec les métiers du bois. `[C]`
- **Résumé** : une terrasse bois superpose un **support** (dalle/sol stabilisé), une **structure** ventilée (**plots réglables**, **lambourdes**/**solives**) et un **platelage** de **lames** (bois ou **composite**) fixées de façon invisible ou apparente, avec **pente**, **drainage**, **ventilation** et **jeux** de dilatation ; la **charpente** (structure lourde) et la **menuiserie extérieure** sont des métiers distincts, le **support maçonné** et le **terrassement** aussi. `[C]` ⟦type de terrasse selon support à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Étudier le support** (pente/drainage/ventilation). `[C]` → [etudier-support-implanter](etudier-support-implanter.md)
  2. Poser **plots/lambourdes/solives** (structure ventilée). `[C]` → [poser-plots-lambourdes-solives](poser-plots-lambourdes-solives.md)
  3. Poser les **lames** (fixation + dilatation). `[C]` → [poser-lames-fixation-invisible-apparente](poser-lames-fixation-invisible-apparente.md)
  4. **Charpente** = structure bois lourde (frontière). `[C]` → [principe-charpente](../../../professions/charpente/cards/principe-charpente.md)
- **Points critiques** : structure **ventilée** (pente/drainage) ; jeux de dilatation ; **frontières** (charpente/menuiserie/maçonnerie) ; classes d'emploi bois.
- **Sécurité** : découpe/poussières bois ; manutention ; ancrages (DICT). **Outils électroportatifs / découpe** : scie circulaire/sauteuse, visseuse — **coupures**, projections → lunettes/gants, capot/guide ; **poussières de bois cancérogènes** (surtout exotiques/composite) → aspiration/masque. **Manutention** (lames, lambourdes, plots, colis lourds) : binôme/moyens — dos/écrasement ; **échardes** (bois brut). **Repérage des réseaux avant ancrage/terrassement** (**DT-DICT**) : scellement de plots, fixations dans dalle → ne pas percer un câble/tuyau. **Terrasse surélevée** : **garde-corps** (métier concerné) et risque de chute pendant la pose. **Glissance** (bois humide) ; intempéries. **Risques électriques** : un éventuel **éclairage intégré** (spots LED) → **raccordement réservé à un électricien** (interface). **Amiante** (rénovation, ancien support/revêtement) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien / diagnostic** : `cite-carte` → [controler-diagnostiquer-terrasse](controler-diagnostiquer-terrasse.md)

## Relations & tags
- **Tags** : `metier:terrasse-bois famille:specialises sous-famille:terrasse-bois intervention:comprendre cluster:support cluster:structure cluster:lames type:principe securite:coupure relation:charpente relation:menuiserie-exterieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
