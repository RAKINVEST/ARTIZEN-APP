# Appliquer la finition ITE

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `appliquer-finition-ite` |
| Titre | Appliquer la finition ITE |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : appliquer la finition (enduit mince) d'un système ETICS — composant du système, distinct de l'enduit de façade sur maçonnerie. `[C]`
- **Résumé** : appliquer, après durcissement du sous-enduit armé, la **couche de finition du système** (RPE/enduit mince, gratté/taloché) dans la teinte prévue ; c'est un **composant de l'ETICS** (Avis Technique), à ne pas confondre avec l'enduit de mortier sur maçonnerie (Livre Façade). `[C]` ⟦produit/teinte/clarté selon ATec à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier le durcissement du **sous-enduit armé**. `[C]`
  2. Appliquer éventuelle sous-couche/primaire d'accrochage. `[C]`
  3. Appliquer la **finition du système** (RPE/enduit mince), teinte prévue. `[C]` ⟦indice de clarté mini selon ATec à confirmer⟧
  4. Contrôle d'aspect ; côté façade → diagnostic finition. `[C]` → [controler-ite-facade](../../../professions/facade/cards/controler-ite-facade.md)
- **Points critiques** : finition **du système ETICS** (pas un enduit façade classique) ; teinte/indice de clarté conformes ATec (dilatation) ; météo.
- **Sécurité** : hauteur ; produits (finition) ; météo (pas de pluie/gel/fort soleil). **Travail en **hauteur** (façade) : risque de **chute** — **échafaudages** / protections **collectives** (garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie/fort ensoleillement) surveillée (prise des colles/enduits). **Découpe des panneaux** (PSE/laines) : **poussières** — masque/aspiration, protection respiratoire pour les laines. **Produits chimiques** (colles, sous-enduits, mortiers) : EPI, protection de l'environnement. **Arrêt immédiat en cas de danger.** La pose ETICS s'effectue **sous Avis Technique** et relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Isolation (théorie)** : `relation:isolation` (voir Livre Isolation)

## Relations & tags
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure intervention:realiser cluster:finitions cluster:etics complexite:avancee type:installation securite:hauteur relation:facade`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
