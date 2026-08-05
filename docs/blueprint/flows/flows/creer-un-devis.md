# Flow — Créer un devis

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Devis

## Nom
Créer un devis

## Mission
Composer un devis à partir d'interventions.

## Objectif métier
Composer un devis à partir d'interventions.

## Déclencheur
« Nouveau devis »

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
Quote

## Engines concernés
Quote, Intervention

## Entrées
Client, interventions

## Sorties
Devis Draft

## Étapes détaillées
1. **Quote** — Créer le brouillon → événement `QuoteCreated` (contrôle : invariants ; résultat : étape validée).
2. **Quote** — Calculer les totaux (calculateur) (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Voir machine Quote

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Quote as Quote
  participant BUS as Bus d'événements
  A->>E_Quote: Créer le brouillon
  E_Quote-->>BUS: QuoteCreated
  A->>E_Quote: Calculer les totaux (calculateur)
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `QuoteCreated`

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
Objectif clair ; **≤ 4 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Synchrone (totaux immédiats).

## Fin du processus
Devis Draft numéroté

## Critères de réussite
Devis chiffré, éditable.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
