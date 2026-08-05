# Analyser le terrain et implanter le projet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `analyser-terrain-implanter` |
| Titre | Analyser le terrain et implanter le projet |
| Profession | `metier:paysagisme` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:paysagisme` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : analyser le terrain (sol, exposition, eau, réseaux) et **implanter** le plan de plantation. `[C]`
- **Résumé** : étudier la **nature du sol** (texture, pH, compaction, drainage), l'**exposition** et le climat, repérer les **réseaux** (DICT si travaux de terrassement), puis **implanter** le projet (plan de plantation, cheminements, zones) en tenant compte du développement adulte des végétaux ; un **terrassement lourd** éventuel relève du **Terrassement**. `[C]` ⟦analyse de sol/exposition selon site à confirmer⟧

## Réalisation
- **Étapes** :
  1. Étudier **sol** (texture/pH/drainage) et exposition. `[C]` → [sol-engorge-ruissellement](../../../diagnostics/paysagisme/sol-engorge-ruissellement.md)
  2. **Repérer les réseaux** (DICT si terrassement). `[A]` → [terrasser-reseaux-dict](../../../professions/terrassement/cards/terrasser-reseaux-dict.md)
  3. Implanter le plan (développement adulte). `[C]`
  4. Terrassement **lourd** = Terrassement (frontière). `[C]` → [preparer-ameliorer-sol](preparer-ameliorer-sol.md)
- **Points critiques** : sol compris (drainage) ; **réseaux repérés** ; développement adulte anticipé ; terrassement lourd = métier distinct.
- **Sécurité** : réseaux (terrassement) ; — ; — **Outils motorisés** : **tronçonneuse** (rebond / coupures graves → EPI anti-coupure : pantalon, gants, casque écran, chaussures), **débroussailleuse** (projections → écran, périmètre de sécurité), tondeuses/broyeurs (happement) — formation/EPI adaptés. **Produits phytosanitaires** : usage **réglementé** (**Certiphyto**, zones de non-traitement **ZNT**, protection de l'eau) → privilégier les alternatives ; EPI, stockage, jamais à proximité de l'eau. **Terrassements légers** : repérer les **réseaux** avant de creuser (DICT si concerné), effondrement des petites fouilles. **Travaux en hauteur** (élagage/taille haute) : nacelle/cordes = **métiers spécialisés** (élagueur/cordiste). **Manutention** (végétaux, mottes, dalles, sacs) : binôme/moyens. **Biodiversité** : respecter les **périodes de taille** (nidification) et les espèces protégées. **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : petits ouvrages maçonnés / soutènements légers (**interface** maçonnerie) **DTU 20.1** ; évacuation / gestion des **eaux pluviales** (**interface**) **DTU 60.11** ; **Règles professionnelles des travaux du paysage** (UNEP/QUALIPAYSAGE), supports de culture **NF U44-551**, réglementation **phytosanitaire** (Certiphyto, ZNT) et **périodes de taille** (Code de l'environnement, nidification) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Gestion des eaux** : `cite-carte` → [gerer-eaux-drainage-paysager](gerer-eaux-drainage-paysager.md)

## Relations & tags
- **Tags** : `metier:paysagisme famille:specialises sous-famille:paysagisme intervention:comprendre cluster:analyse-terrain cluster:implantation complexite:moyenne type:conception securite:outils-motorises relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
