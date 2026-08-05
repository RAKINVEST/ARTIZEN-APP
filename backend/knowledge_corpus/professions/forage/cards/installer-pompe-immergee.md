# Installer une pompe immergée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-pompe-immergee` |
| Titre | Installer une pompe immergée |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer une **pompe immergée** dans un forage/puits, avec alimentation électrique réalisée par un professionnel. `[C]`
- **Résumé** : choisir la pompe selon le **débit exploitable** et la **HMT**, la descendre à la profondeur d'immersion voulue (au-dessus de la crépine), raccorder la colonne d'exhaure et le câble, et faire réaliser l'**alimentation électrique** (protection/coffret) par un professionnel. `[C]` ⟦débit/HMT/immersion selon essai à confirmer⟧

## Réalisation
- **Étapes** :
  1. Dimensionner (débit exploitable/**HMT**) d'après l'essai. `[C]` → [realiser-essai-debit](realiser-essai-debit.md)
  2. Descendre la pompe à la bonne **immersion** ; colonne d'exhaure. `[C]`
  3. **Alimentation électrique** (coffret/protection) = **professionnel**. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  4. Raccorder au réseau d'eau (surpresseur/réservoir). `[C]` → [controler-etancheite-reseau](../../../professions/plomberie/cards/controler-etancheite-reseau.md)
- **Points critiques** : dimensionnement (débit/HMT) ; immersion correcte (ne pas désamorcer) ; **électricité réservée** (protection différentielle).
- **Sécurité** : électricité (pompe immergée) ; levage ; chute (ouvrage ouvert). **Puits / forage ouvert** : **risque de chute** (protéger/couvrir l'ouvrage) et d'**effondrement des parois** (tubage/soutènement). **Espace confiné** (puits traditionnel) : gaz / manque d'oxygène → **jamais de descente sans procédure** (détection, ventilation, surveillant, treuil). **Contamination de la nappe / pollution** : **protection sanitaire** de la tête, **cimentation annulaire**, ne jamais mettre deux nappes en communication ; **désinfection** après travaux. **Réseaux enterrés** (DICT). **Électricité des pompes immergées** : raccordement **réservé** à un professionnel. **Levage** (matériel/pompe lourds). **Qualité de l'eau** : analyse avant usage. **Arrêt immédiat en cas de danger.** Le forage est une opération **réglementée réservée à une entreprise qualifiée** (foreur).** `[A]`

## Cadre & suites
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Baisse de débit** : `traite-diagnostic` → [baisse-debit-forage](../../../diagnostics/forage/baisse-debit-forage.md)

## Relations & tags
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage intervention:poser cluster:pompes-immergees complexite:avancee type:installation securite:electrique relation:electricite-generale relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
