# Flow — Signer un devis

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Devis

## Nom
Signer un devis

## Mission
Le client accepte le devis.

## Objectif métier
Le client accepte le devis.

## Déclencheur
Signature client

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Client

## Acteurs secondaires
Artisan

## Objets concernés
Quote

## Engines concernés
Quote

## Entrées
Signature

## Sorties
Devis Accepted (immuable)

## Étapes détaillées
1. **Quote** — Enregistrer l'acceptation → événement `QuoteAccepted` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Accepté → mission possible · Refusé → archivage · Expiré → relance

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Client
  participant E_Quote as Quote
  participant BUS as Bus d'événements
  A->>E_Quote: Enregistrer l'acceptation
  E_Quote-->>BUS: QuoteAccepted
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `QuoteAccepted`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Devis**). Action irréversible → confirmation explicite.

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
Synchrone ; confirmation.

## Fin du processus
Devis signé, immuable

## Critères de réussite
Devis accepté ; transformation possible.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
