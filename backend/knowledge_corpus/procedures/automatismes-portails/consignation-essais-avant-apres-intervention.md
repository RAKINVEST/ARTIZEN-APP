# Consignation avant, essais & mesure d'effort après intervention

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `consignation-essais-avant-apres-intervention` |
| Titre | Consignation avant, essais & mesure d'effort après intervention |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Encadrer toute intervention sur un portail motorisé (machine) : **consignation avant**, **essais après** — sans raccordement réglementé ni retrait d'amiante. `[A]`

## Étapes
1. **Consignation** : couper et **condamner** l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. `[A]`
2. **Déverrouillage manuel de secours** connu et fonctionnel (personne bloquée, coupure). `[A]`
3. **Réseaux/gaines** avant terrassement = **interface** Terrassement. `[A]` → [realiser-fouille-tranchee](../../professions/terrassement/cards/realiser-fouille-tranchee.md)
4. **Raccordement électrique** = **interface** Électricité (jamais réalisé ici). `[A]`
5. **Essais après intervention** : cellules, bords sensibles, **mesure d'effort** (EN 12445), déverrouillage ; consigner. `[A]`
6. Ouvrages **anciens** : **diagnostic amiante** ; suspect → **arrêt**, retrait = **certifié**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [regler-essayer-motorisation](../../professions/automatismes-portails/cards/regler-essayer-motorisation.md).
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:securite intervention:securiser cluster:securite cluster:essais type:procedure securite:ecrasement securite:amiante relation:desamiantage relation:terrassement relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
