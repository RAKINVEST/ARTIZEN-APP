# Compacter les enrobés

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `compacter-enrobes` |
| Titre | Compacter les enrobés |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : compacter les enrobés (cylindre/plaque) pour atteindre la compacité dans la fenêtre de température. `[C]`
- **Résumé** : compacter chaque couche à l'énergie et selon le plan de balayage requis (**cylindre** lisse/à pneus, plaque pour les rives), **dans la fenêtre de température** (à chaud), pour atteindre la **compacité** cible (durabilité/étanchéité) sans écraser ni ressuer. `[C]` ⟦nombre de passes/compacité selon formule à confirmer⟧

## Réalisation
- **Étapes** :
  1. Compacter **dès le répandage** (fenêtre de température). `[C]`
  2. Plan de balayage (rives → axe) ; **cylindre**/plaque adapté. `[C]`
  3. Atteindre la **compacité** cible (contrôle). `[C]` → [controle-reception-enrobes](../../../checklists/enrobes/controle-reception-enrobes.md)
  4. Éviter le **ressuage**/l'écrasement (excès). `[C]` → [defaut-adherence-ressuage](../../../diagnostics/enrobes/defaut-adherence-ressuage.md)
- **Points critiques** : compacter **à la bonne température** ; compacité cible (sinon désordres) ; plan de balayage ; ni sous- ni sur-compactage.
- **Sécurité** : **compacteurs** (angles morts/marche arrière) ; température ; trafic. **Chantier routier sous circulation** : **signalisation temporaire** (IISR 8e partie) et **balisage** obligatoires ; **travail à proximité du trafic** = **risque n° 1** (vêtements haute visibilité, séparation physique, réduction de vitesse), **visibilité** maîtrisée. **Enrobés à chaud** : **température élevée** (~150–180 °C) → **brûlures graves** (EPI : gants, chaussures montantes) et **fumées de bitume** (VLEP, ventilation, réduction d'exposition). **Compacteurs / engins** : angles morts, marche arrière, personne dans le rayon. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, autorisations et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-reception-enrobes](../../../checklists/enrobes/controle-reception-enrobes.md)

## Relations & tags
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes intervention:realiser cluster:compactage complexite:avancee type:realisation securite:trafic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
