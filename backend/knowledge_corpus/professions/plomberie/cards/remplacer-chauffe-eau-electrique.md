# Remplacer un chauffe-eau électrique (ballon ECS)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-chauffe-eau-electrique` |
| Titre | Remplacer un chauffe-eau électrique (ballon ECS) |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ecs` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (raccordement hydraulique ; le raccordement électrique relève d'un pro habilité) |

## Cadrage
- **Objectif** : remplacer un ballon d'eau chaude sanitaire hors service en assurant les raccordements hydrauliques et la sécurité (groupe de sécurité). `[C]`
- **Résumé** : consigner (eau + électricité), vidanger, déposer l'ancien ballon, poser le neuf sur support adapté, raccorder EF/ECS + **groupe de sécurité** évacué, remplir, purger, puis remettre en chauffe. `[B]`
- **Description complète** : ⟦à compléter/valider métier⟧ — le **raccordement électrique** doit être réalisé/contrôlé par un intervenant habilité (hors périmètre de cette carte). `[B]`
- **Pré-requis** : support mural/sol adapté au poids en eau, arrivée EF isolable, évacuation pour le groupe. `[B]`
- **Difficulté** : `moyenne` à `avancee` `[C]`
- **Temps moyen** : ~2–3 h `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : raccordement ECS, étanchéité, consignation ; **habilitation électrique** pour la partie élec. `[B]`

## Ressources
- **Outillage** : `outil:manuel`, niveau, perceuse. `[C]`
- **Matériel** : ballon ECS, groupe de sécurité, flexibles/raccords diélectriques, support. `[B]`
- **Consommables** : téflon/filasse, siphon d'évacuation. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-chauffe-eau](../../../kits/plomberie/kit-chauffe-eau.md)

## Réalisation
- **Étapes** :
  1. **Consigner** : couper électricité **et** eau, vidanger la cuve. `[A]` → [consignation-eau](../../../procedures/plomberie/consignation-eau.md)
  2. Déconnecter et déposer l'ancien ballon (poids en eau — sécurité). `[B]`
  3. Fixer le neuf sur support adapté, de niveau. `[C]`
  4. Raccorder EF/ECS (raccords **diélectriques**) et poser le **groupe de sécurité** évacué vers siphon. `[B]` → [remplacer-groupe-securite](remplacer-groupe-securite.md)
  5. **Remplir la cuve** et purger (robinet ECS ouvert jusqu'à débit franc) **avant** toute mise sous tension. `[A]`
  6. Faire réaliser/contrôler le raccordement électrique par un habilité, puis mise en chauffe. `[B]` → [mise-en-service-chauffe-eau](../../../procedures/plomberie/mise-en-service-chauffe-eau.md)
- **Contrôles** : étanchéité hydraulique, écoulement de dilatation, ECS chaude. `[C]`
- **Points critiques** : **remplir avant de chauffer** (sinon destruction de la résistance) ; groupe de sécurité évacué et non obturé ; raccords diélectriques. `[A]`
- **Sécurité** : électricité (habilitation), eau très chaude, charges lourdes. `[A]`

## Cadre & suites
- **Normes** : ECS sous pression — **DTU 60.1** ; eau chaude **DTU 65.10** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [absence-eau-chaude](../../../diagnostics/plomberie/absence-eau-chaude.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir⟧

## Langage & réutilisation
- **Retours terrain** : `enrichie-par` → [conseil-entretien-anti-tartre](../../../phrases/plomberie/conseil-entretien-anti-tartre.md)

## Relations & tags
- **Relations** : `utilise-kit`, `cite-procedure`, `cite-carte`, `traite-diagnostic`, `enrichie-par`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:ecs intervention:remplacer equipement:chauffe-eau equipement:groupe-securite complexite:avancee type:remplacement securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
