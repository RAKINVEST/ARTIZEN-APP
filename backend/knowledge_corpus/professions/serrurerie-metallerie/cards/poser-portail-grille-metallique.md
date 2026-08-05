# Poser un portail / une grille métallique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-portail-grille-metallique` |
| Titre | Poser un portail / une grille métallique |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:metallerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : fabriquer et poser un **portail** ou une **grille** métallique (structure/vantaux/fixations) — sans l'**automatisme**. `[C]`
- **Résumé** : sceller/fixer les **poteaux** ou platines, poser les **vantaux** (battant/coulissant) d'aplomb et de niveau, régler les **gonds/roulettes** et la **fermeture**, protéger contre la corrosion ; la **motorisation** (automatisme, raccordement électrique) est une **activité distincte** (Automatismes-portails) et le raccordement relève de l'**Électricité** — non traités ici. `[C]` ⟦type/dimensions selon portail à confirmer⟧

## Réalisation
- **Étapes** :
  1. Sceller/fixer poteaux ou platines (réseaux repérés). `[C]`
  2. Poser les **vantaux** d'aplomb ; régler gonds/fermeture. `[C]` → [portail-grince-affaisse](../../../diagnostics/serrurerie-metallerie/portail-grince-affaisse.md)
  3. Protéger contre la corrosion. `[C]`
  4. **Motorisation** = Automatismes / raccordement = **Électricité** (interfaces). `[C]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
- **Points critiques** : aplomb/niveau des vantaux ; gonds/fermeture réglés ; anti-corrosion ; **automatisme = métier distinct** ; élec = interface.
- **Sécurité** : manutention lourde (vantaux) ; **cisaillement/écrasement** (portail) ; scellement (réseaux). **Manutention des ouvrages lourds** (portails, grilles, escaliers, garde-corps métalliques) : binôme/levage — écrasement/dos. **Découpe / meulage / perçage** : **projections** incandescentes et particules → lunettes/écran, gants, aspiration ; disque adapté/capot. **Soudage** : **risque incendie** (permis de feu, extincteur, éloigner les combustibles), **fumées** (ventilation/aspiration), **rayonnement** (masque/écran, protection des tiers), électrisation. **Travail en hauteur** (garde-corps, verrières, ouvrages en façade) : échafaudage/harnais. **Pincement / cisaillement / écrasement** (ouvrants, portails, éléments mobiles). **Repérage des réseaux avant percement/scellement**. **Risques électriques** : un éventuel **raccordement électrique** (gâche/serrure électrique) est **réservé à un électricien** → voir Électricité (le **verrouillage mécanique** n'est **pas** du **contrôle d'accès**). **Amiante** (ouvrages anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Automatisme** (activité distincte) : `renvoie-vers` [principe-serrurerie-metallerie](principe-serrurerie-metallerie.md)

## Relations & tags
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:metallerie intervention:realiser cluster:portail cluster:grille complexite:avancee type:installation securite:ecrasement relation:automatismes-portails relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
