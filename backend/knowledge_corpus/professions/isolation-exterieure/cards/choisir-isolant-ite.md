# Choisir l'isolant d'un système ITE

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `choisir-isolant-ite` |
| Titre | Choisir l'isolant d'un système ITE |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : choisir l'isolant d'un système ETICS (PSE, laine de roche, laine de bois) selon l'Avis Technique, le feu et le support. `[C]`
- **Résumé** : sélectionner l'isolant **compatible avec le système ETICS retenu** (Avis Technique) : **PSE** (économique), **laine de roche** (feu/acoustique), **laine de bois** (bio-sourcé/déphasage), selon la résistance visée, la réglementation **incendie** (règles C+D, hauteur) et le support. `[C]` ⟦épaisseur/classe feu selon ATec à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier la **compatibilité système** (isolant lié à l'ATec). `[C]`
  2. **PSE** : économique, léger ; contraintes feu. `[C]` ⟦à confirmer⟧
  3. **Laine de roche** : incombustible (feu, hauteur), acoustique. `[C]`
  4. **Laine de bois** : déphasage, bio-sourcé. `[C]` → [choisir-isolant](../../../professions/isolation/cards/choisir-isolant.md)
- **Points critiques** : isolant **indissociable du système** ATec ; **règles incendie** (C+D, recoupements) selon hauteur ; R visé.
- **Sécurité** : manutention/découpe (poussières, laines = respiratoire) ; stockage au sec. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudages** / protections **collectives** (garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie/fort ensoleillement) surveillée (prise des colles/enduits). **Découpe des panneaux** (PSE/laines) : **poussières** — masque/aspiration, protection respiratoire pour les laines. **Produits chimiques** (colles, sous-enduits, mortiers) : EPI, protection de l'environnement. **Arrêt immédiat en cas de danger.** La pose ETICS s'effectue **sous Avis Technique** et relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fixation** : `cite-carte` → [fixer-isolant-ite](fixer-isolant-ite.md)

## Relations & tags
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure intervention:choisir cluster:panneaux-pse cluster:laine-de-roche cluster:laine-de-bois cluster:etics complexite:moyenne type:reference securite:respiratoire relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
