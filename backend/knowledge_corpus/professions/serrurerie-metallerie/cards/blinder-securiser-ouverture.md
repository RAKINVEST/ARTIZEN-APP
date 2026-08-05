# Blinder et sécuriser une ouverture (anti-effraction)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `blinder-securiser-ouverture` |
| Titre | Blinder et sécuriser une ouverture (anti-effraction) |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:serrurerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : renforcer une ouverture contre l'**effraction** (porte blindée, blindage, serrure **multipoints certifiée**). `[B]`
- **Résumé** : évaluer le niveau de protection recherché, poser un **bloc-porte blindé** ou **blinder** une porte existante (cornières, tôle), équiper d'une **serrure multipoints** et d'un cylindre de sûreté (certification **A2P**/EN 1627 — classes de résistance), soigner les **paumées anti-dégondage** et la fixation dans le bâti ; une éventuelle **gâche électrique** = raccordement **Électricité** (interface). `[B]` ⟦classe A2P/EN 1627 selon besoin à confirmer⟧

## Réalisation
- **Étapes** :
  1. Évaluer le niveau (classe de résistance). `[B]`
  2. Poser bloc-porte blindé / blinder l'existant. `[C]`
  3. Équiper multipoints + cylindre de sûreté (**A2P**). `[B]`
  4. Éventuelle **gâche électrique** = **Électricité** (interface). `[C]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
- **Points critiques** : niveau de résistance cohérent (A2P/EN 1627) ; fixation dans le bâti ; anti-dégondage ; issues de secours respectées.
- **Sécurité** : manutention (bloc-porte lourd) ; pincement ; électrique (interface). **Manutention des ouvrages lourds** (portails, grilles, escaliers, garde-corps métalliques) : binôme/levage — écrasement/dos. **Découpe / meulage / perçage** : **projections** incandescentes et particules → lunettes/écran, gants, aspiration ; disque adapté/capot. **Soudage** : **risque incendie** (permis de feu, extincteur, éloigner les combustibles), **fumées** (ventilation/aspiration), **rayonnement** (masque/écran, protection des tiers), électrisation. **Travail en hauteur** (garde-corps, verrières, ouvrages en façade) : échafaudage/harnais. **Pincement / cisaillement / écrasement** (ouvrants, portails, éléments mobiles). **Repérage des réseaux avant percement/scellement**. **Risques électriques** : un éventuel **raccordement électrique** (gâche/serrure électrique) est **réservé à un électricien** → voir Électricité (le **verrouillage mécanique** n'est **pas** du **contrôle d'accès**). **Amiante** (ouvrages anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Issue de secours** (frontière) : `renvoie-vers` → [raccorder-securite-incendie-sortie](../../../professions/controle-acces/cards/raccorder-securite-incendie-sortie.md)

## Relations & tags
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:serrurerie intervention:securiser cluster:anti-effraction cluster:blindage complexite:avancee type:installation securite:manutention relation:controle-acces relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
