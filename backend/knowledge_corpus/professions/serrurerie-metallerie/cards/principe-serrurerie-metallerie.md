# Principe de la serrurerie / métallerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-serrurerie-metallerie` |
| Titre | Principe de la serrurerie / métallerie |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:serrurerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : distinguer et articuler les deux volets : **serrurerie** (verrouillage mécanique) et **métallerie** (ouvrages métalliques). `[C]`
- **Résumé** : le métier couvre la **serrurerie** — serrures, cylindres, verrous, points de fermeture, blindage, dépannage — et la **métallerie** — fabrication et pose d'ouvrages en acier/alu (garde-corps, escaliers, portails, grilles, verrières) par **découpe/soudage/assemblage** ; le **verrouillage mécanique** n'est **pas** du **contrôle d'accès** (électronique), la **ferronnerie d'art**, les **automatismes** et la **vitrerie** sont des métiers distincts. `[C]` ⟦périmètre selon entreprise à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Serrurerie** : poser/remplacer serrures et verrous. `[C]` → [poser-serrure-verrou](poser-serrure-verrou.md)
  2. **Métallerie** : fabriquer un ouvrage (soudage). `[C]` → [fabriquer-ouvrage-metallique](fabriquer-ouvrage-metallique.md)
  3. **Verrouillage ≠ contrôle d'accès** (électronique). `[C]` → [poser-organe-verrouillage](../../../professions/controle-acces/cards/poser-organe-verrouillage.md)
  4. **Diagnostic / entretien**. `[C]` → [entretenir-diagnostiquer-serrurerie-metallerie](entretenir-diagnostiquer-serrurerie-metallerie.md)
- **Points critiques** : frontières nettes (contrôle d'accès / ferronnerie / automatismes / vitrerie) ; sécurité soudage/manutention ; élec = interface.
- **Sécurité** : manutention lourde ; soudage/incendie ; hauteur. **Manutention des ouvrages lourds** (portails, grilles, escaliers, garde-corps métalliques) : binôme/levage — écrasement/dos. **Découpe / meulage / perçage** : **projections** incandescentes et particules → lunettes/écran, gants, aspiration ; disque adapté/capot. **Soudage** : **risque incendie** (permis de feu, extincteur, éloigner les combustibles), **fumées** (ventilation/aspiration), **rayonnement** (masque/écran, protection des tiers), électrisation. **Travail en hauteur** (garde-corps, verrières, ouvrages en façade) : échafaudage/harnais. **Pincement / cisaillement / écrasement** (ouvrants, portails, éléments mobiles). **Repérage des réseaux avant percement/scellement**. **Risques électriques** : un éventuel **raccordement électrique** (gâche/serrure électrique) est **réservé à un électricien** → voir Électricité (le **verrouillage mécanique** n'est **pas** du **contrôle d'accès**). **Amiante** (ouvrages anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurisation anti-effraction** : `cite-carte` → [blinder-securiser-ouverture](blinder-securiser-ouverture.md)

## Relations & tags
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:serrurerie intervention:comprendre cluster:serrurerie cluster:metallerie cluster:verrouillage type:principe securite:manutention relation:controle-acces relation:ferronnerie relation:automatismes-portails relation:vitrerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
