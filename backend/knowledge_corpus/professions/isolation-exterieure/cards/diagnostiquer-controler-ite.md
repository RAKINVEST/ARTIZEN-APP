# Diagnostiquer / contrôler une ITE existante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-controler-ite` |
| Titre | Diagnostiquer / contrôler une ITE existante |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : diagnostiquer et contrôler l'état d'un système ETICS (fissuration, décollement, chocs, planéité, points singuliers). `[C]`
- **Résumé** : inspecter la finition et le sous-enduit (fissures, cloquage, sonorité creuse = décollement), l'état des points singuliers et du soubassement (chocs), sonder l'adhérence, et orienter la réparation dans le respect du système. `[C]`

## Réalisation
- **Étapes** :
  1. Repérer **fissuration** (finition/sous-enduit). `[C]` → [fissuration-ite](../../../diagnostics/isolation-exterieure/fissuration-ite.md)
  2. Rechercher **décollement/cloquage** (sonorité creuse). `[C]` → [decollement-cloquage-ite](../../../diagnostics/isolation-exterieure/decollement-cloquage-ite.md)
  3. Contrôler **soubassement / chocs** et points singuliers. `[C]` → [choc-impact-ite](../../../diagnostics/isolation-exterieure/choc-impact-ite.md)
  4. Reprise **dans le respect du système** (matériaux compatibles). `[C]`
- **Points critiques** : reprise avec des **composants compatibles** du système ; ne pas masquer une entrée d'eau.
- **Sécurité** : hauteur/échafaudage ; produits ; chute de matériaux (purge). **Travail en **hauteur** (façade) : risque de **chute** — **échafaudages** / protections **collectives** (garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie/fort ensoleillement) surveillée (prise des colles/enduits). **Découpe des panneaux** (PSE/laines) : **poussières** — masque/aspiration, protection respiratoire pour les laines. **Produits chimiques** (colles, sous-enduits, mortiers) : EPI, protection de l'environnement. **Arrêt immédiat en cas de danger.** La pose ETICS s'effectue **sous Avis Technique** et relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-ite](../../../checklists/isolation-exterieure/controle-maintenance-ite.md)

## Relations & tags
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure intervention:diagnostiquer intervention:controler cluster:diagnostic cluster:controle cluster:reparation complexite:avancee type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
