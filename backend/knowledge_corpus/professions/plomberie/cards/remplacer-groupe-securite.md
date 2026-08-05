# Remplacer le groupe de sécurité d'un chauffe-eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-groupe-securite` |
| Titre | Remplacer le groupe de sécurité d'un chauffe-eau |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ecs` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** (organe de sécurité normé ; références exactes à confirmer) |

## Cadrage
- **Objectif** : remplacer un groupe de sécurité fuyard ou entartré pour rétablir la protection du chauffe-eau (pression/température) et l'évacuation de dilatation. `[B]`
- **Résumé** : couper l'électricité et l'eau, vidanger la cuve, déposer l'ancien groupe, poser le nouveau avec étanchéité, raccorder l'évacuation vers l'entonnoir/siphon, remettre en eau puis en chauffe, contrôler. `[B]`
- **Description complète** : ⟦à compléter/valider métier⟧ — le groupe de sécurité est **obligatoire** sur un chauffe-eau à accumulation ; son évacuation ne doit jamais être obturée. `[B]`
- **Pré-requis** : chauffe-eau isolable (vanne d'arrêt), évacuation disponible. `[B]`
- **Difficulté** : `moyenne` `[C]`
- **Temps moyen** : ~45–90 min (dont vidange) `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : raccordement ECS, étanchéité filetée, consignation. `[B]`

## Ressources
- **Outillage** : `outil:manuel` (clés, pince), `outil:controle`. `[C]`
- **Matériel** : groupe de sécurité neuf (calibre 7 bar), raccords. `[B]`
- **Consommables** : filasse + pâte ou téflon, siphon si absent. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-chauffe-eau](../../../kits/plomberie/kit-chauffe-eau.md)

## Réalisation
- **Étapes** :
  1. Couper l'**alimentation électrique** du chauffe-eau, puis l'arrivée d'eau. `[B]` → [consignation-eau](../../../procedures/plomberie/consignation-eau.md)
  2. Vidanger la cuve (ouvrir le groupe en position vidange + un robinet ECS pour casser le vide). `[B]`
  3. Déposer l'ancien groupe et l'évacuation. `[C]`
  4. Poser le nouveau groupe (sens d'écoulement respecté), étanchéité filetée. `[B]`
  5. Raccorder l'évacuation vers l'entonnoir/siphon, **jamais obturée**. `[B]`
  6. Remettre en eau, purger l'air (robinet ECS ouvert jusqu'à débit franc). `[B]`
  7. Rétablir l'électricité ; contrôler l'étanchéité et l'écoulement de dilatation en chauffe. `[C]` → [mise-en-service-chauffe-eau](../../../procedures/plomberie/mise-en-service-chauffe-eau.md)
- **Contrôles** : `a-checklist` → [mise-en-service-ecs](../../../checklists/plomberie/mise-en-service-ecs.md)
- **Points critiques** : remplir **avant** de remettre en chauffe (sinon destruction de la résistance) ; évacuation de dilatation libre ; calibre de pression adapté. `[B]`
- **Sécurité** : couper l'électricité et vérifier l'absence de tension ; eau **très chaude** en cuve — laisser refroidir ou vidanger prudemment. `[A]`

## Cadre & suites
- **Normes** : installation ECS sous pression — **DTU 60.1** ; canalisations eau chaude **DTU 65.10** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [absence-eau-chaude](../../../diagnostics/plomberie/absence-eau-chaude.md)
- **Maintenance** : `cite-phrase` → [conseil-entretien-anti-tartre](../../../phrases/plomberie/conseil-entretien-anti-tartre.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir — terrain, sans donnée personnelle⟧

## Langage & réutilisation
- **FAQ** : « Peut-on juste changer la soupape ? » — non recommandé, le groupe se remplace en entier. `[C]` ⟦à valider⟧
- **Retours terrain** : `enrichie-par` → [retour-terrain-cartouche-calcaire](../../../phrases/plomberie/retour-terrain-cartouche-calcaire.md)

## Relations & tags
- **Relations** : `utilise-kit`, `a-checklist`, `traite-diagnostic`, `cite-phrase`, `enrichie-par`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:ecs intervention:remplacer probleme:fuite probleme:usure equipement:chauffe-eau equipement:groupe-securite complexite:moyenne type:reparation securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-03 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
