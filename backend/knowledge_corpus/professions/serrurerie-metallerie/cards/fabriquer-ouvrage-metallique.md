# Fabriquer un ouvrage métallique (découpe, soudage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fabriquer-ouvrage-metallique` |
| Titre | Fabriquer un ouvrage métallique (découpe, soudage) |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:metallerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : fabriquer un **ouvrage métallique** (acier/alu) : tracé, **découpe**, **soudage**, assemblage et traitement de surface. `[C]`
- **Résumé** : tracer/débiter les profilés, **assembler par soudage** (MIG-MAG/TIG/arc) ou boulonnage, **meuler/ébaver** les cordons, contrôler l'équerrage et les cotes, puis appliquer un **traitement anti-corrosion** (galva/apprêt/thermolaquage) ; le **soudage** impose un **permis de feu** et la protection incendie. `[C]` ⟦procédé/nuances selon ouvrage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tracer / débiter (découpe — projections). `[C]`
  2. **Souder** (permis de feu, protection incendie). `[A]` → [permis-feu-reseaux-avant-travaux-serrurerie](../../../procedures/serrurerie-metallerie/permis-feu-reseaux-avant-travaux-serrurerie.md)
  3. Meuler/ébaver ; contrôler équerrage/cotes. `[C]`
  4. **Traitement anti-corrosion** (galva/apprêt/laquage). `[C]` → [ouvrage-metallique-corrode](../../../diagnostics/serrurerie-metallerie/ouvrage-metallique-corrode.md)
- **Points critiques** : soudures saines ; **permis de feu** ; équerrage/cotes ; **protection anti-corrosion** ; ferronnerie d'art = métier distinct.
- **Sécurité** : **soudage/incendie** ; découpe/meulage (projections) ; fumées. **Manutention des ouvrages lourds** (portails, grilles, escaliers, garde-corps métalliques) : binôme/levage — écrasement/dos. **Découpe / meulage / perçage** : **projections** incandescentes et particules → lunettes/écran, gants, aspiration ; disque adapté/capot. **Soudage** : **risque incendie** (permis de feu, extincteur, éloigner les combustibles), **fumées** (ventilation/aspiration), **rayonnement** (masque/écran, protection des tiers), électrisation. **Travail en hauteur** (garde-corps, verrières, ouvrages en façade) : échafaudage/harnais. **Pincement / cisaillement / écrasement** (ouvrants, portails, éléments mobiles). **Repérage des réseaux avant percement/scellement**. **Risques électriques** : un éventuel **raccordement électrique** (gâche/serrure électrique) est **réservé à un électricien** → voir Électricité (le **verrouillage mécanique** n'est **pas** du **contrôle d'accès**). **Amiante** (ouvrages anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose (garde-corps/escalier)** : `cite-carte` → [poser-garde-corps-escalier](poser-garde-corps-escalier.md)

## Relations & tags
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:metallerie intervention:realiser cluster:metallerie cluster:soudage cluster:traitement-surface complexite:avancee type:fabrication securite:incendie relation:ferronnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
