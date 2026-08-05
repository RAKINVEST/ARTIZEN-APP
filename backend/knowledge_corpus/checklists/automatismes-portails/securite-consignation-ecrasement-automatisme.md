# Sécurité — consignation, écrasement & essais (automatisme)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-consignation-ecrasement-automatisme` |
| Titre | Sécurité — consignation, écrasement & essais (automatisme) |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Mouvement automatique** : considérer le portail comme pouvant démarrer seul. `[A]`
- [ ] **Consignation** : alimentation coupée/condamnée ; absence de mouvement vérifiée. `[A]`
- [ ] **Écrasement / cisaillement / entraînement / choc** : zones de danger identifiées. `[A]`
- [ ] **Déverrouillage manuel** connu et testé. `[A]`
- [ ] **Dispositifs** (cellules/bords/effort) installés et **essais/mesure d'effort** faits. `[A]`
- [ ] **Élec** = interface ; **manutention** moteurs/portail ; **amiante** = certifié (jamais ici). `[A]`

## Cadre
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [consignation-essais-avant-apres-intervention](../../procedures/automatismes-portails/consignation-essais-avant-apres-intervention.md).
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:securite type:checklist cluster:securite securite:ecrasement securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
