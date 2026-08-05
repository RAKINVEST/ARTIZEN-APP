# Contrôler les assemblages d'une charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-assemblages` |
| Titre | Contrôler les assemblages d'une charpente |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'état des assemblages (tenon-mortaise, boulonnage, connecteurs de fermettes). `[C]`
- **Résumé** : vérifier le jeu, le serrage, l'état des connecteurs/ferrures et la présence de fissures aux nœuds, sans démonter un assemblage porteur. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler tenons-mortaises (jeu, fissures aux **nœuds**). `[C]`
  2. Vérifier le **serrage** des boulonnages/ferrures. `[C]`
  3. Contrôler les **connecteurs** (fermettes industrielles). `[C]`
  4. Signaler tout désordre structurel → étude. `[C]` → [affaissement-charpente](../../../diagnostics/charpente/affaissement-charpente.md)
- **Points critiques** : un assemblage porteur ne se démonte pas sans étaiement/étude ; connecteurs = ne pas percer/affaiblir.
- **Sécurité** : hauteur ; structure (assemblage porteur). **Travail en **hauteur** : risque de **chute** — EPI antichute, protections/échafaudage, **météo** (vent/gel/pluie) surveillée. **Stabilité de l'ouvrage** : évaluer **charges** et prévoir l'**étaiement** avant toute dépose/coupe d'un élément porteur — ne jamais affaiblir la structure sans étaiement/étude. **Arrêt immédiat en cas de danger** (fissuration, mouvement, doute structurel). Une intervention structurelle relève de **compétences charpente adaptées**.** `[A]`

## Cadre & suites
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Inspection** : `cite-carte` → [inspecter-charpente](inspecter-charpente.md)

## Relations & tags
- **Tags** : `metier:charpente equipement:assemblage famille:enveloppe sous-famille:charpente intervention:controler cluster:assemblages cluster:charpente-industrielle cluster:controle complexite:avancee type:controle securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
