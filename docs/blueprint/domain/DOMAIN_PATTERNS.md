# Domain Patterns — Patrons de modélisation

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [DOMAIN_MODEL.md](DOMAIN_MODEL.md) — **Used By:** objects/, implementation — **Niveau:** 2 · Architecture

## Objective
Documenter les **patrons récurrents** du domaine, pour que tout nouvel objet réutilise une forme éprouvée plutôt que d'en inventer une.

## Patrons
| Patron | Quand l'utiliser | Exemple |
|---|---|---|
| **Agrégat + frontière** | un objet a une cohérence propre à protéger | Mission possède ses interventions, référence ses devis |
| **Value Object** | égalité par valeur, immuable | Money, Address, Temps, Confidence, Visibility |
| **Domain Event** | signaler un fait immuable au reste du système | `MissionCompleted`, `QuoteAccepted` |
| **Composant partagé (VO)** | deux objets composent les mêmes éléments | `Component` partagé par **Kit** et **Intervention** |
| **Famille « Document commercial »** | Devis/Facture/BC partagent structure et cycle | Quote, Invoice, PurchaseOrder |
| **Famille « Journal »** | tracer sans muter (append-only) | Event (bus), History (métier), Audit (sécurité) |
| **Read-model** | vue dérivée d'événements, sans écriture cœur | Performance, Report |
| **Template + Instance** | un modèle réutilisable et ses exécutions | Intervention (modèle) → InterventionInstance |
| **Copie au partage** | importer sans créer de dépendance vivante | Sharing : `import` crée une copie locale (Vol.7) |
| **Tenant par Company** | isolation multi-entreprise | tout objet appartient à une Company |
| **Archive plutôt que détruire** | préserver le savoir (Loi 5) | Article/Knowledge : `Actif → Archivé` |
| **Référence par id** | éviter la duplication (Loi 1) | Mission → Customer par id |

## Rules
Réutiliser un patron existant avant d'en créer un. Tout nouvel objet cite le/les patrons qu'il applique dans sa fiche.

## Acceptance Criteria
Chaque patron a une condition d'emploi et un exemple réel du domaine.

## Related Documents
[DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md) · [OBJECT_CATALOG.md](OBJECT_CATALOG.md)

## Next Reading
[DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — Patrons initiaux.
