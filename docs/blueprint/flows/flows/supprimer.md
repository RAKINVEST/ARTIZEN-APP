# Flow — Supprimer

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Cycle de vie

## Nom
Supprimer

## Mission
Supprimer définitivement — brouillon uniquement.

## Objectif métier
Supprimer définitivement — brouillon uniquement.

## Déclencheur
« Supprimer »

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
brouillon

## Engines concernés
moteur propriétaire

## Entrées
Brouillon cible

## Sorties
Brouillon supprimé

## Étapes détaillées
1. **(propriétaire)** — Vérifier que c'est un brouillon (contrôle : invariants ; résultat : étape validée).
2. **(propriétaire)** — Supprimer après **confirmation** → événement `ObjectDeleted` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Donnée métier figée → **interdit** (archiver)

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant SYS as (propriétaire)
  participant BUS as Bus d'événements
  A->>SYS: Vérifier que c'est un brouillon
  A->>SYS: Supprimer après **confirmation**
  SYS-->>BUS: ObjectDeleted
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `*Deleted`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Cycle de vie**). Action irréversible → confirmation explicite.

## Validation
Invariants du Domain Model (Step 2) vérifiés ; aucune donnée inventée ; le PDF/source fait foi le cas échéant.

## Erreurs possibles
Voir [../FLOW_ERRORS.md](../FLOW_ERRORS.md) : validation, permission (404 cross-tenant), conflit, ressource absente, échec IA/OCR/stockage/réseau.

## Rollback
Tant que l'objet est un brouillon : annulation directe. Après figement : compensation tracée (ex. avoir), jamais de destruction.

## Historisation
Chaque étape est journalisée (History, append-only — Loi 5).

## UX
Objectif clair ; **≤ 2 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Synchrone ; confirmation obligatoire.

## Fin du processus
Brouillon supprimé

## Critères de réussite
Suppression sûre, jamais de donnée capitalisée (Loi 5).

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
