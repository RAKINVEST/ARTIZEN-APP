# Flow — Reporter une intervention

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Mission

## Nom
Reporter une intervention

## Mission
Déplacer un créneau planifié.

## Objectif métier
Déplacer un créneau planifié.

## Déclencheur
Report

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
Client

## Objets concernés
Schedule

## Engines concernés
Planning

## Entrées
Nouvelle date

## Sorties
Créneau reporté

## Étapes détaillées
1. **Planning** — Reporter le créneau → événement `SlotRescheduled` (contrôle : invariants ; résultat : étape validée).
2. **Notification** — Prévenir le client (async) (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
—

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Planning as Planning
  participant E_Notification as Notification
  participant BUS as Bus d'événements
  A->>E_Planning: Reporter le créneau
  E_Planning-->>BUS: SlotRescheduled
  A->>E_Notification: Prévenir le client (async)
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `SlotRescheduled`

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
Objectif clair ; **≤ 2 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Notification asynchrone.

## Fin du processus
Créneau reporté

## Critères de réussite
Report tracé, client prévenu.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
