# Flow — Modifier un devis

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Devis

## Nom
Modifier un devis

## Mission
Éditer un devis brouillon.

## Objectif métier
Éditer un devis brouillon.

## Déclencheur
Édition

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
Quote

## Engines concernés
Quote

## Entrées
Champs modifiés

## Sorties
Draft mis à jour

## Étapes détaillées
1. **Quote** — Appliquer les modifications → événement `QuoteUpdated` (contrôle : invariants ; résultat : étape validée).
2. **Quote** — Recalculer les totaux (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Signé → **immuable** (interdit)

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Quote as Quote
  participant BUS as Bus d'événements
  A->>E_Quote: Appliquer les modifications
  E_Quote-->>BUS: QuoteUpdated
  A->>E_Quote: Recalculer les totaux
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `QuoteUpdated`

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
Objectif clair ; **≤ 3 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Synchrone.

## Fin du processus
Draft cohérent

## Critères de réussite
Modifications appliquées, totaux à jour.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
