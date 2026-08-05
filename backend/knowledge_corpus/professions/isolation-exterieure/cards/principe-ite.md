# Principe de l'ITE (système ETICS)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-ite` |
| Titre | Principe de l'ITE (système ETICS) |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le système d'isolation thermique par l'extérieur (ETICS) : composition, variantes et rôle d'enveloppe continue. `[C]`
- **Résumé** : l'**ITE** enveloppe le bâti par l'extérieur et traite nativement les **ponts thermiques** ; système **ETICS** = isolant **collé/chevillé** + **sous-enduit armé** (treillis) + **finition**, posé comme un **système sous Avis Technique** (la théorie thermique R/λ relève du Livre **Isolation**). Variante **ITE ventilée** à bardage rapporté. `[C]` ⟦système/composants selon ATec à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Théorie thermique (R/λ, ponts thermiques)** : voir Livre Isolation. `[C]` → [principe-isolation](../../../professions/isolation/cards/principe-isolation.md)
  2. **Isolant** collé/chevillé (PSE, laine de roche, laine de bois). `[C]` → [choisir-isolant-ite](choisir-isolant-ite.md)
  3. **Sous-enduit armé** (marouflage du treillis). `[C]` → [realiser-sous-enduit-arme](realiser-sous-enduit-arme.md)
  4. **Finition** (enduit mince) + points singuliers. `[C]` → [appliquer-finition-ite](appliquer-finition-ite.md)
- **Points critiques** : système **complet sous Avis Technique** (ne pas mélanger les composants) ; continuité de l'enveloppe ; gestion des **entrées d'air**.
- **Sécurité** : hauteur/échafaudage ; découpe (poussières) ; produits. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudages** / protections **collectives** (garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie/fort ensoleillement) surveillée (prise des colles/enduits). **Découpe des panneaux** (PSE/laines) : **poussières** — masque/aspiration, protection respiratoire pour les laines. **Produits chimiques** (colles, sous-enduits, mortiers) : EPI, protection de l'environnement. **Arrêt immédiat en cas de danger.** La pose ETICS s'effectue **sous Avis Technique** et relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Ventilation (entrées d'air façade)** : `cite-carte` → [entretenir-vmc-simple-flux](../../../professions/ventilation/cards/entretenir-vmc-simple-flux.md)

## Relations & tags
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure intervention:comprendre cluster:etics cluster:ponts-thermiques type:principe securite:hauteur relation:isolation relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
