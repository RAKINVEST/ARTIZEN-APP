# Remplacer le mécanisme de chasse d'un WC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-mecanisme-chasse` |
| Titre | Remplacer le mécanisme de chasse d'un WC |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:sanitaire` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (geste courant ; compatibilités à confirmer) |

## Cadrage
- **Objectif** : remplacer un mécanisme de chasse fuyard/défaillant pour arrêter l'écoulement continu et rétablir la chasse. `[C]`
- **Résumé** : couper et vidanger le réservoir, déposer l'ancien mécanisme (et le robinet flotteur si besoin), poser le neuf réglé, remettre en eau et contrôler. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — mécanisme universel simple/double chasse ; vérifier la hauteur/compatibilité réservoir. `[C]`
- **Pré-requis** : robinet d'arrêt du WC fonctionnel. `[C]`
- **Difficulté** : `simple` `[C]`
- **Temps moyen** : ~30–45 min `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : démontage réservoir, réglage niveau d'eau. `[C]`

## Ressources
- **Outillage** : `outil:manuel`. `[C]`
- **Matériel** : mécanisme de chasse (+ joint de réservoir), robinet flotteur si remplacé. `[C]`
- **Consommables** : joints. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-wc](../../../kits/plomberie/kit-wc.md)

## Réalisation
- **Étapes** :
  1. Fermer le robinet d'arrêt, tirer la chasse pour vidanger. `[C]`
  2. Déconnecter l'alimentation ; déposer le réservoir si nécessaire. `[C]`
  3. Retirer l'ancien mécanisme (écrou de fixation + joint). `[C]`
  4. Poser le neuf avec joint neuf, régler la **hauteur** et le volume de chasse. `[C]`
  5. Remettre en eau, régler le flotteur (niveau sous le trop-plein). `[C]`
  6. **Contrôler** : pas d'écoulement continu, chasse franche, étanchéité. `[C]` → [controle-mise-en-eau](../../../checklists/plomberie/controle-mise-en-eau.md)
- **Contrôles** : double chasse fonctionnelle, absence de fuite au joint de réservoir. `[C]`
- **Points critiques** : joint de réservoir bien posé ; niveau d'eau **sous** le trop-plein ; ne pas surserrer. `[C]`
- **Sécurité** : eau coupée ; céramique fragile. `[C]`

## Cadre & suites
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Interventions liées** : `cite-carte` → [poser-wc](poser-wc.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir⟧

## Langage & réutilisation
- **FAQ** : « Ma chasse coule en continu » — souvent le clapet/joint du mécanisme ou le niveau trop haut. `[C]` ⟦à valider⟧

## Relations & tags
- **Relations** : `utilise-kit`, `a-checklist`, `cite-carte`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:sanitaire intervention:remplacer probleme:fuite probleme:ecoulement-continu equipement:wc equipement:chasse piece:wc complexite:simple type:reparation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
