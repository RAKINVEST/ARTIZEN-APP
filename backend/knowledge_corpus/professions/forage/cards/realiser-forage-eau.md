# Réaliser un forage d'eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-forage-eau` |
| Titre | Réaliser un forage d'eau |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser un forage d'eau (foreur qualifié) : perforation, tubage provisoire, atteinte de la nappe visée. `[C]`
- **Résumé** : après **déclaration** et **DICT**, foreur et machine de forage perforent jusqu'à la **nappe** visée (méthode adaptée au sol), en gérant la stabilité des parois (tubage), les cuttings et les fluides de forage ; opération **réservée à une entreprise qualifiée**. `[C]` ⟦méthode/profondeur selon hydrogéologie à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Déclaration** + **DICT** ; étude hydrogéologique. `[A]` → [terrasser-reseaux-dict](../../../professions/terrassement/cards/terrasser-reseaux-dict.md)
  2. Forer (foreur qualifié) ; gérer stabilité des parois. `[A]` ⟦méthode à confirmer⟧
  3. Gérer cuttings / fluides ; ne pas polluer la nappe. `[A]`
  4. Tuber/équiper à la profondeur atteinte. `[C]` → [tuber-equiper-forage](tuber-equiper-forage.md)
- **Points critiques** : opération **réservée (foreur qualifié)** ; stabilité des parois ; **ne pas polluer/mettre en communication** les nappes.
- **Sécurité** : effondrement du forage ; contamination nappe ; levage/engins. **Puits / forage ouvert** : **risque de chute** (protéger/couvrir l'ouvrage) et d'**effondrement des parois** (tubage/soutènement). **Espace confiné** (puits traditionnel) : gaz / manque d'oxygène → **jamais de descente sans procédure** (détection, ventilation, surveillant, treuil). **Contamination de la nappe / pollution** : **protection sanitaire** de la tête, **cimentation annulaire**, ne jamais mettre deux nappes en communication ; **désinfection** après travaux. **Réseaux enterrés** (DICT). **Électricité des pompes immergées** : raccordement **réservé** à un professionnel. **Levage** (matériel/pompe lourds). **Qualité de l'eau** : analyse avant usage. **Arrêt immédiat en cas de danger.** Le forage est une opération **réglementée réservée à une entreprise qualifiée** (foreur).** `[A]`

## Cadre & suites
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Instabilité** : `traite-diagnostic` → [effondrement-instabilite-puits](../../../diagnostics/forage/effondrement-instabilite-puits.md)

## Relations & tags
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage intervention:realiser cluster:forage-d-eau cluster:captage complexite:expert type:realisation securite:effondrement securite:nappe relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
