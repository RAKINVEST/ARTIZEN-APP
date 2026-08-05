# Flow — Réceptionner du matériel

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Achats

## Nom
Réceptionner du matériel

## Mission
Constater la réception.

## Objectif métier
Constater la réception.

## Déclencheur
Livraison

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
PurchaseOrder, Stock

## Engines concernés
Stock

## Entrées
BC, quantités reçues

## Sorties
Stock mis à jour

## Étapes détaillées
1. **Stock** — Constater la réception → événement `POReceived` (contrôle : invariants ; résultat : étape validée).
2. **Stock** — Ajuster le stock → événement `StockAdjusted` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Écart de livraison → réserve

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Stock as Stock
  participant BUS as Bus d'événements
  A->>E_Stock: Constater la réception
  E_Stock-->>BUS: POReceived
  A->>E_Stock: Ajuster le stock
  E_Stock-->>BUS: StockAdjusted
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `POReceived`
- `StockAdjusted`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Achats**). Action irréversible → confirmation explicite.

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
Synchrone.

## Fin du processus
Réception enregistrée

## Critères de réussite
Stock à jour, écarts tracés.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
