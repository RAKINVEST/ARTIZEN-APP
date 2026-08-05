# Poser un WC (cuvette à poser)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-wc` |
| Titre | Poser un WC (cuvette à poser) |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:sanitaire` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (geste courant ; raccord d'évacuation à confirmer) |

## Cadrage
- **Objectif** : installer une cuvette WC à poser, raccordée à l'évacuation et à l'alimentation, sans fuite ni odeur. `[C]`
- **Résumé** : positionner la cuvette sur la pipe d'évacuation, fixer au sol, raccorder l'alimentation via robinet d'arrêt, monter le réservoir/mécanisme, remettre en eau et contrôler. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — pipe rigide ou souple selon configuration ; sortie horizontale/verticale. `[C]`
- **Pré-requis** : évacuation Ø100 et arrivée EF avec robinet d'arrêt. `[B]`
- **Difficulté** : `moyenne` `[C]`
- **Temps moyen** : ~1–2 h `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : raccordement évacuation + alimentation, fixation, étanchéité. `[C]`

## Ressources
- **Outillage** : `outil:manuel`, perceuse, niveau. `[C]`
- **Matériel** : cuvette + réservoir, pipe d'évacuation, joint, robinet d'arrêt. `[C]`
- **Consommables** : silicone sanitaire, chevilles, téflon. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-wc](../../../kits/plomberie/kit-wc.md)

## Réalisation
- **Étapes** :
  1. Couper l'eau ; positionner la cuvette et **repérer** évacuation + fixations. `[C]` → [consignation-eau](../../../procedures/plomberie/consignation-eau.md)
  2. Emboîter la pipe d'évacuation (joint à lèvre), présenter la cuvette. `[C]`
  3. Fixer la cuvette au sol (chevilles adaptées), de niveau. `[C]`
  4. Monter le réservoir et le **mécanisme de chasse**. `[C]` → [remplacer-mecanisme-chasse](remplacer-mecanisme-chasse.md)
  5. Raccorder l'alimentation via le robinet d'arrêt ; téflon si nécessaire. `[C]`
  6. Remettre en eau, régler le flotteur, **contrôler** l'étanchéité et l'évacuation. `[C]` → [controle-mise-en-eau](../../../checklists/plomberie/controle-mise-en-eau.md)
  7. Réaliser un joint silicone au pied (hygiène), en laissant un témoin de fuite. `[C]` ⟦usage à valider⟧
- **Contrôles** : double chasse, absence de fuite réservoir/pipe. `[C]`
- **Points critiques** : étanchéité de la **pipe** (odeurs/fuites) ; ne pas fissurer la céramique au serrage. `[C]`
- **Sécurité** : charges, postures ; eau coupée avant dépose. `[C]`

## Cadre & suites
- **Normes** : installation sanitaire / évacuation — **DTU 60.1** ; évacuations **DTU 60.33** le cas échéant `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Garantie** : `cite-phrase` → [garantie-piece-main-oeuvre](../../../phrases/plomberie/garantie-piece-main-oeuvre.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir⟧

## Langage & réutilisation
- **FAQ** : « Faut-il siliconer tout le tour ? » — laisser un **témoin** à l'arrière pour détecter une fuite. `[C]` ⟦à valider⟧

## Relations & tags
- **Relations** : `utilise-kit`, `cite-carte`, `a-checklist`, `cite-procedure`, `cite-phrase`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:sanitaire intervention:installer intervention:poser equipement:wc piece:wc complexite:moyenne type:installation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
