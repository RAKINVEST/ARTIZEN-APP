# Entretenir / diagnostiquer serrurerie & métallerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-diagnostiquer-serrurerie-metallerie` |
| Titre | Entretenir / diagnostiquer serrurerie & métallerie |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:serrurerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir serrures et ouvrages métalliques, et diagnostiquer les défauts (blocage, corrosion, jeu). `[C]`
- **Résumé** : lubrifier et régler les **serrures**/gonds, contrôler la **fermeture** et les points de sécurité, inspecter la **corrosion** des ouvrages (reprise anti-rouille), vérifier la **tenue** des garde-corps/portails et resserrer les fixations ; en rénovation d'ouvrages anciens, **diagnostic amiante**. `[C]`

## Réalisation
- **Étapes** :
  1. Lubrifier/régler serrures et gonds. `[C]` → [serrure-bloquee-grippee](../../../diagnostics/serrurerie-metallerie/serrure-bloquee-grippee.md)
  2. Inspecter/reprendre la **corrosion**. `[C]` → [ouvrage-metallique-corrode](../../../diagnostics/serrurerie-metallerie/ouvrage-metallique-corrode.md)
  3. Vérifier la **tenue** (garde-corps/portails). `[A]` → [portail-grince-affaisse](../../../diagnostics/serrurerie-metallerie/portail-grince-affaisse.md)
  4. Rénovation ancienne → **diagnostic amiante**. `[C]`
- **Points critiques** : sécurité maintenue (fermeture/anti-chute) ; corrosion traitée ; fixations contrôlées ; **amiante** en rénovation.
- **Sécurité** : manutention ; corrosion (bords coupants) ; amiante (rénovation). **Manutention des ouvrages lourds** (portails, grilles, escaliers, garde-corps métalliques) : binôme/levage — écrasement/dos. **Découpe / meulage / perçage** : **projections** incandescentes et particules → lunettes/écran, gants, aspiration ; disque adapté/capot. **Soudage** : **risque incendie** (permis de feu, extincteur, éloigner les combustibles), **fumées** (ventilation/aspiration), **rayonnement** (masque/écran, protection des tiers), électrisation. **Travail en hauteur** (garde-corps, verrières, ouvrages en façade) : échafaudage/harnais. **Pincement / cisaillement / écrasement** (ouvrants, portails, éléments mobiles). **Repérage des réseaux avant percement/scellement**. **Risques électriques** : un éventuel **raccordement électrique** (gâche/serrure électrique) est **réservé à un électricien** → voir Électricité (le **verrouillage mécanique** n'est **pas** du **contrôle d'accès**). **Amiante** (ouvrages anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-serrurier-metallier](../../../kits/serrurerie-metallerie/kit-serrurier-metallier.md)

## Relations & tags
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:serrurerie intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
