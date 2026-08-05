# Étudier le support et implanter (pente, drainage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `etudier-support-implanter` |
| Titre | Étudier le support et implanter (pente, drainage) |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:terrasse-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : étudier le **support** et implanter la terrasse avec **pente**, **drainage** et **ventilation** de sous-face. `[C]`
- **Résumé** : vérifier la nature et la portance du **support** (dalle béton, sol stabilisé, plots sur géotextile), contrôler/créer la **pente** d'écoulement (~1–2 %), assurer le **drainage** et surtout la **ventilation** de sous-face (l'eau et le manque d'air pourrissent le bois), repérer les **réseaux** avant tout ancrage/terrassement ; la **dalle** relève de la **Maçonnerie**, le terrassement du **Terrassement**. `[C]` ⟦pente/support selon DTU 51.4 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier support/portance ; **pente** (≈ 1–2 %). `[C]`
  2. Assurer **drainage + ventilation** de sous-face. `[A]` → [bois-pourri-humidite](../../../diagnostics/terrasse-bois/bois-pourri-humidite.md)
  3. **DT-DICT / réseaux** avant ancrage/terrassement. `[A]` → [terrasser-reseaux-dict](../../../professions/terrassement/cards/terrasser-reseaux-dict.md)
  4. **Dalle** support = Maçonnerie (frontière). `[C]` → [sceller-fixer-maconnerie](../../../professions/maconnerie/cards/sceller-fixer-maconnerie.md)
- **Points critiques** : **pente/drainage/ventilation** (durée de vie du bois) ; support portant ; **DICT** avant ancrage ; frontière maçonnerie.
- **Sécurité** : réseaux (ancrage) ; manutention ; — **Outils électroportatifs / découpe** : scie circulaire/sauteuse, visseuse — **coupures**, projections → lunettes/gants, capot/guide ; **poussières de bois cancérogènes** (surtout exotiques/composite) → aspiration/masque. **Manutention** (lames, lambourdes, plots, colis lourds) : binôme/moyens — dos/écrasement ; **échardes** (bois brut). **Repérage des réseaux avant ancrage/terrassement** (**DT-DICT**) : scellement de plots, fixations dans dalle → ne pas percer un câble/tuyau. **Terrasse surélevée** : **garde-corps** (métier concerné) et risque de chute pendant la pose. **Glissance** (bois humide) ; intempéries. **Risques électriques** : un éventuel **éclairage intégré** (spots LED) → **raccordement réservé à un électricien** (interface). **Amiante** (rénovation, ancien support/revêtement) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Structure (plots/lambourdes)** : `cite-carte` → [poser-plots-lambourdes-solives](poser-plots-lambourdes-solives.md)

## Relations & tags
- **Tags** : `metier:terrasse-bois famille:specialises sous-famille:terrasse-bois intervention:comprendre cluster:support cluster:pente cluster:drainage complexite:moyenne type:conception securite:reseaux relation:maconnerie relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
