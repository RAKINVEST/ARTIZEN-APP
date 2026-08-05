# Flow — Créer une entreprise

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Onboarding

## Nom
Créer une entreprise

## Mission
Créer l'entreprise et sa racine de tenant.

## Objectif métier
Créer l'entreprise et sa racine de tenant.

## Déclencheur
Inscription

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Fondateur

## Acteurs secondaires
—

## Objets concernés
Company

## Engines concernés
Company, Authentication

## Entrées
Nom, coordonnées

## Sorties
Company active

## Étapes détaillées
1. **Company** — Enregistrer l'entreprise → événement `CompanyCreated` (contrôle : invariants ; résultat : étape validée).
2. **Authentication** — Créer le premier accès (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
—

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Fondateur
  participant E_Company as Company
  participant E_Authentication as Authentication
  participant BUS as Bus d'événements
  A->>E_Company: Enregistrer l'entreprise
  E_Company-->>BUS: CompanyCreated
  A->>E_Authentication: Créer le premier accès
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `CompanyCreated`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Onboarding**). Action irréversible → confirmation explicite.

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
Synchrone, immédiat.

## Fin du processus
Company active + 1er utilisateur

## Critères de réussite
Entreprise créée, connexion possible.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
