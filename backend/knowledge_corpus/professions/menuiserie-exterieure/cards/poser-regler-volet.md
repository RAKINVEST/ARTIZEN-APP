# Poser / régler un volet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-regler-volet` |
| Titre | Poser / régler un volet |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser ou régler un volet (battant, roulant, persienne) — la **motorisation** éventuelle relève de l'électricité. `[C]`
- **Résumé** : poser/régler le volet selon son type (**battant** : gonds/arrêts ; **roulant** : coulisses/tablier/lame finale ; **persienne**), assurer manœuvre et fins de course ; tout **raccordement électrique** d'une motorisation est **réservé à un professionnel** (fermetures : **DTU 34.1**). `[C]` ⟦modèle/motorisation selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Identifier le type (battant / **roulant** / persienne). `[C]`
  2. Poser/fixer (gonds & arrêts, ou coulisses & caisson). `[C]`
  3. Régler manœuvre et **fins de course** (roulant). `[C]`
  4. **Motorisation** : raccordement électrique **réservé** → Électricité. `[C]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
- **Points critiques** : manœuvre sans point dur ; fins de course réglées ; **motorisation = raccordement réservé électricité** (jamais improvisé).
- **Sécurité** : manutention (tablier lourd) ; hauteur ; électricité (motorisation → pro). **Manutention** de menuiseries/**vitrages lourds** : risque d'écrasement / **coupure** (verre) — moyens de levage, gants anti-coupure, travail en binôme. **Travail en **hauteur** (baies d'étage, dépose) : protections collectives / EPI. **Produits** (mousse PU, mastics, solvants) : EPI / ventilation. **Motorisation de volet** : le **raccordement électrique** relève d'un professionnel (voir Électricité). **Stabilité** du support/de la baie vérifiée avant dépose. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic** : `traite-diagnostic` → [ouvrant-force-deregle](../../../diagnostics/menuiserie-exterieure/ouvrant-force-deregle.md)

## Relations & tags
- **Tags** : `metier:menuiserie-exterieure equipement:volet famille:enveloppe sous-famille:menuiserie-exterieure intervention:poser intervention:regler cluster:volets cluster:reglages complexite:moyenne type:installation securite:manutention relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
