# Traiter les ponts thermiques en ITE

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-ponts-thermiques-ite` |
| Titre | Traiter les ponts thermiques en ITE |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer la continuité de l'enveloppe extérieure et le traitement des ponts thermiques spécifiques à l'ITE. `[C]`
- **Résumé** : exploiter l'atout de l'ITE (enveloppe continue) en soignant les **retours** (tableaux, soubassement, acrotère/débord), la jonction avec l'isolation existante et les traversées, pour éviter les ponts thermiques résiduels ; le principe théorique est traité dans le Livre Isolation. `[C]` ⟦à confirmer selon configuration⟧

## Réalisation
- **Étapes** :
  1. Assurer la **continuité** extérieure (pas d'interruption). `[C]` → [traiter-ponts-thermiques](../../../professions/isolation/cards/traiter-ponts-thermiques.md)
  2. Soigner **retours de tableaux** et soubassement. `[C]`
  3. Traiter la jonction **toiture/débord** (acrotère, égout). `[C]`
  4. Gérer les traversées (fixations, réseaux). `[C]`
- **Points critiques** : l'ITE limite fortement les ponts thermiques **si les retours sont traités** ; sinon défaut résiduel + condensation.
- **Sécurité** : hauteur ; découpe ; interfaces. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudages** / protections **collectives** (garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie/fort ensoleillement) surveillée (prise des colles/enduits). **Découpe des panneaux** (PSE/laines) : **poussières** — masque/aspiration, protection respiratoire pour les laines. **Produits chimiques** (colles, sous-enduits, mortiers) : EPI, protection de l'environnement. **Arrêt immédiat en cas de danger.** La pose ETICS s'effectue **sous Avis Technique** et relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Points singuliers** : `cite-carte` → [traiter-points-singuliers-ite](traiter-points-singuliers-ite.md)

## Relations & tags
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure intervention:reparer cluster:ponts-thermiques cluster:etics complexite:avancee type:technique securite:hauteur relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
