# Flow — Créer une notification

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Suivi

## Nom
Créer une notification

## Mission
Émettre un message d'attention.

## Objectif métier
Émettre un message d'attention.

## Déclencheur
Événement métier

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Système

## Acteurs secondaires
—

## Objets concernés
Notification

## Engines concernés
Notification

## Entrées
Événement

## Sorties
Notification affichée

## Étapes détaillées
1. **Notification** — Créer la notification (non bloquante) → événement `NotificationRaised` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Lue/masquée/expirée

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Système
  participant E_Notification as Notification
  participant BUS as Bus d'événements
  A->>E_Notification: Créer la notification (non bloquante)
  E_Notification-->>BUS: NotificationRaised
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `NotificationRaised`

## Événements consommés
tous les *

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Suivi**). Action irréversible → confirmation explicite.

## Validation
Invariants du Domain Model (Step 2) vérifiés ; aucune donnée inventée ; le PDF/source fait foi le cas échéant.

## Erreurs possibles
Voir [../FLOW_ERRORS.md](../FLOW_ERRORS.md) : validation, permission (404 cross-tenant), conflit, ressource absente, échec IA/OCR/stockage/réseau.

## Rollback
Tant que l'objet est un brouillon : annulation directe. Après figement : compensation tracée (ex. avoir), jamais de destruction.

## Historisation
Chaque étape est journalisée (History, append-only — Loi 5).

## UX
Objectif clair ; **≤ 1 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Asynchrone.

## Fin du processus
Notification affichée

## Critères de réussite
Copilote discret, jamais bloquant.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
