# Principe du forage / puits (captage d'eau)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-forage-puits` |
| Titre | Principe du forage / puits (captage d'eau) |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les ouvrages de captage d'eau souterraine (puits traditionnel, forage) et leurs préalables (hydrogéologie, déclaration). `[C]`
- **Résumé** : capter l'eau d'une **nappe** se fait par **puits traditionnel** (large, maçonné) ou **forage d'eau** (tubé, étroit, profond) ; l'implantation repose sur l'**hydrogéologie** (nappe visée, débit) et l'ouvrage est **réglementé** (déclaration, protection de la ressource). `[C]` ⟦nappe/profondeur selon étude hydrogéologique à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Hydrogéologie** + **déclaration** préalables (réglementaire). `[A]` → [declaration-forage](../../../procedures/forage/declaration-forage.md)
  2. **Forage d'eau** (foreur qualifié, tubage). `[C]` → [realiser-forage-eau](realiser-forage-eau.md)
  3. **Captage** géothermique = ouvrage voisin (frontière). `[C]` → [controler-champ-de-captage](../../../professions/geothermie/cards/controler-champ-de-captage.md)
  4. **Protection sanitaire** de la ressource. `[C]` → [realiser-tete-protection-sanitaire](realiser-tete-protection-sanitaire.md)
- **Points critiques** : hydrogéologie (nappe/débit) ; **déclaration** obligatoire ; **protection de la nappe** ; ouvrage réservé à un foreur.
- **Sécurité** : chute/effondrement ; espace confiné ; contamination nappe. **Puits / forage ouvert** : **risque de chute** (protéger/couvrir l'ouvrage) et d'**effondrement des parois** (tubage/soutènement). **Espace confiné** (puits traditionnel) : gaz / manque d'oxygène → **jamais de descente sans procédure** (détection, ventilation, surveillant, treuil). **Contamination de la nappe / pollution** : **protection sanitaire** de la tête, **cimentation annulaire**, ne jamais mettre deux nappes en communication ; **désinfection** après travaux. **Réseaux enterrés** (DICT). **Électricité des pompes immergées** : raccordement **réservé** à un professionnel. **Levage** (matériel/pompe lourds). **Qualité de l'eau** : analyse avant usage. **Arrêt immédiat en cas de danger.** Le forage est une opération **réglementée réservée à une entreprise qualifiée** (foreur).** `[A]`

## Cadre & suites
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / contrôle** : `cite-carte` → [entretenir-controler-forage](entretenir-controler-forage.md)

## Relations & tags
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage intervention:comprendre cluster:puits-traditionnel cluster:forage-d-eau cluster:captage cluster:hydrogeologie type:principe securite:nappe relation:geothermie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
