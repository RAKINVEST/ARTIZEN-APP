# Reboucher / abandonner un forage ou un puits

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reboucher-abandonner-forage` |
| Titre | Reboucher / abandonner un forage ou un puits |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : reboucher réglementairement un forage/puits abandonné pour protéger la nappe et supprimer le danger. `[C]`
- **Résumé** : combler l'ouvrage abandonné selon les règles (matériaux inertes + **cimentation** pour rétablir l'étanchéité entre nappes), supprimer le **risque de chute**, et **déclarer l'abandon** ; un rebouchage bâclé = **voie de pollution** durable de la nappe. `[C]` ⟦protocole de comblement selon réglementation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Évaluer l'ouvrage (profondeur, nappes traversées). `[C]`
  2. Combler (matériaux inertes) + **cimentation** (étanchéité inter-nappes). `[A]` ⟦à confirmer⟧
  3. Supprimer le **risque de chute** (tête). `[A]`
  4. **Déclarer l'abandon** (réglementaire). `[C]`
- **Points critiques** : cimentation = **barrière contre la pollution** de la nappe ; suppression du danger de chute ; déclaration d'abandon.
- **Sécurité** : chute (ouvrage ouvert) ; contamination nappe ; espace confiné. **Puits / forage ouvert** : **risque de chute** (protéger/couvrir l'ouvrage) et d'**effondrement des parois** (tubage/soutènement). **Espace confiné** (puits traditionnel) : gaz / manque d'oxygène → **jamais de descente sans procédure** (détection, ventilation, surveillant, treuil). **Contamination de la nappe / pollution** : **protection sanitaire** de la tête, **cimentation annulaire**, ne jamais mettre deux nappes en communication ; **désinfection** après travaux. **Réseaux enterrés** (DICT). **Électricité des pompes immergées** : raccordement **réservé** à un professionnel. **Levage** (matériel/pompe lourds). **Qualité de l'eau** : analyse avant usage. **Arrêt immédiat en cas de danger.** Le forage est une opération **réglementée réservée à une entreprise qualifiée** (foreur).** `[A]`

## Cadre & suites
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réglementation** : `cite-phrase` → [normes-reglementation-forage](../../../phrases/forage/normes-reglementation-forage.md)

## Relations & tags
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage intervention:reparer cluster:rebouchage cluster:protection-sanitaire complexite:avancee type:realisation securite:nappe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
