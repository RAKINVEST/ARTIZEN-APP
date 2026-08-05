# Flow — Importer un devis PDF

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Devis

## Nom
Importer un devis PDF

## Mission
Importer un ancien devis PDF.

## Objectif métier
Importer un ancien devis PDF.

## Déclencheur
Upload PDF

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
Document

## Engines concernés
Document Analysis, Storage, OCR

## Entrées
Fichier PDF

## Sorties
Analyse prête

## Étapes détaillées
1. **Storage** — Stocker le fichier (contrôle : invariants ; résultat : étape validée).
2. **Document Analysis** — Analyser (texte, structure) → événement `AnalysisDone` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Non-devis → refus

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Storage as Storage
  participant E_DocumentAnalysis as Document Analysis
  participant BUS as Bus d'événements
  A->>E_Storage: Stocker le fichier
  A->>E_DocumentAnalysis: Analyser (texte, structure)
  E_DocumentAnalysis-->>BUS: AnalysisDone
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `AnalysisDone`

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
Analyse asynchrone.

## Fin du processus
Analyse disponible

## Critères de réussite
Le PDF est analysé, prêt à extraire.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
