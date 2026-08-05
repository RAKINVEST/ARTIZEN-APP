# Tailler et entretenir les espaces verts

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `tailler-entretenir-espaces-verts` |
| Titre | Tailler et entretenir les espaces verts |
| Profession | `metier:paysagisme` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:paysagisme` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer la **taille**, l'**entretien** et la **maintenance** des espaces verts dans le respect de la biodiversité. `[C]`
- **Résumé** : tondre et entretenir le **gazon** (scarification, fertilisation, réfection), **tailler** haies et arbustes au bon moment (respect des **périodes de nidification**), désherber (mécaniquement / paillage, **phytosanitaire encadré**), arroser/gérer, et surveiller l'état sanitaire ; la **taille en hauteur** (élagage grimpé) relève d'un **métier spécialisé** (élagueur/cordiste). `[C]` ⟦périodes/fréquences selon végétaux à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tondre/entretenir le gazon (scarif./fertil.). `[C]` → [gazon-degrade-mousse](../../../diagnostics/paysagisme/gazon-degrade-mousse.md)
  2. **Tailler** haies/arbustes (**hors nidification**). `[A]`
  3. Désherber (mécanique/paillage ; **phyto encadré**). `[A]` → [securite-motorises-phytosanitaire-reseaux-paysagisme](../../../procedures/paysagisme/securite-motorises-phytosanitaire-reseaux-paysagisme.md)
  4. **Élagage grimpé** = métier spécialisé (cordiste). `[C]`
- **Points critiques** : **périodes de taille** (biodiversité) ; désherbage raisonné (phyto encadré) ; élagage hauteur = métier distinct.
- **Sécurité** : **tronçonneuse/débroussailleuse** ; **phytosanitaire** ; hauteur (élagage). **Outils motorisés** : **tronçonneuse** (rebond / coupures graves → EPI anti-coupure : pantalon, gants, casque écran, chaussures), **débroussailleuse** (projections → écran, périmètre de sécurité), tondeuses/broyeurs (happement) — formation/EPI adaptés. **Produits phytosanitaires** : usage **réglementé** (**Certiphyto**, zones de non-traitement **ZNT**, protection de l'eau) → privilégier les alternatives ; EPI, stockage, jamais à proximité de l'eau. **Terrassements légers** : repérer les **réseaux** avant de creuser (DICT si concerné), effondrement des petites fouilles. **Travaux en hauteur** (élagage/taille haute) : nacelle/cordes = **métiers spécialisés** (élagueur/cordiste). **Manutention** (végétaux, mottes, dalles, sacs) : binôme/moyens. **Biodiversité** : respecter les **périodes de taille** (nidification) et les espèces protégées. **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : petits ouvrages maçonnés / soutènements légers (**interface** maçonnerie) **DTU 20.1** ; évacuation / gestion des **eaux pluviales** (**interface**) **DTU 60.11** ; **Règles professionnelles des travaux du paysage** (UNEP/QUALIPAYSAGE), supports de culture **NF U44-551**, réglementation **phytosanitaire** (Certiphyto, ZNT) et **périodes de taille** (Code de l'environnement, nidification) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-paysagiste](../../../kits/paysagisme/kit-paysagiste.md)

## Relations & tags
- **Tags** : `metier:paysagisme famille:specialises sous-famille:paysagisme intervention:entretenir intervention:controler cluster:tailles cluster:entretien cluster:maintenance cluster:biodiversite complexite:moyenne type:entretien securite:outils-motorises relation:cordiste`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
