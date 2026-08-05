# Désembouer un circuit de chauffage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `desembouer-circuit-chauffage` |
| Titre | Désembouer un circuit de chauffage |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:reseau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (procédé courant ; produits/durées à confirmer) |

## Cadrage
- **Objectif** : éliminer les boues (oxydes) d'un circuit pour rétablir la circulation, le rendement et protéger les organes (circulateur, échangeur). `[C]`
- **Résumé** : injecter un désembouant, faire circuler, rincer le circuit, puis protéger par un inhibiteur ; poser un pot/filtre magnétique en préventif. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — désembouage chimique vs hydrodynamique selon état ; respecter les préconisations produit. `[D]`
- **Pré-requis** : points de remplissage/vidange accessibles, compatibilité produit/installation. `[C]`
- **Difficulté** : `moyenne` à `avancee` `[C]`
- **Temps moyen** : ~2–4 h (hors temps de circulation) `[D]` ⟦à confirmer⟧
- **Compétences nécessaires** : traitement d'eau de chauffage, rinçage. `[C]`

## Ressources
- **Outillage** : `outil:manuel`, pompe de désembouage selon méthode. `[C]`
- **Matériel** : désembouant + inhibiteur ; pot à boue / filtre magnétique. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-desembouage](../../../kits/chauffage/kit-desembouage.md)

## Réalisation
- **Étapes** :
  1. Isoler la chaudière selon préconisation, protéger les organes sensibles. `[C]`
  2. Introduire le **désembouant**, faire circuler (durée selon produit). `[C]`
  3. **Rincer** le circuit jusqu'à eau claire. `[C]`
  4. Introduire l'**inhibiteur** de protection. `[C]`
  5. Poser/vérifier le **filtre magnétique** en préventif. `[C]`
  6. Remettre en eau, purger, contrôler pression et températures. `[B]` → [mise-en-service-chauffage](../../../procedures/chauffage/mise-en-service-chauffage.md)
- **Contrôles** : écart départ/retour cohérent, radiateurs chauds uniformément. `[C]`
- **Points critiques** : compatibilité produit/matériaux ; rinçage **complet** ; protection après traitement. `[C]`
- **Sécurité** : produits chimiques — EPI, ventilation, fiche de données de sécurité ; eau chaude. `[B]`

## Cadre & suites
- **Normes** : installations de chauffage central — **DTU 65.11** ; traitement d'eau `[B]` ⟦références exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [radiateur-froid-bas](../../../diagnostics/chauffage/radiateur-froid-bas.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir⟧

## Relations & tags
- **Relations** : `utilise-kit`, `traite-diagnostic`, `cite-procedure`.
- **Tags** : `metier:chauffage famille:fluides sous-famille:reseau intervention:entretenir intervention:nettoyer probleme:boue probleme:embouage equipement:circuit equipement:radiateur complexite:avancee type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
