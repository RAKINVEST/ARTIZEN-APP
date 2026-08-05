# Poser une serrure / un verrou

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-serrure-verrou` |
| Titre | Poser une serrure / un verrou |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:serrurerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser/remplacer une **serrure**, un **cylindre**, un **verrou** ou un **multipoints** (verrouillage mécanique). `[C]`
- **Résumé** : choisir la **serrure** adaptée (encastrée/applique, multipoints), poser le **cylindre** (éventuel **organigramme** de clés), régler la **gâche** et les **points de fermeture**, vérifier le fonctionnement de la clé et la fermeture de l'ouvrant ; un éventuel **verrouillage électrique** (gâche/serrure électrique) relève du **contrôle d'accès / Électricité** (interfaces), non traité ici. `[C]` ⟦modèle/organigramme selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir la serrure (encastrée/applique/multipoints). `[C]`
  2. Poser cylindre (organigramme) ; régler gâche/points. `[C]` → [serrure-bloquee-grippee](../../../diagnostics/serrurerie-metallerie/serrure-bloquee-grippee.md)
  3. Vérifier clé / fermeture de l'ouvrant. `[C]`
  4. Verrouillage **électrique** = contrôle d'accès (frontière). `[C]` → [poser-organe-verrouillage](../../../professions/controle-acces/cards/poser-organe-verrouillage.md)
- **Points critiques** : serrure/cylindre adaptés ; **organigramme** maîtrisé ; gâche/points réglés ; **électronique = frontière** (contrôle d'accès).
- **Sécurité** : pincement (ouvrant) ; — ; — **Manutention des ouvrages lourds** (portails, grilles, escaliers, garde-corps métalliques) : binôme/levage — écrasement/dos. **Découpe / meulage / perçage** : **projections** incandescentes et particules → lunettes/écran, gants, aspiration ; disque adapté/capot. **Soudage** : **risque incendie** (permis de feu, extincteur, éloigner les combustibles), **fumées** (ventilation/aspiration), **rayonnement** (masque/écran, protection des tiers), électrisation. **Travail en hauteur** (garde-corps, verrières, ouvrages en façade) : échafaudage/harnais. **Pincement / cisaillement / écrasement** (ouvrants, portails, éléments mobiles). **Repérage des réseaux avant percement/scellement**. **Risques électriques** : un éventuel **raccordement électrique** (gâche/serrure électrique) est **réservé à un électricien** → voir Électricité (le **verrouillage mécanique** n'est **pas** du **contrôle d'accès**). **Amiante** (ouvrages anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Blindage / anti-effraction** : `cite-carte` → [blinder-securiser-ouverture](blinder-securiser-ouverture.md)

## Relations & tags
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:serrurerie intervention:realiser cluster:serrurerie cluster:verrouillage cluster:organigramme complexite:moyenne type:installation securite:manutention relation:controle-acces`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
