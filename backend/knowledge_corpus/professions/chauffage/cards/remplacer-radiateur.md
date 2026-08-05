# Remplacer un radiateur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-radiateur` |
| Titre | Remplacer un radiateur |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:emetteurs` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (geste courant ; dimensionnement à confirmer) |

## Cadrage
- **Objectif** : remplacer un radiateur défectueux/percé par un modèle équivalent en conservant l'équilibre du circuit. `[C]`
- **Résumé** : isoler et vidanger l'émetteur, déposer l'ancien, poser le neuf sur supports, raccorder robinet + té, remettre en eau, purger, contrôler. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — respecter la **puissance** (entraxe/dimensions) pour ne pas déséquilibrer l'installation. `[B]`
- **Pré-requis** : radiateur de remplacement adapté, points d'isolement. `[B]`
- **Difficulté** : `moyenne` `[C]`
- **Temps moyen** : ~1–2 h `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : raccordement, fixation murale, purge/équilibrage. `[C]`

## Ressources
- **Outillage** : `outil:manuel`, niveau, perceuse. `[C]`
- **Matériel** : radiateur, supports, robinet + té de réglage. `[C]`
- **Consommables** : filasse/téflon, chevilles adaptées au mur. `[C]`

## Réalisation
- **Étapes** :
  1. Fermer robinet et té ; vidanger l'ancien radiateur. `[B]`
  2. Déposer l'ancien ; repérer/adapter les supports. `[C]`
  3. Fixer le neuf de **niveau**, à hauteur correcte. `[C]`
  4. Raccorder robinet (départ) et té de réglage (retour), étanchéité. `[B]`
  5. Remettre en eau, **purger**, rétablir la pression. `[C]` → [purger-radiateur](purger-radiateur.md)
  6. Contrôler l'équilibre thermique avec les autres émetteurs. `[C]` → [desembouer-circuit-chauffage](desembouer-circuit-chauffage.md)
- **Contrôles** : `a-checklist` → [controle-avant-saison-chauffe](../../../checklists/chauffage/controle-avant-saison-chauffe.md)
- **Points critiques** : puissance/dimensionnement équivalent ; étanchéité ; rétablir la pression. `[B]`
- **Sécurité** : eau/éléments chauds ; charges (radiateur fonte lourd). `[B]`

## Cadre & suites
- **Normes** : installations de chauffage central — **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir⟧

## Relations & tags
- **Relations** : `cite-carte` (purge, désembouage), `a-checklist`.
- **Tags** : `metier:chauffage famille:fluides sous-famille:emetteurs intervention:remplacer probleme:fuite equipement:radiateur complexite:moyenne type:remplacement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
