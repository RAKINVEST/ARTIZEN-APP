# Entretenir et rénover une terrasse bois

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-renover-terrasse` |
| Titre | Entretenir et rénover une terrasse bois |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:terrasse-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'**entretien** (nettoyage, dégrisage, saturateur) et la **rénovation** d'une terrasse bois. `[C]`
- **Résumé** : nettoyer (brosse/basse pression), **dégriser** le bois grisé (dégrisant) et **nourrir/protéger** (saturateur/huile) selon l'essence, remplacer les lames abîmées et resserrer les fixations, contrôler la **ventilation**/le drainage ; en **rénovation** d'un ancien platelage sur support ancien, **diagnostic amiante** éventuel ; les **abords végétalisés** relèvent du **Paysagisme**. `[C]`

## Réalisation
- **Étapes** :
  1. Nettoyer ; **dégriser** ; appliquer **saturateur**. `[C]` → [lame-grise-fendue-echardee](../../../diagnostics/terrasse-bois/lame-grise-fendue-echardee.md)
  2. Remplacer lames abîmées ; resserrer fixations. `[C]`
  3. Contrôler ventilation/drainage. `[C]` → [bois-pourri-humidite](../../../diagnostics/terrasse-bois/bois-pourri-humidite.md)
  4. Rénovation ancienne → **amiante** ; abords = Paysagisme. `[C]` → [realiser-ouvrage-paysager-leger](../../../professions/paysagisme/cards/realiser-ouvrage-paysager-leger.md)
- **Points critiques** : bois nourri/protégé (saturateur) ; ventilation maintenue ; lames remplacées ; **amiante** (rénovation) ; abords = Paysagisme.
- **Sécurité** : produits (saturateur/dégrisant) ; manutention ; amiante (rénovation). **Outils électroportatifs / découpe** : scie circulaire/sauteuse, visseuse — **coupures**, projections → lunettes/gants, capot/guide ; **poussières de bois cancérogènes** (surtout exotiques/composite) → aspiration/masque. **Manutention** (lames, lambourdes, plots, colis lourds) : binôme/moyens — dos/écrasement ; **échardes** (bois brut). **Repérage des réseaux avant ancrage/terrassement** (**DT-DICT**) : scellement de plots, fixations dans dalle → ne pas percer un câble/tuyau. **Terrasse surélevée** : **garde-corps** (métier concerné) et risque de chute pendant la pose. **Glissance** (bois humide) ; intempéries. **Risques électriques** : un éventuel **éclairage intégré** (spots LED) → **raccordement réservé à un électricien** (interface). **Amiante** (rénovation, ancien support/revêtement) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-poseur-terrasse-bois](../../../kits/terrasse-bois/kit-poseur-terrasse-bois.md)

## Relations & tags
- **Tags** : `metier:terrasse-bois famille:specialises sous-famille:terrasse-bois intervention:entretenir intervention:reparer cluster:entretien cluster:renovation complexite:moyenne type:entretien securite:produits-chimiques relation:paysagisme`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
