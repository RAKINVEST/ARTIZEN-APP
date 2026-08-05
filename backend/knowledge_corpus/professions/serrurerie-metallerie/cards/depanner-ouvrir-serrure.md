# Dépanner et ouvrir une serrure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `depanner-ouvrir-serrure` |
| Titre | Dépanner et ouvrir une serrure |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:serrurerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : dépanner une serrure (blocage, clé cassée) et réaliser une **ouverture** non destructive quand c'est possible. `[C]`
- **Résumé** : diagnostiquer le blocage (mécanisme, cylindre, clé cassée, porte claquée), privilégier une **ouverture fine** (non destructive) puis, si nécessaire, une ouverture destructive limitée, remplacer l'organe défectueux et reproduire la **clé** ; **vérifier la légitimité** du demandeur (occupant/propriétaire) avant toute intervention. `[C]` ⟦méthode selon serrure à confirmer⟧

## Réalisation
- **Étapes** :
  1. Diagnostiquer le blocage (mécanisme/clé). `[C]` → [serrure-bloquee-grippee](../../../diagnostics/serrurerie-metallerie/serrure-bloquee-grippee.md)
  2. **Vérifier la légitimité** du demandeur. `[C]`
  3. Ouvrir (non destructif si possible) ; remplacer l'organe. `[C]` → [poser-serrure-verrou](poser-serrure-verrou.md)
  4. Reproduire la clé / rétablir le verrouillage. `[C]`
- **Points critiques** : **légitimité** vérifiée (déontologie) ; ouverture la moins destructive ; organe remplacé ; verrouillage rétabli.
- **Sécurité** : — ; pincement ; — **Manutention des ouvrages lourds** (portails, grilles, escaliers, garde-corps métalliques) : binôme/levage — écrasement/dos. **Découpe / meulage / perçage** : **projections** incandescentes et particules → lunettes/écran, gants, aspiration ; disque adapté/capot. **Soudage** : **risque incendie** (permis de feu, extincteur, éloigner les combustibles), **fumées** (ventilation/aspiration), **rayonnement** (masque/écran, protection des tiers), électrisation. **Travail en hauteur** (garde-corps, verrières, ouvrages en façade) : échafaudage/harnais. **Pincement / cisaillement / écrasement** (ouvrants, portails, éléments mobiles). **Repérage des réseaux avant percement/scellement**. **Risques électriques** : un éventuel **raccordement électrique** (gâche/serrure électrique) est **réservé à un électricien** → voir Électricité (le **verrouillage mécanique** n'est **pas** du **contrôle d'accès**). **Amiante** (ouvrages anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-diagnostiquer-serrurerie-metallerie](entretenir-diagnostiquer-serrurerie-metallerie.md)

## Relations & tags
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:serrurerie intervention:reparer cluster:depannage cluster:ouverture complexite:moyenne type:depannage securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
