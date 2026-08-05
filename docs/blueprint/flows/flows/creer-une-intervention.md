# Flow — Créer une intervention

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Mission

## Nom
Créer une intervention

## Mission
Décrire un travail réutilisable (unité de pensée).

## Objectif métier
Décrire un travail réutilisable (unité de pensée).

## Déclencheur
« Ajouter une intervention »

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
Intervention

## Engines concernés
Intervention, Decision

## Entrées
Action + équipement

## Sorties
Intervention (modèle/instance)

## Étapes détaillées
1. **Intervention** — Créer/choisir l'intervention → événement `InterventionCreated` (contrôle : invariants ; résultat : étape validée).
2. **Decision** — Proposer articles/oublis (suggestions) (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Vide autorisée · avec kit · sans kit

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Intervention as Intervention
  participant E_Decision as Decision
  participant BUS as Bus d'événements
  A->>E_Intervention: Créer/choisir l'intervention
  E_Intervention-->>BUS: InterventionCreated
  A->>E_Decision: Proposer articles/oublis (suggestions)
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `InterventionCreated`
- `InterventionAdded`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Mission**). Action irréversible → confirmation explicite.

## Validation
Invariants du Domain Model (Step 2) vérifiés ; aucune donnée inventée ; le PDF/source fait foi le cas échéant.

## Erreurs possibles
Voir [../FLOW_ERRORS.md](../FLOW_ERRORS.md) : validation, permission (404 cross-tenant), conflit, ressource absente, échec IA/OCR/stockage/réseau.

## Rollback
Tant que l'objet est un brouillon : annulation directe. Après figement : compensation tracée (ex. avoir), jamais de destruction.

## Historisation
Chaque étape est journalisée (History, append-only — Loi 5).

## UX
Objectif clair ; **≤ 3 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Suggestions asynchrones.

## Fin du processus
Intervention prête

## Critères de réussite
L'intervention structure le devis.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
