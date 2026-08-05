# Réaliser un essai de débit

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-essai-debit` |
| Titre | Réaliser un essai de débit |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser un essai de débit (pompage d'essai) pour déterminer le débit exploitable et le rabattement. `[C]`
- **Résumé** : pomper à débit(s) contrôlé(s) en mesurant le **rabattement** du niveau d'eau au cours du temps, en déduire le **débit exploitable** durable (sans surexploiter la nappe) et vérifier la **remontée**, pour dimensionner la pompe et l'usage. `[C]` ⟦protocole/durée d'essai à confirmer⟧

## Réalisation
- **Étapes** :
  1. Pomper à **débit(s) contrôlé(s)** ; mesurer le **rabattement**. `[C]`
  2. Évaluer le **débit exploitable** durable (ne pas surexploiter). `[C]`
  3. Contrôler la **remontée** du niveau (recharge). `[C]`
  4. Consigner pour dimensionner la pompe/l'usage. `[C]` → [installer-pompe-immergee](installer-pompe-immergee.md)
- **Points critiques** : débit **durable** (respecter la nappe/les usages voisins) ; rabattement maîtrisé ; base du dimensionnement.
- **Sécurité** : électricité (pompe d'essai) ; chute (ouvrage) ; rejet des eaux de pompage. **Puits / forage ouvert** : **risque de chute** (protéger/couvrir l'ouvrage) et d'**effondrement des parois** (tubage/soutènement). **Espace confiné** (puits traditionnel) : gaz / manque d'oxygène → **jamais de descente sans procédure** (détection, ventilation, surveillant, treuil). **Contamination de la nappe / pollution** : **protection sanitaire** de la tête, **cimentation annulaire**, ne jamais mettre deux nappes en communication ; **désinfection** après travaux. **Réseaux enterrés** (DICT). **Électricité des pompes immergées** : raccordement **réservé** à un professionnel. **Levage** (matériel/pompe lourds). **Qualité de l'eau** : analyse avant usage. **Arrêt immédiat en cas de danger.** Le forage est une opération **réglementée réservée à une entreprise qualifiée** (foreur).** `[A]`

## Cadre & suites
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Hydrogéologie** : `cite-carte` → [principe-forage-puits](principe-forage-puits.md)

## Relations & tags
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage intervention:controler cluster:essais-de-debit cluster:hydrogeologie complexite:avancee type:controle securite:nappe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
