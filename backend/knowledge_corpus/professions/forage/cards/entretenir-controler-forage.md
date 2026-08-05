# Entretenir / contrôler un forage (désinfection, qualité)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-controler-forage` |
| Titre | Entretenir / contrôler un forage (désinfection, qualité) |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir un forage/puits (nettoyage crépine, **désinfection**) et contrôler la **qualité de l'eau**. `[C]`
- **Résumé** : contrôler l'état de la tête/protection sanitaire, nettoyer/développer la **crépine** en cas de colmatage, **désinfecter** l'ouvrage après intervention, et faire **analyser l'eau** (potabilité) avant tout usage alimentaire. `[C]` ⟦protocole de désinfection/analyse à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler tête/**protection sanitaire** (étanchéité). `[C]`
  2. Nettoyer/développer la **crépine** si colmatée. `[C]` → [baisse-debit-forage](../../../diagnostics/forage/baisse-debit-forage.md)
  3. **Désinfecter** l'ouvrage après travaux. `[C]` ⟦produit/dose à confirmer⟧
  4. **Analyse de l'eau** (potabilité) avant usage alimentaire. `[A]`
- **Points critiques** : protection sanitaire maintenue ; désinfection après intervention ; **analyse d'eau** obligatoire avant usage alimentaire.
- **Sécurité** : espace confiné (ne pas descendre) ; biologique ; produits (désinfection). **Puits / forage ouvert** : **risque de chute** (protéger/couvrir l'ouvrage) et d'**effondrement des parois** (tubage/soutènement). **Espace confiné** (puits traditionnel) : gaz / manque d'oxygène → **jamais de descente sans procédure** (détection, ventilation, surveillant, treuil). **Contamination de la nappe / pollution** : **protection sanitaire** de la tête, **cimentation annulaire**, ne jamais mettre deux nappes en communication ; **désinfection** après travaux. **Réseaux enterrés** (DICT). **Électricité des pompes immergées** : raccordement **réservé** à un professionnel. **Levage** (matériel/pompe lourds). **Qualité de l'eau** : analyse avant usage. **Arrêt immédiat en cas de danger.** Le forage est une opération **réglementée réservée à une entreprise qualifiée** (foreur).** `[A]`

## Cadre & suites
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-forage-puits](../../../kits/forage/kit-forage-puits.md)

## Relations & tags
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage intervention:entretenir intervention:controler cluster:entretien cluster:controle cluster:protection-sanitaire complexite:moyenne type:entretien securite:nappe relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
