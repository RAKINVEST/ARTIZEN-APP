# Purger un radiateur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `purger-radiateur` |
| Titre | Purger un radiateur |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:emetteurs` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (geste courant ; spécifications à confirmer) |

## Cadrage
- **Objectif** : évacuer l'air d'un radiateur pour rétablir la chauffe (haut froid) et le bon rendement du circuit. `[C]`
- **Résumé** : repérer le purgeur en partie haute, ouvrir doucement avec la clé jusqu'à sortie d'eau franche, refermer, puis **rétablir la pression** du circuit au manomètre. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — la purge se fait circulateur idéalement à l'arrêt pour laisser l'air remonter. `[C]`
- **Pré-requis** : accès au purgeur, récipient/chiffon, manomètre lisible. `[C]`
- **Difficulté** : `simple` `[C]`
- **Temps moyen** : ~5–10 min/radiateur `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : notions de circuit fermé, lecture de pression. `[C]`

## Ressources
- **Outillage** : `outil:manuel` (clé de purge, tournevis plat selon purgeur). `[C]`
- **Matériel** : —
- **Consommables** : chiffon. `[C]`
- **Kit conseillé** : —

## Réalisation
- **Étapes** :
  1. Arrêter le circulateur/chaudière et laisser l'air remonter quelques minutes. `[C]`
  2. Placer un récipient sous le purgeur. `[C]`
  3. Ouvrir le purgeur **doucement** : l'air s'échappe (sifflement). `[C]`
  4. Refermer dès que l'eau coule de façon **franche** (plus d'air). `[C]`
  5. Contrôler la **pression** du circuit et **compléter** si sous le seuil (~1–1,5 bar à froid). `[B]` → [mise-en-service-chauffage](../../../procedures/chauffage/mise-en-service-chauffage.md)
  6. Vérifier que le haut du radiateur chauffe à nouveau. `[C]`
- **Contrôles** : `a-checklist` → [controle-avant-saison-chauffe](../../../checklists/chauffage/controle-avant-saison-chauffe.md)
- **Points critiques** : **rétablir la pression** après purge (sinon manque d'eau, sécurité) ; ne pas vidanger le circuit. `[B]`
- **Sécurité** : eau et éléments **chauds** — laisser refroidir ou opérer prudemment. `[B]`

## Cadre & suites
- **Normes** : sécurité des installations de chauffage central — **DTU 65.11** `[B]` ⟦référence/version exacte à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [radiateur-froid-haut](../../../diagnostics/chauffage/radiateur-froid-haut.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir — terrain, sans donnée personnelle⟧

## Langage & réutilisation
- **FAQ** : « À quelle fréquence purger ? » — en début de saison et si un radiateur chauffe mal en haut. `[C]` ⟦à valider⟧

## Relations & tags
- **Relations** : `traite-diagnostic`, `a-checklist`, `cite-procedure`.
- **Tags** : `metier:chauffage famille:fluides sous-famille:emetteurs intervention:entretenir intervention:purger probleme:air probleme:radiateur-froid equipement:radiateur complexite:simple type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
