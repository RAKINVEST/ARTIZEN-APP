# Gérer les eaux pluviales et le drainage paysager

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gerer-eaux-drainage-paysager` |
| Titre | Gérer les eaux pluviales et le drainage paysager |
| Profession | `metier:paysagisme` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:paysagisme` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : gérer les **eaux pluviales** et le **drainage** à l'échelle du jardin (noues, drains, infiltration). `[B]`
- **Résumé** : évaluer les écoulements et la perméabilité, créer des **noues** végétalisées, des **drains** agricoles, des zones d'**infiltration**/jardins de pluie et des pentes douces pour éviter l'engorgement et le ruissellement, en privilégiant l'infiltration à la parcelle ; le **réseau enterré d'eaux pluviales** (collecteur, regard, raccordement) relève du **VRD**. `[B]` ⟦dimensionnement/infiltration selon sol à confirmer⟧

## Réalisation
- **Étapes** :
  1. Évaluer écoulements/perméabilité. `[C]` → [sol-engorge-ruissellement](../../../diagnostics/paysagisme/sol-engorge-ruissellement.md)
  2. Créer **noues / drains / infiltration** (pentes douces). `[B]` → [gerer-eaux-drainage-talus](../../../professions/terrassement/cards/gerer-eaux-drainage-talus.md)
  3. Privilégier l'**infiltration à la parcelle**. `[C]`
  4. **Réseau EP enterré** = VRD (frontière). `[C]` → [poser-reseau-humide](../../../professions/vrd/cards/poser-reseau-humide.md)
- **Points critiques** : infiltration privilégiée ; pentes/noues efficaces ; **réseau EP enterré = VRD** ; pas d'engorgement.
- **Sécurité** : terrassement léger (réseaux) ; manutention ; — **Outils motorisés** : **tronçonneuse** (rebond / coupures graves → EPI anti-coupure : pantalon, gants, casque écran, chaussures), **débroussailleuse** (projections → écran, périmètre de sécurité), tondeuses/broyeurs (happement) — formation/EPI adaptés. **Produits phytosanitaires** : usage **réglementé** (**Certiphyto**, zones de non-traitement **ZNT**, protection de l'eau) → privilégier les alternatives ; EPI, stockage, jamais à proximité de l'eau. **Terrassements légers** : repérer les **réseaux** avant de creuser (DICT si concerné), effondrement des petites fouilles. **Travaux en hauteur** (élagage/taille haute) : nacelle/cordes = **métiers spécialisés** (élagueur/cordiste). **Manutention** (végétaux, mottes, dalles, sacs) : binôme/moyens. **Biodiversité** : respecter les **périodes de taille** (nidification) et les espèces protégées. **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : petits ouvrages maçonnés / soutènements légers (**interface** maçonnerie) **DTU 20.1** ; évacuation / gestion des **eaux pluviales** (**interface**) **DTU 60.11** ; **Règles professionnelles des travaux du paysage** (UNEP/QUALIPAYSAGE), supports de culture **NF U44-551**, réglementation **phytosanitaire** (Certiphyto, ZNT) et **périodes de taille** (Code de l'environnement, nidification) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Ouvrage paysager léger** : `cite-carte` → [realiser-ouvrage-paysager-leger](realiser-ouvrage-paysager-leger.md)

## Relations & tags
- **Tags** : `metier:paysagisme famille:specialises sous-famille:paysagisme intervention:realiser cluster:drainage cluster:eaux-pluviales complexite:avancee type:installation securite:outils-motorises relation:terrassement relation:vrd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
